package quartz;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Map;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;
import org.quartz.impl.calendar.HolidayCalendar;

/**
 * Calendar 인터페이스를 통해 트리거가 동작하지 않는 날 설정가능
 *
 */
public class CronWithCalendarExample {

	public static void main(String[] args) throws SchedulerException, ParseException {
		Scheduler scheduler = new StdSchedulerFactory().getScheduler();
		scheduler.start();

		// 제외할 날짜에 대하 calendar 생성
		Calendar calendar = Calendar.getInstance();
		calendar.set(2009, Calendar.DECEMBER, 25);

		HolidayCalendar holiday = new HolidayCalendar();
		holiday.addExcludedDate(calendar.getTime());

		// 스케줄에 추가
		scheduler.addCalendar("xmasCalendar", holiday, true, false);

		JobDetail jobDetail = new JobDetail("messageJob", Scheduler.DEFAULT_GROUP, MessageJob.class);

		Map map = jobDetail.getJobDataMap();
		map.put("message", "This is a message from Quartz");

		String cronExpression = "3/5 * 21,22,23 * * ?";

		Trigger trigger = new CronTrigger("cronTrigger", Scheduler.DEFAULT_GROUP, cronExpression);
		trigger.setCalendarName("xmasCalendar");

		scheduler.scheduleJob(jobDetail, trigger);

	}
}
