package com.second_hand.user.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.model.Rule;
import com.second_hand.user.dao.RuleDao;

public class RuleDaoImpl extends HibernateDaoSupport implements RuleDao {

	public int addRule(Rule rule) {
		// TODO Auto-generated method stub
		try{
			this.getHibernateTemplate().save(rule);
			return 1;
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}

	public Rule delete(int ruleId) {
		// TODO Auto-generated method stub
		try{
			Rule rule=findRuleById(ruleId);
			this.getHibernateTemplate().delete(rule);
			return rule;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	public Rule findRuleById(int ruleId) {
		// TODO Auto-generated method stub
		return (Rule)this.getHibernateTemplate().get(Rule.class,ruleId);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Rule> findByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Rule";
						Query query = session.createQuery(hql);
						// 设置分页查询参数
						int begin = (page - 1) * pageSize;// 起始点从0开始
						query.setFirstResult(begin);// 设置抓取记录起点索引
						query.setMaxResults(pageSize);// 设置最大抓取数量
						return query.list();
					}
				});
		return list;
	}

	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Rule";
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	public Rule update(Rule rule) {
		// TODO Auto-generated method stub
		try {
			this.getHibernateTemplate().update(rule);
			return rule;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Rule> findAll() {
		// TODO Auto-generated method stub
		String hql = "from Rule ";
		List<Rule> list = this.getHibernateTemplate().find(hql);
		return list;
	}

}
