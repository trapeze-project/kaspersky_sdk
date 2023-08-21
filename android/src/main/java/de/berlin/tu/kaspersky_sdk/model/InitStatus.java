package de.berlin.tu.kaspersky_sdk.model;

public enum InitStatus {
    notInitiated,
    initInProgress,
    initiatedSuccessfully,
    insufficientPermissions,
    needNewLicenseCode,
    initAntivirusFailed,
    initFailed;
}
