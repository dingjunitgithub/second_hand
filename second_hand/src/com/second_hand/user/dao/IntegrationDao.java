package com.second_hand.user.dao;

import java.util.List;

import com.second_hand.model.Integration;

public interface IntegrationDao {

	//添加
	public int addIntegration(Integration integration);
	//分页查询
	public List<Integration> findByPage(final int page, final int pageSize,int userId);
	//查询类型的最大页数
	public int countMaxPage(int pageSize,int userId) throws Exception;
}
