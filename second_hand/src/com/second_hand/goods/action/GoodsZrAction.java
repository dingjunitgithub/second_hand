package com.second_hand.goods.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import com.second_hand.base.action.BaseAction;
import com.second_hand.comment.service.CommentService;
import com.second_hand.goods.service.GoodsZrService;
import com.second_hand.goodsType.service.GoodsClassService;
import com.second_hand.model.CityInfo;
import com.second_hand.model.Comment;
import com.second_hand.model.GoodsClass;
import com.second_hand.model.GoodsZr;
import com.second_hand.model.Integration;
import com.second_hand.model.Rule;
import com.second_hand.model.User;
import com.second_hand.user.service.IntegrationService;
import com.second_hand.user.service.RuleService;
import com.second_hand.user.service.UserService;
import com.second_hand.util.Constants;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class GoodsZrAction extends BaseAction {

    GoodsZrService goodsZrService=null;
    UserService userService=null;
	GoodsClassService goodsClassService=null;
	CommentService commentService=null;
	IntegrationService integrationService=null;
	RuleService ruleService=null;
	private int a;
	//分页信息
	private int page = 1;
	private int maxPage;
	private int condition=0;
	private List<GoodsZr> goodsZrlist;
	private String lv;
	private String name;
	private String yuanxi;
	private int id;
	private GoodsZr goodsZr;
	private User user;
	private String yuanxis;
	private int tradeType;
	private List<GoodsClass> goodsClassList;

	//商品信息
	private String goodsName;
	private String goodsMsg;
	private String newAndOld;
	private String talkPrice;
	private String address;
	private float price;
	private String goodsClassName;
	private String goodsPic;
	private String phone;
	private String qq;
	private String keyword;
	private int classId;
	private int userId;
	private String statu;//状态 正在出售0-停售1-已出售2
	private List<Comment> commentList;
	private String state;
	private List<String> goodsPicList;
	private GoodsClass goodsClass=null;

	//点赞
	public String addPraise(){
		System.out.println("aaaaaaaa"+id);
		GoodsZr goodsZr=goodsZrService.addPraise(id);
		JSONObject jobject = new JSONObject();
		jobject.put("praiseCount", goodsZr.getPraise());
		JSONArray json = JSONArray.fromObject(jobject);
		state = json.toString();
		System.out.println(state);
		return "addPraise";
	}
	
	//用户更多闲置列表
	public String toListByUserMore(){
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
		System.out.println("aaaaaa"+userId);
		goodsZrlist = goodsZrService.findMoreByPageByUser(page,PageUtil.PAGENUM1,userId);
		for(GoodsZr goodsZr:goodsZrlist){
			String picOne=goodsZr.getGoodsPic().split("\\|")[0];
			goodsZr.setGoodspicone(picOne);
			//设置留言条数
			goodsZr.setComCount(goodsZr.getCommentList().size());
		}
		try {
			maxPage = goodsZrService.countMaxPageMoreByUser(PageUtil.PAGENUM1,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toListByUserMore";
	}

	//详细信息
	public String toDetailPage(){
		try {
			goodsZr = goodsZrService.findById(id);
			commentList = commentService.findByGoodsId(goodsZr.getGoodsZrId());
			
			//图片信息
			String goodspic = goodsZr.getGoodsPic();
			if(goodspic != null && goodspic != ""){
				goodsPicList = new ArrayList<String>();
				for(int i = 0;i<goodspic.split("\\|").length;i++){
					goodsPicList.add(goodspic.split("\\|")[i]);
				}
			}
			goodsZr.setGoodspicone(goodsZr.getGoodsPic().split("\\|")[0]);
			int integral = goodsZr.getUser().getIntegral();
			System.out.println("asdsad");
			System.out.println(integral);

			if(integral <= Constants.LV1){
				lv = "Lv1";
			}else if(integral <= Constants.LV2){
				lv = "Lv2";
			}else if(integral <= Constants.LV3){
				lv = "Lv3";
			}else if(integral <= Constants.LV4){
				lv = "Lv4";
			}else if(integral <= Constants.LV5){
				lv = "Lv5";
			}else if(integral <= Constants.LV6){
				lv = "Lv6";
			}
			System.out.println("bbbbbbbbbbb"+lv);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toDetailPage";
	}
	
	//根据分类查询
	public String indexSearchByGoodsclass(){
		goodsClass=goodsClassService.findById(classId);
		CityInfo city=(CityInfo)session.get("city");
		goodsZrlist = goodsZrService.findByGoodsclass(page,PageUtil.PAGENUM,goodsClass.getClassName(),city.getCityId());
		//取第一张图片作为展示图片
		if(goodsZrlist != null && goodsZrlist.size() > 0){
			for(int i = 0;i<goodsZrlist.size();i++){
				goodsZrlist.get(i).setGoodspicone(goodsZrlist.get(i).getGoodsPic().split("\\|")[0]);
			}
		}
		try {
			maxPage = goodsZrService.countMaxPageByGoodsclass(PageUtil.PAGENUM,goodsClass.getClassName(),city.getCityId());
			System.out.println("aaaaaaaaaaaaaaaaaaa"+maxPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "indexSearchByGoodsclass";
	}
	
	//首页关键字搜索
	public String indexSearch(){
		CityInfo city=(CityInfo)session.get("city");
		goodsZrlist = goodsZrService.findByKeyword(page, PageUtil.PAGENUM,keyword,city.getCityId());
		//取第一张图片作为展示图片
		if(goodsZrlist != null && goodsZrlist.size() > 0){
			for(int i = 0;i<goodsZrlist.size();i++){
				goodsZrlist.get(i).setGoodspicone(goodsZrlist.get(i).getGoodsPic().split("\\|")[0]);
			}
		}
		try {
			maxPage = goodsZrService.countMaxPageByKeyword(PageUtil.PAGENUM, keyword,city.getCityId());
			keyword=this.getKeyword();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "indexSearch";
	}

	
	//改变状态，出售-停售
	public String updateStatu(){
		GoodsZr goodsZr = goodsZrService.findById(id);
		goodsZr.setStatu(statu);
		goodsZrService.update(goodsZr);
		return "updateStatu";
	}

	//用户转让信息列表
	public String toListByUser(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		System.out.println("condition"+condition);
		goodsZrlist = goodsZrService.findByPageByUser(page,PageUtil.PAGENUM,user.getUserId(),condition);
		try {
			maxPage = goodsZrService.countMaxPageByUser(PageUtil.PAGENUM,user.getUserId(),condition);
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
		//查询商品分类信息
		goodsClassList = goodsClassService.findAll();
		return "toAdd";
	}

	//新增
	public String add(){
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		GoodsZr goodsZr = new GoodsZr();
		goodsZr.setAddress(address);
		goodsZr.setGoodsMsg(goodsMsg);
		goodsZr.setGoodsName(goodsName);
		goodsZr.setGoodsPic(goodsPic);
		goodsZr.setNewAndOld(newAndOld);
		goodsZr.setPhone(phone);
		goodsZr.setPrice(price);
		goodsZr.setTradeType(tradeType);
		goodsZr.setPubDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		GoodsClass goodsClass=new GoodsClass();
		goodsClass.setClassId(classId);
		goodsZr.setClasses(goodsClass);
		goodsZr.setQq(qq);
		goodsZr.setStatu("0");
		goodsZr.setTalkPrice(talkPrice);
		goodsZr.setUser(user);
		boolean flag=goodsZrService.add(goodsZr);
		if(flag){
			Rule rule=ruleService.findRuleById(2);
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
		user = userService.findUserByEmail(email);
		//查询商品分类信息
		goodsClassList = goodsClassService.findAll();
		goodsZr = goodsZrService.findById(id);
		//图片信息
		String goodspic = goodsZr.getGoodsPic();
		if(goodspic != null && goodspic != ""){
			goodsPicList=new ArrayList<String>();
			for(int i = 0;i<goodspic.split("\\|").length;i++){
				goodsPicList.add(goodspic.split("\\|")[i]);
			}
		}
		return "toUpdate";
	}
	
	//去详细信息页面
	public String toDetail(){
		goodsZr = goodsZrService.findById(id);
		//图片信息
		String goodspic = goodsZr.getGoodsPic();
		if(goodspic != null && goodspic != ""){
			goodsPicList = new ArrayList<String>();
			for(int i = 0;i<goodspic.split("\\|").length;i++){
				goodsPicList.add(goodspic.split("\\|")[i]);
			}
		}
		return "toDetail";
	}

	//修改
	public String update(){
		GoodsZr goodsZr = goodsZrService.findById(id);
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		goodsZr.setAddress(address);
		goodsZr.setGoodsMsg(goodsMsg);
		goodsZr.setGoodsName(goodsName);
		goodsZr.setGoodsPic(goodsPic);
		goodsZr.setNewAndOld(newAndOld);
		goodsZr.setPhone(phone);
		goodsZr.setPrice(price);
		goodsZr.setTradeType(tradeType);
		goodsZr.setPubDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		GoodsClass goodsClass=new GoodsClass();
		goodsClass.setClassId(classId);
		goodsZr.setClasses(goodsClass);
		goodsZr.setQq(qq);
		goodsZr.setTalkPrice(talkPrice);
		goodsZr.setUser(user);
		goodsZrService.update(goodsZr);
		return "update";
	}
	
	/*//删除
	public String delete(){
		boolean flag=goodsZrService.delete(id);
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		if(flag){
			Rule rule=ruleService.findRuleById(8);
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
	}*/

	//用户删除发布的转让信息
	public String deleteByUser(){
		boolean flag=goodsZrService.delete(id);
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		if(flag){
			Rule rule=ruleService.findRuleById(8);
			int value=Integer.parseInt(rule.getRuleValue().substring(1));
			user.setIntegral(user.getIntegral()-value);
			userService.update(user);
			Integration integration=new Integration();
			integration.setRule(rule);
			integration.setUser(user);
			integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			integrationService.addIntegration(integration);	
		}
		return "deleteByUser";
	}
	
	//首页转让商品展示
	public String indexGoodsZr(){
		CityInfo city=(CityInfo)session.get("city");
		try {			
			goodsZrlist = goodsZrService.findByPage(page, PageUtil.PAGENUM, city.getCityId());
			//取第一张图片作为展示图片
			if(goodsZrlist != null && goodsZrlist.size() > 0){
				for(int i = 0;i<goodsZrlist.size();i++){
					goodsZrlist.get(i).setGoodspicone(goodsZrlist.get(i).getGoodsPic().split("\\|")[0]);
				}
			}
			try {
				
				maxPage = goodsZrService.countMaxPage(PageUtil.PAGENUM,city.getCityId());
			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}


		return "indexGoodsZr";
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
	 * @return the goodsZrlist
	 */
	public List<GoodsZr> getGoodsZrlist() {
		return goodsZrlist;
	}
	/**
	 * @param goodsZrlist the goodsZrlist to set
	 */
	public void setGoodsZrlist(List<GoodsZr> goodsZrlist) {
		this.goodsZrlist = goodsZrlist;
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
	 * @return the yuanxi
	 */
	public String getYuanxi() {
		return yuanxi;
	}
	/**
	 * @param yuanxi the yuanxi to set
	 */
	public void setYuanxi(String yuanxi) {
		this.yuanxi = yuanxi;
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
	 * @return the goodsClassName
	 */
	public String getGoodsClassName() {
		return goodsClassName;
	}
	/**
	 * @param goodsClassName the goodsClassName to set
	 */
	public void setGoodsClassName(String goodsClassName) {
		this.goodsClassName = goodsClassName;
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
	 * @return the keyword
	 */
	public String getKeyword() {
		return keyword;
	}
	/**
	 * @param keyword the keyword to set
	 */
	public void setKeyword(String keyword) {
		this.keyword = keyword;
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
	 * @return the goodsPicList
	 */
	public List<String> getGoodsPicList() {
		return goodsPicList;
	}
	/**
	 * @param goodsPicList the goodsPicList to set
	 */
	public void setGoodsPicList(List<String> goodsPicList) {
		this.goodsPicList = goodsPicList;
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
	 * @return the a
	 */
	public int getA() {
		return a;
	}
	/**
	 * @param a the a to set
	 */
	public void setA(int a) {
		this.a = a;
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
