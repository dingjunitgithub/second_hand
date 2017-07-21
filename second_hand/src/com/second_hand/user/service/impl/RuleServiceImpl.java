package com.second_hand.user.service.impl;

import java.util.List;

import com.second_hand.model.Rule;
import com.second_hand.user.dao.RuleDao;
import com.second_hand.user.service.RuleService;

public class RuleServiceImpl implements RuleService {

	RuleDao ruleDao=null;
	public int addRule(Rule rule) {
		// TODO Auto-generated method stub
		return ruleDao.addRule(rule);
	}

	public Rule delete(int ruleId) {
		// TODO Auto-generated method stub
		return ruleDao.delete(ruleId);
	}

	public Rule findRuleById(int ruleId) {
		// TODO Auto-generated method stub
		return ruleDao.findRuleById(ruleId);
	}

	public List<Rule> findByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return ruleDao.findByPage(page, pageSize);
	}

	public int countMaxPage(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		return ruleDao.countMaxPage(pageSize);
	}

	public Rule update(Rule rule) {
		// TODO Auto-generated method stub
		return ruleDao.update(rule);
	}

	/**
	 * @return the ruleDao
	 */
	public RuleDao getRuleDao() {
		return ruleDao;
	}

	/**
	 * @param ruleDao the ruleDao to set
	 */
	public void setRuleDao(RuleDao ruleDao) {
		this.ruleDao = ruleDao;
	}

	public List<Rule> findAll() {
		// TODO Auto-generated method stub
		return ruleDao.findAll();
	}

	
}
