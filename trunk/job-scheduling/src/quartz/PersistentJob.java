package quartz;

import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

/**
 * 영속적인 잡을 사용하면 쿼츠에 실시간으로 잡을 추가했을때 나중에 다시 시작해도 어플리케이션에 그대로 남는다.
 * 여러 잡 실행 사이에 넘겨진 JobDataMap을 수정할 수 있기 때문에 변경 사항은 어플리케이션을 재시작한 다음에도 영향을 미칠것이다.
 */
public class PersistentJob implements StatefulJob {

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		Map map = context.getJobDetail().getJobDataMap();
		System.out.println("[" + context.getJobDetail().getName() + "]" + map.get("message"));
		map.put("message", "Updated Message");
	}

}
