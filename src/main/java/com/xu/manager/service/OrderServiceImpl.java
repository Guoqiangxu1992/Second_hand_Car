package com.xu.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xu.manager.bean.Car;
import com.xu.manager.bean.DateFormat;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.dao.CarDao;
import com.xu.manager.dao.OrderDao;

@Service("orderService")
@Scope("prototype")
@Transactional


public class OrderServiceImpl implements OrderService{
   @Autowired OrderDao orderDao;
   @Autowired CarDao carDao;
	@Override
	public int insert(Order order) {
		orderDao.insert(order);
		carDao.updateStatus(order.getId());
		
		return 0;
		
	}
	@Override
	public List<Order> queryShopping(Order query, PageBean page) {
		List<Order> list = orderDao.queryShopping(query);
		return list;
	}
	@Override
	public List<Order> listOrder(Order query, PageBean page) {
		List<Order> list = orderDao.listOrder(query);
		return list;
	}
	@Override
	public void updateStatus(String id) {
		String Date = DateFormat.getCurrentDateTimeStr();
		orderDao.updateStatus(id,Date);
		
	}
	@Override
	public void updateStatus1(String id) {
		orderDao.updateStatus1(id);
		
	}
	@Override
	public void delete(String id) {
		orderDao.delete(id);
		
	}
	@Override
	public void updateStatusCar(String id) {
		orderDao.updateStatusCar(id);
		
	}
	@Override
	public List<Order> dealOrdered(Order query, PageBean page) {
		List<Order> list = orderDao.dealOrdered(query);
		return list;
	}
	@Override
	public void deleteCar(String id) {
	    orderDao.deleteCar(id);
		
	}
	

}
