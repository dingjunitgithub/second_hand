package com.second_hand.model;

public class Cart {
	private int cartId;                  //购物车信息编号
	private String goodsPicOne;          //转让信息编号
	private String statu;                //用户表信息id
	private GoodsZr goodsZr;
	private User user;
	/**
	 * @return the cartId
	 */
	public int getCartId() {
		return cartId;
	}
	/**
	 * @param cartId the cartId to set
	 */
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	/**
	 * @return the goodsPicOne
	 */
	public String getGoodsPicOne() {
		return goodsPicOne;
	}
	/**
	 * @param goodsPicOne the goodsPicOne to set
	 */
	public void setGoodsPicOne(String goodsPicOne) {
		this.goodsPicOne = goodsPicOne;
	}
	/**
	 * @return the statu
	 */
	public String getStatu() {
		return statu;
	}
	/**
	 * @param statu the statu to set
	 */
	public void setStatu(String statu) {
		this.statu = statu;
	}
	/**
	 * @return the goodsZr
	 */
	public GoodsZr getGoodsZr() {
		return goodsZr;
	}
	/**
	 * @param goodsZr the goodsZr to set
	 */
	public void setGoodsZr(GoodsZr goodsZr) {
		this.goodsZr = goodsZr;
	}
	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}
	/**
	 * @param user the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}
	

}
