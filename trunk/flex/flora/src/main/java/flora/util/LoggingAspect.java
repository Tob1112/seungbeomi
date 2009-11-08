package flora.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

import org.springframework.util.StopWatch;

@Aspect
public class LoggingAspect {

	private Log log = LogFactory.getLog(getClass());

	// @Around("execution(public * examples.account..*.*(..))")
	@Around("execution(public * flora.service.impl..*.*(..))")
	public Object invoke(ProceedingJoinPoint proceedingJointPoint)
			throws Throwable {

		String methodName = proceedingJointPoint.getSignature().getName();

		StopWatch stopWatch = new StopWatch();

		log.info(" + start : " + methodName + "()");

		Object[] args = proceedingJointPoint.getArgs();
		if ((args != null) && (args.length > 0)) {
			for (int i = 0; i < args.length; i++) {
				log.info(" + Argument[" + i + "] : " + args[i]);
			}
		}

		try {
			stopWatch.start(methodName);

			Object returnValue = proceedingJointPoint.proceed();

			stopWatch.stop();

			log.info(" + return value : " + returnValue);

			return returnValue;

		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		} finally {
			log.info(" + finish : " + methodName + "()");
			log.info(" + time : " + stopWatch.getTotalTimeSeconds() + " seconds");
		}
	}
}
