package com.leinbow.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.leinbow.domain.LoginInfo;
import com.leinbow.service.UserService;

@Controller
public class LoginController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private UserService userService;
    private LoginValidator validator = new LoginValidator();

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    /**
     * spring securityのlogin-urlは /login/をmappingできないため
     * 以下のmethodを追加する
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    @RequestMapping(value = "/login_fail")
    public String loginFail(@ModelAttribute LoginInfo loginInfo, BindingResult result) {
        validator.validate(loginInfo, result);

        logger.debug("login username : " + loginInfo.getJ_username());
        logger.debug("login password : " + loginInfo.getJ_password());

        return "login";
    }

//    @InitBinder
//    public void initBinder(WebDataBinder dataBinder) {
//        //dataBinder.setDisallowedFields(new String[] { "id" });
//        dataBinder.setRequiredFields(new String[] { "j_password", "j_username", });
//        dataBinder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
//    }

}
