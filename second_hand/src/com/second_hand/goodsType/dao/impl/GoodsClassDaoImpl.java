package com.second_hand.goodsType.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.goodsType.dao.GoodsClassDao;
import com.second_hand.model.GoodsClass;

public class GoodsClassDaoImpl extends HibernateDaoSupport implements GoodsClassDao {

	//查询所有类型
	@SuppressWarnings("unchecked")
	public List<GoodsClass> findAll() {
		// TODO Auto-generated method stub
		String hql = "from GoodsClass";
		List<GoodsClass> list = this.getHibernateTemplate().find(hql);
		return list;
	}

	//新增类型
	public boolean add(GoodsClass goodsClass) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(goodsClass);
		return false;
	}

	//根据编号查询商品类型
	public GoodsClass findById(int id) {
		// TODO Auto-generated method stub
		return (GoodsClass)this.getHibernateTemplate().get(GoodsClass.class,id);
	}

	//删除商品类型
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		GoodsClass school;
		try {
			school = findById(id);
			this.getHibernateTemplate().delete(school);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public void update(GoodsClass goodsClass) {
		this.getHibernateTemplate().saveOrUpdate(goodsClass);
		
	}

	//分页查询商品类型信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsClass> findByPage(final int page,final  int pageSize) {
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from GoodsClass ";
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

	//查询类型的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize){
		// TODO Auto-generated method stub
		String hql = "select count(*) from GoodsClass";
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
