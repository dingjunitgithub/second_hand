package com.second_hand.sell.service.impl;

import java.util.List;

import com.second_hand.model.Cart;
import com.second_hand.sell.dao.ShopCarDao;
import com.second_hand.sell.service.ShopCarService;

public class ShopCarServiceImpl implements ShopCarService {

	ShopCarDao shopCarDao=null;
	
	//加入购物车
	public boolean add(Cart cart) {
		// TODO Auto-generated method stub
		return shopCarDao.add(cart);
	}

	//根据编号查询
	public Cart findById(int id) {
		// TODO Auto-generated method stub
		return shopCarDao.findById(id);
	}

	//根据商品编号查询
	public Cart findByGoodsId(int id) {
		// TODO Auto-generated method stub
		return shopCarDao.findByGoodsId(id);
	}

	//根据购物车编号逐个删除
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return shopCarDao.delete(id);
	}

	//根据商品编号删除
	public boolean deleteByGoodsId(int goodsId) {
		// TODO Auto-generated method stub
		return shopCarDao.deleteByGoodsId(goodsId);
	}

	//根据用户和商品编号删除购物车信息
	public boolean deleteByGoodsIdAndUserId(int goodsId,int userId){
		Cart cart=shopCarDao.findByGoodsIdAndUserId(goodsId, userId);
		shopCarDao.deleteByGoodsIdAndUserId(cart);
		return true;
	}
	

	//计算用户购物车的最大页数
	public int countMaxPage(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		return shopCarDao.countMaxPage(pageSize, userId);
	}

	/**
	 * @return the shopCarDao
	 */
	public ShopCarDao getShopCarDao() {
		return shopCarDao;
	}

	/**
	 * @param shopCarDao the shopCarDao to set
	 */
	public void setShopCarDao(ShopCarDao shopCarDao) {
		this.shopCarDao = shopCarDao;
	}

	public Cart findByGoodsIdAndUserId(int goodsId, int userId) {
		// TODO Auto-generated method stub
		return shopCarDao.findByGoodsIdAndUserId(goodsId, userId);
	}

	public List<Cart> findByPage(int page, int pageSize, int userId) {
		// TODO Auto-generated method stub
		return shopCarDao.findByPage(page, pageSize, userId);
	}

	public boolean deleteMore(String goodsids,int userId) {
		// TODO Auto-generated method stub
		String[] goodsidsstr = goodsids.split(",");
		for(int i = 0;i<goodsidsstr.length;i++){
			Cart cart=new Cart();
			cart=shopCarDao.findByGoodsIdAndUserId(Integer.valueOf(goodsidsstr[i]), userId);
			shopCarDao.delete(cart.getCartId());
		}
		return true;
	}

	public int recordCount(int userId) throws Exception {
		// TODO Auto-generated method stub
		return shopCarDao.recordCount(userId);
	}

}
