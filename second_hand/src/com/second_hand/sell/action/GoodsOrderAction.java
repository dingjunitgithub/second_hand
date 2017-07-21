package com.second_hand.sell.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.second_hand.base.action.BaseAction;
import com.second_hand.model.GoodsZr;
import com.second_hand.model.Integration;
import com.second_hand.model.OrderInfo;
import com.second_hand.model.Rule;
import com.second_hand.model.User;
import com.second_hand.sell.service.GoodsOrderService;
import com.second_hand.user.service.IntegrationService;
import com.second_hand.user.service.RuleService;
import com.second_hand.user.service.UserService;
import com.second_hand.util.Constants;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class GoodsOrderAction extends BaseAction{

	GoodsOrderService goodOrderService=null;
	IntegrationService integrationService=null;
	RuleService ruleService=null;
	List<OrderInfo> orderList;
	private int page = 1;
	private int maxPage;
	UserService userService=null;
	private int id;
	private String evaluate;
	private String state;
	private int userId;
	private int flag;
	private User user;
	private String lv;
	private int condition=4;
	private int sendCount=0;
	private int receiveCount=0;
	private int evaluationCount=0;
	private int sendCountToBuy=0;

	//买家评价以后交易结束需要修改订单状态2->3
	public String evaluate(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		goodOrderService.updateStatu(id,"3");
		boolean flag=goodOrderService.evaluate(id, evaluate);
		if(flag){
			Rule rule=ruleService.findRuleById(6);
			int value=Integer.parseInt(rule.getRuleValue().substring(1));
			user.setIntegral(user.getIntegral()+value);
			userService.update(user);
			Integration integration=new Integration();
			integration.setRule(rule);
			integration.setUser(user);
			integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			integrationService.addIntegration(integration);	
			return "evaluate";
		}else{
			return "error";
		}
	}

	//修改订单状态,卖家处理订单需要修改订单状态0->1
	public String updateStatuToWaitRe(){
		goodOrderService.updateStatu(id,"1");
		return "updateStatuToWaitRe";
	}

	//修改订单状态，买家收到货以后需要修改订单状态1->2
	public String updateStatuToWaitEvalu(){
		goodOrderService.updateStatu(id,"2");
		return "updateStatuToWaitEvalu";
	}

	//修改订单状态，买家评价以后交易结束需要修改订单状态2->3（在评价中完成）
	public String updateStatuToEnd(){
		goodOrderService.updateStatu(id,"3");
		return "updateStatuToEnd";
	}

	//查询所有评价，后台管理
	public String findEvaluateNotNull(){
		orderList=goodOrderService.findEvaluateNotNullByPage(page, PageUtil.PAGENUM2);
		maxPage=goodOrderService.countMaxPageByEvaluate(PageUtil.PAGENUM2);
		return "findEvaluateNotNull";
	}

	//后台删除无效评价
	public String delete_evaluate(){
		goodOrderService.deleteEvaluate(id);
		return "delete_evaluate";
	}

	//根据id查找评价
	public String findById(){
		OrderInfo order=goodOrderService.findById(id);
		User user=order.getUser();
		String lv="Lv1";
		if(user.getIntegral() <= Constants.LV1){
			lv = "Lv1";
		}else if(user.getIntegral()<= Constants.LV2){
			lv = "Lv2";
		}else if(user.getIntegral() <= Constants.LV3){
			lv = "Lv3";
		}else if(user.getIntegral()<= Constants.LV4){
			lv = "Lv4";
		}else if(user.getIntegral() <= Constants.LV5){
			lv = "Lv5";
		}else if(user.getIntegral() <= Constants.LV6){
			lv = "Lv6";
		}
		
		JSONObject jobject = new JSONObject();
		jobject.put("evaluation", order.getEvaluate());
		jobject.put("photoUrl",order.getUser().getPhotoUrl());
		jobject.put("userName",order.getUser().getNickname());
		jobject.put("lv",lv);
		JSONArray json = JSONArray.fromObject(jobject);
		state = json.toString();
		System.out.println(state);
		return "findById";
	}

	//查询用户的历史售出商品的评价
	public String findEvaluateNotNullByUser(){
		//div
		if(flag==1){
			orderList=goodOrderService.findEvaluateNotNullByUser(userId);
			List<JSONObject> jsonList=new ArrayList<JSONObject>();
			for(OrderInfo order:orderList){
				JSONObject jobject = new JSONObject();
				jobject.put("picOne",order.getGoodsPicOne());
				jobject.put("evaluation",order.getEvaluate());
				jobject.put("goodsName",order.getGoodsZr().getGoodsName());
				jobject.put("pubDate",order.getPubDate());
				jsonList.add(jobject);
			}
			JSONArray json = JSONArray.fromObject(jsonList);
			state = json.toString();
			System.out.println(state);
			return "findEvaluateNotNullByUser";
		}else{
			//新页面
			orderList=goodOrderService.findEvaluateNotNullByUser(userId, page,PageUtil.PAGENUM1);
			maxPage=goodOrderService.countMaxPageByEvaluateByUser(userId,PageUtil.PAGENUM1);
			user=userService.findById(userId);
			if(user.getIntegral() <= Constants.LV1){
				lv = "Lv1";
			}else if(user.getIntegral()<= Constants.LV2){
				lv = "Lv2";
			}else if(user.getIntegral() <= Constants.LV3){
				lv = "Lv3";
			}else if(user.getIntegral()<= Constants.LV4){
				lv = "Lv4";
			}else if(user.getIntegral() <= Constants.LV5){
				lv = "Lv5";
			}else if(user.getIntegral() <= Constants.LV6){
				lv = "Lv6";
			}
			for(OrderInfo order:orderList){
				GoodsZr goodsZr=order.getGoodsZr();
				User user1=order.getUser();
				String lv1="Lv1";
				if(user1.getIntegral() <= Constants.LV1){
					lv1 = "Lv1";
				}else if(user1.getIntegral()<= Constants.LV2){
					lv1 = "Lv2";
				}else if(user1.getIntegral() <= Constants.LV3){
					lv1 = "Lv3";
				}else if(user1.getIntegral()<= Constants.LV4){
					lv1 = "Lv4";
				}else if(user1.getIntegral() <= Constants.LV5){
					lv1 = "Lv5";
				}else if(user1.getIntegral() <= Constants.LV6){
					lv1 = "Lv6";
				}
				user1.setLv(lv1);
				System.out.println("lv:"+lv1);
				goodsZr.setComCount(order.getGoodsZr().getCommentList().size());
				order.setGoodsZr(goodsZr);
				order.setUser(user1);
			}
			return "showUserSaleGoods";
		}
	}

	//售出列表
	public String toListSale(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		System.out.println("conditionhaha:"+condition);
		orderList = goodOrderService.findByPageSale(page, PageUtil.PAGENUM,user.getUserId(),condition);
		try {
			maxPage = goodOrderService.countMaxPageSale(PageUtil.PAGENUM,user.getUserId(),condition);
			sendCount=goodOrderService.countWaitSend(user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toListSale";
	}
	
	//购买列表
	public String toListBuy(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		orderList = goodOrderService.findByPageBuy(page, PageUtil.PAGENUM,user.getUserId(),condition);
		try {
			System.out.println("conditionhaha:"+condition);
			maxPage = goodOrderService.countMaxPageBuy(PageUtil.PAGENUM,user.getUserId(),condition);
			receiveCount=goodOrderService.countWaitReceive(user.getUserId());
			evaluationCount=goodOrderService.countWaitEvaluate(user.getUserId());
			sendCountToBuy=goodOrderService.countWaitSendToBuy(user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toListBuy";
	}
	//前台用户删除订单，相当于只修改两个状态
	public String delete(){
		if(flag==1){
			//买家
			goodOrderService.delete(id,1);
			return "deleteBuy";
		}else if(flag==2){
			//卖家
			goodOrderService.delete(id,2);
			return "deleteSale";
		}else{
			return "delete";
		}
	}
	/**
	 * @return the goodOrderService
	 */
	public GoodsOrderService getGoodOrderService() {
		return goodOrderService;
	}
	/**
	 * @param goodOrderService the goodOrderService to set
	 */
	public void setGoodOrderService(GoodsOrderService goodOrderService) {
		this.goodOrderService = goodOrderService;
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
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

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

	/**
	 * @return the flag
	 */
	public int getFlag() {
		return flag;
	}

	/**
	 * @param flag the flag to set
	 */
	public void setFlag(int flag) {
		this.flag = flag;
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

	/**
	 * @return the condition
	 */
	public int getCondition() {
		return condition;
	}

	/**
	 * @param condition the condition to set
	 */
	public void setCondition(int condition) {
		this.condition = condition;
	}

	/**
	 * @return the sendCount
	 */
	public int getSendCount() {
		return sendCount;
	}

	/**
	 * @param sendCount the sendCount to set
	 */
	public void setSendCount(int sendCount) {
		this.sendCount = sendCount;
	}

	/**
	 * @return the receiveCount
	 */
	public int getReceiveCount() {
		return receiveCount;
	}

	/**
	 * @param receiveCount the receiveCount to set
	 */
	public void setReceiveCount(int receiveCount) {
		this.receiveCount = receiveCount;
	}

	/**
	 * @return the evaluationCount
	 */
	public int getEvaluationCount() {
		return evaluationCount;
	}

	/**
	 * @param evaluationCount the evaluationCount to set
	 */
	public void setEvaluationCount(int evaluationCount) {
		this.evaluationCount = evaluationCount;
	}

	/**
	 * @return the sendCountToBuy
	 */
	public int getSendCountToBuy() {
		return sendCountToBuy;
	}

	/**
	 * @param sendCountToBuy the sendCountToBuy to set
	 */
	public void setSendCountToBuy(int sendCountToBuy) {
		this.sendCountToBuy = sendCountToBuy;
	}

	

}
