package com.syahruromadona.trackr;

import android.Manifest;
import android.os.Build;
import com.getcapacitor.JSObject;
import com.getcapacitor.PermissionState;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.annotation.Permission;
import com.getcapacitor.annotation.PermissionCallback;

// Asks for the Android 13+ notification permission, without which the "recording" notification of the
// background GPS service is hidden. Called from the web app when a recording starts.
@CapacitorPlugin(
    name = "TrackrNotify",
    permissions = { @Permission(strings = { Manifest.permission.POST_NOTIFICATIONS }, alias = "notify") }
)
public class NotifyPermission extends Plugin {

    @PluginMethod
    public void request(PluginCall call) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU || getPermissionState("notify") == PermissionState.GRANTED) {
            resolve(call, true);
            return;
        }
        requestPermissionForAlias("notify", call, "notifyCallback");
    }

    @PermissionCallback
    private void notifyCallback(PluginCall call) {
        resolve(call, getPermissionState("notify") == PermissionState.GRANTED);
    }

    private void resolve(PluginCall call, boolean granted) {
        JSObject r = new JSObject();
        r.put("granted", granted);
        call.resolve(r);
    }
}
