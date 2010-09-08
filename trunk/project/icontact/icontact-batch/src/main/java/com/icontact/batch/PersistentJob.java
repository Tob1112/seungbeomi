package com.icontact.batch;

import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

public class PersistentJob implements StatefulJob{

	public void execute(JobExecutionContext context) throws JobExecutionException {
		Map map = context.getJobDetail().getJobDataMap();
		System.out.println("[" + context.getJobDetail().getName() + "]" + map.get("message"));
		map.put("message", "Update Message");
	}

}
