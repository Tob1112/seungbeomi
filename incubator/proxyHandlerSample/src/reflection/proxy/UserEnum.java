package reflection.proxy;

import java.util.HashMap;
import java.util.Map;

public interface UserEnum {

	public static enum UserType {
		DEVELOPER("1", "Developer"),
		PROJECT_MANAGER("2", "Project Manager"),
		OTHER("3","other");

		private static final Map<String, UserType> map = new HashMap<String, UserType>();
		private String code;
		private String value;

		static {
			UserType[] userTypes;

			userTypes = UserType.values();
			for (int i=0; i < userTypes.length; i++) {
				map.put(userTypes[i].toString(), userTypes[i]);
			}
		}

		UserType(String code, String value) {
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

		public static UserType fromCode(String code) {
			return map.get(code);
		}
	}
}
