package seungbeomi.util;

import static org.apache.commons.io.FileUtils.forceMkdir;
import static org.apache.commons.io.FileUtils.openOutputStream;
import static org.apache.commons.io.IOUtils.closeQuietly;
import static org.apache.commons.io.IOUtils.copy;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;

public class ZipFile {

	private String fileName;
	private String fileEncoding;

	public ZipFile(String fileName) {
		this.fileName = fileName;
		this.fileEncoding = System.getProperty("file.encoding");
	}

	public ZipFile(String fileName, String fileEncoding) {
		this.fileName = fileName;
		this.fileEncoding = fileEncoding;
	}

	/** Zip«Õ«£«¢«ëú°ÔÐ */
	public void extract(String outputDir) throws IOException {
		org.apache.commons.compress.archivers.zip.ZipFile file = null;
		InputStream in = null;
		OutputStream out = null;

		try {
			file = new org.apache.commons.compress.archivers.zip.ZipFile(fileName, fileEncoding);
			Enumeration<ZipArchiveEntry> entries = file.getEntries();
			while (entries.hasMoreElements()) {
				ZipArchiveEntry entry = entries.nextElement();
				String entryName = entry.getName();
				if (entry.isDirectory()) {
					forceMkdir(new File(outputDir + File.separator + entryName));
					continue;
				}
				out = openOutputStream(new File(outputDir + File.separator
						+ entryName));
				in = file.getInputStream(entry);
				copy(in, out);
				closeQuietly(in);
				closeQuietly(out);
			}
		} finally {
			closeQuietly(in);
			closeQuietly(out);
			org.apache.commons.compress.archivers.zip.ZipFile.closeQuietly(file);
		}
	}

	public void compress(String contentsDirPath) throws IOException {
		List<File> files = new ArrayList<File>();
		File contentsDir = new File(contentsDirPath);
		listFileAndDirectories(contentsDir, files);
		InputStream in = null;
		ZipArchiveOutputStream out = null;

		try {
			out = new ZipArchiveOutputStream(new File(fileName));
			String contentsDirAbsolutePath = contentsDir.getAbsolutePath();
			for (File file : files) {
				String entryName = file.getAbsolutePath().substring(contentsDirAbsolutePath.length() + 1) + (file.isDirectory() ? File.separator : "");
				ZipArchiveEntry entry = new ZipArchiveEntry(entryName);
				out.putArchiveEntry(entry);
				if (file.isDirectory()) {
					continue;
				}
				in = new FileInputStream(file);
				copy(in, out);
				out.closeArchiveEntry();
				closeQuietly(in);
			}
		} finally {
			closeQuietly(in);
			closeQuietly(out);
		}
	}

	private void listFileAndDirectories(File directory, List<File> list) {
		File[] files = directory.listFiles();
		for (File file : files) {
			list.add(file);
			if (file.isDirectory()) {
				listFileAndDirectories(file, list);
			}
		}

	}
}
