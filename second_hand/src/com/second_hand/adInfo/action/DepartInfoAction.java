package com.second_hand.adInfo.action;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;
import com.second_hand.adInfo.service.CityInfoService;
import com.second_hand.adInfo.service.DepartInfoService;
import com.second_hand.adInfo.service.SchoolInfoService;
import com.second_hand.model.CityInfo;
import com.second_hand.model.DepartmentInfo;
import com.second_hand.model.SchoolInfo;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class DepartInfoAction extends ActionSupport {

	DepartInfoService departService=null;
	SchoolInfoService schoolService=null;
	CityInfoService cityService=null;
	DepartmentInfo depart=null;
	private List<DepartmentInfo> departList=null;
	private List<CityInfo> cityList=null;
	private List<SchoolInfo> schoolList=null;
	SchoolInfo school=null;
	private String state;
	private String departName=null;
	private int schoolId;
	private int departId;
	//分页信息
	private int page = 1;
	private int maxPage;


	//删除
	public String delete(){
		depart=new DepartmentInfo();
		depart.setDepartId(departId);
		departService.delete(depart);
		return "delete";
	}

	//去更新页面
	public String toUpdate(){
		depart=departService.findDepartById(departId);
		cityList=cityService.findAllCity();
		schoolList=schoolService.findAllSchool();
		return "toUpdate";
	}

	//更新
	public String update(){
		DepartmentInfo depart =departService.findDepartById(departId);
		if(depart!=null){
			school=new SchoolInfo();
			school.setSchoolId(schoolId);
			depart.setSchool(school);
			depart.setFacultyName(departName);
			departService.update(depart);
			return "update";
		}else{
			return "error";
		}

	}

	//添加院系信息
	public String addDepart(){
		school=new SchoolInfo();
		school.setSchoolId(schoolId);
		depart=new DepartmentInfo();
		depart.setSchool(school);
		depart.setFacultyName(departName);
		int count=departService.addDepart(depart);
		if(count!=0){
			return "add";
		}else{
			return ERROR;
		}
	}

	//去添加院系信息页面
	public String toAdd(){
		cityList=cityService.findAllCity();
		schoolList=schoolService.findAllSchool();
		return "toAdd";
	}

	//根据学校Id来查询院系信息（用户修改个人信息时调用）
	public String findDepartBySchoolId(){
		departList=departService.findDepartBySchoolId(school);
		List<JSONObject> jsonList=new ArrayList<JSONObject>();
		for(DepartmentInfo item:departList){
			JSONObject jobject = new JSONObject();
			jobject.put("departName",item.getFacultyName());
			jobject.put("departId",item.getDepartId());
			jsonList.add(jobject);
		}
		JSONArray json = JSONArray.fromObject(jsonList);
		state = json.toString();
		System.out.println(state);
		return "findDepartBySchool";
	}

	//院系信息列表
	public String toList(){
		departList=departService.findByPage(page, PageUtil.PAGENUM);
		try {
			maxPage=departService.countMaxPage(PageUtil.PAGENUM);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "toList";
	}
	/**
	 * @return the departService
	 */
	public DepartInfoService getDepartService() {
		return departService;
	}

	/**
	 * @param departService the departService to set
	 */
	public void setDepartService(DepartInfoService departService) {
		this.departService = departService;
	}

	/**
	 * @return the depart
	 */
	public DepartmentInfo getDepart() {
		return depart;
	}

	/**
	 * @param depart the depart to set
	 */
	public void setDepart(DepartmentInfo depart) {
		this.depart = depart;
	}

	/**
	 * @return the departList
	 */
	public List<DepartmentInfo> getDepartList() {
		return departList;
	}

	/**
	 * @param departList the departList to set
	 */
	public void setDepartList(List<DepartmentInfo> departList) {
		this.departList = departList;
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
	 * @return the departName
	 */
	public String getDepartName() {
		return departName;
	}

	/**
	 * @param departName the departName to set
	 */
	public void setDepartName(String departName) {
		this.departName = departName;
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
