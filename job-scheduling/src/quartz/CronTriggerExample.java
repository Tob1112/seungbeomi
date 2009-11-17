package quartz;

import java.text.ParseException;
import java.util.Map;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;

public class CronTriggerExample {
	public static void main(String[] args) throws SchedulerException, ParseException {
		Scheduler scheduler = new StdSchedulerFactory().getScheduler();
		scheduler.start();

		JobDetail jobDetail = new JobDetail("messageJob", Scheduler.DEFAULT_GROUP, MessageJob.class);

		Map map = jobDetail.getJobDataMap();
		map.put("message", "This is a message from Quartz");

		// 3/5 : 매 분 3초에 시작하여 5초마다
		// *   : 매 분
		// 14,15,16,17 : 오후 2:00에서 오후 5:59까지만 동작
		// *   : 매 달
		// *   : 매 년
		// ?   : 모든 요일
		String cronExpression = "3/5 * 14,15,16,17 * * ?";

		Trigger trigger = new CronTrigger("cronTrigger", Scheduler.DEFAULT_GROUP, cronExpression);
		scheduler.scheduleJob(jobDetail, trigger);
	}
}
