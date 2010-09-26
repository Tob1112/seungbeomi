package seungbeomi.util;

public class XmlProcessingInstruction {
	private String target;
	private String data;

	public XmlProcessingInstruction(String target, String data) {
		this.target = target;
		this.data = data;
	}

	public String getTarget() {
		return this.target;
	}

	public String getData() {
		return this.data;
	}
}
