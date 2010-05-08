package xml;

/**
 * XML処理命令です。
 * @author seungbeomi
 */
public class XmlProcessingInstruction {
	/** ターゲットです。 */
	private String target;
	/** データです。 */
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
