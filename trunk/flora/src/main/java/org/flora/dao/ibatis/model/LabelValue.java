package org.flora.dao.ibatis.model;

import java.io.Serializable;
import java.util.Comparator;

public class LabelValue implements Comparable, Serializable{

	// ---------------------------------------------- Properties
	private String label = null;
	private String value = null;

	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getLabel() {
		return this.label;
	}
	public void setLabel(String label) {
		this.label = label;
	}

	// ---------------------------------------------- Constructors
	public LabelValue() {}

	public LabelValue(String label, String value) {
		this.label = label;
		this.value = value;
	}

	// ---------------------------------------------- Public Methods

	public static final Comparator CASE_INSENSITIVE_ORDER = new Comparator() {
		public int compare(Object obj1, Object obj2) {
			String label1 = ((LabelValue) obj1).getLabel();
			String label2 = ((LabelValue) obj2).getLabel();
			return label1.compareToIgnoreCase(label2);
		}
	};

	@Override
	public int compareTo(Object obj) {
		String otherLabel = ((LabelValue) obj).getLabel();
		return this.getLabel().compareTo(otherLabel);
	}

}
