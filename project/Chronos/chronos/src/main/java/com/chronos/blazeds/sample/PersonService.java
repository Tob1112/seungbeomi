package com.chronos.blazeds.sample;

import java.util.logging.Logger;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.orm.jdo.support.JdoDaoSupport;

@RemotingDestination(channels={"my-amf", "my-secure-amf"})
public class PersonService extends JdoDaoSupport {

	//@Autowired
	//private PersistenceManagerFactory pmf;

	private static final Logger log = Logger.getLogger(PersonService.class.getName());

	@RemotingInclude
	public String sayHello(Person person) {
		log.info("PersonServiceImpl - sayHello : name " + person.getName());
		return "Hello " + person.getName();
	}
	/*
	@RemotingInclude
	public String fileUpload(FileUpDownLoad file) {
		PersistenceManager pm = pmf.getPersistenceManager();

		BlobFile blob = new BlobFile(file.getName(), file.getData());
		pm.makePersistent(blob);

		// ファイル名を返す
		return file.getName();
	}
	*/

	/*
	// simple
	@RemotingInclude
	public Shain login(Shain shain) {
		shain.setShainMei("孫承範");
		shain.setShainBango("111");

		log.fine(shain.toString());

		return  shain ;
	}
	*/

	/*
	// low-level api
	@RemotingInclude
	public Shain login(Shain shain) {
		log.fine("ログイン");
		shain.setShainMei("孫承範");
		shain.setShainBango("111");

		long start = System.currentTimeMillis();

		Key shainId = KeyFactory.createKey("shain", shain.getId());
		Entity shainEntity = new Entity(shainId);
		shainEntity.setProperty("password", shain.getPassword());
		shainEntity.setProperty("shainBango", shain.getShainBango());
		shainEntity.setProperty("shainMei", shain.getShainMei());
		ds.put(shainEntity);
		long stop = System.currentTimeMillis();
		long time = stop - start;

		log.fine("所与時間：" + time);

		return shain;
	}
	*/

	// JDO
	@RemotingInclude
	public Shain login(Shain shain) {
		shain.setShainMei("孫承範");
		shain.setShainBango("111");

		log.fine("JDO : " + shain);

		getJdoTemplate().makePersistent(shain);
		return shain;
	}

	@RemotingInclude
	public void sendKinmuhyo(Shinsei shinsei) {
		log.fine(shinsei.toString());
	}
}
