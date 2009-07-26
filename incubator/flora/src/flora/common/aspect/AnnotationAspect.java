package flora.common.aspect;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class AnnotationAspect{

	private Log logger = LogFactory.getLog(getClass());

	//@Around("execution(public * flora.user.service.*.*(..))")
	@Around("execution(public * flora.*.*(..))")
	public Object invoke(ProceedingJoinPoint proceedingJoinPoint) throws Throwable{

		String className = proceedingJoinPoint.toString();

		if(logger.isInfoEnabled()){
			logger.info("<<< " + className + "() calling!!");
		}

		try {
			// Target class
			Object returnValue = proceedingJoinPoint.proceed();

			if(logger.isInfoEnabled()){
				logger.info("<<< return value is " + returnValue);
			}

			return returnValue;
		} catch (Throwable e) {
			if(logger.isErrorEnabled()){
				logger.error("<<< error occured while processing " );
			}

			throw e;
		} finally {
			if (logger.isInfoEnabled()){
				logger.info("<<< " + className + " processing completed!!");
			}
		}
	}
}
