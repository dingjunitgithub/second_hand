package com.second_hand.model;

public class OrderInfo {

	private int orderId;                  //订单信息编号             
	private String statu;             //转让信息编号
	private String pubDate;            //状态
	private String goodsPicOne;
	private String evaluate;
	private User user;  		//用户表信息id
	private GoodsZr goodsZr;
	private int buyStatu;
	private int saleStatu;
	/**
	 * @return the orderId
	 */
	public int getOrderId() {
		return orderId;
	}
	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(int orderId) {
		this.orderId = orderId;
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
	 * @return the pubDate
	 */
	public String getPubDate() {
		return pubDate;
	}
	/**
	 * @param pubDate the pubDate to set
	 */
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
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
	 * @return the evaluate
	 */
	public String getEvaluate() {
		return evaluate;
	}
	/**
	 * @param evaluate the evaluate to set
	 */
	public void setEvaluate(String evaluate) {
		this.evaluate = evaluate;
	}
	/**
	 * @return the buyStatu
	 */
	public int getBuyStatu() {
		return buyStatu;
	}
	/**
	 * @param buyStatu the buyStatu to set
	 */
	public void setBuyStatu(int buyStatu) {
		this.buyStatu = buyStatu;
	}
	/**
	 * @return the saleStatu
	 */
	public int getSaleStatu() {
		return saleStatu;
	}
	/**
	 * @param saleStatu the saleStatu to set
	 */
	public void setSaleStatu(int saleStatu) {
		this.saleStatu = saleStatu;
	}
	
	
}
