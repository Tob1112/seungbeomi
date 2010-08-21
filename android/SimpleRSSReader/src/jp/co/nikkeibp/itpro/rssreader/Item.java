package jp.co.nikkeibp.itpro.rssreader;

public class Item {

	private CharSequence title;

	private CharSequence desc;

	public Item() {
		title = "";
		desc = "";
	}

	public CharSequence getTitle() {
		return title;
	}

	public void setTitle(CharSequence title) {
		this.title = title;
	}

	public CharSequence getDesc() {
		return desc;
	}

	public void setDesc(CharSequence desc) {
		this.desc = desc;
	}
}
