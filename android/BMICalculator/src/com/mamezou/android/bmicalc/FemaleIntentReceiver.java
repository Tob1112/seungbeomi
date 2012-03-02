package com.mamezou.android.bmicalc;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

public class FemaleIntentReceiver extends BroadcastReceiver {

	@Override
	public void onReceive(Context context, Intent intent) {
		Bundle bundle = intent.getExtras();
		int height = bundle.getInt("HEIGHT");
		int weight = bundle.getInt("WEIGHT");
		int bmi = 10000 * weight / height / height;
		
		StringBuffer message = new StringBuffer();
		message.append(context.getText(R.string.label_bmi_description));
		message.append(bmi);
		message.append(" ");
		message.append(context.getText(R.string.label_female));
		
		if (bmi > 22) {
			message.append(context.getText(R.string.label_too_fat));
		} else if (bmi < 21) {
			message.append(context.getText(R.string.label_too_slim));
		} else {
			message.append(context.getText(R.string.label_standard));
		}
		
		Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
	}

}
