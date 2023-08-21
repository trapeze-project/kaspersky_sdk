package de.berlin.tu.kaspersky_sdk.easyscanner;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;
import androidx.core.os.HandlerCompat;

import com.kavsdk.antivirus.ThreatInfo;
import com.kavsdk.antivirus.easyscanner.EasyListener;
import com.kavsdk.antivirus.easyscanner.EasyObject;
import com.kavsdk.antivirus.easyscanner.EasyScanner;
import com.kavsdk.antivirus.easyscanner.EasyStatus;

import java.util.HashMap;
import java.util.Map;

import de.berlin.tu.kaspersky_sdk.MapConverter;
import io.flutter.plugin.common.MethodChannel;

/**
 * Listener to listen to events emitted by the Easy Scanner.
 */
public class EasyScannerListener implements EasyListener {
    private final Context context;
    private final MethodChannel channel;
    private final EasyScanner easyScanner;
    private Handler handler;

    public EasyScannerListener(Context context, MethodChannel channel, EasyScanner easyScanner) {
        this.context = context;
        this.channel = channel;
        this.easyScanner = easyScanner;
        this.handler = HandlerCompat.createAsync(Looper.getMainLooper());
    }

    /**
     * Called when the Easy Scanner starts processing an object. An object can
     * be a file, an archive, or a file in an archive.
     *
     * @param easyObject
     */
    @Override
    public void onObjectBegin(@NonNull EasyObject easyObject) {
        Map<String, Object> map = MapConverter.easyObjectToMap(easyObject);
        handler.post(() -> channel.invokeMethod("onObjectBegin", map));
    }

    /**
     * Called when the Easy Scanner has detected a malware object. An object can
     * be a file, an archive, or a file in an archive.
     *
     * @param easyObject
     * @param threatInfo
     */
    @Override
    public void onMalwareDetected(@NonNull EasyObject easyObject, @NonNull ThreatInfo threatInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("object", MapConverter.easyObjectToMap(easyObject));
        map.put("threat", MapConverter.threatInfoToMap(threatInfo, context));
        handler.post(() -> channel.invokeMethod("onMalwareDetected", map));
    }

    /**
     * Called when the Easy Scanner has detected a probably infected object or
     * adware. An object can be a file, an archive, or a file in an archive.
     *
     * @param easyObject
     * @param threatInfo
     */
    @Override
    public void onRiskwareDetected(@NonNull EasyObject easyObject, @NonNull ThreatInfo threatInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("object", MapConverter.easyObjectToMap(easyObject));
        map.put("threat", MapConverter.threatInfoToMap(threatInfo, context));
        handler.post(() -> channel.invokeMethod("onRiskwareDetected", map));
    }

    /**
     * Called when the Easy Scanner has detected that the device is rooted.
     */
    @Override
    public void onRooted() {
        handler.post(() -> channel.invokeMethod("onRooted", true));
    }

    /**
     * Called when the Easy Scanner has finished processing an object. An object
     * can be a file, an archive, or a file in an archive.
     *
     * @param easyObject
     * @param easyStatus
     */
    @Override
    public void onObjectEnd(@NonNull EasyObject easyObject, @NonNull EasyStatus easyStatus) {
        Map<String, Object> map = new HashMap<>();
        map.put("object", MapConverter.easyObjectToMap(easyObject));
        map.put("status", easyStatus.name());
        handler.post(() -> channel.invokeMethod("onObjectEnd", map));
    }

    /**
     * Called when the Easy Scanner has finished calculating the number of files
     * to be scanned.
     *
     * @param i
     */
    @Override
    public void onFilesCountCalculated(int i) {
        handler.post(() -> channel.invokeMethod("onFilesCountCalculated", i));
    }
}
