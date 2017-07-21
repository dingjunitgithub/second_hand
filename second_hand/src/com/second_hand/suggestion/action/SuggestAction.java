package com.second_hand.suggestion.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.second_hand.model.Suggestion;
import com.second_hand.suggestion.service.SuggestService;

public class SuggestAction {

	SuggestService suggService=null;
	List<Suggestion> suggList;
	private int page = 1;
	private int pageSize = 10;
	private int maxPage;
	private String returnstr;

	private int id;
	private Suggestion sugg;

	private String content;

	//列表
	public String toList(){
		suggList = suggService.findByPage(page, pageSize);
		try {
			maxPage = suggService.countMaxPage(pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toList";
	}

	//新增建议及意见
	public String add(){
		Suggestion sugg = new Suggestion();
		sugg.setContent(content);
		sugg.setPubDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		Boolean s=suggService.add(sugg);
		if(s){
			returnstr = "success";
		}else{
			returnstr = "success";
		}
		
		return "add";
	}

	//删除
	public String delete(){
		suggService.delete(id);
		return "delete";
	}

	/**
	 * @return the suggService
	 */
	public SuggestService getSuggService() {
		return suggService;
	}

	/**
	 * @param suggService the suggService to set
	 */
	public void setSuggService(SuggestService suggService) {
		this.suggService = suggService;
	}

	
	/**
	 * @return the suggList
	 */
	public List<Suggestion> getSuggList() {
		return suggList;
	}

	/**
	 * @param suggList the suggList to set
	 */
	public void setSuggList(List<Suggestion> suggList) {
		this.suggList = suggList;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}

	/**
	 * @param page the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}

	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	/**
	 * @return the maxPage
	 */
	public int getMaxPage() {
		return maxPage;
	}

	/**
	 * @param maxPage the maxPage to set
	 */
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	

	/**
	 * @return the sugg
	 */
	public Suggestion getSugg() {
		return sugg;
	}

	/**
	 * @param sugg the sugg to set
	 */
	public void setSugg(Suggestion sugg) {
		this.sugg = sugg;
	}

	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the returnstr
	 */
	public String getReturnstr() {
		return returnstr;
	}

	/**
	 * @param returnstr the returnstr to set
	 */
	public void setReturnstr(String returnstr) {
		this.returnstr = returnstr;
	}

	

}
