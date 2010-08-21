package jp.co.nikkeibp.itpro.rssreader;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

public class RssListAdapter extends ArrayAdapter<Item>{

	private LayoutInflater mInflater;
	private TextView title;
	private TextView desc;

	public RssListAdapter(Context context, List<Item> objects) {
		super(context, 0, objects);
		mInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
	}

	// 1行ごとのビューを生成する
	@Override
	public View getView(int position, View convertView, ViewGroup parent) {

		View view = convertView;

		if (convertView == null) {
			view = mInflater.inflate(R.layout.item_row, null);
		}

		// 現在参照しているリストの位置からItemを取得する
		Item item = this.getItem(position);
		if (item != null) {
			String title = item.getTitle().toString();
			this.title = (TextView) view.findViewById(R.id.item_title);
			this.title.setText(title);
			String desc = item.getDesc().toString();
			this.desc = (TextView) view.findViewById(R.id.item_desc);
			this.desc.setText(desc);
		}

		return view;
	}

}
