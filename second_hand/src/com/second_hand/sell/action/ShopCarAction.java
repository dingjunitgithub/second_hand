package com.second_hand.sell.action;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;















import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.second_hand.base.action.BaseAction;
import com.second_hand.goods.service.GoodsZrService;
import com.second_hand.model.Cart;
import com.second_hand.model.GoodsZr;
import com.second_hand.model.Integration;
import com.second_hand.model.OrderInfo;
import com.second_hand.model.Rule;
import com.second_hand.model.User;
import com.second_hand.sell.service.GoodsOrderService;
import com.second_hand.sell.service.ShopCarService;
import com.second_hand.user.service.IntegrationService;
import com.second_hand.user.service.RuleService;
import com.second_hand.user.service.UserService;
import com.second_hand.util.PageUtil;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@Transactional(propagation=Propagation.REQUIRED)
public class ShopCarAction extends BaseAction {

	private ShopCarService shopCarService=null;
	private GoodsZrService goodsZrService=null;
	private GoodsOrderService goodOrderService=null;
	private UserService userService=null;
	private IntegrationService integrationService=null;
	private RuleService ruleService=null;
	private List<Cart> carList;
	private int page = 1;
	private int maxPage;
	private int id;
	private String goodspicone;
	private String goodsMsg;
	private int num;
	private float price=0;
	private int userId;
	private int goodsId;
	private Cart cart=null;
	private float zhye;
	private int cartnum;
	private String goodsids;
	private String returnstr;
	private float total;
	private User user;
	private float buyye;
	private String payPassword;

	//购买
	public String buy(){
		//检查账户余额
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		float ye = user.getAccountBalance();
		float buyye = 0;
		if(goodsids != null){
			//将所有的商品编号都传过来
			String[] goodsidsstr = goodsids.split(",");
			GoodsZr goodsZr = null;
			for(int i = 0;i<goodsidsstr.length;i++){
				//根据商品编号查询商品价格
				goodsZr = goodsZrService.findById(Integer.valueOf(goodsidsstr[i]));
				//计算总共价格
				buyye+= goodsZr.getPrice();
			}
		}
		if(ye < buyye){
			//余额不足
			returnstr = "yebz";
		}else{
			
		}
		return "buy";
	}

	//批量删除
	public String deleteMore(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		shopCarService.deleteMore(goodsids,user.getUserId());
		return "deleteMore";
	}

	//结算（检验支付密码）
	public String checkPayPassword(){
		User user=new User();
		String email = (String)session.get("email");
		user.setEmail(email);
		user.setPayPassword(payPassword);
		//检查支付密码
		boolean flag=userService.checkPayPassword(user);
		//支付密码正确
		if(flag){
			//将所有的商品编号传过来
			String[] goodsidsstr = goodsids.split(",");
			if(goodsids != null){
				GoodsZr goodsZr= null;
				for(int i = 0;i<goodsidsstr.length;i++){
					goodsZr = goodsZrService.findById(Integer.valueOf(goodsidsstr[i]));
					goodsZr.setStatu("2");//0代表正在出售，1代表停止出售，2代表已售出
					/*将商品标记为已售出*/
					goodsZrService.update(goodsZr);
					user= userService.findUserByEmail(email);
					//结算时生成订单
					OrderInfo order = new OrderInfo();
					order.setStatu("0");
					order.setSaleStatu(0);
					order.setBuyStatu(0);
					order.setUser(user);
					order.setGoodsZr(goodsZr);
					order.setGoodsPicOne(goodsZr.getGoodsPic().split("\\|")[0]);
					order.setPubDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
					flag=goodOrderService.add(order);
				}

				//减掉用户账户余额
				user= userService.findUserByEmail(email);
				float ye = user.getAccountBalance();
				//增加积分
				Rule rule=ruleService.findRuleById(4);
				int value=Integer.parseInt(rule.getRuleValue().substring(1));
				user.setIntegral(user.getIntegral()+value);
				//修改余额
				user.setAccountBalance(ye-buyye);
				userService.update(user);
				//添加积分明细
				Integration integration=new Integration();
				integration.setRule(rule);
				integration.setUser(user);
				integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
				integrationService.addIntegration(integration);	
				//删除购物车里这些信息
				for(int i = 0;i<goodsidsstr.length;i++){
					//删除购物车中商品编号并且用户编号是这些的信息
					shopCarService.deleteByGoodsIdAndUserId(Integer.parseInt(goodsidsstr[i]),user.getUserId());
				}
				returnstr = "success";
			}
		}else{
			returnstr = "unsuccess";
		}
		return "checkPayPassword";
	}

