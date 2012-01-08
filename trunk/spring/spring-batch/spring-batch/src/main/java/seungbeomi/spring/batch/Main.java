package seungbeomi.spring.batch;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.repository.JobExecutionAlreadyRunningException;
import org.springframework.batch.core.repository.JobInstanceAlreadyCompleteException;
import org.springframework.batch.core.repository.JobRestartException;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Main {

	public static void main(String[] args) throws JobExecutionAlreadyRunningException, JobRestartException, JobInstanceAlreadyCompleteException, JobParametersInvalidException {
		ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:launch-context.xml");
		ctx.start();
		
		JobLauncher jobLauncher = (JobLauncher) ctx.getBean("jobLauncher");
		Job job = (Job) ctx.getBean("job1");
		JobExecution jobExecution = jobLauncher.run(job, new JobParameters());
	}
}
