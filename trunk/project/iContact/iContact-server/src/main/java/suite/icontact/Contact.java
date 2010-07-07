package suite.icontact;

public class Contact {

	private String username;
	private String name;
	private String phoneType;
	private String phoneValue;
	private String emailType;
	private String emailValue;
	private String addressType;
	private String addressValue;
	private String status;

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneType() {
		return phoneType;
	}
	public void setPhoneType(String phoneType) {
		this.phoneType = phoneType;
	}
	public String getPhoneValue() {
		return phoneValue;
	}
	public void setPhoneValue(String phoneValue) {
		this.phoneValue = phoneValue;
	}
	public String getEmailType() {
		return emailType;
	}
	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}
	public String getEmailValue() {
		return emailValue;
	}
	public void setEmailValue(String emailValue) {
		this.emailValue = emailValue;
	}
	public String getAddressType() {
		return addressType;
	}
	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}
	public String getAddressValue() {
		return addressValue;
	}
	public void setAddressValue(String addressValue) {
		this.addressValue = addressValue;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("Contact[");
		buffer.append(" username = ").append(username);
		buffer.append(" name = ").append(name);
		buffer.append(" phoneType = ").append(phoneType);
		buffer.append(" phoneValue = ").append(phoneValue);
		buffer.append(" emailType = ").append(emailType);
		buffer.append(" emailValue = ").append(emailValue);
		buffer.append(" addressType = ").append(addressType);
		buffer.append(" addressValue = ").append(addressValue);
		buffer.append(" status = ").append(status);
		buffer.append("]");
		return buffer.toString();
	}
}
