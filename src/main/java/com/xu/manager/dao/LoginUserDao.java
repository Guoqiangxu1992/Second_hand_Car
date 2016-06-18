package com.xu.manager.dao;

import com.xu.manager.bean.LoginUser;

public interface LoginUserDao {

	LoginUser getByUserName(String userName);
	

}
