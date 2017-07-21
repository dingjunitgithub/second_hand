package com.second_hand.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

@SuppressWarnings("serial")
public class CheckLoginInterceptor extends AbstractInterceptor{

	public String intercept(ActionInvocation in) throws Exception {
		ActionContext ac = in.getInvocationContext();
		Map<String,Object> session = ac.getSession();
		//登录检查
		if(session.get("email") == null){
			//未登录
			ac.put("noLoginStr", "noLogin");
			/*System.out.println("拦截器");*/
			return "nologin";//进入登录页面
		}
		in.invoke();//执行下一个拦截器或Action和Result
		return null;


	}




}
