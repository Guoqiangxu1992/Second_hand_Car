package com.xu.manager.bean;

import java.util.List;


public class MenuBean {
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public Integer getMenuOrder() {
		return menuOrder;
	}
	public void setMenuOrder(Integer menuOrder) {
		this.menuOrder = menuOrder;
	}
	public String getMenuAction() {
		return menuAction;
	}
	public void setMenuAction(String menuAction) {
		this.menuAction = menuAction;
	}
	public Integer getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(Integer menuLevel) {
		this.menuLevel = menuLevel;
	}
	public Integer getParentID() {
		return parentID;
	}
	public void setParentID(Integer parentID) {
		this.parentID = parentID;
	}
	public String getMenuIcon() {
		return menuIcon;
	}
	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}
	public Integer getMenuStatus() {
		return menuStatus;
	}
	public void setMenuStatus(Integer menuStatus) {
		this.menuStatus = menuStatus;
	}
	public String getMenuCode() {
		return menuCode;
	}
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
	public Integer getChildId() {
		return childId;
	}
	public void setChildId(Integer childId) {
		this.childId = childId;
	}
	public String getChildMenuName() {
		return childMenuName;
	}
	public void setChildMenuName(String childMenuName) {
		this.childMenuName = childMenuName;
	}
	public String getChildMenuAction() {
		return childMenuAction;
	}
	public void setChildMenuAction(String childMenuAction) {
		this.childMenuAction = childMenuAction;
	}
	public String getChildMenuIcon() {
		return childMenuIcon;
	}
	public void setChildMenuIcon(String childMenuIcon) {
		this.childMenuIcon = childMenuIcon;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public List<MenuBean> getChildren() {
		return children;
	}
	public void setChildren(List<MenuBean> children) {
		this.children = children;
	}
	private Integer id;
	private String menuName;
	private Integer menuOrder;
	private String menuAction;
	private Integer menuLevel;
	private Integer parentID;
	private String menuIcon;
	private Integer menuStatus;
	
	private String menuCode;
	
	private Integer childId;
	private String childMenuName;
	private String childMenuAction;
	private String childMenuIcon;
	//tree
	private String text;
	private String state;
	private boolean checked;
	private List<MenuBean> children;

}
