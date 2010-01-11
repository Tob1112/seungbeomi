package org.flora.dao.ibatis.model;

public class TestModel {
	private Integer no;
	private String name;

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
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
			buffer.append("[");
			buffer.append(" no = ").append(no);
			buffer.append(" name = ").append(name);
			buffer.append("]");
			return buffer.toString();
		}

}
