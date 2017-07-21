package com.second_hand.suggestion.service.impl;

import java.util.List;

import com.second_hand.model.Suggestion;
import com.second_hand.suggestion.dao.SuggestDao;
import com.second_hand.suggestion.service.SuggestService;

public class SuggestServiceImpl implements SuggestService {

	SuggestDao suggDao=null;
	//提出建议及意见
	public boolean add(Suggestion sugg) {
		// TODO Auto-generated method stub
		return suggDao.add(sugg);
	}

	//删除建议及意见信息
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return suggDao.delete(id);
	}

	//根据Id查找建议及意见信息
	public Suggestion findById(int id) {
		// TODO Auto-generated method stub
		return suggDao.findById(id);
	}

	//分页查询建议及意见信息
	public List<Suggestion> findByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return suggDao.findByPage(page, pageSize);
	}

	//查询建议及意见最大页数
	public int countMaxPage(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		return suggDao.countMaxPage(pageSize);
	}

	/**
	 * @return the suggDao
	 */
	public SuggestDao getSuggDao() {
		return suggDao;
	}

	/**
	 * @param suggDao the suggDao to set
	 */
	public void setSuggDao(SuggestDao suggDao) {
		this.suggDao = suggDao;
	}

}
