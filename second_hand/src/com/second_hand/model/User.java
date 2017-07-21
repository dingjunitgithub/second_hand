package com.second_hand.model;

import java.util.List;

public class User {

	private int userId;             //用户编号
	private int userType;			//用户类型（1代表管理员，2代表一般用户）
	private String password;		//密码
	private String nickname;        //昵称
	private String email;           //邮箱
	private DepartmentInfo depart;	//院系
	private String photoUrl;        //头像
	private String qq;              //qq号码
	private int integral;           //个人积分
	private String phone;           //手机号码
	private float accountBalance;   //账户余额
	private String payPassword;		//支付密码
	private String lv;
	private List<GoodsZr> goodsZrList;
	private List<GoodsQg> goodsQgList;
	private List<Cart> carList;
	private List<OrderInfo> orderList;
	private List<Comment> commentList;
	private List<Comment> commentMeList;
	private List<Integration> integraList;
	/**
	 * @return the userId
	 */
	public int getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(int userId) {
		this.userId = userId;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the nickname
	 */
	public String getNickname() {
		return nickname;
	}
	/**
	 * @param nickname the nickname to set
	 */
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the photoUrl
	 */
	public String getPhotoUrl() {
		return photoUrl;
	}
	/**
	 * @param photoUrl the photoUrl to set
	 */
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
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
	 * @return the integral
	 */
	public int getIntegral() {
		return integral;
	}
	/**
	 * @param integral the integral to set
	 */
	public void setIntegral(int integral) {
		this.integral = integral;
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
	 * @return the accountBalance
	 */
	public float getAccountBalance() {
		return accountBalance;
	}
	/**
	 * @param accountBalance the accountBalance to set
	 */
	public void setAccountBalance(float accountBalance) {
		this.accountBalance = accountBalance;
	}
	/**
	 * @return the payPassword
	 */
	public String getPayPassword() {
		return payPassword;
	}
	/**
	 * @param payPassword the payPassword to set
	 */
	public void setPayPassword(String payPassword) {
		this.payPassword = payPassword;
	}
	/**
	 * @return the depart
	 */
	public DepartmentInfo getDepart() {
		return depart;
	}
	/**
	 * @param depart the depart to set
	 */
	public void setDepart(DepartmentInfo depart) {
		this.depart = depart;
	}
	/**
	 * @return the goodsZrList
	 */
	public List<GoodsZr> getGoodsZrList() {
		return goodsZrList;
	}
	/**
	 * @param goodsZrList the goodsZrList to set
	 */
	public void setGoodsZrList(List<GoodsZr> goodsZrList) {
		this.goodsZrList = goodsZrList;
	}
	/**
	 * @return the goodsQgList
	 */
	public List<GoodsQg> getGoodsQgList() {
		return goodsQgList;
	}
	/**
	 * @param goodsQgList the goodsQgList to set
	 */
	public void setGoodsQgList(List<GoodsQg> goodsQgList) {
		this.goodsQgList = goodsQgList;
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
	 * @return the integraList
	 */
	public List<Integration> getIntegraList() {
		return integraList;
	}
	/**
	 * @param integraList the integraList to set
	 */
	public void setIntegraList(List<Integration> integraList) {
		this.integraList = integraList;
	}
	/**
	 * @return the commentMeList
	 */
	public List<Comment> getCommentMeList() {
		return commentMeList;
	}
	/**
	 * @param commentMeList the commentMeList to set
	 */
	public void setCommentMeList(List<Comment> commentMeList) {
		this.commentMeList = commentMeList;
	}
	/**
	 * @return the userType
	 */
	public int getUserType() {
		return userType;
	}
	/**
	 * @param userType the userType to set
	 */
	public void setUserType(int userType) {
		this.userType = userType;
	}
	/**
	 * @return the lv
	 */
	public String getLv() {
		return lv;
	}
	/**
	 * @param lv the lv to set
	 */
	public void setLv(String lv) {
		this.lv = lv;
	}
	
	
	
	
}
