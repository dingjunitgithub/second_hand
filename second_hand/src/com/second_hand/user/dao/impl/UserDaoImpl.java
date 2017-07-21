package com.second_hand.user.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.second_hand.model.User;
import com.second_hand.user.dao.UserDao;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao {

	//登录
	public User login(User user) {
		// TODO Auto-generated method stub
		try{
			String queryString="from User u where u.email=? and u.password=?";
			Object[] values={user.getEmail().trim(),user.getPassword().trim()};
			@SuppressWarnings("unchecked")
			List<User> list=super.getHibernateTemplate().find(queryString,values);
			System.out.println(list.size());
			if(list.size()>0){
				return list.get(0);
			}else{
				return null;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	//添加用户
	public boolean addUser(User user) {
		// TODO Auto-generated method stub
		try{
			this.getHibernateTemplate().saveOrUpdate(user);
			return true;
		}catch(Exception e){
			return false;
		}

	}

	//查询是否已有人注册
	@SuppressWarnings("unchecked")
	public boolean checkEmail(String email) {
		// TODO Auto-generated method stub
		String hql = "from User where email = ?";
		Object[] params = { email };
		List<User> list = this.getHibernateTemplate().find(hql, params);
		if (list != null && list.size() > 0) {
			return true;
		}
		return false;
	}

	//根据邮箱查找用户信息
	@SuppressWarnings("unchecked")
	public User findUserByEmail(String email) {
		// TODO Auto-generated method stub

		String hql = "from User where email = ?";
		Object[] params = {email};
		List<User> list = this.getHibernateTemplate().find(hql, params);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;

	}

	//更新用户信息
	public void update(User user) {
		this.getHibernateTemplate().update(user);

	}

	//根据编号查询用户信息
	public User findById(int id) {
		// TODO Auto-generated method stub
		User user =(User)this.getHibernateTemplate().get(User.class,id);
		return user;
	}

	//删除用户信息
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		User user;
		try {
			user = findById(id);
			this.getHibernateTemplate().delete(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	//分页查询用户信息
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<User> findByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from User u where u.userType=2 ";
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

	//查询用户信息最大页数
	@SuppressWarnings("rawtypes")
	public int countMaxPage(int pageSize){
		// TODO Auto-generated method stub
		String hql = "select count(*) from User u where u.userType=2";
		List list = this.getHibernateTemplate().find(hql);
		int totalSize = Integer.parseInt(list.get(0).toString());
		// 计算最大页
		if (totalSize % pageSize == 0) {
			return totalSize / pageSize;
		} else {
			return totalSize / pageSize + 1;
		}
	}

	//检查支付密码是否正确
	public boolean checkPayPassword(User user) {
		// TODO Auto-generated method stub
		try{
			String queryString="from User u where u.email=? and u.payPassword=?";
			Object[] values={user.getEmail().trim(),user.getPayPassword().trim()};
			@SuppressWarnings("unchecked")
			List<User> list=super.getHibernateTemplate().find(queryString,values);
			System.out.println(list.size());
			if(list.size()>0){
				return true;
			}else{
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

	//查询最后一个用户
	@SuppressWarnings("unchecked")
	public User findLastUser() {
		// TODO Auto-generated method stub
		String hql = "from User u order by u.userId desc";
		List<User> list = this.getHibernateTemplate().find(hql);
		return list.get(0);
	}

	//查询管理员
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<User> findAdminByPage(final int page, final int pageSize) {
		// TODO Auto-generated method stub
		List list = (List) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						// 使用session操作
						String hql = "from User u where u.userType=1 ";
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

	//查询管理员的最大页数
	@SuppressWarnings("rawtypes")
	public int countAdminMaxPage(int pageSize){
		// TODO Auto-generated method stub
		String hql = "select count(*) from User u where u.userType=1";
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
