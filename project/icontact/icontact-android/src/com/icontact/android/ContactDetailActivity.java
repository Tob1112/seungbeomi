package com.icontact.android;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class ContactDetailActivity extends Activity{

	private TextView name;
	private TextView phone;
	private TextView email;
	private TextView address;
	private TextView notes;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.contact_detail);

		Intent intent = getIntent();

		String name = intent.getStringExtra("NAME");
		this.name = (TextView) findViewById(R.id.detail_name);
		this.name.setText(name);
		String phone = intent.getStringExtra("PHONE");
		this.phone = (TextView) findViewById(R.id.detail_phone);
		this.phone.setText(phone);
		String email = intent.getStringExtra("EMAIL");
		this.email = (TextView) findViewById(R.id.detail_email);
		this.email.setText(email);
		String address = intent.getStringExtra("ADDRESS");
		this.address = (TextView) findViewById(R.id.detail_address);
		this.address.setText(address);
		String notes = intent.getStringExtra("NOTES");
		this.notes = (TextView) findViewById(R.id.detail_notes);
		this.notes.setText(notes);
	}

}
