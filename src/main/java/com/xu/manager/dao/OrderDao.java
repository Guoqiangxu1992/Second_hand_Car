package com.xu.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xu.manager.bean.Order;

public interface OrderDao {

	int insert(Order order);

	List<Order> queryShopping(@Param("query")Order query);

	List<Order> listOrder(@Param("query")Order query);

	void updateStatus(@Param("id")String id,@Param("Date") String Date);

	void updateStatus1(String id);

	void delete(String id);

	void updateStatusCar(String id);

	List<Order> dealOrdered(@Param("query")Order query);

	void deleteCar(String id);
	

}
