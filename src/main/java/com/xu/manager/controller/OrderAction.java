package com.xu.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.service.OrderService;

@Controller
@Scope("prototype")
@RequestMapping("/order")

public class OrderAction {
	@Autowired
	private OrderService orderService;
	/*商家查看待处理订单*/
	@RequestMapping(value = "/listOrder.do")
	@ResponseBody
	public String listOrder(Order query, @RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model,HttpSession session){
				PageBean page = null;
				if(pageNumber!=null){
					page = new PageBean();
					page.setCurrPage(pageNumber);
					page.setPageSize(pageSize);
				}
				LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
				query.setAgencyId(loginUser.getUserId());
				List<Order> list = orderService.listOrder(query,page);
				Gson gson = new Gson();
				String json = gson.toJson(list);
				if(pageNumber != null) {
					json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() + "}";
				}
				return json;
				}
	@RequestMapping(value = "/gree.do")
	@ResponseBody
	public int gree(@RequestParam("id")String id,Model model){
		  orderService.updateStatus(id);
		  orderService.deleteCar(id);//从车信息中删除
		 
		  return 0;
		}
	
	@RequestMapping(value = "/degree.do")
	@ResponseBody
	public int degree(@RequestParam("id")String id,Model model){
		  orderService.updateStatus1(id);//更新订单表中的车的销售状态，从预订改为热销
		  orderService.delete(id);//从订单表中删除
		  orderService.updateStatusCar(id);//更改汽车表的销售状态
		
		  return 0;
		}
	
	@RequestMapping(value = "/dealOrder.do")
	public ModelAndView dealOrder(Model model){
		return new ModelAndView("order/dealOrder");
		
	}
	
	@RequestMapping(value = "/dealOrdered.do")
	public ModelAndView dealOrdered(Model model){
		return new ModelAndView("order/dealOrdered");
		
	}
	
	/*商家查看待处理订单*/
	@RequestMapping(value = "/list1.do")
	@ResponseBody
	public String list1(Order query, @RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model,HttpSession session){
				PageBean page = null;
				if(pageNumber!=null){
					page = new PageBean();
					page.setCurrPage(pageNumber);
					page.setPageSize(pageSize);
				}
				LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
				query.setAgencyId(loginUser.getUserId());
				List<Order> list = orderService.dealOrdered(query,page);
				Gson gson = new Gson();
				String json = gson.toJson(list);
				return json;
				}
}
