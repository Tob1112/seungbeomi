package validators;

public class ValidateBean extends Object {

    private String name;
    private String email;
    private int age;

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("ValidateBean[");
		buffer.append("age = ").append(age);
		buffer.append(" email = ").append(email);
		buffer.append(" name = ").append(name);
		buffer.append("]");
		return buffer.toString();
	}

}
