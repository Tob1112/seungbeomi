package org.chronos.domain;

import java.util.HashMap;
import java.util.Map;

public interface ChronosEnum {

	/** 申請区分 */
	public static enum ShinseiKubun {
		KINMUHYO("01", "勤務表"),		// 勤務表
		KOUTSUHI("02", "交通費");		// 交通費

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

	/** 申請状況 */
	public static enum ShinseiJokyo {
		SAKUSEITYU("00","作成中"),				// 作成中
		UKETSUKE_KANRYO("01", "受付完了"),		// 受付完了
		KAKUNINTYU("02", "確認中"),				// 確認中
		TORISAGE("03", "取下"),					// 取下
		TORISAGE_KAKUNINTYU("04", "取下確認中"),	// 取下確認中
		SHINSEI_KANRYO("05", "申請完了"),			// 申請完了
		SHINSEI_ERROR("99","申請エラー");			// 申請エラー

		private static final Map<String, ShinseiJokyo> map = new HashMap<String, ShinseiJokyo>();
		private String code;
		private String value;

		static {
			ShinseiJokyo[] shinseiJokyo;

			shinseiJokyo = ShinseiJokyo.values();
			for (int i = 0; i < shinseiJokyo.length; i++) {
				map.put(shinseiJokyo[i].toString(), shinseiJokyo[i]);
			}
		}

		ShinseiJokyo(String code, String value) {
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

		public static ShinseiJokyo fromCode(String code) {
			return map.get(code);
		}
	}
}
