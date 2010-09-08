package com.icontact.android;

import java.util.ArrayList;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.widget.ListView;

public class IContactActivity extends ListActivity {

	private static final int MENU_ITEM_NEW_CONTACT = Menu.FIRST;

	private ArrayList<Contact> contacts;
	private ContactListAdapter adapter;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        contacts = new ArrayList<Contact>();
        adapter = new ContactListAdapter(this, contacts);

        setListAdapter(adapter);

        for (int i=0; i < 10; i++) {
        	adapter.add(new Contact());
        }
    }

    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
    	Contact contact = contacts.get(position);
    	Intent intent = new Intent(this, ContactDetailActivity.class);
    	intent.putExtra("NAME", contact.getName());
    	intent.putExtra("PHONE", contact.getPhone());
    	intent.putExtra("EMAIL", contact.getEmail());
    	intent.putExtra("ADDRESS", contact.getAddress());
    	intent.putExtra("NOTES", contact.getNotes());
    	startActivity(intent);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
    	boolean result = super.onCreateOptionsMenu(menu);
    	menu.add(0, MENU_ITEM_NEW_CONTACT, 0, "New Contact");
    	return result;
    }
}