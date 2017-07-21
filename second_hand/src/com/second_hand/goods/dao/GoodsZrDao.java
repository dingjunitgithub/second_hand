package com.second_hand.goods.dao;

import java.util.List;

import com.second_hand.model.GoodsZr;

public interface GoodsZrDao {

	//新增转让信息
	public boolean add(GoodsZr goodszr);
	
	//根据id查找转让信息
	public GoodsZr findById(int id);
	
	//删除转让信息
	public boolean delete(int id);
	
	//修改转让信息
	public void update(GoodsZr goodszr);
	
	//分页查询正在出售商品转让信息（首页显示）
	public List<GoodsZr> findByPage(final int page, final int pageSize,int cityId);
	//根据每页大小查询正在出售的商品转让信息的最大页数
	public int countMaxPage(int pageSize,int cityId);
	
	//根据关键字分页查询正在出售转让信息
	public List<GoodsZr> findByKeyword(final int page, final int pageSize,String keyword,int cityId);
	//根据关键字查询正在出售转让信息的最大页数
	public int countMaxPageByKeyword(int pageSize,String keyword,int cityId);
	
	//根据商品类型分页查询正在出售的转让信息
	public List<GoodsZr> findByGoodsclass(final int page, final int pageSize,String goodsclass,int cityId);
	//根据商品类型查询正在出售的转让信息的最大页数
	public int countMaxPageByGoodsclass(int pageSize,String goodsClass,int cityId);
	
	//分页查询用户转让信息（根据出售状态statu的不同选择性查询）
	public List<GoodsZr> findByPageByUser(final int page, final int pageSize,final int userid,int condition);
	//查询用户转让信息的最大页数（根据出售状态statu的不同选择性查询）
	public int countMaxPageByUser(int pageSize,int userId,int condition);
	
	//分页查询用户的更多闲置
	public List<GoodsZr> findMoreByPageByUser(final int page, final int pageSize,final int userid);
	//查询用户更多闲置的最大页数
	public int countMaxPageMoreByUser(int pageSize,int userId);

}
