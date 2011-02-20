package com.leinbow.web.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/sandbox")
public class SandboxController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home() {
        logger.info("Welcome home2!");
        return "sandbox/home"; //returnタイプがstringの場合springはこの値をview名で利用する。
    }

    //public String homePost(@RequestParam int id) {
    @RequestMapping(value = "/param")
    public String homePost() {
        logger.info("Welcome member : id");
        return "sandbox/member";
    }


    @RequestMapping(value = "/hello")
    public String hello() {
        return "sandbox/hello";
    }

//    @RequestMapping(value = "/hello")
//    public String hello(@RequestParam String name, Model model) {
//        model.addAttribute("name", name);
//        return "sandbox/hello";
//    }

}

