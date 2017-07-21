package com.second_hand.model;

import java.util.List;

public class GoodsZr {

	private int goodsZrId;                  //商品转让信息编号
	private String goodsName;        //商品名称
	private String goodsPic;         //商品图片
	private String goodsMsg;         //商品详细信息
	private String newAndOld;        //几成新
	private String address;          //交易地址
	private float price;             //商品价格
	private String talkPrice;        //是否能讲价
	private String phone;            //手机号码
	private String qq;               //qq号码
	private String pubDate;          //发布时间
	private String statu;            //状态
	private String goodspicone;
	private int comCount;
	private int tradeType;
	private User user;              //发布人的id
	private GoodsClass classes;
	private List<Comment> commentList;
	private List<Cart> carList;
	private List<OrderInfo> orderList;
	private int praise;
	/**
	 * @return the goodsZrId
	 */
	public int getGoodsZrId() {
		return goodsZrId;
	}
	/**
	 * @param goodsZrId the goodsZrId to set
	 */
	public void setGoodsZrId(int goodsZrId) {
		this.goodsZrId = goodsZrId;
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
	 * @return the goodsPic
	 */
	public String getGoodsPic() {
		return goodsPic;
	}
	/**
	 * @param goodsPic the goodsPic to set
	 */
	public void setGoodsPic(String goodsPic) {
		this.goodsPic = goodsPic;
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
	/**
	 * @return the newAndOld
	 */
	public String getNewAndOld() {
		return newAndOld;
	}
	/**
	 * @param newAndOld the newAndOld to set
	 */
	public void setNewAndOld(String newAndOld) {
		this.newAndOld = newAndOld;
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
	 * @return the talkPrice
	 */
	public String getTalkPrice() {
		return talkPrice;
	}
	/**
	 * @param talkPrice the talkPrice to set
	 */
	public void setTalkPrice(String talkPrice) {
		this.talkPrice = talkPrice;
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
	 * @return the goodspicone
	 */
	public String getGoodspicone() {
		return goodspicone;
	}
	/**
	 * @param goodspicone the goodspicone to set
	 */
	public void setGoodspicone(String goodspicone) {
		this.goodspicone = goodspicone;
	}
	/**
	 * @return the carList
	 */
	public List<Cart> getCarList() {
		return carList;
	}
	/**
	 * @param carList the carList to set
	 */
	public void setCarList(List<Cart> carList) {
		this.carList = carList;
	}
	/**
	 * @return the orderList
	 */
	public List<OrderInfo> getOrderList() {
		return orderList;
	}
	/**
	 * @param orderList the orderList to set
	 */
	public void setOrderList(List<OrderInfo> orderList) {
		this.orderList = orderList;
	}
	/**
	 * @return the commentList
	 */
	public List<Comment> getCommentList() {
		return commentList;
	}
	/**
	 * @param commentList the commentList to set
	 */
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	/**
	 * @return the comCount
	 */
	public int getComCount() {
		return comCount;
	}
	/**
	 * @param comCount the comCount to set
	 */
	public void setComCount(int comCount) {
		this.comCount = comCount;
	}
	/**
	 * @return the praise
	 */
	public int getPraise() {
		return praise;
	}
	/**
	 * @param praise the praise to set
	 */
	public void setPraise(int praise) {
		this.praise = praise;
	}
	/**
	 * @return the tradeType
	 */
	public int getTradeType() {
		return tradeType;
	}
	/**
	 * @param tradeType the tradeType to set
	 */
	public void setTradeType(int tradeType) {
		this.tradeType = tradeType;
	}
	
	
	
}
