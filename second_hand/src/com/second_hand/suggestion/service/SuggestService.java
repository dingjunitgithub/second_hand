package com.second_hand.suggestion.service;

import java.util.List;

import com.second_hand.model.Suggestion;

public interface SuggestService {

	//新增
	public boolean add(Suggestion sugg);
	//删除
	public boolean delete(int id);
	//根据id查找
	public Suggestion findById(int id);
	//分页查询
	public List<Suggestion> findByPage(final int page, final int pageSize);
	//查询建议及意见的最大页数
	public int countMaxPage(int pageSize) throws Exception;
}
