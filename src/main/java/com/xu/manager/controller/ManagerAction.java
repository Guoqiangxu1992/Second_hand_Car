package com.xu.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.xu.manager.bean.Car;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.service.ManagerService;

@Controller
@Scope("prototype")
@RequestMapping("/manager")
public class ManagerAction {
	@Autowired
	private ManagerService managerService;
	
	@RequestMapping("/index.do")
	public ModelAndView index(Model model){
		return new ModelAndView("/order/index");
		
	}
	
	@RequestMapping(value = "/list.do")
	@ResponseBody
	public String list(Order query, @RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize,Model model){
		PageBean page = null;
		if(pageNumber!=null){
			page = new PageBean();
			page.setCurrPage(pageNumber);
			page.setPageSize(pageSize);
		}
		  query.setStatus(5);
		List<Order> list = managerService.query(query,page);
		Gson gson = new Gson();
		String json = gson.toJson(list);
		return json;
		}

}
