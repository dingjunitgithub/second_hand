package com.second_hand.model;

public class Suggestion {

	private int suggId;               //网站建议及意见编号
	private String content;          //建议内容
	private String pubDate;         //提出时间
	/**
	 * @return the suggId
	 */
	public int getSuggId() {
		return suggId;
	}
	/**
	 * @param suggId the suggId to set
	 */
	public void setSuggId(int suggId) {
		this.suggId = suggId;
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
	 * @return the pubDate
	 */
	public String getPubDate() {
		return pubDate;
	}
	/**
	 * @param pubDate the pubDate to set
	 */
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	
}
