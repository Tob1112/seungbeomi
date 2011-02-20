package com.leinbow.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.leinbow.service.UserService;

@Controller
@RequestMapping("/member")
public class MemberController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());


    UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String member(Model model) {
        //model.addAttribute("list", userService.getUsers());
        return "member/member";
    }

}
