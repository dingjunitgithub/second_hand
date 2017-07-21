package com.second_hand.adInfo.action;

import java.util.List;

import com.opensymphony.xwork2.ActionSupport;
import com.second_hand.adInfo.service.CityInfoService;
import com.second_hand.model.CityInfo;
import com.second_hand.util.PageUtil;

@SuppressWarnings("serial")
public class CityInfoAction extends ActionSupport{

	CityInfoService cityService=null;
	private CityInfo city;
	private List<CityInfo> cityList;
	private String cityName;
	private int cityId;
	//分页信息
	private int page = 1;
	private int maxPage;

	//去新增界面
	public String toAdd(){
		return "toAdd";
	}

	//去更新页面
	public String toUpdate(){
		city=cityService.findCityById(cityId);
		return "toUpdate";
	}

	//删除
	public String delete(){

		cityService.delete(cityId);
		return "delete";
	}

	//更新
	public String update(){
		CityInfo city = cityService.findCityById(cityId);
		if(city!=null){
			city.setCityName(cityName);
			cityService.update(city);
			return "update";
		}else{
			return "error";
		}

	}

	//添加城市信息
	public String addCity(){
		city=new CityInfo();
		city.setCityName(cityName);
		int count=cityService.addCity(city);;
		if(count!=0){
			return "add";
		}else{
			return ERROR;
		}
	}

	//城市信息列表
	public String toList(){
		try {
			cityList=cityService.findByPage(page, PageUtil.PAGENUM);
			maxPage=cityService.countMaxPage(PageUtil.PAGENUM);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "toList";
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
	 * @return the cityName
	 */
	public String getCityName() {
		return cityName;
	}

	/**
	 * @param cityName the cityName to set
	 */
	public void setCityName(String cityName) {
		this.cityName = cityName;
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
