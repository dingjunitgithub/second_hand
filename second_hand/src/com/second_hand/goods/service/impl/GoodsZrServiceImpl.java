package com.second_hand.goods.service.impl;

import java.util.List;





import com.second_hand.goods.dao.GoodsZrDao;
import com.second_hand.goods.service.GoodsZrService;
import com.second_hand.model.GoodsZr;

public class GoodsZrServiceImpl implements GoodsZrService {

	GoodsZrDao goodsZrDao=null;

	//添加转让商品
	public boolean add(GoodsZr goodszr) {
		// TODO Auto-generated method stub
		return goodsZrDao.add(goodszr);
	}

	//根据转让商品Id查找转让信息
	public GoodsZr findById(int id) {
		// TODO Auto-generated method stub
		return goodsZrDao.findById(id);
	}

	//删除转让信息
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return goodsZrDao.delete(id);
	}

	//更新转让信息
	public void update(GoodsZr goodszr) {
		// TODO Auto-generated method stub
		goodsZrDao.update(goodszr);
	}

	//分页查询正在出售商品转让信息（首页显示）
	public List<GoodsZr> findByPage(int page, int pageSize, int cityId) {
		// TODO Auto-generated method stub
		return goodsZrDao.findByPage(page, pageSize, cityId);
	}

	//根据关键字分页查询正在出售转让信息
	public List<GoodsZr> findByKeyword(int page, int pageSize, String keyword,
			int cityId) {
		// TODO Auto-generated method stub
		return goodsZrDao.findByKeyword(page, pageSize, keyword, cityId);
	}

	//根据商品类型分页查询正在出售的转让信息
	public List<GoodsZr> findByGoodsclass(int page, int pageSize,
			String goodsclass, int cityId) {
		// TODO Auto-generated method stub
		return goodsZrDao.findByGoodsclass(page, pageSize, goodsclass, cityId);
	}

	//分页查询用户转让信息（根据出售状态statu的不同选择性查询）
	public List<GoodsZr> findByPageByUser(int page, int pageSize, int userid,int condition) {
		// TODO Auto-generated method stub
		return goodsZrDao.findByPageByUser(page, pageSize, userid,condition);
	}

	//根据关键字查询正在出售转让信息的最大页数
	public int countMaxPageByKeyword(int pageSize, String keyword, int cityId)
	{
		// TODO Auto-generated method stub
		return goodsZrDao.countMaxPageByKeyword(pageSize, keyword, cityId);
	}

	//根据商品类型查询正在出售的转让信息的最大页数
	public int countMaxPageByGoodsclass(int pageSize, String goodsClass,
			int cityId){
		// TODO Auto-generated method stub
		return goodsZrDao.countMaxPageByGoodsclass(pageSize, goodsClass, cityId);
	}

	//根据每页大小查询正在出售的商品转让信息的最大页数
	public int countMaxPage(int pageSize, int cityId){
		// TODO Auto-generated method stub
		return goodsZrDao.countMaxPage(pageSize, cityId);
	}

	//查询用户转让信息的最大页数（根据出售状态statu的不同选择性查询）
	public int countMaxPageByUser(int pageSize, int userId,int condition) {
		// TODO Auto-generated method stub
		return goodsZrDao.countMaxPageByUser(pageSize, userId,condition);
	}

	//分页查询用户的更多闲置
	public List<GoodsZr> findMoreByPageByUser(int page, int pageSize, int userid) {
		// TODO Auto-generated method stub
		return goodsZrDao.findMoreByPageByUser(page, pageSize, userid);
	}

	//查询用户更多闲置的最大页数
	public int countMaxPageMoreByUser(int pageSize, int userId) {
		// TODO Auto-generated method stub
		return goodsZrDao.countMaxPageMoreByUser(pageSize, userId);
	}

	public GoodsZr addPraise(int goodsId) {
		// TODO Auto-generated method stub
		GoodsZr goodsZr=goodsZrDao.findById(goodsId);
		goodsZr.setPraise(goodsZr.getPraise()+1);
		goodsZrDao.update(goodsZr);
		return goodsZr;
	}

	/**
	 * @return the goodsZrDao
	 */
	public GoodsZrDao getGoodsZrDao() {
		return goodsZrDao;
	}

	/**
	 * @param goodsZrDao the goodsZrDao to set
	 */
	public void setGoodsZrDao(GoodsZrDao goodsZrDao) {
		this.goodsZrDao = goodsZrDao;
	}




}
