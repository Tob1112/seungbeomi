package org.april.util;

import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;

public class LoggingAspect {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	public Object logging(ProceedingJoinPoint proceedingJointPoint) throws Throwable {

		String methodName = proceedingJointPoint.getSignature().getName();

		StopWatch stopWatch = new StopWatch();

		if (logger.isDebugEnabled()) {
			logger.debug("Start : " + methodName + "()");

			Object[] args = proceedingJointPoint.getArgs();
			if ((args != null) && (args.length > 0)) {
				for (int i = 0; i < args.length; i++) {
					logger.debug("Argument[" + i + "] : " + args[i]);
				}
			}
		}

		try {
			stopWatch.start(methodName);

			Object returnValue = proceedingJointPoint.proceed();

			stopWatch.stop();

			if (logger.isDebugEnabled()) {
				logger.debug("Return value : " + returnValue);
			}

			return returnValue;

		} catch (Exception e) {
			if (logger.isErrorEnabled()) {
				logger.error("Error accured while processing!!" + e);
			}
			throw e;
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Time : " + stopWatch.getTotalTimeSeconds() + " seconds");
				logger.debug("Finish : " + methodName + "()");
			}
		}
	}

}
