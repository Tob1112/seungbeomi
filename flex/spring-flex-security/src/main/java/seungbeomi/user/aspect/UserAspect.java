package seungbeomi.user.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;

@Aspect
public class UserAspect {

	private Logger logger = LoggerFactory.getLogger(UserAspect.class);

	//@Around("execution(public * examples.account..*.*(..))")
	@Around("execution(public * seungbeomi.user..*.*(..))")
	public Object invoke(ProceedingJoinPoint proceedingJointPoint) throws Throwable {

		String methodName = proceedingJointPoint.getSignature().getName();

		StopWatch stopWatch = new StopWatch();

		if(logger.isInfoEnabled()) {
			logger.debug(" + start : " + methodName + "()");

			Object[] args = proceedingJointPoint.getArgs();
			if((args != null) && (args.length > 0)) {
				for(int i = 0; i < args.length; i++) {
					logger.debug(" + Argument[" + i + "] : " + args[i]);
				}
			}
		}

		try {
			stopWatch.start(methodName);

			Object returnValue = proceedingJointPoint.proceed();

			stopWatch.stop();

			if(logger.isDebugEnabled()) {
				logger.debug(" + return value : " + returnValue);
			}

			return returnValue;

		} catch (Throwable e) {
			if(logger.isErrorEnabled()) {
				logger.error("error accured while processing!!");
				e.printStackTrace();
			}
			throw e;
		} finally {
			if(logger.isDebugEnabled()) {
				logger.debug(" + finish : " + methodName + "()");
				logger.debug("time : " + stopWatch.getTotalTimeSeconds() + " seconds");
			}
		}
	}
}
