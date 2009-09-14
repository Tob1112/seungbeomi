package jdktimer;

import java.util.Calendar;
import java.util.Timer;

import task.HelloWorldTask;

public class OneOffScheduling {
	public static void main(String[] args) {

		System.out.println("<<< OneOffScheduling");

		// task 1
		Timer t = new Timer();
		t.schedule(new HelloWorldTask(), 3000);

		// task 2
		Calendar cal  = Calendar.getInstance();
		cal.set(2009, Calendar.SEPTEMBER, 15);
		t.schedule(new HelloWorldTask(), cal.getTime());
	}
}
