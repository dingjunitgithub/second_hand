package com.second_hand.user.action;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.second_hand.adInfo.service.CityInfoService;
import com.second_hand.adInfo.service.DepartInfoService;
import com.second_hand.adInfo.service.SchoolInfoService;
import com.second_hand.base.action.BaseAction;
import com.second_hand.model.CityInfo;
import com.second_hand.model.DepartmentInfo;
import com.second_hand.model.Integration;
import com.second_hand.model.Rule;
import com.second_hand.model.SchoolInfo;
import com.second_hand.model.User;
import com.second_hand.user.service.IntegrationService;
import com.second_hand.user.service.RuleService;
import com.second_hand.user.service.UserService;
import com.second_hand.util.Constants;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class UserAction extends BaseAction implements SessionAware{

	User user=null;
	UserService userService=null;

	private String returnstr;
	private String password;
	private String nickname;
	private String email;
	String phone;
	String qq;
	String newpassword;
	int departId;
	String payPassword;
	String newPayPassword;
	private String photoUrl;
	float paynumber;//充值金额

	List<User> userList;
	int page = 1;
	int maxPage;
	int id;


	SchoolInfoService schoolService=null;
	CityInfoService cityService=null;
	DepartInfoService departService=null;
	IntegrationService integrationService=null;
	RuleService ruleService=null;
	List<CityInfo> cityList=null;
	List<SchoolInfo> schoolList=null;
	List<DepartmentInfo> departList=null;

	//去管理员添加页面
	public String toAddAdmin(){
		cityList=cityService.findAllCity();
		schoolList=schoolService.findAllSchool();
		departList=departService.findAllDepart();
		return "toAddAdmin";
	}

	//添加管理员
	public String addAdmin(){
		User user=new User();
		user.setUserType(1);
		user.setNickname("管理员");
		user.setEmail(email);
		user.setPassword(password);
		user.setPhone(phone);
		user.setQq(qq);
		DepartmentInfo depart=new DepartmentInfo();
		depart.setDepartId(departId);
		user.setDepart(depart);
		boolean rs = userService.addUser(user);
		if(rs){

			returnstr="success";
		}
		return "addAdmin";
	}

	//修改用户头像
	public String updatePhotoUrl(){
		String email = (String)session.get("email");
		user = userService.findUserByEmail(email);

		user.setPhotoUrl(photoUrl);
		userService.update(user);
		returnstr="success";
		return "updatePhotoUrl";
	}

	//删除
	public String delete(){
		userService.delete(id);
		return "delete";
	}
	//列表
	public String toList(){
		userList = userService.findByPage(page, PageUtil.PAGENUM);
		try {

			maxPage = userService.countMaxPage( PageUtil.PAGENUM);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toList";
	}

	//管理员列表
	public String toAdminList(){
		userList = userService.findAdminByPage(page, PageUtil.PAGENUM);
		try {

			maxPage = userService.countAdminMaxPage( PageUtil.PAGENUM);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toAdminList";
	}

	//根据email查询用户
	@SuppressWarnings("unused")
	public String findUserByEmail(){
		user = userService.findUserByEmail(email);
		String lv = "LV1";
		//计算积分等级
		long integral = user.getIntegral();
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
		return "findUserByEmail";
	}


	//跳转到修改资料界面
	public String toUpdatePage(){
		user = userService.findUserByEmail(email);
		cityList=cityService.findAllCity();
		schoolList=schoolService.findAllSchool();
		departList=departService.findAllDepart();
		return "toUpdatePage";
	}

	//修改
	public String update(){
		User user = userService.findById(id);
		user.setPhone(phone);
		user.setNickname(nickname);
		DepartmentInfo depart=new DepartmentInfo();
		depart.setDepartId(departId);
		user.setDepart(depart);
		user.setQq(qq);
		userService.update(user);
		return "update";
	}
	//跳转到修改密码页面
	public String toupdatepassword(){
		user = userService.findUserByEmail(email);
		return "toupdatepassword";
	}
	//跳转到修改支付密码页面
	public String toupdatepaypassword(){
		user = userService.findUserByEmail(email);
		return "toupdatepaypassword";
	}
	//修改密码
	public String updatepassword(){
		//检查旧密码是否正确
		User user = userService.findById(id);
		String password1 = user.getPassword();
		if(password1 != null && password1.equals(password)){
			user.setPassword(newpassword);
			userService.update(user);
			returnstr = "ok";
		}else{
			returnstr = "error";
		}
		return "updatepassword";
	}
	//修改支付密码
	public String updatepaypassword(){
		User user = userService.findById(id);
		String password1 = user.getPayPassword();
		if(password1 != null && password1.equals(payPassword)){
			user.setPayPassword(newPayPassword);
			userService.update(user);
			returnstr = "ok";
		}else{
			returnstr = "error";
		}
		return "updatepaypassword";
	}

	//跳转到充值页面
	public String topay(){
		user = userService.findById(id);
		return "topay";
	}

	//跳转到提现页面
	public String toOutMoney(){
		user = userService.findById(id);
		return "toOutMoney";
	}

	//充值
	public String pay(){
		User user = null;
		user = userService.findById(id);
		float a = user.getAccountBalance();
		user.setAccountBalance(paynumber+a);
		userService.update(user);
		return "pay";
	}
	//提现
	public String outMoney(){
		User user = null;
		user = userService.findById(id);
		float a = user.getAccountBalance();
		user.setAccountBalance(a-paynumber);
		userService.update(user);
		return "outMoney";
	}

	//退出登录
	public String userOutLogin(){
		session.put("user",null);
		session.put("userType",null);
		session.put("email",null);
		session.put("userid",null);
		session.put("nickname",null);
		session.put("lv", null);
		return "success";
	}

	//用户登录
	public String userLogin(){
		user =userService.login(user);
		if(user != null){//存在
			returnstr = "success";
			//计算积分等级
			String lv = "LV1";
			long integral = user.getIntegral();
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
			session.put("user",user);
			session.put("userType",""+user.getUserType());
			session.put("email",user.getEmail());
			session.put("userid",user.getUserId());
			session.put("nickname", user.getNickname() != null ? user.getNickname() : "");
			session.put("lv", lv);
		}else{
			returnstr = "unsuccess";
		}

		return "success";
	}

	//添加用户
	public String addUser(){
		boolean checkRs =  userService.checkEmail(email);
		if(checkRs){//存在
			returnstr = "username_exist";//用户名存在,无法继续注册
		}else{//用户名不存在，可以注册
			User user1=new User();
			user1.setNickname(nickname);
			user1.setPassword(password);
			user1.setIntegral(0);
			user1.setAccountBalance(0);
			user1.setEmail(email);
			user1.setUserType(2);
			user1.setPayPassword("000000");
			DepartmentInfo depart=new DepartmentInfo();
			depart.setDepartId(1);
			user1.setDepart(depart);
			boolean rs = userService.addUser(user1);
			if(rs){
				returnstr = "success";//注册成功
				user=userService.findLastUser();
				Rule rule=ruleService.findRuleById(1);
				int value=Integer.parseInt(rule.getRuleValue().substring(1));
				user.setIntegral(user.getIntegral()+value);
				userService.update(user);
				Integration integration=new Integration();
				integration.setRule(rule);
				integration.setUser(user);
				integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
				integrationService.addIntegration(integration);	
			}else{
				returnstr = "unsuccess";//注册失败
			}
		}
		return "success";
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
	 * @return the session
	 */
	public Map<String, Object> getSession() {
		return session;
	}
	/**
	 * @param session the session to set
	 */
	public void setSession(Map<String, Object> session) {
		this.session = session;
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
	 * @return the newpassword
	 */
	public String getNewpassword() {
		return newpassword;
	}
	/**
	 * @param newpassword the newpassword to set
	 */
	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}


	/**
	 * @return the paynumber
	 */
	public float getPaynumber() {
		return paynumber;
	}
	/**
	 * @param paynumber the paynumber to set
	 */
	public void setPaynumber(float paynumber) {
		this.paynumber = paynumber;
	}
	/**
	 * @return the userList
	 */
	public List<User> getUserList() {
		return userList;
	}
	/**
	 * @param userList the userList to set
	 */
	public void setUserList(List<User> userList) {
		this.userList = userList;
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
	 * @return the departId
	 */
	public int getDepartId() {
		return departId;
	}
	/**
	 * @param departId the departId to set
	 */
	public void setDepartId(int departId) {
		this.departId = departId;
	}
	/**
	 * @return the schoolService
	 */
	public SchoolInfoService getSchoolService() {
		return schoolService;
	}
	/**
	 * @param schoolService the schoolService to set
	 */
	public void setSchoolService(SchoolInfoService schoolService) {
		this.schoolService = schoolService;
	}
	/**
	 * @return the cityService
	 */
	public CityInfoService getCityService() {
		return cityService;
	}
	/**
	 * @param cityService the cityService to set
	 */
	public void setCityService(CityInfoService cityService) {
		this.cityService = cityService;
	}
	/**
	 * @return the departService
	 */
	public DepartInfoService getDepartService() {
		return departService;
	}
	/**
	 * @param departService the departService to set
	 */
	public void setDepartService(DepartInfoService departService) {
		this.departService = departService;
	}
	/**
	 * @return the cityList
	 */
	public List<CityInfo> getCityList() {
		return cityList;
	}
	/**
	 * @param cityList the cityList to set
	 */
	public void setCityList(List<CityInfo> cityList) {
		this.cityList = cityList;
	}
	/**
	 * @return the schoolList
	 */
	public List<SchoolInfo> getSchoolList() {
		return schoolList;
	}
	/**
	 * @param schoolList the schoolList to set
	 */
	public void setSchoolList(List<SchoolInfo> schoolList) {
		this.schoolList = schoolList;
	}
	/**
	 * @return the departList
	 */
	public List<DepartmentInfo> getDepartList() {
		return departList;
	}
	/**
	 * @param departList the departList to set
	 */
	public void setDepartList(List<DepartmentInfo> departList) {
		this.departList = departList;
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
	 * @return the newPayPassword
	 */
	public String getNewPayPassword() {
		return newPayPassword;
	}
	/**
	 * @param newPayPassword the newPayPassword to set
	 */
	public void setNewPayPassword(String newPayPassword) {
		this.newPayPassword = newPayPassword;
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




}