	//获取购物车商品数量（首页小购物车的显示）
	public String getCartNum(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		try {
			if(user!= null){
				cartnum = shopCarService.recordCount(user.getUserId());
			}else{
				cartnum = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "getCartNum";
	}
	
	//获取购物车信息
	public String findAllByUserid(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		zhye= user.getAccountBalance();
		carList = shopCarService.findByPage(page,PageUtil.PAGENUM,user.getUserId());
		try {

			maxPage = shopCarService.countMaxPage(PageUtil.PAGENUM,user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		total=0;
		if(carList!=null){
			for(Cart car:carList){
				total+=car.getGoodsZr().getPrice();	
			}
		}
		return "findAllByUserid";
	}


	//加入购物车
	public String add(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		//判断该用户的购物车中属否有该商品
		Cart cart1=shopCarService.findByGoodsIdAndUserId(goodsId, user.getUserId());
		if(cart1==null){
			//用户购物车中无该商品
			GoodsZr goodsZr=goodsZrService.findById(goodsId);
			Cart cart = new Cart();
			cart.setGoodsZr(goodsZr);
			cart.setGoodsPicOne(goodspicone);
			cart.setUser(user);
			boolean flag=shopCarService.add(cart);
			if(flag){
				//添加积分
				Rule rule=ruleService.findRuleById(7);
				int value=Integer.parseInt(rule.getRuleValue().substring(1));
				user.setIntegral(user.getIntegral()+value);
				userService.update(user);
				//添加积分明细
				Integration integration=new Integration();
				integration.setRule(rule);
				integration.setUser(user);
				integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
				integrationService.addIntegration(integration);	
				returnstr="success";
			}else{
				returnstr="unsuccess";
			}
		}else{
			//用户购物车中存在该商品
			returnstr="unsuccess";
		}
		return "add";
	}
	
	//逐个删除
	public String delete(){
		boolean flag=shopCarService.delete(id);
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);
		if(flag){
			Rule rule=ruleService.findRuleById(10);
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

	/**
	 * @return the shopCarService
	 */
	public ShopCarService getShopCarService() {
		return shopCarService;
	}

	/**
	 * @param shopCarService the shopCarService to set
	 */
	public void setShopCarService(ShopCarService shopCarService) {
		this.shopCarService = shopCarService;
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
	 * @return the num
	 */
	public int getNum() {
		return num;
	}

	/**
	 * @param num the num to set
	 */
	public void setNum(int num) {
		this.num = num;
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
	 * @return the cart
	 */
	public Cart getCart() {
		return cart;
	}

	/**
	 * @param cart the cart to set
	 */
	public void setCart(Cart cart) {
		this.cart = cart;
	}

	/**
	 * @return the zhye
	 */
	public float getZhye() {
		return zhye;
	}

	/**
	 * @param zhye the zhye to set
	 */
	public void setZhye(float zhye) {
		this.zhye = zhye;
	}

	/**
	 * @return the cartnum
	 */
	public int getCartnum() {
		return cartnum;
	}

	/**
	 * @param cartnum the cartnum to set
	 */
	public void setCartnum(int cartnum) {
		this.cartnum = cartnum;
	}

	/**
	 * @return the goodsids
	 */
	public String getGoodsids() {
		return goodsids;
	}

	/**
	 * @param goodsids the goodsids to set
	 */
	public void setGoodsids(String goodsids) {
		this.goodsids = goodsids;
	}

	/**
	 * @return the returnstr
	 */
	public String getReturnstr() {
		return returnstr;
	}

	/**
	 * @param returnstr the returnstr to set
	 */
	public void setReturnstr(String returnstr) {
		this.returnstr = returnstr;
	}

	/**
	 * @return the total
	 */
	public float getTotal() {
		return total;
	}

	/**
	 * @param total the total to set
	 */
	public void setTotal(float total) {
		this.total = total;
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
	 * @return the buyye
	 */
	public float getBuyye() {
		return buyye;
	}

	/**
	 * @param buyye the buyye to set
	 */
	public void setBuyye(float buyye) {
		this.buyye = buyye;
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