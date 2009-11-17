package quartz;

import java.util.Date;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleTrigger;
import org.quartz.Trigger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class SpringWithJobPersistence {

	public static void main(String[] args) throws SchedulerException {

		ApplicationContext ctx = new FileSystemXmlApplicationContext("src/quartz/PersistentJob-schedule.xml");

		// get the scheduler
		Scheduler scheduler = (Scheduler) ctx.getBean("schedulerFactory");

		// 잡 존재여부 확인, 어플리케이션에서 다음으로 실행할 잡을 덮어쓰는 일을 방지
		JobDetail jobDetail = scheduler.getJobDetail("otherJob", Scheduler.DEFAULT_GROUP);

		if (jobDetail == null) {
			// the job has not yet been created
			jobDetail = (JobDetail) ctx.getBean("job");
			jobDetail.setName("otherJob");
			jobDetail.getJobDataMap().put("message", "This is another message");

			Trigger trigger = new SimpleTrigger("simpleTrigger", Scheduler.DEFAULT_GROUP, new Date(), null, SimpleTrigger.REPEAT_INDEFINITELY, 3000);

			scheduler.scheduleJob(jobDetail, trigger);
		}
	}
}
