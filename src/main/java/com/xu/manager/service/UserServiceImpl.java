package com.xu.manager.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.PageBean;
import com.xu.manager.dao.UserDao;
@Service("userService")

@Transactional
@Scope("prototype")
public class UserServiceImpl implements UserService {
@Autowired
private UserDao userDao;
	
	@Override
	public List<LoginUser> query(LoginUser query,PageBean page) {
           if(page != null) {
			
			int total = userDao.countAll(query);
			page.setTotal(total);
		}
		List<LoginUser> list = userDao.query(query);
		return list;
	}

	@Override
	public void insert(LoginUser loginUser) {
		loginUser.setPassWord("123");
		loginUser.setRoleId(2);
		userDao.insert(loginUser);
		
	}

	@Override
	public int deleteMore(String ids) {
		String [] s = ids.split(",");
		List<Integer> list = new ArrayList<Integer>(s.length);
		for(String id:s){
			list.add(Integer.parseInt(id));
		}
		userDao.deleteMore(list);
		return 0;
	}

	@Override
	public LoginUser getByID(int id) {
		LoginUser loginUser = userDao.getById(id);
		return loginUser;
	}

	@Override
	public void update(LoginUser loginUser) {
		userDao.update(loginUser);
		
	}

}
