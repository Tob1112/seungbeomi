package com.chronos.appengine.sample;

import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;


@Service("PersonService")
@RemotingDestination(channels={"my-amf", "my-secure-amf"})
public class PersonService {
	
	@Autowired
	private PersistenceManagerFactory pmf;
	
	private static final Logger log = Logger.getLogger(PersonService.class.getName());
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

	@RemotingInclude
	public String sayHello(Person person) {
		//log.log(Level.INFO, "PersonServiceImpl - sayHello : name " + person.getName());
		log.info("PersonServiceImpl - sayHello : name " + person.getName());
		return "Hello " + person.getName();
	}
	
	@RemotingInclude
	public String fileUpload(FileUpDownLoad file) {
		PersistenceManager pm = pmf.getPersistenceManager();
		
		BlobFile blob = new BlobFile(file.getName(), file.getData());
		pm.makePersistent(blob);

		// ファイル名を返す
		return file.getName();
	}
}
