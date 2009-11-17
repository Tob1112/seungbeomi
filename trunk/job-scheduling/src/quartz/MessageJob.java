package quartz;

import java.util.Map;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class MessageJob implements Job{

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		Map properties = context.getMergedJobDataMap();

		System.out.println("Previous Fire Time: " + context.getPreviousFireTime());	//이전 job 실행시간
		System.out.println("Currentf Fire Time: " + context.getFireTime());			//현재 job 실행시간
		System.out.println("Next Fire Time    : " + context.getNextFireTime());		//다음 job 실행시간
		System.out.println(properties.get("message"));
		System.out.println(properties.get("jobDetailMessage"));
		System.out.println(properties.get("triggerMessage"));
		System.out.println("===================================================");
		System.out.println();
	}

}
