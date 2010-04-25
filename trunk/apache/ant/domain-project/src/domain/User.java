package domain;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class User {
	private Log log = LogFactory.getLog(getClass());
	
	private String no;
	private String password;
	private String name;
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	/**
		 * 
		 * @return 
		 * @author 
		 */
		public String toString() {
			StringBuffer buffer = new StringBuffer();
			buffer.append("User[");
			buffer.append(" no = ").append(no);
			buffer.append(" password = ").append(password);
			buffer.append(" name = ").append(name);
			buffer.append("]");
			return buffer.toString();
		}
	
}
