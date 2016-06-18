package com.xu.manager.service;

import java.util.List;

import com.xu.manager.bean.Car;
import com.xu.manager.bean.LoginUser;
import com.xu.manager.bean.PageBean;


public interface CarService {

	List<Car> query(Car query, PageBean page);

	void saveImag(String fileName, String id);

	void saveCar(Car car);

	int deleteMore(String ids);

	Car getByID(int id);

	void update(Car car);

	List<Car> queryList(Car query, PageBean page);

	List<Car> queryAllList(Car query, PageBean page);




}
