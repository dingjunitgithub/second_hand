package com.second_hand.adInfo.dao;

import java.util.List;

import com.second_hand.model.CityInfo;

public interface CityInfoDao {

	/**
	 * 添加城市
	 * @param city
	 * @return
	 */
	public int addCity(CityInfo city);
	/**
	 * 更新城市信息
	 * @param city
	 * @return
	 */
	public CityInfo update(CityInfo city);
	/**
	 * 删除城市
	 * @param cityId
	 * @return
	 */
	public CityInfo delete(int cityId);
	/**
	 * 根据城市编号查询城市信息
	 * @param cityId
	 * @return
	 */
	public CityInfo findCityById(int cityId);
	/**
	 * 查询所有城市信息
	 * @return
	 */
	public List<CityInfo> findAllCity();
	/**
	 * 分页查询城市信息
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<CityInfo> findByPage(final int page, final int pageSize);
	/**
	 * 查询城市的最大页数，为在分页显示
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	public int countMaxPage(int pageSize);

}
