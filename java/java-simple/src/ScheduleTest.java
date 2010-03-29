import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;


public class ScheduleTest {

	private ScheduledExecutorService executor = Executors.newScheduledThreadPool(10);
	private volatile boolean running = false;
	private int i = 0;

	public synchronized void beginWatch() {
		if (running) {
			System.out.println("thread is running");
			return;
		}
		try {
			final ScheduledFuture future =
				executor.scheduleAtFixedRate(
					new Runnable() {
						public void run() {
							System.out.println("running " + i);
							i++;

							// 5번째 중지
							if (i > 3) {
								endWatch();
							}
						}
					}, 3, 3, TimeUnit.SECONDS);

				// 용도는??
				executor.schedule(
					new Runnable() {
						public void run() {
							System.out.println("cancel.");
							future.cancel(true);
						}
					}, 3600, TimeUnit.SECONDS);

			running = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public synchronized void endWatch() {
		System.out.println("shutdown operation");
		executor.shutdown();
		try {
			if (executor.awaitTermination(3, TimeUnit.SECONDS)) {
				executor.shutdownNow();
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
			executor.shutdownNow();
			Thread.currentThread().interrupt();
		} finally {
			running = false;
		}
	}

	public static void main(String[] args) {
		new ScheduleTest().beginWatch();
	}
}
