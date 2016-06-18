package com.xu.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xu.manager.bean.Car;
import com.xu.manager.bean.Order;
import com.xu.manager.bean.PageBean;
import com.xu.manager.dao.BuyInfoDao;
@Service("buyInfoService")
@Scope("prototype")
@Transactional
public class BuyInfoServiceImpl implements BuyInfoService{

@Autowired
private BuyInfoDao buyInfoDao;
		    @Override
			public List<Car> query(Car query, PageBean page) {
				if(page!=null){
					int total = buyInfoDao.countAll(query);
					page.setTotal(total);
				}
				List<Car> list = buyInfoDao.query(query);
				return list;
			}
	}


