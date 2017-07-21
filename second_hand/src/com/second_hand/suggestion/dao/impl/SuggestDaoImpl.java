package com.second_hand.suggestion.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.model.Suggestion;
import com.second_hand.suggestion.dao.SuggestDao;

public class SuggestDaoImpl extends HibernateDaoSupport implements SuggestDao {

	//新增网站建议及意见信息
	public boolean add(Suggestion sugg) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(sugg);
		return false;
	}

	//删除网站建议及意见
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		Suggestion sugg;
		try {
			sugg = findById(id);
			this.getHibernateTemplate().delete(sugg);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//根据建议及意见Id查找建议信息
	public Suggestion findById(int id) {
		// TODO Auto-generated method stub
		return (Suggestion)this.getHibernateTemplate().get(Suggestion.class,id);
	}

	//分页查询建议及意见
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Suggestion> findByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Suggestion ";
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

	//查询建议及意见的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Suggestion";
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

}
