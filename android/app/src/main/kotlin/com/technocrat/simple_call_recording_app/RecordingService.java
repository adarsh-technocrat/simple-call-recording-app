package com.technocrat.simple_call_recording_app;

import android.app.Service;
import android.content.Intent;
import android.media.MediaRecorder;
import android.os.Environment;
import android.os.IBinder;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.text.format.DateFormat;

import androidx.annotation.Nullable;

import java.io.File;
import java.io.IOException;
import java.util.Date;

public class RecordingService extends Service {
    private MediaRecorder mediaRecorder;
    private boolean startCallRecord;
    private File  file;
    String path="/sdcard/alarms/";

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
//        return super.onStartCommand(intent, flags, startId);

        file = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_ALARMS);
        Date date = new Date();
        CharSequence charSequence = DateFormat.format("MM-ddd-yy-hh-mm-ss",date.getTime());
       mediaRecorder =new MediaRecorder();
       mediaRecorder.setAudioSource(MediaRecorder.AudioSource.VOICE_CALL);
       mediaRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
       mediaRecorder.setOutputFile(file.getAbsolutePath()+"/"+charSequence+"record.3gp");
       mediaRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);

        TelephonyManager telephonyManager = (TelephonyManager)getApplicationContext().getSystemService(getApplicationContext().TELEPHONY_SERVICE);
        telephonyManager.listen(new PhoneStateListener(){
            @Override
            public void onCallStateChanged(int state, String phoneNumber) {
//                super.onCallStateChanged(state, phoneNumber){
                    if(TelephonyManager.CALL_STATE_IDLE==state && mediaRecorder==null){
                        mediaRecorder.stop();
                        mediaRecorder.reset();
                        mediaRecorder.release();
                        startCallRecord = false;
                        stopSelf();
                    } else if(TelephonyManager.CALL_STATE_OFFHOOK==state){
                        try {
                            mediaRecorder.prepare();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        mediaRecorder.start();
                        startCallRecord = true;
                    }
                }
//            }
        }, PhoneStateListener.LISTEN_CALL_STATE);
        return  START_STICKY;
    }
}
