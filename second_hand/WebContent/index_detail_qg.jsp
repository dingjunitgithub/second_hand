<%@page import="com.second_hand.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session = (String)session.getAttribute("email");
	String tag = request.getParameter("tag");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>">
<title>个人中心</title>
<link type="text/css" rel="stylesheet" href="css/common.css" />
<script type="text/javascript" language="javascript" src="js/jquery-1.7.2.min.js"></script>

<style>
.chooes_div{
	font-weight:bolder;
	color:#e4393c;
}
</style>
<script type="text/javascript" language="javascript">
function addtocart(){
	location = "cart/cart_add.action?goodspicone=${shGoodsZr.goodspicone}&goodsmsg=${shGoodsZr.goodsmsg }&goodsid=${shGoodsZr.id}&price=${shGoodsZr.price }";
}
function fbpl(){
	var comments = $("#comments").val();
	location = "comment_add.action?content="+comments+"&goodsid=${shGoodsZr.id}";
}
</script>
</head>
<body>
<!-- 求购商品详细信息 -->
	<div style="width:100%;height:150px;">
		<%@ include file="homePage/head.jsp" %>
    </div>
    
    <div style="width:100%;height:2px; background-color:#b1191a" >
    	
    </div>
    <div style="width:100%; height:50px; background-color:#f2f2f2;">
    	
       
    </div>
    <div style="width:1200px; height:400px;  margin:0px auto;">
    	
       	<div style="width:1200px; height:380px;margin:25px 25px 25px 0px;float:left;">
        	<div style="width:1200px; height:30px; line-height:30px; font-size:16px; font-weight:bold;color:#666666">
            	${goodsQg.goodsName }
            </div>
            <div style="width:1200px; height:30px; line-height:30px; font-size:13px;">
            	期望价格：<span style="font-size:20px; color:#e3393c">￥${goodsQg.price }</span>
            </div>
            <div style="width:1200px; height:30px; line-height:30px; font-size:13px;">
            	所在城市：${goodsQg.user.depart.school.city.cityName}
            </div>
            <div style="width:1200px; height:30px; line-height:30px; font-size:13px;">
            	交易地点：${goodsQg.address }
            </div>
            
            <div style="width:1200px; height:30px; line-height:30px; font-size:16px;">
            	求购描述：${goodsQg.goodsMsg }
            </div>
             <div style="width:1200px; height:50px; color:#e3393c; font-size:30px;">
             	你正想要出售？快快找我吧！ 电话：${goodsQg.phone }&nbsp;&nbsp;&nbsp;或者&nbsp;&nbsp;&nbsp;qq：${goodsQg.qq}讨论
            </div>
        </div>
    </div>
     
 	<div style="height:60px;width:100%;">
    	<iframe src="homePage/foot.html" width="100%" height="100%" frameborder="no" border="0" scrolling="no"></iframe>
    </div>
</body>
</html>

