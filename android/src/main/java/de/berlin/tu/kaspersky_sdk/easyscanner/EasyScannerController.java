package de.berlin.tu.kaspersky_sdk.easyscanner;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;
import androidx.core.os.HandlerCompat;

import com.kavsdk.antivirus.easyscanner.EasyMode;
import com.kavsdk.antivirus.easyscanner.EasyScanner;

import de.berlin.tu.kaspersky_sdk.AntivirusController;
import de.berlin.tu.kaspersky_sdk.MapConverter;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Controller for the Easy Scanner by Kaspersky. Handles calls from Flutter,
 * forwards them to the Easy Scanner and returns the results.
 */
public class EasyScannerController implements MethodChannel.MethodCallHandler {

    static private EasyScannerController singleton;

    static public EasyScannerController init(Context context, MethodChannel channel) {
        singleton = new EasyScannerController(context, channel);
        return singleton;
    }

    static public EasyScannerController get() {
        return singleton;
    }

    private EasyScanner easyScanner;
    private MethodChannel channel;
    private Context context;
    private Handler handler;

    private EasyScannerController(Context context, MethodChannel channel) {
        this.context = context;
        this.channel = channel;
        this.handler = HandlerCompat.createAsync(Looper.getMainLooper());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("scan")) {
            // start easy scanner
            runEasyScanner(EasyMode.valueOf(call.arguments()));
            sendSuccessResult(result, true);
        } else if (call.method.equals("getResult")) {
            // return easy scanners result
            result.success(MapConverter.easyResultToMap(easyScanner.getResult(), context));
        } else if (call.method.equals("isPaused")) {
            // returns if easy scanner is paused
            sendSuccessResult(result, easyScanner.isPaused());
        } else if (call.method.equals("isScanInProgress")) {
            // returns if easy scanner is in progress
            sendSuccessResult(result, easyScanner.isScanInProgress());
        } else if (call.method.equals("pauseScan")) {
            // pauses easy scanner
            easyScanner.pauseScan();
            sendSuccessResult(result, null);
        } else if (call.method.equals("resumeScan")) {
            // resumes easy scanner
            easyScanner.resumeScan();
            sendSuccessResult(result, null);
        } else if (call.method.equals("stopScan")) {
            // stops easy scanner
            easyScanner.stopScan();
            sendSuccessResult(result, null);
        } else {
            result.notImplemented();
        }
    }

    private void runEasyScanner(EasyMode mode) {
        easyScanner = AntivirusController.get().getAntivirus().createEasyScanner();
        easyScanner.scan(mode, new EasyScannerListener(context, channel, easyScanner));
    }

    private void sendSuccessResult(@NonNull MethodChannel.Result result, Object object) {
        handler.post(() -> result.success(object));
    }

}
