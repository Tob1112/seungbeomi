package com.mamezou.android.bmilog;

import android.app.ListActivity;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.widget.ArrayAdapter;

public class BMILogActivity extends ListActivity {
	
	private static final String PREFERENCE_NAME = "BMI_LIST";
	private static final String PREFERENCE_KEY = "PREFERENCE_KEY";
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        SharedPreferences preferences = getSharedPreferences(PREFERENCE_NAME, MODE_PRIVATE);
        Uri uri = getIntent().getData();
        if (uri != null) {
        	String[] measurements = uri.getQueryParameter("measurements").split(",");
        	String result = getString(R.string.label_height) + measurements[0] + ", "
        			+ getString(R.string.label_weight) + measurements[1] + ", "
        			+ getString(R.string.label_bmi) + measurements[2];
        	
        	SharedPreferences.Editor editor = preferences.edit();
        	editor.putString(PREFERENCE_KEY, preferences.getString(PREFERENCE_KEY, "") + result + "/");
        	editor.commit();
         }
         setListAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, preferences.getString(PREFERENCE_KEY, "").split("/")));
         getListView().setTextFilterEnabled(true);
    }
}