package task;

import java.util.TimerTask;

public class HelloWorldTask extends TimerTask{

	@Override
	public void run() {
		System.out.println("Hello world!");

	}

}
