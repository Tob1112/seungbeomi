/**
 * CustomDTO.java
 *
 * Created on   : 2011. 10. 26.
 * Target OS    : Java VM 1.6.0.25 
 * CVS revision : $Revision: $ 
 *
 * ------------------------------------------------------------
 * CHANGE REVISION
 * ------------------------------------------------------------
 * DATE				AUTHOR		REVISION    
 * 2011. 10. 26.		TSB/sb.son		First release.
 */
package org.seungbeomi.mvc;

/**
 * 클래스의 내용을 입력해주세요.
 * 
 * @author TSB/sb.son
 */
public class CustomDTO {

	private String name;
	
	public CustomDTO() {}
	
	public CustomDTO(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
