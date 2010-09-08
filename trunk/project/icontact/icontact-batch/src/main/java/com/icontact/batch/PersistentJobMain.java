package com.icontact.batch;

import java.util.Date;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleTrigger;
import org.quartz.Trigger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class PersistentJobMain {

	public static void main(String[] args) throws SchedulerException {
		ApplicationContext ctx = new FileSystemXmlApplicationContext("classpath:applicationContext-quartz.xml");

		Scheduler scheduler = (Scheduler) ctx.getBean("schedulerFactory");

		JobDetail job = scheduler.getJobDetail("otherJob", Scheduler.DEFAULT_GROUP);

		if (job == null) {
			job = (JobDetail) ctx.getBean("job");
			job.setName("otherJob");
			job.getJobDataMap().put("message", "This is another message");
			Trigger trigger = new SimpleTrigger("simpleTrigger",
					Scheduler.DEFAULT_GROUP, new Date(), null,
					SimpleTrigger.REPEAT_INDEFINITELY, 3000);
			scheduler.scheduleJob(job, trigger);

		}
	}
}
