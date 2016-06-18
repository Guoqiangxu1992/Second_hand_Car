package com.xu.manager.service;

import java.util.List;

import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.PageBean;

public interface UserService {

	List<LoginUser> query(LoginUser query,PageBean page);

	void insert(LoginUser loginUser);

	int deleteMore(String ids);

	LoginUser getByID(int id);

	void update(LoginUser loginUser);
	

}
