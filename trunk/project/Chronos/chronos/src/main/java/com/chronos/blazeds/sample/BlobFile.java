package com.chronos.blazeds.sample;

import java.sql.Blob;

public class BlobFile {

	private String fileName;
	private Blob blob;

	public BlobFile(String fileName, byte[] bytes) {
		this.fileName = fileName;
		//blob = new Blob(bytes);
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public byte[] getBlob() {
		return null;
	}

	public void setBlob(byte[] bytes) {
		//blob = new Blob(bytes);
	}

}
