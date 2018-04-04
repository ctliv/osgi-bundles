package com.ctliv.report;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.util.JRStyledTextParser;

public class Activator implements BundleActivator {

	private Log log = LogFactory.getLog(this.getClass());
	
	Properties props = readProperties();
	
	private final String JR_CLASSPATH = "net.sf.jasperreports.compiler.classpath";
	String defaultClassPath = null;
	
	@Override
	public void start(BundleContext context) throws Exception {
		
		Thread.currentThread().setContextClassLoader(this.getClass().getClassLoader());
		
		try {
			JRStyledTextParser parser = JRStyledTextParser.getInstance();
			log.info("Parser is: " + parser);
		} catch (Exception e) {
			log.fatal("Error caught when initializing JRStyledTextParser");
			log.debug(e);
			throw e;
		}
		
		String jrLibDir = "";
		try {
			File f = new File(DefaultJasperReportsContext.class.getProtectionDomain().getCodeSource().getLocation().toURI().getPath());
			jrLibDir = f.getAbsolutePath();
			jrLibDir = jrLibDir.substring(0, jrLibDir.lastIndexOf('/')) + "/.cp/";
		} catch (Exception e) { }
		log.info("class file dir: " + jrLibDir);
		
		String jrLibPath = jrLibDir + 
				"jasperreports-" + props.getProperty("jasperreports.version") + ".jar";
		log.info("class file path: " + jrLibPath);
		
		defaultClassPath = DefaultJasperReportsContext.getInstance().getProperty(JR_CLASSPATH);

		DefaultJasperReportsContext.getInstance().setProperty(
				JR_CLASSPATH,
				defaultClassPath + ":" + jrLibPath);	
	}

	@Override
	public void stop(BundleContext context) throws Exception {		
		DefaultJasperReportsContext.getInstance().setProperty(JR_CLASSPATH,defaultClassPath);
	}
	
	private Properties readProperties() {
		ClassLoader classLoader = getClass().getClassLoader();
		Properties p = new Properties();
		InputStream inputStream = null;
		try {
		    inputStream = classLoader.getResourceAsStream("app.properties");
		    p.load( inputStream );
		} catch ( IOException e ) {
		    log.error( e.getMessage(), e );
		} finally {
			try {
				inputStream.close();
			} catch (IOException e) { }
		}
		return p;
	}

}
