package de.berlin.tu.kaspersky_sdk;

import android.content.Context;

import com.kavsdk.antivirus.ThreatInfo;
import com.kavsdk.antivirus.easyscanner.EasyObject;
import com.kavsdk.antivirus.easyscanner.EasyResult;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Static methods to parse objects to maps. Required to send them to Flutter.
 */
public class MapConverter {

    public static Map<String, Object> easyResultToMap(EasyResult er, Context context) {
        Map<String, Object> map = new HashMap<>();
        map.put("filesCount", er.getFilesCount());
        map.put("filesScanned", er.getFilesScanned());
        map.put("malwareList", er.getMalwareList()
                .stream()
                .map((ti) -> threatInfoToMap(ti, context))
                .collect(Collectors.toList()));
        map.put("objectsScanned", er.getObjectsScanned());
        map.put("objectsSkipped", er.getObjectsSkipped());
        map.put("riskwareList", er.getRiskwareList()
                .stream()
                .map((ti) -> threatInfoToMap(ti, context))
                .collect(Collectors.toList()));
        return map;
    }

    public static Map<String, Object> threatInfoToMap(ThreatInfo ti, Context context) {
        Map<String, Object> map = new HashMap<>();
        map.put("categories", ti.getCategories()
                .stream()
                .map((vc) -> vc.name())
                .collect(Collectors.toList()));
        map.put("packageName", ti.getPackageName());
        map.put("fileFullPath", ti.getFileFullPath());
        map.put("objectName", ti.getObjectName());
        map.put("severityLevel", ti.getSeverityLevel().name());
        map.put("virusName", ti.getVirusName());
        map.put("isApplication", ti.isApplication());
        map.put("isCloudCheckFailed", ti.isCloudCheckFailed());
        map.put("isDeviceAdminThreat", ti.isDeviceAdminThreat(context));
        return map;
    }

    public static Map<String, Object> easyObjectToMap(EasyObject eo) {
        Map<String, Object> map = new HashMap<>();
        map.put("objectName", eo.getObjectName());
        map.put("packageName", eo.getPackageName());
        map.put("fileFullPath", eo.getFileFullPath());
        return map;
    }
}
