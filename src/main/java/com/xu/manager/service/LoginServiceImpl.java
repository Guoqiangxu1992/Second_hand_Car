package com.xu.manager.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xu.manager.bean.MenuBean;
import com.xu.manager.dao.LoginDao;
@Service("loginService")
@Scope("prototype")
@Transactional
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDao loginDao;
	@Override
	public List<MenuBean> queryTreeService(String userId) {
		List<MenuBean> list = loginDao.queryTreeList(userId);
		if(list == null || list.size()==0) return null;
		List<MenuBean> treeList = new ArrayList<MenuBean>();
		
		MenuBean parentMenu = null;
		MenuBean childMenu = null;
		Integer id = -1;
		for(MenuBean menu: list ) {
			//父id相同，取子菜单的数据
			if(id.equals(menu.getId())) {
					
					childMenu = new MenuBean();
					childMenu.setId(menu.getChildId());
					childMenu.setMenuName(menu.getChildMenuName());
					childMenu.setMenuAction(menu.getChildMenuAction());
					childMenu.setMenuIcon(menu.getChildMenuIcon());
					parentMenu.getChildren().add(childMenu);
			} else {
					
					parentMenu = new MenuBean();
					parentMenu.setId(menu.getId());
					parentMenu.setMenuName(menu.getMenuName());
					parentMenu.setMenuIcon(menu.getMenuIcon());
					
					parentMenu.setChildren( new ArrayList<MenuBean>());
					treeList.add(parentMenu);
					
					childMenu = new MenuBean();
					childMenu.setId(menu.getChildId());
					childMenu.setMenuName(menu.getChildMenuName());
					childMenu.setMenuAction(menu.getChildMenuAction());
					childMenu.setMenuIcon(menu.getChildMenuIcon());
					parentMenu.getChildren().add(childMenu);
				
					id=menu.getId();
			}
		}
		list = null;
		return treeList;
	}

}
