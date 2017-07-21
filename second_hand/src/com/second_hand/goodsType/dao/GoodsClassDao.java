package com.second_hand.goodsType.dao;

import java.util.List;

import com.second_hand.model.GoodsClass;

public interface GoodsClassDao {

	//查询所有
	public List<GoodsClass> findAll();
	//新增
	public boolean add(GoodsClass goodsClass);
	//根据id查找
	public GoodsClass findById(int id);
	//删除
	public boolean delete(int id);
	//修改
	public void update(GoodsClass goodsClass);
	//分页查询
	public List<GoodsClass> findByPage(final int page, final int pageSize);
	//查询类型的最大页数
	public int countMaxPage(int pageSize);

}
