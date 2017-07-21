package com.second_hand.adInfo.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.adInfo.dao.DepartInfoDao;
import com.second_hand.model.DepartmentInfo;
import com.second_hand.model.SchoolInfo;

public class DepartInfoDaoImpl extends HibernateDaoSupport implements DepartInfoDao {

	//添加院系信息
	public int addDepart(DepartmentInfo depart) {
		// TODO Auto-generated method stub
		try{
			this.getHibernateTemplate().save(depart);
			return 1;
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}

	//查询所有院系信息
	@SuppressWarnings("unchecked")
	public List<DepartmentInfo> findAllDepart() {
		// TODO Auto-generated method stub
		String hql = "from DepartmentInfo ";
		return getHibernateTemplate().find(hql);
	}

	//根据学校Id查询院系信息
	@SuppressWarnings("unchecked")
	public List<DepartmentInfo> findDepartBySchoolId(SchoolInfo school) {
		// TODO Auto-generated method stub
		String queryString="from DepartmentInfo d where d.school.schoolId=?";
		Object[] values={school.getSchoolId()};
		List<DepartmentInfo> list=super.getHibernateTemplate().find(queryString,values);
		if(list.size()>0){
			return list;
		}else{
			return null;
		}
	}

	//更新院系信息
	public DepartmentInfo update(DepartmentInfo depart) {
		// TODO Auto-generated method stub
		try {
			this.getHibernateTemplate().update(depart);
			return depart;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	//删除院系信息
	public DepartmentInfo delete(DepartmentInfo depart) {
		// TODO Auto-generated method stub
		try{
			this.getHibernateTemplate().delete(depart);
			return depart;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	//根据院系Id查找院系信息
	public DepartmentInfo findDepartById(int departId) {
		// TODO Auto-generated method stub
		return (DepartmentInfo)this.getHibernateTemplate().get(DepartmentInfo.class,departId);
	}

	//分页查询院系信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<DepartmentInfo> findByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from DepartmentInfo ";
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

	//查询院系最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize){
		// TODO Auto-generated method stub
		String hql = "select count(*) from DepartmentInfo";
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
