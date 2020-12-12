package com.technocrat.simple_call_recording_app;


import android.content.Intent;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/callrecording";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getcallrecording")) {
                                getcallrecording();


                            }
                            if(call.method.equals("stopcallrecording")){
                                stopcallrecording();

                            }

                        }
                );
    }
     public void getcallrecording() {
         if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP){
             Intent intent = new Intent(this,RecordingService.class);
            startService(intent);


        }


    }
    private void stopcallrecording() {
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            Intent intent = new Intent(this,RecordingService.class);
            stopService(intent);
        }
    }



}