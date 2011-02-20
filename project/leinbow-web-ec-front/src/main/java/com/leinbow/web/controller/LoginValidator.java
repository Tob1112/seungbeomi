package com.leinbow.web.controller;

import org.apache.commons.lang.StringUtils;
import org.springframework.validation.Errors;

import com.leinbow.domain.LoginInfo;

public class LoginValidator {

    // private WorldService worldService = new MockWorldService();

    public void validate(LoginInfo loginInfo, Errors errors) {
        String username = loginInfo.getJ_username();
        String password = loginInfo.getJ_password();

        // login.jspのエラー表示部分がformの外にあるのでglobalエラーで追加する
        if (StringUtils.isEmpty(username))
            errors.reject("error_login_empty_username", "Enter your email");
        if (StringUtils.isEmpty(password))
            errors.reject("error_login_empty_password", "Enter your password");

        if ( StringUtils.isNotEmpty(username) && StringUtils.isNotEmpty(password) ) {
            errors.reject("error_login_auth_fail", "Please re-enter your email or password");
        }

        //ValidationUtils.rejectIfEmptyOrWhitespace(errors, "j_username", "error_login_empty_username");
        //ValidationUtils.rejectIfEmptyOrWhitespace(errors, "j_password", "error_login_empty_password");
    }
}