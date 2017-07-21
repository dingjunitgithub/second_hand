package com.second_hand.adInfo.service.impl;

import java.util.List;

import com.second_hand.adInfo.dao.DepartInfoDao;
import com.second_hand.adInfo.service.DepartInfoService;
import com.second_hand.model.DepartmentInfo;
import com.second_hand.model.SchoolInfo;


public class DepartInfoServiceImpl implements DepartInfoService {

	DepartInfoDao departDao=null;
	//添加院系信息
	public int addDepart(DepartmentInfo depart) {
		// TODO Auto-generated method stub
		return departDao.addDepart(depart);
	}
	//查询所有院系信息
	public List<DepartmentInfo> findAllDepart() {
		// TODO Auto-generated method stub
		return departDao.findAllDepart();
	}
	//根据学校编号查询所有院系信息
	public List<DepartmentInfo> findDepartBySchoolId(SchoolInfo school) {
		// TODO Auto-generated method stub
		return departDao.findDepartBySchoolId(school);
	}
	//更新院系信息
	public DepartmentInfo update(DepartmentInfo depart) {
		// TODO Auto-generated method stub
		return departDao.update(depart);
	}
	//删除院系信息
	public DepartmentInfo delete(DepartmentInfo depart) {
		// TODO Auto-generated method stub
		return departDao.delete(depart);
	}
	//根据院系编号查询院系信息
	public DepartmentInfo findDepartById(int departId) {
		// TODO Auto-generated method stub
		return departDao.findDepartById(departId);
	}
	//分页查询院系信息
	public List<DepartmentInfo> findByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return departDao.findByPage(page, pageSize);
	}
	//查询院系的最大页数，用于分页
	public int countMaxPage(int pageSize){
		// TODO Auto-generated method stub
		return departDao.countMaxPage(pageSize);
	}
	/**
	 * @return the departDao
	 */
	public DepartInfoDao getDepartDao() {
		return departDao;
	}
	/**
	 * @param departDao the departDao to set
	 */
	public void setDepartDao(DepartInfoDao departDao) {
		this.departDao = departDao;
	}

	
}
