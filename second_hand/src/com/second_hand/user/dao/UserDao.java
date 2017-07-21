package com.second_hand.user.dao;

import java.util.List;

import com.second_hand.model.User;

public interface UserDao {

	//检查用户名是是否已经注册，存在返回true，不存在返回false
	public boolean checkEmail(String email);
	//注册
	public boolean addUser(User user);
	//登录
	public User login(User user);
	//根据email查询用户
	public User findUserByEmail(String email);
	//验证支付密码
	public boolean checkPayPassword(User user);
	//修改用户信息
	public void update(User user);
	//根据用户编号查找用户信息
	public User findById(int id);
	//删除用户信息
	public boolean delete(int id);
	//分页查找用户信息
	public List<User> findByPage(final int page, final int pageSize);
	//查询用户的最大页数
	public int countMaxPage(int pageSize);
	//查询管理员
	public List<User> findAdminByPage(final int page, final int pageSize);
	//查询管理员的最大页数
	public int countAdminMaxPage(int pageSize);
	//查询最后注册的一个用户，积分明细时要用到
	public User findLastUser();
}
