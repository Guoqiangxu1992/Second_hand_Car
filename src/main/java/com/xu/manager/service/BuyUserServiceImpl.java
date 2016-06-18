package com.xu.manager.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.PageBean;
import com.xu.manager.dao.BuyUserDao;

@Service("buyUserService")
@Scope("prototype")
@Transactional

public class BuyUserServiceImpl implements BuyUserService {
@Autowired
private BuyUserDao buyUserDao;
	
	@Override
	public List<LoginUser> query(LoginUser query,PageBean page) {
           if(page != null) {
			
			int total = buyUserDao.countAll(query);
			page.setTotal(total);
		}
		List<LoginUser> list = buyUserDao.query(query);
		return list;
	}

	@Override
	public void insert(LoginUser loginUser) {
		loginUser.setPassWord("123");
		loginUser.setRoleId(3);
		buyUserDao.insert(loginUser);
		
	}

	@Override
	public int deleteMore(String ids) {
		String [] s = ids.split(",");
		List<Integer> list = new ArrayList<Integer>(s.length);
		for(String id:s){
			list.add(Integer.parseInt(id));
		}
		buyUserDao.deleteMore(list);
		return 0;
	}

	@Override
	public LoginUser getByID(int id) {
		LoginUser loginUser = buyUserDao.getById(id);
		return loginUser;
	}

	@Override
	public void update(LoginUser loginUser) {
		buyUserDao.update(loginUser);
		
	}

}
