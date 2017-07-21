package com.second_hand.user.service.impl;

import java.util.List;

import com.second_hand.model.User;
import com.second_hand.user.dao.UserDao;
import com.second_hand.user.service.UserService;

public class UserServiceImpl implements UserService {

	UserDao userDao=null;
	//登录
	public User login(User user) {
		// TODO Auto-generated method stub
		return userDao.login(user);
	}
	/**
	 * @return the userDao
	 */
	public UserDao getUserDao() {
		return userDao;
	}
	/**
	 * @param userDao the userDao to set
	 */
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	//注册
	public boolean addUser(User user) {
		// TODO Auto-generated method stub
		boolean flag=userDao.addUser(user);
		if(flag){
			return true;
		}else{
			return false;
		}		
	}
	//检查该用户名是否有人注册
	public boolean checkEmail(String email) {
		// TODO Auto-generated method stub
		return userDao.checkEmail(email);
	}
	//根据用户邮箱查找用户信息
	public User findUserByEmail(String email) {
		// TODO Auto-generated method stub

		User user=userDao.findUserByEmail(email);

		return user;
	}
	//更新用户信息
	public void update(User user) {
		// TODO Auto-generated method stub
		this.userDao.update(user);
	}
	//根据用户Id查找用户信息
	public User findById(int id) {
		// TODO Auto-generated method stub
		return userDao.findById(id);
	}
	//删除用户信息
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return userDao.delete(id);
	}
	//分页查询用户信息
	public List<User> findByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return userDao.findByPage(page, pageSize);
	}
	//查询用户信息最大页数
	public int countMaxPage(int pageSize){
		// TODO Auto-generated method stub
		return userDao.countMaxPage(pageSize);
	}
	//检查支付密码
	public boolean checkPayPassword(User user) {
		// TODO Auto-generated method stub
		return userDao.checkPayPassword(user);
	}
	//查询最后一个用户，用于注册积分明细的添加
	public User findLastUser() {
		// TODO Auto-generated method stub
		return userDao.findLastUser();
	}
	//查询管理员信息
	public List<User> findAdminByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return userDao.findAdminByPage(page, pageSize);
	}
	//查询管理员信息最大页数
	public int countAdminMaxPage(int pageSize){
		// TODO Auto-generated method stub
		return userDao.countAdminMaxPage(pageSize);
	}
	
}
