package quartz;

import java.util.Date;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleTrigger;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;

/**
 * Trigger 에서 제공하는 데이터에 대한 예제와
 * 값을 가지고 있는 두 jobDataMap인스턴스를 병합
 *
 */
public class TriggerMessageScheduling {

	public static void main(String[] args) throws SchedulerException {
		Scheduler scheduler = new StdSchedulerFactory().getScheduler();
		scheduler.start();

		JobDetail jobDetail = new JobDetail("triggerMessageJob", Scheduler.DEFAULT_GROUP, MessageJob.class);
		jobDetail.getJobDataMap().put("message", "this is a message from Quartz");
		jobDetail.getJobDataMap().put("jobDetailMessage", "My job details data.");

		Trigger trigger = new SimpleTrigger("simpleTrigger", Scheduler.DEFAULT_GROUP, new Date(), null, SimpleTrigger.REPEAT_INDEFINITELY, 3000);
		trigger.getJobDataMap().put("message", "message from Trigger");
		trigger.getJobDataMap().put("triggerMessage", "Another trigger message");

		scheduler.scheduleJob(jobDetail, trigger);
	}
}
