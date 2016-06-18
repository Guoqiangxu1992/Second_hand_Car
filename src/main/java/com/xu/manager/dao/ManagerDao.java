package com.xu.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xu.manager.bean.Order;

public interface ManagerDao {

	int countAll(Order query);

	List<Order> query(@Param("query")Order query);

}
