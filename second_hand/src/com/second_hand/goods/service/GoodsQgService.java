package com.second_hand.goods.service;

import java.util.List;

import com.second_hand.model.GoodsQg;

public interface GoodsQgService {


	//新增
	public boolean add(GoodsQg goodsQg);

	//根据id查找
	public GoodsQg findById(int id);

	//删除
	public boolean delete(int id);

	//修改
	public void update(GoodsQg goodsQg);

	//分页查询求购信息
	public List<GoodsQg> findByPageOrderById(final int page, final int pageSize,int cityId);
	//查询求购信息的最大页数
	public int countMaxPage(int pageSize,int cityId);

	/*//分页查询
		public List<GoodsQg> findByKeyword(final int page, final int pageSize,String keyword,int cityId);
		//分页查询
		public List<GoodsQg> findByGoodsclass(final int page, final int pageSize,String goodsclass,int cityId);*/

	//分页查询用户求购信息
	public List<GoodsQg> findByPageByUser(final int page, final int pageSize,final int userid);
	//查询用户求购信息的最大页数
	public int countMaxPageByUser(int pageSize,int userId) throws Exception;

	/*	//查询类型的最大页数
		public int countMaxPageByKeyword(int pageSize,String keyword,int cityId) throws Exception;
		//查询类型的最大页数
		public int countMaxPageByGoodsclass(int pageSize,String goodsclass,int cityId) throws Exception;*/

}
