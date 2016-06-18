package com.xu.manager.controller;

import java.awt.Dialog.ModalExclusionType;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.xu.manager.bean.Car;
import com.xu.manager.bean.DateFormat;
import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.dao.CarDao;
import com.xu.manager.service.BuyInfoService;
import com.xu.manager.service.OrderService;

@Controller
@Scope("prototype")
@RequestMapping("/buy")

public class BuyInfoAction {
	@Autowired OrderService orderService;
	@Autowired CarDao carDao;
	
	@Autowired
	private BuyInfoService buyInfoService;
	
	@RequestMapping("/info.do")
	public ModelAndView info(Model model){
		return new ModelAndView("/car/buyInfo");
	}
	
	@RequestMapping(value = "/list.do")
	@ResponseBody
	public String list(Car query, @RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model){
				PageBean page = null;
				if(pageNumber!=null){
					page = new PageBean();
					page.setCurrPage(pageNumber);
					page.setPageSize(pageSize);
				}
				
				List<Car> list = buyInfoService.query(query,page);
				Gson gson = new Gson();	
				String json = gson.toJson(list);
				if(pageNumber != null) {
					json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() + "}";
				}
				return json;
				}
	@RequestMapping(value = "/order.do")
	public ModelAndView order(@RequestParam("id")String id,@RequestParam("status") int status,Model model){
		if(status==1){
			model.addAttribute("id",id);	
			   return new ModelAndView("/order/order");
		}else
		{
			return new ModelAndView("/order/orderERROR");
		}
		
	   
	}
	
	@RequestMapping(value = "/orderView.do")
	@ResponseBody
	public String orderView(@RequestParam("id") String id,ModalExclusionType model){
		Car list = carDao.getById(Integer.parseInt(id));
		Gson gson = new Gson();
		String json = gson.toJson(list);
		return json;
		
	}
	
	@RequestMapping(value = "/orderList.do")
	@ResponseBody
     public int orderList(Car car,HttpSession session,Model model){
		LoginUser loginUser =  (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
		String currentDate =Long.toString(System.currentTimeMillis());
		Order order = new Order();
		order.setOrderNum(currentDate);
		order.setId(car.getId());
		order.setCarType(car.getCarType());
		order.setPrice(car.getPrice());
		order.setMileage(car.getMileage());
		order.setColor(car.getColor());
		order.setOld(car.getOld());
		order.setAgencyId(car.getAgencyId());
		order.setAgency(car.getAgency());
		order.setContractPrice(car.getContractPrice());
		order.setImag(car.getMarkImag());
		order.setBuyer(loginUser.getFullName());
		order.setMobile(loginUser.getMobile());
		order.setStatus(2);
		order.setOrderTime(DateFormat.getCurrentDateTimeStr());
		order.setUserId(loginUser.getUserId());
		orderService.insert(order);
		System.out.println(order.getOrderTime());
		return 0;
		
		
	}	
	/*已购车信息*/
	@RequestMapping("/shop.do")
	public ModelAndView shop(Model model){
		return new ModelAndView("/order/shopping");
	}
	
	@RequestMapping(value = "/listShopping.do")
	@ResponseBody
	public String listShopping(Order query, @RequestParam(value="page", required=false) Integer pageNumber,
			@RequestParam(value="rows", required=false) Integer pageSize, Model model,HttpSession session){
				PageBean page = null;
				if(pageNumber!=null){
					page = new PageBean();
					page.setCurrPage(pageNumber);
					page.setPageSize(pageSize);
				}
				LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
				query.setUserId(loginUser.getUserId());
				List<Order> list = orderService.queryShopping(query,page);
				Gson gson = new Gson();
				String json = gson.toJson(list);
				if(pageNumber != null) {
					json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() + "}";
				}
				return json;
				}

}
