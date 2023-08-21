package de.berlin.tu.kaspersky_sdk.model;

/**
 * Listener interface for initialization process controlled by the Antivirus
 * Controller.
 */
public interface SdkInitListener {
    void onInitializationFailed(String reason);
    void onSdkInitialized();
}
