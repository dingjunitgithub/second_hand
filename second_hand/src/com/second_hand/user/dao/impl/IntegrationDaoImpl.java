package com.second_hand.user.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.model.Integration;
import com.second_hand.user.dao.IntegrationDao;

public class IntegrationDaoImpl extends HibernateDaoSupport implements
		IntegrationDao {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Integration> findByPage(final int page, final int pageSize, final int userId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from Integration i where i.user.userId="+userId;
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
	public int countMaxPage(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from Integration i where i.user.userId="+userId;
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	public int addIntegration(Integration integration) {
		// TODO Auto-generated method stub
		try{
			this.getHibernateTemplate().save(integration);
			return 1;
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}

	

}
