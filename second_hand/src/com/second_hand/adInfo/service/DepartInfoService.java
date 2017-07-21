package com.second_hand.adInfo.service;

import java.util.List;

import com.second_hand.model.DepartmentInfo;
import com.second_hand.model.SchoolInfo;

public interface DepartInfoService {

	/**
	 * 添加院系信息
	 * @param depart
	 * @return
	 */
	public int addDepart(DepartmentInfo depart);
	/**
	 * 查找所有部门信息
	 * @return
	 */
	public List<DepartmentInfo> findAllDepart();
	/**
	 * 根据学校的Id查找院系信息
	 * @param school
	 * @return
	 */
	public List<DepartmentInfo> findDepartBySchoolId(SchoolInfo school);
	/**
	 * 更新院系信息
	 * @param depart
	 * @return
	 */
	public DepartmentInfo update(DepartmentInfo depart);
	/**
	 * 删除院系信息
	 * @param depart
	 * @return
	 */
	public DepartmentInfo delete(DepartmentInfo depart);
	/**
	 * 根据院系Id查找院系信息
	 * @param departId
	 * @return
	 */
	public DepartmentInfo findDepartById(int departId);
	/**
	 * 分页查询院系信息
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<DepartmentInfo> findByPage(final int page, final int pageSize);
	/**
	 * 计算院系最大页数，用户分页显示
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public int countMaxPage(int pageSize);
}
