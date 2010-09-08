package com.icontact.android;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

public class ContactListAdapter extends ArrayAdapter<Contact> {

	private LayoutInflater inflater;
	private TextView name;
	private TextView phone;

	public ContactListAdapter(Context context, List<Contact> objects) {
		super(context, 0, objects);
		inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = convertView;

		if (convertView == null) {
			view = inflater.inflate(R.layout.contact_row, null);
		}

		Contact contact = this.getItem(position);
		if (contact != null) {
			String name = contact.getName().toString();
			this.name = (TextView) view.findViewById(R.id.name);
			this.name.setText(name);

			String phone = contact.getPhone().toString();
			this.phone = (TextView) view.findViewById(R.id.phone);
			this.phone.setText(phone);
		}

		return view;
	}
}
