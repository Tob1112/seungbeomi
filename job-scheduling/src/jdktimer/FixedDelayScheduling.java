package jdktimer;

import java.util.Timer;

import task.HelloWorldTask;

public class FixedDelayScheduling {
	public static void main(String[] args) {

		System.out.println("<<< FixedDelayScheduling");

		Timer t = new Timer();
		t.schedule(new HelloWorldTask(), 1000, 3000);
	}
}
