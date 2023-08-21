package de.berlin.tu.kaspersky_sdk.model;

import com.kavsdk.shared.iface.ServiceState;
import com.kavsdk.shared.iface.ServiceStateStorage;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import de.berlin.tu.kaspersky_sdk.KasperskySdkPlugin;

public class DataStorage implements ServiceStateStorage {

    public static final Object GENERAL_SETTINGS_STORAGE = null;

    public DataStorage() {
    }

    @Override
    public void read(ServiceState state) throws IOException {
        FileInputStream stream = new FileInputStream("/sw-state.dat");
        try {
            state.load(stream);
        } finally {
            stream.close();
        }
    }

    @Override
    public void write(ServiceState state) throws IOException {
        FileOutputStream stream = new FileOutputStream("/sw-state.dat");
        try {
            state.save(stream);
        } finally {
            stream.close();
        }
    }
}
