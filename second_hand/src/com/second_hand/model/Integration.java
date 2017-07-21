package com.second_hand.model;

public class Integration {

	private int integraId;
	private String integraDate;
	private User user;
	private Rule rule;
	/**
	 * @return the integraId
	 */
	public int getIntegraId() {
		return integraId;
	}
	/**
	 * @param integraId the integraId to set
	 */
	public void setIntegraId(int integraId) {
		this.integraId = integraId;
	}
	/**
	 * @return the integraDate
	 */
	public String getIntegraDate() {
		return integraDate;
	}
	/**
	 * @param integraDate the integraDate to set
	 */
	public void setIntegraDate(String integraDate) {
		this.integraDate = integraDate;
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
	
}
