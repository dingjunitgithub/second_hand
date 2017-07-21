package com.second_hand.goodsType.action;

import java.util.List;

import com.opensymphony.xwork2.ActionSupport;
import com.second_hand.goodsType.service.GoodsClassService;
import com.second_hand.model.GoodsClass;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class GoodsClassAction extends ActionSupport {
	GoodsClassService goodsClassService=null;
	List<GoodsClass> goodsClassList=null;
	private int page = 1;
	private int maxPage;

	private int id;
	private String className;
	GoodsClass goodsClass=null;

	private String yuanxis;

	//列表
	public String toList(){

		goodsClassList = goodsClassService.findByPage(page, PageUtil.PAGENUM);
		try {
			maxPage = goodsClassService.countMaxPage(PageUtil.PAGENUM);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toList";
	}
	//去新增界面
	public String toAdd(){
		return "toAdd";
	}

	//新增
	public String add(){
		GoodsClass goodsclass = new GoodsClass();
		goodsclass.setClassName(className);
		goodsClassService.add(goodsclass);
		return "add";
	}
	//去修改界面
	public String toUpdate(){
		goodsClass = goodsClassService.findById(id);
		return "toUpdate";
	}
	//修改
	public String update(){
		GoodsClass goodsclass = goodsClassService.findById(id);
		goodsclass.setClassName(className);
		goodsClassService.update(goodsclass);
		return "update";
	}
	//删除
	public String delete(){
		goodsClassService.delete(id);
		return "delete";
	}
	/**
	 * @return the goodsClassService
	 */
	public GoodsClassService getGoodsClassService() {
		return goodsClassService;
	}
	/**
	 * @param goodsClassService the goodsClassService to set
	 */
	public void setGoodsClassService(GoodsClassService goodsClassService) {
		this.goodsClassService = goodsClassService;
	}
	/**
	 * @return the goodsClassList
	 */
	public List<GoodsClass> getGoodsClassList() {
		return goodsClassList;
	}
	/**
	 * @param goodsClassList the goodsClassList to set
	 */
	public void setGoodsClassList(List<GoodsClass> goodsClassList) {
		this.goodsClassList = goodsClassList;
	}
	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}
	/**
	 * @param page the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}
	
	/**
	 * @return the maxPage
	 */
	public int getMaxPage() {
		return maxPage;
	}
	/**
	 * @param maxPage the maxPage to set
	 */
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
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
	 * @return the goodsClass
	 */
	public GoodsClass getGoodsClass() {
		return goodsClass;
	}
	/**
	 * @param goodsClass the goodsClass to set
	 */
	public void setGoodsClass(GoodsClass goodsClass) {
		this.goodsClass = goodsClass;
	}
	/**
	 * @return the yuanxis
	 */
	public String getYuanxis() {
		return yuanxis;
	}
	/**
	 * @param yuanxis the yuanxis to set
	 */
	public void setYuanxis(String yuanxis) {
		this.yuanxis = yuanxis;
	}






}
