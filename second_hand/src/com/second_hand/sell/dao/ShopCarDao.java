package com.second_hand.sell.dao;

import java.util.List;

import com.second_hand.model.Cart;

public interface ShopCarDao {

	//购物车新增
	public boolean add(Cart cart);
	//根据购物车id查找购物车信息
	public Cart findById(int id);
	//根据转让商品id查找购物车信息
	public Cart findByGoodsId(int id);
	//删除
	public boolean delete(int id);
	//删除
	public boolean deleteByGoodsId(int goodsId);
	//分页查询用户购物车
	public List<Cart> findByPage(final int page, final int pageSize,final int userId);
	//查询用户购物车的最大页数
	public int countMaxPage(int pageSize,int userId);
	//删除购物车商品
	public boolean deleteByGoodsIdAndUserId(Cart cart);
	//根据用户编号和商品编号查找购物车，判断其购物车中是否存在商品
	public Cart findByGoodsIdAndUserId(int goodsId,int userId);
	//查询用户的购物车中商品数
	public int recordCount(int userId);
}
