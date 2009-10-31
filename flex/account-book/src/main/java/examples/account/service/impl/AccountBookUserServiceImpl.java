package examples.account.service.impl;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import examples.account.dao.AccountBookUserDao;
import examples.account.entity.AccountBookUser;
import examples.account.service.AccountBookUserService;
import flex.messaging.MessageBroker;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.util.UUIDUtils;

@Service("accountBookUserService")
@RemotingDestination
public class AccountBookUserServiceImpl implements AccountBookUserService {

	protected static Logger logger = Logger.getLogger(AccountBookUserServiceImpl.class);

	@Autowired
	protected AccountBookUserDao accountBookUserDao;

	protected ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);

	protected volatile boolean running = false;

	public AccountBookUserServiceImpl() {
	}

	public void setAccountBookUserDao(AccountBookUserDao accountBookUserDao) {
		this.accountBookUserDao = accountBookUserDao;
	}

	public synchronized void beginWatch() {
		if (running) {
			return;
		}
		final ScheduledFuture<?> future = executor.scheduleAtFixedRate(
				new Runnable() {

					public void run() {
						logger.debug("get count");
						int count = accountBookUserDao.getCount();
						notifyToClient(new Integer(count));
					}

				}, 3, 3, TimeUnit.SECONDS);
		executor.schedule(new Runnable() {

			public void run() {
				logger.debug("cancel.");
				future.cancel(true);
			}

		}, 3600, TimeUnit.SECONDS);
		running = true;
	}

	public synchronized void endWatch() {
		logger.debug("shutdown operation");
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

	public List<AccountBookUser> findAll() {
		return accountBookUserDao.findAll();
	}

	protected void notifyToClient(Object body) {
		MessageBroker msgBroker = MessageBroker.getMessageBroker(null);
		String clientID = UUIDUtils.createUUID();
		AsyncMessage msg = new AsyncMessage();
		msg.setDestination("accountBookUserServiceChange");
		msg.setClientId(clientID);
		msg.setMessageId(UUIDUtils.createUUID());
		msg.setTimestamp(System.currentTimeMillis());
		msg.setBody(body);
		msgBroker.routeMessageToService(msg, null);
	}

}
