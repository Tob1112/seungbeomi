package com.chronos.appengine.sample;

import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Blob;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class BlobFile {

	@PrimaryKey
	private String fileName;
	@Persistent
	private Blob blob;
	
	public BlobFile(String fileName, byte[] bytes) {
		this.fileName = fileName;
		blob = new Blob(bytes);
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public byte[] getBlob() {
		return blob.getBytes();
	}

	public void setBlob(byte[] bytes) {
		blob = new Blob(bytes);
	}
	
}
