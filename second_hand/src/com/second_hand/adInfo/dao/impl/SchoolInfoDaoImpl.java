package com.second_hand.adInfo.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.adInfo.dao.SchoolInfoDao;
import com.second_hand.model.CityInfo;
import com.second_hand.model.SchoolInfo;

public class SchoolInfoDaoImpl extends HibernateDaoSupport implements SchoolInfoDao {

	//添加学校信息
	public int addSchool(SchoolInfo school) {
		// TODO Auto-generated method stub
		try{
			this.getHibernateTemplate().save(school);
			return 1;
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}

	//查询所有学校信息
	@SuppressWarnings("unchecked")
	public List<SchoolInfo> findAllSchool() {
		// TODO Auto-generated method stub
		String hql = "from SchoolInfo";
		return getHibernateTemplate().find(hql);
	}

	//根据城市编号查询学校信息，添加院系信息时使用
	@SuppressWarnings("unchecked")
	public List<SchoolInfo> findSchoolByCityId(CityInfo city) {
		// TODO Auto-generated method stub
		String queryString="from SchoolInfo s where s.city.cityId=?";
		Object[] values={city.getCityId()};
		List<SchoolInfo> list=super.getHibernateTemplate().find(queryString,values);
		if(list.size()>0){
			return list;
		}else{
			return null;
		}
	}

	//更新学校信息
	public SchoolInfo update(SchoolInfo school) {
		// TODO Auto-generated method stub
		try {
			this.getHibernateTemplate().update(school);
			return school;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	//删除学校信息
	public SchoolInfo delete(int schoolId) {
		// TODO Auto-generated method stub
		try{
			SchoolInfo school=findSchoolById(schoolId);
			this.getHibernateTemplate().delete(school);
			return school;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	//根据学校编号查询学校信息
	public SchoolInfo findSchoolById(int schoolId) {
		// TODO Auto-generated method stub
		return (SchoolInfo)this.getHibernateTemplate().get(SchoolInfo.class,schoolId);
	}

	//分页查询学校信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<SchoolInfo> findByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from SchoolInfo ";
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

    //查询学校最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		String hql = "select count(*) from SchoolInfo";
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
