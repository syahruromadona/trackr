package com.syahruromadona.trackr;

import android.os.Bundle;
import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        registerPlugin(NotifyPermission.class);
        super.onCreate(savedInstanceState);
    }
}
