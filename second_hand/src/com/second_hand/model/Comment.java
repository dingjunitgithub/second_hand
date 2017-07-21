package com.second_hand.model;

import java.util.List;


public class Comment {

	private int comId;                  //评论信息编号
	private String content;          //评论内容
	private String cdate;             //评论时间
	private int ctype;					//留言还是回复
	private GoodsZr goodsZr;          
	private User user;
	private User toUser;
	private int revertSta;
	private int oldComId;
	private int autoType;
	private List<Comment> revertList;
	/**
	 * @return the comId
	 */
	public int getComId() {
		return comId;
	}
	/**
	 * @param comId the comId to set
	 */
	public void setComId(int comId) {
		this.comId = comId;
	}
	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * @return the cdate
	 */
	public String getCdate() {
		return cdate;
	}
	/**
	 * @param cdate the cdate to set
	 */
	public void setCdate(String cdate) {
		this.cdate = cdate;
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
	/**
	 * @return the toUser
	 */
	public User getToUser() {
		return toUser;
	}
	/**
	 * @param toUser the toUser to set
	 */
	public void setToUser(User toUser) {
		this.toUser = toUser;
	}
	/**
	 * @return the ctype
	 */
	public int getCtype() {
		return ctype;
	}
	/**
	 * @param ctype the ctype to set
	 */
	public void setCtype(int ctype) {
		this.ctype = ctype;
	}
	/**
	 * @return the revertSta
	 */
	public int getRevertSta() {
		return revertSta;
	}
	/**
	 * @param revertSta the revertSta to set
	 */
	public void setRevertSta(int revertSta) {
		this.revertSta = revertSta;
	}
	/**
	 * @return the oldComId
	 */
	public int getOldComId() {
		return oldComId;
	}
	/**
	 * @param oldComId the oldComId to set
	 */
	public void setOldComId(int oldComId) {
		this.oldComId = oldComId;
	}
	/**
	 * @return the revertList
	 */
	public List<Comment> getRevertList() {
		return revertList;
	}
	/**
	 * @param revertList the revertList to set
	 */
	public void setRevertList(List<Comment> revertList) {
		this.revertList = revertList;
	}
	/**
	 * @return the autoType
	 */
	public int getAutoType() {
		return autoType;
	}
	/**
	 * @param autoType the autoType to set
	 */
	public void setAutoType(int autoType) {
		this.autoType = autoType;
	}

	
	
}
