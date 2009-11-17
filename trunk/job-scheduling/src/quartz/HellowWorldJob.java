package quartz;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * Quartz sample
 */
public class HellowWorldJob implements Job{

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		System.out.println("Hello Quartz!!");

	}

}
