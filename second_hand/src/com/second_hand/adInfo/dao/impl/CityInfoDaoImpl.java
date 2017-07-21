package com.second_hand.adInfo.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.adInfo.dao.CityInfoDao;
import com.second_hand.model.CityInfo;

public class CityInfoDaoImpl extends HibernateDaoSupport implements CityInfoDao {

	//添加城市信息
	public int addCity(CityInfo city) {
		// TODO Auto-generated method stub
		try{
			this.getHibernateTemplate().save(city);
			return 1;
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}

	//查询所有城市信息
	@SuppressWarnings("unchecked")
	public List<CityInfo> findAllCity() {
		// TODO Auto-generated method stub
		String hql = "from CityInfo ";
		return getHibernateTemplate().find(hql);
	}

	//更新城市信息
	public CityInfo update(CityInfo city) {
		// TODO Auto-generated method stub
		try {
			this.getHibernateTemplate().update(city);
			return city;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	//删除城市
	public CityInfo delete(int cityId) {
		// TODO Auto-generated method stub
		try{
			CityInfo city=findCityById(cityId);
			this.getHibernateTemplate().delete(city);
			return city;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	//根据城市编号查询城市信息
	public CityInfo findCityById(int cityId) {
		// TODO Auto-generated method stub
		return (CityInfo)this.getHibernateTemplate().get(CityInfo.class,cityId);
	}

	//分页查询城市信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<CityInfo> findByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from CityInfo ";
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

	//查询城市的最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize) {
		// TODO Auto-generated method stub
		String hql = "select count(*) from CityInfo";
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
