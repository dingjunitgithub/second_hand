package com.second_hand.goods.service.impl;

import java.util.List;

import com.second_hand.goods.dao.GoodsQgDao;
import com.second_hand.goods.service.GoodsQgService;
import com.second_hand.model.GoodsQg;

public class GoodsQgServiceImpl implements GoodsQgService {

	GoodsQgDao goodsQgDao=null;
	//新增
	public boolean add(GoodsQg goodsQg) {
		// TODO Auto-generated method stub
		return goodsQgDao.add(goodsQg);
	}

	//根据id查找
	public GoodsQg findById(int id) {
		// TODO Auto-generated method stub
		return goodsQgDao.findById(id);
	}

	//删除
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return goodsQgDao.delete(id);
	}

	//修改
	public void update(GoodsQg goodsQg) {
		// TODO Auto-generated method stub
		goodsQgDao.update(goodsQg);
	}

	//分页查询求购信息
	public List<GoodsQg> findByPageOrderById(int page, int pageSize,int cityId) {
		// TODO Auto-generated method stub
		return goodsQgDao.findByPageOrderById(page, pageSize, cityId);
	}

/*	public List<GoodsQg> findByKeyword(int page, int pageSize, String keyword,int cityId) {
		// TODO Auto-generated method stub
		return goodsQgDao.findByKeyword(page, pageSize, keyword, cityId);
	}

	public List<GoodsQg> findByGoodsclass(int page, int pageSize,
			String goodsclass,int cityId) {
		// TODO Auto-generated method stub
		return goodsQgDao.findByGoodsclass(page, pageSize, goodsclass, cityId);
	}*/

	//分页查询用户求购信息
	public List<GoodsQg> findByPageByUser(int page, int pageSize, int userid) {
		// TODO Auto-generated method stub
		return goodsQgDao.findByPageByUser(page, pageSize, userid);
	}

/*	public int countMaxPageByKeyword(int pageSize, String keyword,int cityId)
			throws Exception {
		// TODO Auto-generated method stub
		return goodsQgDao.countMaxPageByKeyword(pageSize, keyword, cityId);
	}

	public int countMaxPageByGoodsclass(int pageSize, String goodsclass,int cityId)
			throws Exception {
		// TODO Auto-generated method stub
		return goodsQgDao.countMaxPageByGoodsclass(pageSize, goodsclass, cityId);
	}*/

	//查询求购信息的最大页数
	public int countMaxPage(int pageSize,int cityId){
		// TODO Auto-generated method stub
		return goodsQgDao.countMaxPage(pageSize, cityId);
	}

	//查询用户求购信息的最大页数
	public int countMaxPageByUser(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		return goodsQgDao.countMaxPageByUser(pageSize, userId);
	}

	/**
	 * @return the goodsQgDao
	 */
	public GoodsQgDao getGoodsQgDao() {
		return goodsQgDao;
	}

	/**
	 * @param goodsQgDao the goodsQgDao to set
	 */
	public void setGoodsQgDao(GoodsQgDao goodsQgDao) {
		this.goodsQgDao = goodsQgDao;
	}

	
}
