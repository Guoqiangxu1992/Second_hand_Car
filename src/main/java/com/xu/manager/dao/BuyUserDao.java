package com.xu.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xu.manager.bean.LoginUser;

public interface BuyUserDao {

	int countAll(LoginUser query);

	List<LoginUser> query(@Param("query")LoginUser query);

	void insert(LoginUser loginUser);

	void deleteMore(List<Integer> list);

	LoginUser getById(int id);

	void update(LoginUser loginUser);


}
