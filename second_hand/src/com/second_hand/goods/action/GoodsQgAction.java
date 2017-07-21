package com.second_hand.goods.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.second_hand.base.action.BaseAction;
import com.second_hand.goods.service.GoodsQgService;
import com.second_hand.goodsType.service.GoodsClassService;
import com.second_hand.model.CityInfo;
import com.second_hand.model.GoodsClass;
import com.second_hand.model.GoodsQg;
import com.second_hand.model.Integration;
import com.second_hand.model.Rule;
import com.second_hand.model.User;
import com.second_hand.user.service.IntegrationService;
import com.second_hand.user.service.RuleService;
import com.second_hand.user.service.UserService;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class GoodsQgAction extends BaseAction {

	GoodsQgService goodsQgService=null;
	UserService userService=null;
	GoodsClassService goodsClassService=null;
	IntegrationService integrationService=null;
	RuleService ruleService=null;
	private List<GoodsQg> goodsQgList;
	private List<GoodsClass> goodsClassList;

	private int page = 1;
	private int maxPage;
	
	private String name;
	private int id;
	GoodsQg goodsQg;
	User user;
	
	
	//商品信息
	String goodsName;
	String address;
	float price;
	String phone;
	String qq;
	String statu;
	String className;
	int classId;
	String goodsMsg;
	
	
	public String toDetailPage(){
		goodsQg = goodsQgService.findById(id);
		//图片信息
		return "toDetailPage";
	}
	
	
	//首页求购商品展示
	public String indexGoodsQg(){
		System.out.println("aaaaaaaaaaaaa"+page);
		CityInfo city=(CityInfo)session.get("city");
		goodsQgList = goodsQgService.findByPageOrderById(page, PageUtil.PAGENUM,city.getCityId());
		try {
			maxPage = goodsQgService.countMaxPage(PageUtil.PAGENUM,city.getCityId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "indexGoodsQg";
	}
	
	//列表
	public String toList(){
		CityInfo city=(CityInfo)session.get("city");
		goodsQgList = goodsQgService.findByPageOrderById(page, PageUtil.PAGENUM, city.getCityId());
		try {
			maxPage = goodsQgService.countMaxPage(PageUtil.PAGENUM,city.getCityId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toList";
	}
	//列表
	public String toListByUser(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		goodsQgList = goodsQgService.findByPageByUser(page, PageUtil.PAGENUM,user.getUserId());
		try {
			maxPage = goodsQgService.countMaxPageByUser(PageUtil.PAGENUM,user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toListByUser";
	}
	
	
	//去新增界面
	public String toAdd(){
		//查询当前用户信息
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		goodsClassList = goodsClassService.findAll();
		return "toAdd";
	}
	
	//新增
	public String add(){
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		GoodsQg goodsQg = new GoodsQg();
		goodsQg.setAddress(address);
		goodsQg.setGoodsName(goodsName);
		goodsQg.setPhone(phone);
		goodsQg.setPrice(price);
		goodsQg.setGoodsMsg(goodsMsg);
		goodsQg.setPubDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		GoodsClass goodsClass=new GoodsClass();
		goodsClass.setClassId(classId);
		goodsQg.setClasses(goodsClass);
		goodsQg.setQq(qq);
		goodsQg.setStatu("0");
		goodsQg.setUser(user);
		boolean flag=goodsQgService.add(goodsQg);
		if(flag){
			Rule rule=ruleService.findRuleById(3);
			int value=Integer.parseInt(rule.getRuleValue().substring(1));
			user.setIntegral(user.getIntegral()+value);
			userService.update(user);
			Integration integration=new Integration();
			integration.setRule(rule);
			integration.setUser(user);
			integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			integrationService.addIntegration(integration);	
		}
		return "add";
	}
	
	//去修改界面
	public String toUpdate(){
		//查询当前用户信息
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);//可以不用，直接通过goodsQg获得
		//查询商品分类信息
		goodsQg = goodsQgService.findById(id);
		goodsClassList = goodsClassService.findAll();
		return "toUpdate";
	}
	
	//去详细信息页面
	public String toDetail(){
		goodsQg = goodsQgService.findById(id);
		return "toDetail";
	}
	
	//改变状态，出售-停售
	public String updateStatu(){
		GoodsQg goodsQg= goodsQgService.findById(id);
		goodsQg.setStatu(statu);
		goodsQgService.update(goodsQg);
		
		return "updateStatu";
	}
	
	//修改
	public String update(){
		GoodsQg goodsQg = goodsQgService.findById(id);
		goodsQg.setAddress(address);
		goodsQg.setGoodsName(goodsName);
		goodsQg.setPhone(phone);
		goodsQg.setPrice(price);
		goodsQg.setGoodsMsg(goodsMsg);
		goodsQg.setPubDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		GoodsClass goodsClass=new GoodsClass();
		goodsClass.setClassId(classId);
		goodsQg.setClasses(goodsClass);
		goodsQg.setQq(qq);
	
		goodsQgService.update(goodsQg);
		return "update";
	}
	
	//删除
	public String delete(){
		boolean flag=goodsQgService.delete(id);
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		if(flag){
			Rule rule=ruleService.findRuleById(9);
			int value=Integer.parseInt(rule.getRuleValue().substring(1));
			user.setIntegral(user.getIntegral()-value);
			userService.update(user);
			Integration integration=new Integration();
			integration.setRule(rule);
			integration.setUser(user);
			integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			integrationService.addIntegration(integration);	
		}
		return "delete";
	}
	
	//删除
	public String deleteByUser(){
		boolean flag=goodsQgService.delete(id);
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		if(flag){
			user.setIntegral(user.getIntegral()-3);
			userService.update(user);
		}
		return "deleteByUser";
	}


	/**
	 * @return the goodsQgService
	 */
	public GoodsQgService getGoodsQgService() {
		return goodsQgService;
	}


	/**
	 * @param goodsQgService the goodsQgService to set
	 */
	public void setGoodsQgService(GoodsQgService goodsQgService) {
		this.goodsQgService = goodsQgService;
	}


	/**
	 * @return the userService
	 */
	public UserService getUserService() {
		return userService;
	}


	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
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
	 * @return the name
	 */
	public String getName() {
		return name;
	}


	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
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
	 * @return the goodsQg
	 */
	public GoodsQg getGoodsQg() {
		return goodsQg;
	}


	/**
	 * @param goodsQg the goodsQg to set
	 */
	public void setGoodsQg(GoodsQg goodsQg) {
		this.goodsQg = goodsQg;
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
	 * @return the integrationService
	 */
	public IntegrationService getIntegrationService() {
		return integrationService;
	}


	/**
	 * @param integrationService the integrationService to set
	 */
	public void setIntegrationService(IntegrationService integrationService) {
		this.integrationService = integrationService;
	}


	/**
	 * @return the ruleService
	 */
	public RuleService getRuleService() {
		return ruleService;
	}


	/**
	 * @param ruleService the ruleService to set
	 */
	public void setRuleService(RuleService ruleService) {
		this.ruleService = ruleService;
	}
	
	
}
