package org.barista.common.test;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.beans.factory.xml.XmlBeanDefinitionReader;
import org.springframework.context.ApplicationContext;
import org.springframework.util.ClassUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AbstractRefreshableWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.ModelAndView;

public class ConfigurableDispatcherServlet extends DispatcherServlet {

	private static final long serialVersionUID = 1L;

	private String[] locations;

	private ModelAndView modelAndView;

	public ConfigurableDispatcherServlet() {}

	public ConfigurableDispatcherServlet(String[] locations) {
		this.locations = locations;
	}

	public void setLocations(String ...locations) {
		this.locations = locations;
	}

	public void setRelativeLocations(Class clazz, String ...relativeLocations) {
		String[] locations = new String[relativeLocations.length];
		String currentPath = ClassUtils.classPackageAsResourcePath(clazz) + File.separator;

		for (int i=0; i < relativeLocations.length; i++) {
			locations[i] = currentPath + relativeLocations[i];
		}
		this.setLocations(locations);
	}

	public void service(ServletRequest req, ServletResponse res)
			throws ServletException, IOException {
		modelAndView = null;
		super.service(req, res);
	}

	protected WebApplicationContext createWebApplicationContext(ApplicationContext parent) {
		AbstractRefreshableWebApplicationContext wac =
			new AbstractRefreshableWebApplicationContext() {

				@Override
				protected void loadBeanDefinitions(DefaultListableBeanFactory beanFactory)
						throws IOException, BeansException {
					if (locations != null) {
						XmlBeanDefinitionReader xmlReader =
							new XmlBeanDefinitionReader(beanFactory);
						xmlReader.loadBeanDefinitions(locations);
					}
				}
			};
		wac.setServletContext(getServletContext());
		wac.setServletConfig(getServletConfig());
		wac.refresh();

		return wac;
	}

	protected void render(ModelAndView mv, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		this.modelAndView = mv;
		super.render(mv, request, response);
	}

	public ModelAndView getModelAndView() {
		return modelAndView;
	}
}
