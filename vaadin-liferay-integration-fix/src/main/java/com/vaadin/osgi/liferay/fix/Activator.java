package com.vaadin.osgi.liferay.fix;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vaadin.osgi.resources.OsgiVaadinResources;
import com.vaadin.osgi.resources.VaadinResourceService;

public class Activator implements BundleActivator {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public void start(BundleContext context) throws Exception {
		VaadinResourceService service = null;
		int count = 0;
		while (count < 10) {
			try {
				service = OsgiVaadinResources.getService();
			} catch (Exception e) {
				log.info("[Vaadin Liferay Integration Fix] Caught error: " + e.getMessage());
			}
			if (service != null) {
				log.info("[Vaadin Liferay Integration Fix] Found Vaadin Shared!");
				break;
			}
			log.info("[Vaadin Liferay Integration Fix] Waiting 5 seconds...");
			Thread.sleep(5000);
			count++;
		}
	}

	@Override
	public void stop(BundleContext context) throws Exception {
		//Noop		
	}

}
