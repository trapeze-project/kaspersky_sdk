package de.berlin.tu.kaspersky_sdk;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;
import androidx.core.os.HandlerCompat;

import com.kavsdk.KavSdk;
import com.kavsdk.antivirus.Antivirus;
import com.kavsdk.antivirus.AntivirusInstance;
import com.kavsdk.license.SdkLicense;
import com.kavsdk.license.SdkLicenseDateTimeException;
import com.kavsdk.license.SdkLicenseException;
import com.kavsdk.license.SdkLicenseNetworkException;
import com.kavsdk.license.SdkLicenseViolationException;
import com.kavsdk.shared.iface.ServiceStateStorage;

import java.io.File;
import java.io.IOException;

import de.berlin.tu.kaspersky_sdk.model.DataStorage;
import de.berlin.tu.kaspersky_sdk.model.InitStatus;
import de.berlin.tu.kaspersky_sdk.model.SdkInitListener;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Controller to control Kaspersky SDK initialization
 */
public class AntivirusController implements MethodChannel.MethodCallHandler, SdkInitListener {

    static final String LICENSE_KEY = "<ADD-YOUR-LICENSE-KEY>";

    static private AntivirusController singleton;

    static public AntivirusController init(Context context, MethodChannel channel) {
        singleton = new AntivirusController(context, channel);
        return singleton;
    }

    static public AntivirusController get() {
        return singleton;
    }

    private Antivirus antivirus;
    private Context context;
    private InitStatus initStatus;
    private MethodChannel channel;
    private Handler handler;

    private AntivirusController(Context context, MethodChannel channel) {
        this.context = context;
        this.channel = channel;
        this.handler = HandlerCompat.createAsync(Looper.getMainLooper());
    }

    public Antivirus getAntivirus() {
        return antivirus;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("init")) {
            // start initialization
            new Thread(() -> initializeSdk(AntivirusController.this)).start();
            result.success(true);
        } else {
            result.notImplemented();
        }
    }

    private String getNativeLibsPath() {
        // If you do not want to store native libraries in the application data
        // directory
        // SDK provides the ability to specify another path
        // (otherwise, you can simply omit pathToLibraries parameter).
        // Note: storing the libraries outside the application data directory is not
        // secure as
        // the libraries can be replaced. In this case, the libraries correctness
        // checking is required.
        // Besides, the specified path must be to device specific libraries,
        // i.e. you should care about device architecture.
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return packageInfo.applicationInfo.nativeLibraryDir;

        } catch (PackageManager.NameNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Initializes Kaspersky SDK.
     *
     * @param listener listener to listen on sdk initialization events
     */
    private void initializeSdk(SdkInitListener listener) {
        final File basesPath = context.getDir("bases", Context.MODE_PRIVATE);
        ServiceStateStorage generalStorage = new DataStorage();
        try {
            KavSdk.initSafe(context, basesPath, generalStorage, getNativeLibsPath());
            final SdkLicense license = KavSdk.getLicense();
            if (!license.isValid()) {
                if (!license.isClientUserIDRequired()) {
                    license.activate(LICENSE_KEY);
                } else {
                    throw new SdkLicenseException("Client ID is null but required");
                }
            }
        } catch (SdkLicenseNetworkException | SdkLicenseDateTimeException | IOException e) {
            initStatus = InitStatus.initFailed;
            listener.onInitializationFailed("Init failure: " + e.getMessage());
            return;
        } catch (SdkLicenseException e) {
            initStatus = InitStatus.needNewLicenseCode;
            listener.onInitializationFailed("New license code is required: " + e.getMessage());
            return;
        }
        SdkLicense license = KavSdk.getLicense();
        if (!license.isValid()) {
            initStatus = InitStatus.needNewLicenseCode;
            listener.onInitializationFailed("New license code is required");
            return;
        }
        antivirus = AntivirusInstance.getInstance();
        File scanTmpDir = context.getDir("scan_tmp", Context.MODE_PRIVATE);
        File monitorTmpDir = context.getDir("monitor_tmp", Context.MODE_PRIVATE);
        try {
            antivirus.initAntivirus(context.getApplicationContext(), scanTmpDir.getAbsolutePath(),
                    monitorTmpDir.getAbsolutePath());

        } catch (SdkLicenseViolationException | IOException e) {
            initStatus = InitStatus.initFailed;
            listener.onInitializationFailed(e.getMessage());
            return;
        }
        initStatus = InitStatus.initiatedSuccessfully;
        listener.onSdkInitialized();
    }

    /**
     * forwards initialization failure to Flutter
     *
     * @param reason
     */
    @Override
    public void onInitializationFailed(String reason) {
        handler.post(
                () -> channel.invokeMethod("onInitializationFailed", reason));
    }

    /**
     * forwards successful initialization to Flutter
     */
    @Override
    public void onSdkInitialized() {
        handler.post(() -> channel.invokeMethod("onSdkInitialized", null));
    }
}
