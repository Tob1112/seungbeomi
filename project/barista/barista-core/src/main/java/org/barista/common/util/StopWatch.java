package org.barista.common.util;

public class StopWatch {

	private enum Status {
		INITIALIZED,
		STARTED,
		STOPPED,
		BROKEN;
	}

	private static final long BROKEN_LAP_TIME = -1;

	private Status status;
	private long startTime;
	private long finishTime;

	public StopWatch() {
		this.status = Status.INITIALIZED;
	}

	public void start() {
		if (status == Status.INITIALIZED) {
			startTime = System.currentTimeMillis();
			status = Status.STARTED;
		} else {
			status = Status.BROKEN;
		}
	}

	public void stop() {
		if (status == Status.STARTED) {
			finishTime = System.currentTimeMillis();
			status = Status.STOPPED;
		} else {
			status = Status.BROKEN;
		}
	}

	public void reset() {
		status = Status.INITIALIZED;
	}

	public long getLapTime() {
		long lapTime;

		if (status == Status.STOPPED) {
			lapTime = finishTime - startTime;
		} else {
			status = Status.BROKEN;
			lapTime = BROKEN_LAP_TIME;
		}

		return lapTime;
	}
}
