package com.xu.manager.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.xu.manager.bean.DateFormat;
import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.MenuBean;
import com.xu.manager.service.LoginService;
import com.xu.manager.service.LoginUserService;

@Controller
@RequestMapping("/login")  
@Scope("prototype")
public class LoginAction {
Logger logger = LoggerFactory.getLogger(getClass());
@Autowired 
private LoginUserService loginUserService;
@Autowired
private LoginService loginService;

@RequestMapping(value="/tologin.do")
	public ModelAndView tologin() {
		return new ModelAndView("/index");     
	}

@RequestMapping(value = "/ajaxLogin.do")
@ResponseBody
public int index(LoginUser user,HttpServletRequest request,Model model,HttpSession session){
	String userName = user.getUserName();
	LoginUser loginUser = loginUserService.getByUserName(userName);
	session.setAttribute("SESSION_LOGIN_USER", loginUser);
	if(loginUser !=null && user.getPassWord().equalsIgnoreCase(loginUser.getPassWord())){
		return 1;
	}
	else{
		
		return 0;
}
	 
	
	}
@RequestMapping(value="/main.do")
public ModelAndView index1( Model model, HttpSession session, HttpServletRequest request) {
	logger.debug("----index--------");
	LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
	List<MenuBean> treeList = loginService.queryTreeService(loginUser.getUserId());
	model.addAttribute("treeList",treeList);
	model.addAttribute("loginUser", loginUser);
	
	model.addAttribute("currentDate",DateFormat.getCurrentDateTimeStr() );
	return new ModelAndView("/login");
}
@RequestMapping(value="/logout.do")
public ModelAndView  logout(LoginUser user, Model model, HttpSession session) {
	logger.debug("----logout--------");
	LoginUser loginUser = (LoginUser)session.getAttribute("SESSION_LOGIN_USER");
	if(loginUser != null) {
		session.removeAttribute("SESSION_LOGIN_USER");
	}
	
	return new ModelAndView("redirect: tologin.do");  
}

@RequestMapping(value="/ajaxLogout.do")
@ResponseBody
public int  ajaxLogout(LoginUser user, Model model, HttpSession session) {
	logger.debug("----logout--------");
	LoginUser loginUser = (LoginUser)session.getAttribute("SESSION_LOGIN_USER");
	if(loginUser != null) {
		session.removeAttribute("SESSION_LOGIN_USER");
	}
	
	return 0;  
}
}
