package com.xu.manager.service;

import java.util.List;

import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;

public interface ManagerService {

	List<Order> query(Order query, PageBean page);

}
