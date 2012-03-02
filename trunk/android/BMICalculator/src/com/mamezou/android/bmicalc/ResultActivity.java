package com.mamezou.android.bmicalc;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class ResultActivity extends Activity {

	private int height = 0;
	private int weight = 0;
	private int bmi = 0;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.result);
		
		TextView bmiValue = (TextView) findViewById(R.id.label_bmivalue);
		TextView status = (TextView) findViewById(R.id.label_status);
		Button saveResult = (Button) findViewById(R.id.button_save_result);
		Button close = (Button) findViewById(R.id.button_close_current_activity);
		
		Bundle extras = getIntent().getExtras();
		if (extras != null) {
			height = extras.getInt("HEIGHT");
			weight = extras.getInt("WEIGHT");
			bmi = 10000 * weight / height / height;
			bmiValue.setText(String.valueOf(bmi));
			if (bmi > 24) {
				status.setText(R.string.label_too_fat);
			} else if (bmi < 18) {
				status.setText(R.string.label_too_slim);
			} else {
				status.setText(R.string.label_standard);
			}
		}
		
		saveResult.setOnClickListener(saveResultListener);
		close.setOnClickListener(closeListener);
	}
	
	private View.OnClickListener saveResultListener = new View.OnClickListener() {
		@Override
		public void onClick(View view) {
			SharedPreferences preferences = getSharedPreferences("PREVIOUS_RESULT", MODE_PRIVATE);
			SharedPreferences.Editor editor = preferences.edit();
			editor.putInt("PREVIOUS_HEIGHT", height);
			editor.putInt("PRIVIOUS_WEIGHT", weight);
			editor.commit();
			setResult(RESULT_OK);
			finish();
		}
	};
	private View.OnClickListener closeListener = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			setResult(RESULT_CANCELED);
			finish();
		}
	};
}
