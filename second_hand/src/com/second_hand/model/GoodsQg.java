package com.second_hand.model;

public class GoodsQg {

	private int goodsQgId;           //求购信息编号
	private String goodsName;        //商品名称    
	private String goodsMsg;
	private String address;          //交易地点
	private float price;             //期望价格
	private String phone;            //手机号码
	private String qq;               //qq号码
	private String pubDate;
	private String statu;            //求购状态
	private User user;              
	private GoodsClass classes;    //状态
	/**
	 * @return the goodsQgId
	 */
	public int getGoodsQgId() {
		return goodsQgId;
	}
	/**
	 * @param goodsQgId the goodsQgId to set
	 */
	public void setGoodsQgId(int goodsQgId) {
		this.goodsQgId = goodsQgId;
	}
	/**
	 * @return the goodsName
	 */
	public String getGoodsName() {
		return goodsName;
	}
	/**
	 * @param goodsName the goodsName to set
	 */
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the price
	 */
	public float getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(float price) {
		this.price = price;
	}
	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}
	/**
	 * @return the qq
	 */
	public String getQq() {
		return qq;
	}
	/**
	 * @param qq the qq to set
	 */
	public void setQq(String qq) {
		this.qq = qq;
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
	 * @return the classes
	 */
	public GoodsClass getClasses() {
		return classes;
	}
	/**
	 * @param classes the classes to set
	 */
	public void setClasses(GoodsClass classes) {
		this.classes = classes;
	}
	/**
	 * @return the goodsMsg
	 */
	public String getGoodsMsg() {
		return goodsMsg;
	}
	/**
	 * @param goodsMsg the goodsMsg to set
	 */
	public void setGoodsMsg(String goodsMsg) {
		this.goodsMsg = goodsMsg;
	}

	
	
}
