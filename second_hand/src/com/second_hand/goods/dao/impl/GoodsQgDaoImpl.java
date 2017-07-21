package com.second_hand.goods.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.goods.dao.GoodsQgDao;
import com.second_hand.model.GoodsQg;

public class GoodsQgDaoImpl extends HibernateDaoSupport implements GoodsQgDao {

	//新增求购信息
	public boolean add(GoodsQg goodsQg) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(goodsQg);
		return true;
	}

	//根据求购编号查询求购信息
	public GoodsQg findById(int id) {
		// TODO Auto-generated method stub
		return (GoodsQg)this.getHibernateTemplate().get(GoodsQg.class,id);
	}

	//删除求购信息
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		GoodsQg goodsQg;
		try {
			goodsQg = findById(id);
			this.getHibernateTemplate().delete(goodsQg);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//更新求购信息
	public void update(GoodsQg goodsQg) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(goodsQg);
	}

	//分页查询求购信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsQg> findByPageOrderById(final int page, final int pageSize,final int cityId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql;
						if(cityId==1){
							hql = "from GoodsQg g where g.statu = '0' order by g.goodsQgId desc";
						}else{
							hql = "from GoodsQg g where g.user.depart.school.city.cityId="+cityId+" and g.statu = '0' order by g.goodsQgId desc";
						}
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

	/*	public List<GoodsQg> findByKeyword(final int page, final int pageSize,final String keyword,final int cityId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql;
						if(cityId==1){
							hql = "from GoodsQg g where g.goodsName like '%"+keyword+"%' order by g.goodsQgId desc";
						}else{
							hql = "from GoodsQg g where  g.user.depart.school.city.cityId="+cityId+" and g.goodsName like '%"+keyword+"%' order by g.goodsQgId desc";
						}

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

	public List<GoodsQg> findByGoodsclass(final int page,final  int pageSize,
			final String goodsclass,final int cityId) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql;
						if(cityId==1){
							hql = "from GoodsQg g where g.classes.className = '"+goodsclass+"' order by g.goodsQgId desc";
						}else{
							hql = "from GoodsQg g where g.user.depart.school.city.cityId="+cityId+" and g.classes.className = '"+goodsclass+"' order by g.goodsQgId desc";
						}

						Query query = session.createQuery(hql);
						// 设置分页查询参数
						int begin = (page - 1) * pageSize;// 起始点从0开始
						query.setFirstResult(begin);// 设置抓取记录起点索引
						query.setMaxResults(pageSize);// 设置最大抓取数量
						return query.list();
					}
				});
		return list;
	}*/

	//查询用户的求购信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<GoodsQg> findByPageByUser(final int page, final int pageSize, final int userid) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql;
						hql = "from GoodsQg g where g.user.userId = "+userid;
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

	/*public int countMaxPageByKeyword(int pageSize, String keyword,int cityId)
			throws Exception {
		// TODO Auto-generated method stub
		String hql;
		if(cityId==1){
			hql = "select count(*) from GoodsQg g where g.statu = '0' and g.goodsName like '%"+keyword+"%'";
		}else{
			hql = "select count(*) from GoodsQg g where g.user.depart.school.city.cityId="+cityId+" and g.statu = '0' and g.goodsName like '%"+keyword+"%'";
		}

		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	public int countMaxPageByGoodsclass(int pageSize, String goodsclass,int cityId)
			throws Exception {
		// TODO Auto-generated method stub
		String hql;
		if(cityId==1){
			hql = "select count(*) from GoodsQ g where g.statu = '0' and g.classes.className = '"+goodsclass+"'";
		}else{
			hql = "select count(*) from GoodsQ g where g.user.depart.school.city.cityId="+cityId+" and g.statu = '0' and g.classes.className = '"+goodsclass+"'";
		}

		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}*/

	//查询求购信息的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize,int cityId){
		// TODO Auto-generated method stub
		String hql;
		if(cityId==1){
			hql = "select count(*) from GoodsQg g where g.statu = '0' order by g.goodsQgId desc";
		}else{
			hql = "select count(*) from GoodsQg g where g.statu = '0' and g.user.depart.school.city.cityId="+cityId+" order by g.goodsQgId desc";
		}

		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//查询用户最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPageByUser(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from GoodsQg g where g.user.userId="+userId;
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
