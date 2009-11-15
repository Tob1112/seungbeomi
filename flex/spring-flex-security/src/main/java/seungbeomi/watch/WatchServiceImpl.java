package seungbeomi.watch;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import edu.emory.mathcs.backport.java.util.concurrent.Executors;
import edu.emory.mathcs.backport.java.util.concurrent.ScheduledExecutorService;
import edu.emory.mathcs.backport.java.util.concurrent.ScheduledFuture;
import flex.messaging.MessageBroker;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.util.UUIDUtils;

import seungbeomi.user.ibatis.dao.UserDao;
import seungbeomi.user.model.User;

public class WatchServiceImpl implements WatchService{

	public Logger logger = Logger.getLogger(getClass());

	@Autowired
	private UserDao dao;
	private ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);

	private volatile boolean running = false;

	public void beginWatch() {
		if (running) {
			return;
		}
		final ScheduledFuture future = executor.scheduleAtFixedRate(
				new Runnable(){
					public void run() {
						logger.info(" + get count");
						int count = dao.getCount();
						notifyToClient(new Integer(count));
					}
				}
				, 3, 3, TimeUnit.SECONDS);

	}

	public void endWatch() {
		// TODO Auto-generated method stub

	}

	public List<User> findUsers() {
		// TODO Auto-generated method stub
		return null;
	}
	
	private void notifyToClient() {
		MessageBroker msgBroker = MessageBroker.getMessageBroker(null);
		String clientID = UUIDUtils.createUUID();
		AsyncMessage msg = new AsyncMessage();
		msg.setDestination("");
		msg
	}

}
