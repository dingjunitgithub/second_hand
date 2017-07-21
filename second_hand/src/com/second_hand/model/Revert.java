package com.second_hand.model;

public class Revert {

	private int revertId;
	private String revertContent;
	private String pubDate;
	private User user;
	private Comment comment;
	/**
	 * @return the revertId
	 */
	public int getRevertId() {
		return revertId;
	}
	/**
	 * @param revertId the revertId to set
	 */
	public void setRevertId(int revertId) {
		this.revertId = revertId;
	}
	
	/**
	 * @return the revertContent
	 */
	public String getRevertContent() {
		return revertContent;
	}
	/**
	 * @param revertContent the revertContent to set
	 */
	public void setRevertContent(String revertContent) {
		this.revertContent = revertContent;
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
	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}
	/**
	 * @param user the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}
	/**
	 * @return the comment
	 */
	public Comment getComment() {
		return comment;
	}
	/**
	 * @param comment the comment to set
	 */
	public void setComment(Comment comment) {
		this.comment = comment;
	}
	
	
	
}
