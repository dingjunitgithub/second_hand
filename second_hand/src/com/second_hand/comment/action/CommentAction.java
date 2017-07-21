package com.second_hand.comment.action;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.second_hand.base.action.BaseAction;
import com.second_hand.comment.service.CommentService;
import com.second_hand.goods.service.GoodsZrService;
import com.second_hand.model.Comment;
import com.second_hand.model.GoodsZr;
import com.second_hand.model.Integration;
import com.second_hand.model.Rule;
import com.second_hand.model.User;
import com.second_hand.user.service.IntegrationService;
import com.second_hand.user.service.RuleService;
import com.second_hand.user.service.UserService;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class CommentAction extends BaseAction {

	CommentService commentService=null;
	private List<Comment> commentList;
	UserService userService=null;
	GoodsZrService goodsZrService=null;
	private int goodsId;
	private String content;
	private String state;
	private int comId;
	//分页信息
	private int page=1;
	private int maxPage;
	
	private int toUserId;
	private int ctype;
	IntegrationService integrationService=null;
	RuleService ruleService=null;
	private int orderId;
	private int condition;
	private int waitRevertCount;
	
	//提醒卖家发货
	public String sendMessageToSaleUser(){
		commentService.sendMessageToSaleUser(orderId);
		return "sendMessageToSaleUser";
	}
	
	//删除留言
	public String delete(){
		commentService.delete(comId);
		return "delete";
	}

	//用户删除留言
	public String deleteByUser(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		commentService.delete(comId);
		//剪掉积分
		Rule rule=ruleService.findRuleById(11);
		int value=Integer.parseInt(rule.getRuleValue().substring(1));
		user.setIntegral(user.getIntegral()-value);
		userService.update(user);
		Integration integration=new Integration();
		integration.setRule(rule);
		integration.setUser(user);
		integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		integrationService.addIntegration(integration);	
		return "deleteByUser";
	}

	//留言列表
	public String toList(){
		commentList = commentService.findAllCommentByPage(page, PageUtil.PAGENUM);
		try {
			maxPage=commentService.countMaxPageByAllComment(PageUtil.PAGENUM);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "toList";
	}

	//用户我的留言列表
	public String toListByUser(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		try {
			commentList=commentService.findByPage(page, PageUtil.PAGENUM, user.getUserId());
			for(Comment com:commentList){
				String picOne=com.getGoodsZr().getGoodsPic().split("\\|")[0];
				GoodsZr goodsZr=com.getGoodsZr();
				goodsZr.setGoodspicone(picOne);
				com.setGoodsZr(goodsZr);
				List<Comment> revertList=commentService.findAllRevert(com.getComId());
				System.out.println("revert"+revertList.size());
				com.setRevertList(revertList);
			}
			maxPage=commentService.countMaxPage(PageUtil.PAGENUM, user.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "toListByUser";
	}

	//给我的留言但未回复的留言列表
	public String toListToMeNo(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		try {
			commentList=commentService.findAllCommentByPageToMeNo(page, PageUtil.PAGENUM, user.getUserId());
			for(Comment com:commentList){
				String picOne=com.getGoodsZr().getGoodsPic().split("\\|")[0];
				GoodsZr goodsZr=com.getGoodsZr();
				goodsZr.setGoodspicone(picOne);
				com.setGoodsZr(goodsZr);
			}
			maxPage=commentService.countMaxPageToMeNo(PageUtil.PAGENUM, user.getUserId());
			waitRevertCount=commentService.countWaitRevert(user.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "toListToMeNo";
	}
	
	//给我的留言且我已回复的留言列表
		public String toListToMeYes(){
			String email = (String)session.get("email");
			User user = userService.findUserByEmail(email);
			try {
				commentList=commentService.findAllCommentByPageToMeYes(page, PageUtil.PAGENUM, user.getUserId());
				for(Comment com:commentList){
					String picOne=com.getGoodsZr().getGoodsPic().split("\\|")[0];
					GoodsZr goodsZr=com.getGoodsZr();
					goodsZr.setGoodspicone(picOne);
					com.setGoodsZr(goodsZr);
					List<Comment> revertList=commentService.findAllRevert(com.getComId());
					System.out.println("revert"+revertList.size());
					com.setRevertList(revertList);
				}
				maxPage=commentService.countMaxPageToMeYes(PageUtil.PAGENUM, user.getUserId());
				waitRevertCount=commentService.countWaitRevert(user.getUserId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "toListToMeYes";
		}
	
	//添加
	public String add(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		Comment comment = new Comment();
		User toUser=userService.findById(toUserId);
		comment.setToUser(toUser);
		comment.setContent(content);
		comment.setCtype(ctype);
		comment.setRevertSta(0);
		comment.setAutoType(0);
		if(this.getCtype()==1){
			//更新回复状态
			Comment comment1=commentService.findById(comId);
			comment1.setRevertSta(1);
			comment.setOldComId(comment1.getComId());
			commentService.update(comment1);
		}
		comment.setCdate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		
		GoodsZr goodsZr=goodsZrService.findById(goodsId);
		
		comment.setGoodsZr(goodsZr);
		comment.setUser(user);
		commentService.add(comment);
		commentList = commentService.findByGoodsId(goodsId);
		//添加积分
		Rule rule=ruleService.findRuleById(10);
		int value=Integer.parseInt(rule.getRuleValue().substring(1));
		user.setIntegral(user.getIntegral()+value);
		userService.update(user);
		Integration integration=new Integration();
		integration.setRule(rule);
		integration.setUser(user);
		integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		integrationService.addIntegration(integration);	

		List<JSONObject> jsonList=new ArrayList<JSONObject>();
		int i=1;
		for(Comment item:commentList){
			JSONObject jobject = new JSONObject();
			jobject.put("usernickname",item.getUser().getNickname());
			jobject.put("cdate",item.getCdate());
			jobject.put("content",item.getContent());
			jobject.put("index_count",i);
			jsonList.add(jobject);
			i++;
		}
		JSONArray json = JSONArray.fromObject(jsonList);
		state = json.toString();
		System.out.println(state);
		return "add";
	}
	/**
	 * @return the commentService
	 */
	public CommentService getCommentService() {
		return commentService;
	}
	/**
	 * @param commentService the commentService to set
	 */
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
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
	 * @return the goodsId
	 */
	public int getGoodsId() {
		return goodsId;
	}
	/**
	 * @param goodsId the goodsId to set
	 */
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
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
	 * @return the goodsZrService
	 */
	public GoodsZrService getGoodsZrService() {
		return goodsZrService;
	}
	/**
	 * @param goodsZrService the goodsZrService to set
	 */
	public void setGoodsZrService(GoodsZrService goodsZrService) {
		this.goodsZrService = goodsZrService;
	}



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
	 * @return the toUserId
	 */
	public int getToUserId() {
		return toUserId;
	}

	/**
	 * @param toUserId the toUserId to set
	 */
	public void setToUserId(int toUserId) {
		this.toUserId = toUserId;
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
	 * @return the waitRevertCount
	 */
	public int getWaitRevertCount() {
		return waitRevertCount;
	}

	/**
	 * @param waitRevertCount the waitRevertCount to set
	 */
	public void setWaitRevertCount(int waitRevertCount) {
		this.waitRevertCount = waitRevertCount;
	}

	

}
