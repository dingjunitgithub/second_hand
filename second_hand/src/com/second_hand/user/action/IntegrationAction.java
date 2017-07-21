package com.second_hand.user.action;

import java.util.List;

import com.second_hand.base.action.BaseAction;
import com.second_hand.model.Integration;
import com.second_hand.model.User;
import com.second_hand.user.service.IntegrationService;
import com.second_hand.user.service.UserService;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class IntegrationAction extends BaseAction {

	IntegrationService integrationService=null;
	private int page=1;
	UserService userService=null;
	private List<Integration> integrationList=null;
	
	private int maxPage;
	public String toList(){
		String email = (String)session.get("email");
		User user = userService.findUserByEmail(email);
		try {
			integrationList=integrationService.findByPage(page, PageUtil.PAGENUM,user.getUserId());
			maxPage=integrationService.countMaxPage(PageUtil.PAGENUM,user.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "toList";
	}
	/**
	 * @return the integrationService
	 */
	public IntegrationService getIntegrationService() {
		return integrationService;
	}
	/**
	 * @param integrationService the integrationService to set
	 */
	public void setIntegrationService(IntegrationService integrationService) {
		this.integrationService = integrationService;
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
	 * @return the userService
	 */
	public UserService getUserService() {
		return userService;
	}
	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	/**
	 * @return the integrationList
	 */
	public List<Integration> getIntegrationList() {
		return integrationList;
	}
	/**
	 * @param integrationList the integrationList to set
	 */
	public void setIntegrationList(List<Integration> integrationList) {
		this.integrationList = integrationList;
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


}

