package com.second_hand.goodsType.service.impl;

import java.util.List;

import com.second_hand.goodsType.dao.GoodsClassDao;
import com.second_hand.goodsType.service.GoodsClassService;
import com.second_hand.model.GoodsClass;


public class GoodsClassServiceImpl implements GoodsClassService {

	GoodsClassDao goodsClasssDao=null;
	//查询所有类型信息
	public List<GoodsClass> findAll() {
		// TODO Auto-generated method stub
		return goodsClasssDao.findAll();
	}
	//新增类型信息
	public boolean add(GoodsClass goodsClass) {
		// TODO Auto-generated method stub
		return goodsClasssDao.add(goodsClass);
	}
	//根据Id查询类型信息
	public GoodsClass findById(int id) {
		// TODO Auto-generated method stub
		return goodsClasssDao.findById(id);
	}
	//删除类型
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return goodsClasssDao.delete(id);
	}
	//更新类型名称
	public void update(GoodsClass goodsClass) {
		// TODO Auto-generated method stub
		goodsClasssDao.update(goodsClass);
	}
	//分页查询分类信息
	public List<GoodsClass> findByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return goodsClasssDao.findByPage(page, pageSize);
	}
	//查询类型信息的最大页数
	public int countMaxPage(int pageSize){
		// TODO Auto-generated method stub
		return goodsClasssDao.countMaxPage(pageSize);
	}
	/**
	 * @return the goodsClasssDao
	 */
	public GoodsClassDao getGoodsClasssDao() {
		return goodsClasssDao;
	}
	/**
	 * @param goodsClasssDao the goodsClasssDao to set
	 */
	public void setGoodsClasssDao(GoodsClassDao goodsClasssDao) {
		this.goodsClasssDao = goodsClasssDao;
	}


}
