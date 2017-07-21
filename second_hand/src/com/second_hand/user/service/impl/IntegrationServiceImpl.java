package com.second_hand.user.service.impl;

import java.util.List;

import com.second_hand.model.Integration;
import com.second_hand.user.dao.IntegrationDao;
import com.second_hand.user.service.IntegrationService;

public class IntegrationServiceImpl implements IntegrationService {

	IntegrationDao integrationDao=null;
	public int addIntegration(Integration integration) {
		// TODO Auto-generated method stub
		return integrationDao.addIntegration(integration);
	}

	public List<Integration> findByPage(int page, int pageSize, int userId) {
		// TODO Auto-generated method stub
		return integrationDao.findByPage(page, pageSize, userId);
	}

	public int countMaxPage(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		return integrationDao.countMaxPage(pageSize, userId);
	}

	/**
	 * @return the integrationDao
	 */
	public IntegrationDao getIntegrationDao() {
		return integrationDao;
	}

	/**
	 * @param integrationDao the integrationDao to set
	 */
	public void setIntegrationDao(IntegrationDao integrationDao) {
		this.integrationDao = integrationDao;
	}

	
}
