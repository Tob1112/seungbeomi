package jp.co.nikkeibp.itpro.rssreader;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class ItemDetailActivity extends Activity{

	private TextView title;
	private TextView desc;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.item_detail);

		Intent intent = getIntent();

		String title = intent.getStringExtra("TITLE");
		this.title = (TextView) findViewById(R.id.item_detail_title);
		this.title.setText(title);
		String desc = intent.getStringExtra("DESCRIPTION");
		this.desc = (TextView) findViewById(R.id.item_detail_desc);
		this.desc.setText(desc);
	}
}
