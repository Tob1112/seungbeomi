package seungbeomi.user.aspect;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

@Aspect
public class UserSecurityAspect  {

	private final Log log = LogFactory.getLog(getClass());

	@Before("execution(public * seungbeomi.user..*.*(..))")
	public void before(JoinPoint joinPoint) {
		String method = joinPoint.getSignature().getName();
		log.info(" ++ calling: " + method);
	}

	@AfterReturning(pointcut="execution(public * seungbeomi.user..*.*(..))", returning="returnValue")
	public void afterReturning(JoinPoint joinPoint, Object returnValue) throws Throwable {
		String method = joinPoint.getSignature().getName();
		log.info(" ++ called successfully: " + method + ", returns: " + returnValue);
	}

}
