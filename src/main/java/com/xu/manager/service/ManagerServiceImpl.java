package com.xu.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xu.manager.bean.Car;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.dao.ManagerDao;

@Service("managerService")
@Scope("prototype")
@Transactional
public class ManagerServiceImpl implements ManagerService{
	
	@Autowired
	private ManagerDao managerDao;

	@Override
	public List<Order> query(Order query, PageBean page) {
		
		List<Order> list = managerDao.query(query);
		return list;
	}

}
