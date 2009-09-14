package jdktimer;

import java.util.Timer;

import task.HelloWorldTask;

public class FixedRateScheduling {
	public static void main(String[] args) {
		Timer t = new Timer();
		t.scheduleAtFixedRate(new HelloWorldTask(), 1000, 1000);
	}
}
