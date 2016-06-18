package com.xu.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xu.manager.bean.MenuBean;

public interface LoginDao {

	List<MenuBean> queryTreeList(@Param("id") String id);

}
