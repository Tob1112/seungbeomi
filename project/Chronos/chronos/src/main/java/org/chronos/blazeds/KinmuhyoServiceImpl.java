package org.chronos.blazeds;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.barista.common.util.SystemUtiltity;
import org.barista.common.util.ZipFile;
import org.barista.common.xml.XmlDocument;
import org.chronos.domain.KinmuhyoDao;
import org.chronos.domain.Shinsei;
import org.chronos.domain.ChronosEnum.ShinseiJokyo;
import org.chronos.domain.ChronosEnum.ShinseiKubun;
import org.springframework.beans.factory.annotation.Autowired;


public class KinmuhyoServiceImpl implements KinmuhyoService {

	private static final Logger log = Logger.getLogger(KinmuhyoServiceImpl.class);

}
