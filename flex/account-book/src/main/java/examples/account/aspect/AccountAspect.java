package examples.account.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;

@Aspect
public class AccountAspect {

	private Logger logger = LoggerFactory.getLogger(AccountAspect.class);

	@Around("execution(public * examples.account..*.*(..))")
	public Object invoke(ProceedingJoinPoint proceedingJointPoint) throws Throwable {

		String methodName = proceedingJointPoint.getSignature().getName();

		StopWatch stopWatch = new StopWatch();

		if(logger.isInfoEnabled()) {
			logger.info("calling : " + methodName + "()");

			Object[] args = proceedingJointPoint.getArgs();
			if((args != null) && (args.length > 0)) {
				for(int i = 0; i < args.length; i++) {
					logger.info("Argument[" + i + "] : " + args[i]);
				}
			}
		}

		try {
			stopWatch.start(methodName);

			Object returnValue = proceedingJointPoint.proceed();

			stopWatch.stop();

			if(logger.isInfoEnabled()) {
				logger.info("return value : " + returnValue);
			}

			return returnValue;

		} catch (Throwable e) {
			if(logger.isErrorEnabled()) {
				e.printStackTrace();
			}
			throw e;
		} finally {
			if(logger.isInfoEnabled()) {
				logger.info("finish call : " + methodName + "()");
				logger.debug("time : " + stopWatch.getTotalTimeSeconds() + " seconds");
			}
		}
	}
}
