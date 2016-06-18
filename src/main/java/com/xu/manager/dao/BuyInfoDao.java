package com.xu.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xu.manager.bean.Car;
import com.xu.manager.bean.Order;

public interface BuyInfoDao {

	int countAll(Car query);

	List<Car> query(@Param("query")Car query);

	List<Order> queryShopping(Order query);

}
