package org.chronos.domain;

import java.util.HashMap;
import java.util.Map;

public interface ChronosEnum {

	public static enum ShinseiKubun {
		KINMUHYO("01", "勤務表"),
		KOUTSUHI("02", "交通費");

		private static final Map<String, ShinseiKubun> map = new HashMap<String, ShinseiKubun>();
		private String code;
		private String value;

		static {
			ShinseiKubun[] shinseiKubun;

			shinseiKubun = ShinseiKubun.values();
			for (int i = 0; i < shinseiKubun.length; i++) {
				map.put(shinseiKubun[i].toString(), shinseiKubun[i]);
			}
		}

		ShinseiKubun(String code, String value) {
			this.code = code;
			this.value = value;
		}

		@Override
		public String toString() {
			return this.code;
		}

		public String getValue() {
			return this.value;
		}

		public static ShinseiKubun fromCode(String code) {
			return map.get(code);
		}
	}
}
