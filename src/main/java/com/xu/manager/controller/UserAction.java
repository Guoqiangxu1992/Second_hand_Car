package com.xu.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.xu.manager.bean.LoginUser;
import com.xu.manager.dao.LoginUserDao;
import com.xu.manager.dao.UserDao;

@RequestMapping("/user")
@Scope("prototype")
@Controller
public class UserAction {
	@Autowired
	private UserDao userDao;
	
	@Autowired 
	private LoginUserDao loginUserDao;
	
	@RequestMapping("/infoModify.do")
	public ModelAndView infoModify(Model model){
		return new ModelAndView("/user/infoModify");
	}
	
	
	@RequestMapping(value = "/list.do")
	@ResponseBody
	public String list(Model model,HttpSession session){
		LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
		LoginUser list = loginUserDao.getByUserName(loginUser.getUserName());
		Gson gson = new Gson();
		String json = gson.toJson(list);
		return json;
		
	}
	
	
	@RequestMapping("/modify.do")
	@ResponseBody
	public int modify(Model model,LoginUser loginUser,HttpSession session){
		LoginUser loginUser1 = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
		loginUser.setId(loginUser1.getId());
		userDao.update(loginUser);
		return 0;
		
	}
	
	
	

}
