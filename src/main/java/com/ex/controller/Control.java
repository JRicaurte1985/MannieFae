package com.ex.controller;

import java.io.IOException;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.stereotype.Controller;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;

@Controller
public class Control {
	@RequestMapping(value = "/test", method = { RequestMethod.GET })
	public String loginGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

		response.getWriter().print("Test");
		return null;	
//		return "mf_index";
	}	
}
