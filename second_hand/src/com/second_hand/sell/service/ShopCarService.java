package com.second_hand.sell.service;

import java.util.List;

import com.second_hand.model.Cart;

public interface ShopCarService {

	//新增
	public boolean add(Cart cart);
	//根据id查找
	public Cart findById(int id);
	//根据商品id查找购物车
	public Cart findByGoodsId(int id);
	//根据购物车编号删除，逐个删除
	public boolean delete(int id);
	//根据商品编号删除
	public boolean deleteByGoodsId(int goodsId);
	//查询用户购物车的最大页数
	public int countMaxPage(int pageSize,int userId) throws Exception;
	//查询用户购物车数量
	public int recordCount(int userId) throws Exception;
	//根据用户和商品编号删除购物车信息
	public boolean deleteByGoodsIdAndUserId(int goodsId,int userId);
	//根据用户和商品编号查询购物车信息，判断该商品是否已在用户购物车中
	public Cart findByGoodsIdAndUserId(int goodsId,int userId);
	//分页查询用户购物车
	public List<Cart> findByPage(final int page, final int pageSize,final int userId);
	//批量删除
	public boolean deleteMore(String goodsids,int userId);

}
