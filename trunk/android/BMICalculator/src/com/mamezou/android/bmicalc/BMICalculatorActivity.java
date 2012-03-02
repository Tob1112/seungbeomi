package com.mamezou.android.bmicalc;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class BMICalculatorActivity extends Activity {
	
	private static final String DEBUG = "DEBUG";
	public static final String ACTION_CALCULATE_BMI = "com.mamezou.android.intent.action.CALCULLATE_BMI";
	public static final String ACTION_CALCULATE_BMI_WITH_URI = "com.mamezou.android.intent.action.CALCULLATE_BMI_WITH_URI";
	public static final String CATEGORY_MALE = "com.mamezou.android.intent.category.bmi.MALE";
	
	private EditText textHeight;
	private EditText textWeight;
	private TextView labelPreviousHeight;
	private TextView labelPreviousWeight;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.v(DEBUG, "onCreate was called...");
        setContentView(R.layout.main);
        
        textHeight = (EditText) findViewById(R.id.text_height);
        textWeight = (EditText) findViewById(R.id.text_weight);
        Button button = (Button) findViewById(R.id.button_calculate);
        Button buttonShowNextActivity = (Button) findViewById(R.id.button_show_next_activity);
        labelPreviousHeight = (TextView) findViewById(R.id.label_previous_height);
        labelPreviousWeight = (TextView) findViewById(R.id.label_previous_weight);
        Button buttonBroadcastWithAction = (Button) findViewById(R.id.button_broadcast_with_action);
        Button buttonBroadcastWithCategory = (Button) findViewById(R.id.button_broadcast_with_category);
        Button buttonBroadcastWithUri = (Button) findViewById(R.id.button_broadcast_with_uri);
        
        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(R.string.label_bmi_description);
        builder.setPositiveButton(R.string.button_close_dialog, new DialogInterface.OnClickListener() {
			@Override
			public void onClick(DialogInterface dialog, int which) {
				setResult(RESULT_OK);
			}
		});
        
        button.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				EditText textHeight = (EditText) findViewById(R.id.text_height);
				EditText textWeight = (EditText) findViewById(R.id.text_weight);
				int height = Integer.parseInt(textHeight.getText().toString());
				int weight = Integer.parseInt(textWeight.getText().toString());
				int bmi = 10000 * weight / height / height;
				builder.setMessage(String.valueOf(bmi));
				builder.create();
				builder.show();
			}
		});
        
        buttonShowNextActivity.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(BMICalculatorActivity.this, ResultActivity.class);
				intent.putExtra("HEIGHT", Integer.parseInt(textHeight.getText().toString()));
				intent.putExtra("WEIGHT", Integer.parseInt(textWeight.getText().toString()));
				startActivityForResult(intent, 0);
			}
		});
        
        buttonBroadcastWithAction.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ACTION_CALCULATE_BMI);
				intent.putExtra("HEIGHT", Integer.parseInt(textHeight.getText().toString()));
				intent.putExtra("WEIGHT", Integer.parseInt(textWeight.getText().toString()));
				sendBroadcast(intent);
			}
		});
        
        buttonBroadcastWithCategory.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ACTION_CALCULATE_BMI);
				intent.addCategory(CATEGORY_MALE);
				intent.putExtra("HEIGHT", Integer.parseInt(textHeight.getText().toString()));
				intent.putExtra("WEIGHT", Integer.parseInt(textWeight.getText().toString()));
				sendBroadcast(intent);
			}
		});
        
        buttonBroadcastWithUri.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ACTION_CALCULATE_BMI_WITH_URI);
				Uri uri = Uri.parse("bmi:///female");
				intent.setData(uri);
				intent.putExtra("HEIGHT", Integer.parseInt(textHeight.getText().toString()));
				intent.putExtra("WEIGHT", Integer.parseInt(textWeight.getText().toString()));
				sendBroadcast(intent);
			}
		});
    }
    
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    	if (resultCode == RESULT_OK) {
    		SharedPreferences preferences = getSharedPreferences("PREVIOUS_RESULT", MODE_PRIVATE);
    		labelPreviousHeight.setText(String.valueOf(preferences.getInt("PREVIOUS_HEIGHT", 0)));
    		labelPreviousWeight.setText(String.valueOf(preferences.getInt("PREVIOUS_WEIGHT", 0)));
    	}
    }
    
    @Override
    protected void onStart() {
    	super.onStart();
    	Log.v(DEBUG, "onStart was called...");
    }
    @Override
    protected void onRestart() {
    	super.onRestart();
    	Log.v(DEBUG, "onRestart was called...");
    }
    @Override
    protected void onResume() {
    	super.onResume();
    	Log.v(DEBUG, "onResume was called...");
    }
    @Override
    protected void onPause() {
    	super.onPause();
    	Log.v(DEBUG, "onPause was called...");
    }
    @Override
    protected void onStop() {
    	super.onStop();
    	Log.v(DEBUG, "onStop was called...");
    }
    @Override
    protected void onDestroy() {
    	super.onDestroy();
    	Log.v(DEBUG, "onDestroy was called...");
    }
    
    @Override
    public void onConfigurationChanged(Configuration newConfig) {
    	super.onConfigurationChanged(newConfig);
    	Log.v(DEBUG, "onConfigurationChanged was called...");
    }
}