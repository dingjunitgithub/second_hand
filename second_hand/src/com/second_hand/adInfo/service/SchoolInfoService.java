package com.second_hand.adInfo.service;

import java.util.List;

import com.second_hand.model.CityInfo;
import com.second_hand.model.SchoolInfo;

public interface SchoolInfoService {

	/**
	 * 添加学校信息
	 * @param school
	 * @return
	 */
	public int addSchool(SchoolInfo school);
	/**
	 * 查询所有学校
	 * @return
	 */
	public List<SchoolInfo> findAllSchool();
	/**
	 * 根据城市编号查询学校信息（在添加院系信息时）
	 * @param city
	 * @return
	 */
	public List<SchoolInfo> findSchoolByCityId(CityInfo city);
	/**
	 * 更新学校信息
	 * @param school
	 * @return
	 */
	public SchoolInfo update(SchoolInfo school);
	/**
	 * 删除学校信息
	 * @param schoolId
	 * @return
	 */
	public SchoolInfo delete(int schoolId);
	/**
	 * 根据编号查询学校信息
	 * @param schoolId
	 * @return
	 */
	public SchoolInfo findSchoolById(int schoolId);
	/**
	 * 分页查询学校信息
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<SchoolInfo> findByPage(final int page, final int pageSize);
	/**
	 * 学校的最大页数，在分页处显示
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public int countMaxPage(int pageSize) throws Exception;
}
