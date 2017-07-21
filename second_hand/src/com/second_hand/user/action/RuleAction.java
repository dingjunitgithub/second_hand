package com.second_hand.user.action;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.second_hand.model.Rule;
import com.second_hand.user.service.RuleService;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class RuleAction extends ActionSupport {

	RuleService ruleService=null;
	Rule rule=null;
	private int ruleId;
	private List<Rule> ruleList;
	private int page=1;
	private int maxPage;
	private String ruleName;
	private String ruleValue;
	private String validTime;
	private String fuhao;
	private String state;
	public String toAdd(){
		return "toAdd";
	}
	
	public String toUpdate(){
		rule=ruleService.findRuleById(ruleId);
		return "toUpdate";
	}
	
	public String delete(){
		ruleService.delete(ruleId);
		return "delete";
	}
	
	public String update(){
		System.out.println("asddfds"+ruleId);
		rule=ruleService.findRuleById(ruleId);
		if(rule!=null){
			rule.setRuleValue(ruleValue);
			ruleService.update(rule);
			return "update";
		}else{
			return "error";
		}
		
	}
	
	public String add(){
		rule=new Rule();
		rule.setRuleName(ruleName);
		rule.setValidTime(validTime);
		rule.setRuleValue(fuhao+ruleValue);
		int count=ruleService.addRule(rule);;
		if(count!=0){
			return "add";
		}else{
			return ERROR;
		}
	}
	
	public String list(){
		ruleList=ruleService.findAll();
		List<JSONObject> jsonList=new ArrayList<JSONObject>();
		for(Rule rule:ruleList){
			JSONObject jobject = new JSONObject();
			jobject.put("ruleName",rule.getRuleName());
			jobject.put("ruleValue",rule.getRuleValue());
			jobject.put("validTime",rule.getValidTime());
			jsonList.add(jobject);
		}
		JSONArray json = JSONArray.fromObject(jsonList);
		state = json.toString();
		System.out.println(state);
		return "list";
	}
	
	public String toList(){
		
		try {
			ruleList=ruleService.findByPage(page, PageUtil.PAGENUM);
			maxPage=ruleService.countMaxPage(PageUtil.PAGENUM);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "toList";
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
	 * @return the rule
	 */
	public Rule getRule() {
		return rule;
	}

	/**
	 * @param rule the rule to set
	 */
	public void setRule(Rule rule) {
		this.rule = rule;
	}

	/**
	 * @return the ruleId
	 */
	public int getRuleId() {
		return ruleId;
	}

	/**
	 * @param ruleId the ruleId to set
	 */
	public void setRuleId(int ruleId) {
		this.ruleId = ruleId;
	}

	/**
	 * @return the ruleList
	 */
	public List<Rule> getRuleList() {
		return ruleList;
	}

	/**
	 * @param ruleList the ruleList to set
	 */
	public void setRuleList(List<Rule> ruleList) {
		this.ruleList = ruleList;
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
	 * @return the ruleName
	 */
	public String getRuleName() {
		return ruleName;
	}

	/**
	 * @param ruleName the ruleName to set
	 */
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}

	/**
	 * @return the ruleValue
	 */
	public String getRuleValue() {
		return ruleValue;
	}

	/**
	 * @param ruleValue the ruleValue to set
	 */
	public void setRuleValue(String ruleValue) {
		this.ruleValue = ruleValue;
	}

	/**
	 * @return the validTime
	 */
	public String getValidTime() {
		return validTime;
	}

	/**
	 * @param validTime the validTime to set
	 */
	public void setValidTime(String validTime) {
		this.validTime = validTime;
	}

	/**
	 * @return the fuhao
	 */
	public String getFuhao() {
		return fuhao;
	}

	/**
	 * @param fuhao the fuhao to set
	 */
	public void setFuhao(String fuhao) {
		this.fuhao = fuhao;
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
	
	
	
	
}
