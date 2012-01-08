package seungbeomi.spring.quartz;

import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;


public class PersistentJob implements StatefulJob {

	private Logger logger = Logger.getLogger(getClass());
	
	public void execute(JobExecutionContext context) throws JobExecutionException {
		Map map = context.getJobDetail().getJobDataMap();

		System.out.println(">>> [" + context.getJobDetail().getName() + "] " + map.get("message"));
		
		map.put("message", "Updated Message");
	}

}
