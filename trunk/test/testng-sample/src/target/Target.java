package target;

public class Target {

	public int add(int a, int b) {
		return a+b;
	}

	public void throwException() {
		throw new RuntimeException("exception!!");
	}

}
