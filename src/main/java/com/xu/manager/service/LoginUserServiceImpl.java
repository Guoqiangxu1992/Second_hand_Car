package com.xu.manager.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xu.manager.bean.LoginUser;
import com.xu.manager.dao.LoginUserDao;

@Service("loginUserService")
@Transactional
@Scope("prototype")
public class LoginUserServiceImpl implements LoginUserService {
@Autowired 
private LoginUserDao loginUserDao;
	
	@Override
	public LoginUser getByUserName(String userName) {
		LoginUser loginUser = loginUserDao.getByUserName(userName);
		return loginUser;
	}

}
