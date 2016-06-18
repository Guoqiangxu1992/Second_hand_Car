package com.xu.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xu.manager.bean.Car;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.dao.BuyInfoDao;

public interface BuyInfoService {

	List<Car> query(Car query, PageBean page);



}
