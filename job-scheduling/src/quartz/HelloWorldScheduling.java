package quartz;

import java.util.Date;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleTrigger;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;

/**
 * scheduler 인스턴스 취득 -> job에 대한 정보를 담고 있는 JobDetail -> job을 관장하는 트리거 작성
 */
public class HelloWorldScheduling {
	public static void main(String[] args) throws SchedulerException {
		Scheduler scheduler = new StdSchedulerFactory().getScheduler();
		scheduler.start();

		JobDetail jobDetail = new JobDetail("helloWorldJob", Scheduler.DEFAULT_GROUP, HellowWorldJob.class);

		Trigger trigger = new SimpleTrigger("simpleTrigger", Scheduler.DEFAULT_GROUP, new Date(), null, SimpleTrigger.REPEAT_INDEFINITELY, 3000);

		scheduler.scheduleJob(jobDetail, trigger);
	}
}
 