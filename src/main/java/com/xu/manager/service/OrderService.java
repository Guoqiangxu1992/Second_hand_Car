package com.xu.manager.service;

import java.util.List;

import com.xu.manager.bean.Car;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;

public interface OrderService {

	int insert(Order order);

	List<Order> queryShopping(Order query, PageBean page);

	List<Order> listOrder(Order query, PageBean page);

	void updateStatus(String id);

	void updateStatus1(String id);

	void delete(String id);

	void updateStatusCar(String id);

	List<Order> dealOrdered(Order query, PageBean page);

	void deleteCar(String id);

}
