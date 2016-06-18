package com.xu.manager.service;

import java.util.List;

import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.PageBean;

public interface BuyUserService {

	LoginUser getByID(int id);

	int deleteMore(String ids);

	void insert(LoginUser loginUser);

	void update(LoginUser loginUser);

	List<LoginUser> query(LoginUser query, PageBean page);

}
