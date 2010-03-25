package org.seungbeomi.blank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

public class HelloController extends AbstractController{

	Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("<<< HelloController");

		ModelAndView mav = new ModelAndView();
		mav.setViewName("hello");	// prefix + viewName + suffix
		mav.addObject("greeting", getGreeting());	// ${greting} で使用可能
		return mav;
	}

	private String getGreeting() {
		return "Hello spring-blank";
	}

}
