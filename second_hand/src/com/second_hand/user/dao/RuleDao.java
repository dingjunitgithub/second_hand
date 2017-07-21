package com.second_hand.user.dao;

import java.util.List;

import com.second_hand.model.Rule;

public interface RuleDao {

	//添加
	public int addRule(Rule rule);
	//删除
	public Rule delete(int ruleId);
	public Rule findRuleById(int ruleId);
	//分页查询
	public List<Rule> findByPage(final int page, final int pageSize);
	//查询类型的最大页数
	public int countMaxPage(int pageSize) throws Exception;
	//更新
	public Rule update(Rule rule);
	public  List<Rule> findAll();
}
