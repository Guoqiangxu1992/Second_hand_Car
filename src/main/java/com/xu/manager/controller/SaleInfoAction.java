package com.xu.manager.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.xu.manager.bean.Car;
import com.xu.manager.bean.DateFormat;
import com.xu.manager.bean.FileName;
import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.service.CarService;

@Controller
@Scope("prototype")
@RequestMapping("/sale")

public class SaleInfoAction {
	
@Autowired CarService carService;

	@RequestMapping(value = "/info.do")
	public ModelAndView info(Model model){
		return new ModelAndView("car/info");
		
	}
	
@RequestMapping(value = "/list.do")
@ResponseBody
public String list(Car query, @RequestParam(value="page", required=false) Integer pageNumber,
		@RequestParam(value="rows", required=false) Integer pageSize, Model model,HttpSession session){
			PageBean page = null;
			if(pageNumber!=null){
				page = new PageBean();
				page.setCurrPage(pageNumber);
				page.setPageSize(pageSize);
			}
			LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
			query.setAgencyId(loginUser.getUserId());
			List<Car> list = carService.queryList(query,page);
			Gson gson = new Gson();
			String json = gson.toJson(list);
			if(pageNumber != null) {
				json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() + "}";
			}
			return json;
			}

@RequestMapping(value = "/allList.do")
@ResponseBody
public String allList(Car query, @RequestParam(value="page", required=false) Integer pageNumber,
		@RequestParam(value="rows", required=false) Integer pageSize, Model model,HttpSession session){
			PageBean page = null;
			if(pageNumber!=null){
				page = new PageBean();
				page.setCurrPage(pageNumber);
				page.setPageSize(pageSize);
			}
			LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
			//query.setAgencyId(loginUser.getUserId());
			List<Car> list = carService.queryAllList(query,page);
			Gson gson = new Gson();
			String json = gson.toJson(list);
			if(pageNumber != null) {
				json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() + "}";
			}
			return json;
			}
/*车辆信息发布*/
@RequestMapping(value = "/pub.do")
public ModelAndView pub(Model model){
	return new ModelAndView("car/pub");
	
}

@RequestMapping(value = "/addList.do")
@ResponseBody
public String addList(Car query, @RequestParam(value="page", required=false) Integer pageNumber,
		@RequestParam(value="rows", required=false) Integer pageSize, Model model,HttpSession session){
			PageBean page = null;
			if(pageNumber!=null){
				page = new PageBean();
				page.setCurrPage(pageNumber);
				page.setPageSize(pageSize);
			}
			LoginUser loginUser = (LoginUser) session.getAttribute("SESSION_LOGIN_USER");
			query.setAgencyId(loginUser.getUserId());
			List<Car> list = carService.queryList(query,page);
			Gson gson = new Gson();
			String json = gson.toJson(list);
			if(pageNumber != null) {
				json = "{\"rows\":" + json + ",\"total\":" + page.getTotal() + "}";
			}
			//System.out.println(json);
			return json;
			}
/*上传图片*/
@RequestMapping(value = "/uploadCarImag.do")  
@ResponseBody
public String uploadUserIcon(@RequestParam("id")String id,HttpSession session,@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, ModelMap model) {  
 String currentDate = Long.toString(System.currentTimeMillis());
     String name = file.getOriginalFilename();
     String lastname=name.substring(name.lastIndexOf("."),name.length());
	 String fileName = currentDate+ lastname;
	 String path = request.getSession().getServletContext()
				.getRealPath("uploadImage");
	 String a =  path.substring(0,path.length()-20);
	 String upPath = path.substring(0,path.length()-20)+"\\uploadImage";
		File targetFile = new File(upPath, fileName);
	if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
	
	carService.saveImag(currentDate,id);
	// 保存
	try {
		file.transferTo(targetFile);
	} catch (Exception e) {
		e.printStackTrace();
	}
	return path;
   }

@RequestMapping(value = "/detail.do")
public ModelAndView detail(@RequestParam("id") String id,Model model){
	model.addAttribute("id",id);
	return new ModelAndView("car/detail");
	
}
/*增加商品*/
@RequestMapping(value = "/saveCar.do")
public void saveCar(Car car,Model model,HttpSession session){
	LoginUser loginUser = (LoginUser)session.getAttribute("SESSION_LOGIN_USER");
	String agencyId = loginUser.getUserId();
	car.setAgencyId(agencyId);
	car.setSubmitTime(DateFormat.getCurrentDateTimeStr());
	if(car.getId()!=null){
		carService.update(car);
	}else{
		carService.saveCar(car);
	}
	
	
}
/*删除信息*/
@RequestMapping(value = "/deleteMore")
@ResponseBody
public int delete(@RequestParam("ids") String ids) throws Exception {
	int result = carService.deleteMore(ids);
	return result;
}

/*修改信息*/
@RequestMapping(value = "/id{id}.do", produces = { "application/json;charset=utf-8" })
@ResponseBody
public Car getById(@PathVariable("id") int id) {
	Car bean = carService.getByID(id);
	return bean;
}




}
