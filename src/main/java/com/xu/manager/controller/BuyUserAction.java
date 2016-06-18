package com.xu.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.PageBean;
import com.xu.manager.service.BuyUserService;

@Controller
@RequestMapping("/user/buy")  
@Scope("prototype")
public class BuyUserAction {
	
	@Autowired
	private BuyUserService buyUserService;
	
@RequestMapping("/index.do")	
public ModelAndView index1(Model model){
	
	return new ModelAndView("/user/buyIndex");
}
	
@RequestMapping(value = "/list.do")	
@ResponseBody
public String Salelist(LoginUser query, @RequestParam(value="page", required=false) Integer pageNumber,
		@RequestParam(value="rows", required=false) Integer pageSize, Model model){
	PageBean page = null;
	if(pageNumber != null) {
		page = new PageBean();
		page.setCurrPage(pageNumber);
		page.setPageSize(pageSize);
	}
	List<LoginUser> list = buyUserService.query(query,page);
	Gson gson = new Gson();
	String json = gson.toJson(list);
	if(pageNumber != null) {
		json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() + "}";
	}
	return json;
}

@RequestMapping(value = "/saveSale.do")	
public void insert(LoginUser loginUser,Model model){
	if(loginUser.getId()==null){
		buyUserService.insert(loginUser);
	}else
		buyUserService.update(loginUser);
	
	
	
	}
@RequestMapping(value = "/deleteMore")
@ResponseBody
public int delete(@RequestParam("ids") String ids) throws Exception {
	int result = buyUserService.deleteMore(ids);
	return result;
}

@RequestMapping(value = "/id{id}.do", produces = { "application/json;charset=utf-8" })
@ResponseBody
public LoginUser getById(@PathVariable("id") int id) {
	LoginUser bean = buyUserService.getByID(id);
	return bean;
}
}
