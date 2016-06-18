package com.xu.manager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.xu.manager.bean.Car;

public interface CarDao {

	List<Car> query(@Param("query")Car query);

	int countAll(@Param("query")Car query);

	void saveImag(@Param("fileName")String fileName, @Param("id")String id);

	void saveCar(Car car);

	void deleteMore(List<Integer> list);

	Car getById(int id);

	void update(Car car);

	void updateStatus(Integer id);

	List<Car> queryList(@Param("query")Car query);

	List<Car> queryAllList(@Param("query")Car query);

}
