package org.barista.common.xml;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import org.apache.commons.io.IOUtils;


public class XmlUtils {

	/** Convert XML to Object */
	@SuppressWarnings("unchecked")
	public static <E> E unmarshal(Class<?> objectFactoryClass, String filePath) 
			throws JAXBException {
		FileReader reader = null;
		try {
			reader = new FileReader(filePath);
			JAXBContext context 
				= JAXBContext.newInstance(objectFactoryClass.getPackage().getName());
			Unmarshaller unmarshaller = context.createUnmarshaller();
			Object obj = unmarshaller.unmarshal(reader);
			return (E) obj;
		} catch (FileNotFoundException e) {
			throw new JAXBException(e);
		} finally {
			IOUtils.closeQuietly(reader);
		}
	}
	
	/** Convert Object to XML */
	public static <E> void marshal(Class<?> objectFactoryClass, E element, String filePath)
			throws JAXBException {
		FileWriter writer = null;
		try {
			writer = new FileWriter(filePath);
			JAXBContext context 
				= JAXBContext.newInstance(objectFactoryClass.getPackage().getName());
			Marshaller marshaller = context.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			marshaller.marshal(element, writer);
		} catch (IOException e) {
			throw new JAXBException(e);
		} finally {
			IOUtils.closeQuietly(writer);
		}
	}
	
}
