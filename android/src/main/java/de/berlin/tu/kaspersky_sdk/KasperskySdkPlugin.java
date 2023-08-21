package de.berlin.tu.kaspersky_sdk;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

import androidx.annotation.NonNull;

import com.kavsdk.KavSdk;
import com.kavsdk.antivirus.Antivirus;
import com.kavsdk.antivirus.AntivirusInstance;
import com.kavsdk.antivirus.ThreatInfo;
import com.kavsdk.antivirus.easyscanner.EasyListener;
import com.kavsdk.antivirus.easyscanner.EasyMode;
import com.kavsdk.antivirus.easyscanner.EasyObject;
import com.kavsdk.antivirus.easyscanner.EasyScanner;
import com.kavsdk.antivirus.easyscanner.EasyStatus;
import com.kavsdk.license.SdkLicense;
import com.kavsdk.license.SdkLicenseDateTimeException;
import com.kavsdk.license.SdkLicenseException;
import com.kavsdk.license.SdkLicenseNetworkException;
import com.kavsdk.license.SdkLicenseViolationException;
import com.kavsdk.shared.iface.ServiceStateStorage;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import de.berlin.tu.kaspersky_sdk.easyscanner.EasyScannerController;
import de.berlin.tu.kaspersky_sdk.easyscanner.EasyScannerListener;
import de.berlin.tu.kaspersky_sdk.model.DataStorage;
import de.berlin.tu.kaspersky_sdk.model.InitStatus;
import de.berlin.tu.kaspersky_sdk.model.SdkInitListener;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * Kaspersky SDK Plugin to control and listen to the Kaspersky SDK from Flutter
 */
public class KasperskySdkPlugin
        implements FlutterPlugin, MethodCallHandler, SdkInitListener,
        ActivityAware {

    private MethodChannel channel;

    private MethodChannel antivirusChannel;

    private MethodChannel easyScannerChannel;

    private InitStatus mSdkInitStatus;

    private Antivirus mAntivirusComponent;

    private Context context;

    private Activity activity;

    @Override
    public void onAttachedToEngine(
            @NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        // establish connection for main method channel
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(),
                "de.berlin.tu/kaspersky_sdk");
        channel.setMethodCallHandler(this);
        // establish connection for antivirus method channel
        antivirusChannel =
                new MethodChannel(flutterPluginBinding.getBinaryMessenger(),
                        "de.berlin.tu/kaspersky_sdk/antivirus");
        antivirusChannel.setMethodCallHandler(
                AntivirusController.init(context, antivirusChannel));
        // establish connection for easy scanner method channel
        easyScannerChannel =
                new MethodChannel(flutterPluginBinding.getBinaryMessenger(),
                        "de.berlin.tu/kaspersky_sdk/easyScanner");
        easyScannerChannel.setMethodCallHandler(
                EasyScannerController.init(context, easyScannerChannel));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("initializeSdk")) {
            // initialize kaspersky sdk
            result.success(mSdkInitStatus.name());
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        antivirusChannel.setMethodCallHandler(null);
        easyScannerChannel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        // do nothing
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        // do nothing
    }

    @Override
    public void onReattachedToActivityForConfigChanges(
            @NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        // do nothing
    }

    @Override
    public void onInitializationFailed(String reason) {
        System.out.println("SDK Initialization Status=" + reason);
    }

    @Override
    public void onSdkInitialized() {
        System.out.println("SDK initialized");
    }

}
