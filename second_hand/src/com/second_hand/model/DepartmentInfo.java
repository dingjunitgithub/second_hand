package com.second_hand.model;

import java.util.List;

public class DepartmentInfo {

	private int departId;                  //院系信息编号
	private String facultyName;           //院系名称
	private SchoolInfo school;            //学校表记录
	private List<User> userList; 
	/**
	 * @return the departId
	 */
	public int getDepartId() {
		return departId;
	}
	/**
	 * @param departId the departId to set
	 */
	public void setDepartId(int departId) {
		this.departId = departId;
	}
	/**
	 * @return the facultyName
	 */
	public String getFacultyName() {
		return facultyName;
	}
	/**
	 * @param facultyName the facultyName to set
	 */
	public void setFacultyName(String facultyName) {
		this.facultyName = facultyName;
	}
	/**
	 * @return the school
	 */
	public SchoolInfo getSchool() {
		return school;
	}
	/**
	 * @param school the school to set
	 */
	public void setSchool(SchoolInfo school) {
		this.school = school;
	}
	/**
	 * @return the userList
	 */
	public List<User> getUserList() {
		return userList;
	}
	/**
	 * @param userList the userList to set
	 */
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}


	
	
	
	
}
