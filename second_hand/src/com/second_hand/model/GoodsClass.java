package com.second_hand.model;

import java.util.List;

public class GoodsClass {

	private int classId;                  //商品一级分类编号
	private String className;          //分类名称
	private List<GoodsZr> goodsZrList;
	private List<GoodsQg> goodsQgList;
	/**
	 * @return the classId
	 */
	public int getClassId() {
		return classId;
	}
	/**
	 * @param classId the classId to set
	 */
	public void setClassId(int classId) {
		this.classId = classId;
	}
	/**
	 * @return the className
	 */
	public String getClassName() {
		return className;
	}
	/**
	 * @param className the className to set
	 */
	public void setClassName(String className) {
		this.className = className;
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

	
	
}
