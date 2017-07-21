package com.second_hand.adInfo.action;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.second_hand.adInfo.service.CityInfoService;
import com.second_hand.adInfo.service.SchoolInfoService;
import com.second_hand.model.CityInfo;
import com.second_hand.model.SchoolInfo;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class SchoolInfoAction extends ActionSupport {

	SchoolInfoService schoolService=null;
	CityInfoService cityService=null;
	List<CityInfo> cityList=null;
	List<SchoolInfo> schoolList=null;
	SchoolInfo school=null;
	CityInfo city=null;
	private String state;
	private int cityId;
	private int schoolId;
	private String schoolName=null;
	//分页信息
	private int page = 1;
	private int maxPage;

	//删除学校信息
	public String delete(){
		schoolService.delete(schoolId);
		return "delete";
	}

	//去更新页面
	public String toUpdate(){
		school=schoolService.findSchoolById(schoolId);
		cityList=cityService.findAllCity();
		return "toUpdate";
	}


	//更新学校信息
	public String update(){
		SchoolInfo school = schoolService.findSchoolById(schoolId);
		if(school!=null){
			CityInfo city=new CityInfo();
			city.setCityId(cityId);
			school.setCity(city);
			school.setSchoolName(schoolName);
			schoolService.update(school);
			return "update";
		}else{
			return "error";
		}

	}

	//去新增页面
	public String toAdd(){
		cityList=cityService.findAllCity();
		System.out.print("aaaaaaa");
		return "toAdd";
	}

	//新增学校信息
	public String addSchool(){
		school=new SchoolInfo();
		CityInfo city=new CityInfo();
		city.setCityId(cityId);
		school.setCity(city);
		school.setSchoolName(schoolName);
		int count=schoolService.addSchool(school);
		if(count!=0){
			return "add";
		}else{
			return ERROR;
		}
	}

	//根据城市编号查找学校信息（添加院系信息时、添加用户信息时）
	public String findSchoolByCityId(){
		schoolList=schoolService.findSchoolByCityId(city);
		List<JSONObject> jsonList=new ArrayList<JSONObject>();
		for(SchoolInfo item:schoolList){
			JSONObject jobject = new JSONObject();
			jobject.put("schoolName",item.getSchoolName());
			jobject.put("schoolId",item.getSchoolId());
			jsonList.add(jobject);
		}
		JSONArray json = JSONArray.fromObject(jsonList);
		state = json.toString();
		System.out.println(state);
		return "findSchoolByCity";
	}

	//查找城市信息
	public String toList(){
		schoolList=schoolService.findByPage(page, PageUtil.PAGENUM);
		try {
			maxPage=schoolService.countMaxPage(PageUtil.PAGENUM);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "toList";
	}
	/**
	 * @return the schoolService
	 */
	public SchoolInfoService getSchoolService() {
		return schoolService;
	}
	/**
	 * @param schoolService the schoolService to set
	 */
	public void setSchoolService(SchoolInfoService schoolService) {
		this.schoolService = schoolService;
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
	 * @return the cityService
	 */
	public CityInfoService getCityService() {
		return cityService;
	}
	/**
	 * @param cityService the cityService to set
	 */
	public void setCityService(CityInfoService cityService) {
		this.cityService = cityService;
	}
	/**
	 * @return the cityList
	 */
	public List<CityInfo> getCityList() {
		return cityList;
	}
	/**
	 * @param cityList the cityList to set
	 */
	public void setCityList(List<CityInfo> cityList) {
		this.cityList = cityList;
	}
	/**
	 * @return the schoolList
	 */
	public List<SchoolInfo> getSchoolList() {
		return schoolList;
	}
	/**
	 * @param schoolList the schoolList to set
	 */
	public void setSchoolList(List<SchoolInfo> schoolList) {
		this.schoolList = schoolList;
	}

	/**
	 * @return the city
	 */
	public CityInfo getCity() {
		return city;
	}

	/**
	 * @param city the city to set
	 */
	public void setCity(CityInfo city) {
		this.city = city;
	}

	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}

	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the cityId
	 */
	public int getCityId() {
		return cityId;
	}

	/**
	 * @param cityId the cityId to set
	 */
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	/**
	 * @return the schoolName
	 */
	public String getSchoolName() {
		return schoolName;
	}

	/**
	 * @param schoolName the schoolName to set
	 */
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	/**
	 * @return the schoolId
	 */
	public int getSchoolId() {
		return schoolId;
	}

	/**
	 * @param schoolId the schoolId to set
	 */
	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
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
