package com.second_hand.model;

import java.util.List;


public class Rule {

	private int ruleId;              //积分规则编号
	private String ruleName;         //积分项
	private String ruleValue;        //分值
	private String validTime;	     //有效时间
	private List<Integration> integraList;
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
	 * @return the integraList
	 */
	public List<Integration> getIntegraList() {
		return integraList;
	}
	/**
	 * @param integraList the integraList to set
	 */
	public void setIntegraList(List<Integration> integraList) {
		this.integraList = integraList;
	}
	
	
}
