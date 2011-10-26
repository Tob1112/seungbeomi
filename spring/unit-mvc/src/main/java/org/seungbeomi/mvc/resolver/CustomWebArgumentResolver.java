/**
 * CustomArgumentResolver.java
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
package org.seungbeomi.mvc.resolver;

import org.apache.log4j.Logger;
import org.seungbeomi.mvc.CustomDTO;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebArgumentResolver;
import org.springframework.web.context.request.NativeWebRequest;

/**
 * 클래스의 내용을 입력해주세요.
 * 
 * @author TSB/sb.son
 */
public class CustomWebArgumentResolver implements WebArgumentResolver {

	private Logger logger = Logger.getLogger(getClass());
	
	public Object resolveArgument(MethodParameter methodParameter, NativeWebRequest nativewebrequest) throws Exception {
		
		Class clazz = methodParameter.getParameterType();
        String paramName = methodParameter.getParameterName();
		
        logger.info("Class Name : " + clazz.getClass().getName() + ", Parameter Name : "  + paramName);
        
		if (methodParameter.getParameterType().equals(CustomDTO.class)) {
			return new CustomDTO("seungbeomi");
		} 
		
		return UNRESOLVED;
	}

}
