package com.second_hand.base.action;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.second_hand.adInfo.service.CityInfoService;
import com.second_hand.goodsType.service.GoodsClassService;
import com.second_hand.model.CityInfo;
import com.second_hand.model.GoodsClass;

@SuppressWarnings("serial")
public class IndexAction extends BaseAction {
	GoodsClassService goodsClassService=null;
	CityInfoService cityService=null;
	List<GoodsClass> goodsClassList;
	List<CityInfo> cityList;
	private String state;
	private int cityId;
	CityInfo city=null;
	
	public String toIndexPage(){
		goodsClassList = goodsClassService.findAll();
		return "toIndexPage";
	}
	
	//用户所在城市信息加载，进入首页
	public String addCity(){
		System.out.print(cityId);
		city=cityService.findCityById(cityId);
		session.put("city",city);
		session.put("cityName",city.getCityName());
		return "toIndexPage";
	}
	
	//城市首页显示定位信息
	public String city(){
		cityList=cityService.findAllCity();
		List<JSONObject> jsonList=new ArrayList<JSONObject>();
		for(CityInfo item:cityList){
			JSONObject jobject = new JSONObject();
			jobject.put("cityName",item.getCityName());
			jobject.put("cityId",item.getCityId());
			jsonList.add(jobject);
		}
		JSONArray json = JSONArray.fromObject(jsonList);
		state = json.toString();
		System.out.println(state);
		return "city";
	}
	
	//首页动态刷新商品类型
	public String indexOne(){
		goodsClassList = goodsClassService.findAll();
		List<JSONObject> jsonList=new ArrayList<JSONObject>();
		for(GoodsClass item:goodsClassList){
			JSONObject jobject = new JSONObject();
			jobject.put("className",item.getClassName());
			jobject.put("classId",item.getClassId());
			jsonList.add(jobject);
		}
		JSONArray json = JSONArray.fromObject(jsonList);
		state = json.toString();
		System.out.println(state);
		return "toIndexPage";
	}
	
	/**
	 * @return the goodsClassService
	 */
	public GoodsClassService getGoodsClassService() {
		return goodsClassService;
	}


	/**
	 * @param goodsClassService the goodsClassService to set
	 */
	public void setGoodsClassService(GoodsClassService goodsClassService) {
		this.goodsClassService = goodsClassService;
	}


	/**
	 * @return the goodsClassList
	 */
	public List<GoodsClass> getGoodsClassList() {
		return goodsClassList;
	}


	/**
	 * @param goodsClassList the goodsClassList to set
	 */
	public void setGoodsClassList(List<GoodsClass> goodsClassList) {
		this.goodsClassList = goodsClassList;
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


	
}


