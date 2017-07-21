package com.second_hand.adInfo.service.impl;

import java.util.List;

import com.second_hand.adInfo.dao.CityInfoDao;
import com.second_hand.adInfo.service.CityInfoService;
import com.second_hand.model.CityInfo;

public class CityInfoServiceImpl implements CityInfoService {

	CityInfoDao cityDao=null;
	
	//添加城市信息
	public int addCity(CityInfo city) {
		// TODO Auto-generated method stub
		return cityDao.addCity(city);
	}
	//查询所有城市信息
	public List<CityInfo> findAllCity() {
		// TODO Auto-generated method stub
		return cityDao.findAllCity();
	}
	//更新城市信息
	public CityInfo update(CityInfo city) {
		// TODO Auto-generated method stub
		return cityDao.update(city);
	}
	//删除城市信息
	public CityInfo delete(int cityId) {
		// TODO Auto-generated method stub
		return cityDao.delete(cityId);
	}
	//根据城市编号查询城市信息
	public CityInfo findCityById(int cityId) {
		// TODO Auto-generated method stub
		return cityDao.findCityById(cityId);
	}
	//分页查询城市信息
	public List<CityInfo> findByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return cityDao.findByPage(page, pageSize);
	}
	//查询城市的最大页数，用于分页显示
	public int countMaxPage(int pageSize){
		// TODO Auto-generated method stub
		return cityDao.countMaxPage(pageSize);
	}

	/**
	 * @return the cityDao
	 */
	public CityInfoDao getCityDao() {
		return cityDao;
	}

	/**
	 * @param cityDao the cityDao to set
	 */
	public void setCityDao(CityInfoDao cityDao) {
		this.cityDao = cityDao;
	}

	
	
}
