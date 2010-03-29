package user.model;

/**
 * 사용자 관리를 위하여 필요한 도메인 클래스.
 * USERINFO 테이블의 각 칼럼에 해당하는 setter와 getter를 가진다. 
 */
public class User {
	private String userId = null;
	private String password = null;
	private String name = null;
	private String email = null;

	public String getEmail() {
		return email;
	}

	public String getName() {
		return name;
	}

	public String getPassword() {
		return password;
	}

	public String getUserId() {
		return userId;
	}

	public void setEmail(String string) {
		email = string;
	}

	public void setName(String string) {
		name = string;
	}

	public void setPassword(String string) {
		password = string;
	}

	public void setUserId(String string) {
		userId = string;
	}
	
	/**
	 * 비밀번호가 일치하는지 여부를 결정하는 메써드.
	 */
	public boolean isMatchPassword(String inputPassword){
		if ( getPassword().equals(inputPassword)){
			return true;
		} else {
			return false;
		}
	}
}
