package com.second_hand.adInfo.service.impl;


import java.util.List;

import com.second_hand.adInfo.dao.SchoolInfoDao;
import com.second_hand.adInfo.service.SchoolInfoService;
import com.second_hand.model.CityInfo;
import com.second_hand.model.SchoolInfo;

public class SchoolInfoServiceImpl implements SchoolInfoService {

	SchoolInfoDao schoolDao=null;
	
	//添加学校信息
	public int addSchool(SchoolInfo school) {
		// TODO Auto-generated method stub
		return schoolDao.addSchool(school);
	}
	
	//查询所有学校信息
	public List<SchoolInfo> findAllSchool() {
		// TODO Auto-generated method stub
		return schoolDao.findAllSchool();
	}
	
	//根据城市Id查找学校信息
	public List<SchoolInfo> findSchoolByCityId(CityInfo city) {
		// TODO Auto-generated method stub
		return schoolDao.findSchoolByCityId(city);
	}
	
	//更新学校信息
	public SchoolInfo update(SchoolInfo school) {
		// TODO Auto-generated method stub
		return schoolDao.update(school);
	}
	
	//删除学校信息
	public SchoolInfo delete(int schoolId) {
		// TODO Auto-generated method stub
		return schoolDao.delete(schoolId);
	}
	
	//根据学校Id查询学校信息
	public SchoolInfo findSchoolById(int schoolId) {
		// TODO Auto-generated method stub
		return schoolDao.findSchoolById(schoolId);
	}
	
	//分页查询学校信息
	public List<SchoolInfo> findByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return schoolDao.findByPage(page, pageSize);
	}
	
	//查询学校的最大页数，用于分页
	public int countMaxPage(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		return schoolDao.countMaxPage(pageSize);
	}

	/**
	 * @return the schoolDao
	 */
	public SchoolInfoDao getSchoolDao() {
		return schoolDao;
	}

	/**
	 * @param schoolDao the schoolDao to set
	 */
	public void setSchoolDao(SchoolInfoDao schoolDao) {
		this.schoolDao = schoolDao;
	}
	

	
}
