<%@page import="com.second_hand.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session = (String) session.getAttribute("email");
	String tag = request.getParameter("tag");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>">
<title>个人中心</title>
<link type="text/css" rel="stylesheet" href="css/common.css" />
<script type="text/javascript" language="javascript"
	src="js/jquery-1.7.2.min.js"></script>
<style>
a:link {
	text-decoration: none;
	color: #000000;
}

a:visited {
	color: #000000;
}

a:hover {
	color: red;
	font-size: 18px;
}

a:active {
	color: #FF6600;
}

#userDetails {
	/*border:2px solid #06F;*/
	background-color: #3f495b;
	z-index: 2;
	border: 1px solid #3f495b;
	width: 300px;
	height: 550px;
	left: 61%; /*FF IE7*/
	top: 30%; /*FF IE7*/
	border-radius: 5px;
	-webkit-box-shadow: #666 0px 0px 10px;
	-moz-box-shadow: #666 0px 0px 10px;
	box-shadow: #666 0px 0px 10px;
	margin-left: -300px !important; /*FF IE7 */
	margin-top: -150px !important; /*FF IE7 */
	margin-top: 0px;
	position: fixed !important; /*FF IE7*/
	position: absolute; /*IE6*/
	_top: expression(eval(document.compatMode &&         
	 document.compatMode ==         'CSS1Compat')?         
	documentElement.scrollTop+          (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		
		
		
		
		
		
		
		 /*IE6*/         
	document.body.scrollTop+          (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}
</style>
<script type="text/javascript" language="javascript">
function shangPage(){
	var userId = $("#userId").val();
	location = 'goodsZr/noint_goodszr_toListByUserMore?userId='+userId+'&page=${page-1}'; 
}
function nextPage(){
	var userId = $("#userId").val();
	location = 'goodsZr/noint_goodszr_toListByUserMore?userId='+userId+'&page=${page+1}'; 
}
function jump() {
		var userId = $("#userId").val();
		var jumppage = $("#jumppage").val();
		var max = $("#max").val();
		if (isNaN(jumppage)) {
			alert("页码为数字！");
			return;
		}
		if (parseInt(jumppage) < 1) {
			alert("您输入的页码不存在！");
			return;
		}
		if (parseInt(jumppage) > parseInt(max)) {
			alert("超过最大页数，最大页数为" + max);
			return;
		}
		location = 'goodsZr/noint_goodszr_toListByUserMore?userId='+userId+'&page='+jumppage+''; 
}
</script>
</head>
<body id="all">
<!-- 用户其他闲置商品 -->
	<div style="width: 100%; height: 150px;">
		<%@ include file="../../homePage/head.jsp"%>
	</div>

	<div style="width: 100%; height: 2px; background-color: #b1191a">

	</div>
	<div style="width: 100%; height: 50px; background-color: #f2f2f2;">

		<input id="email" value="${session.email }" type="hidden" />
	</div>

	<div id="main"
		style="padding-top: 40px; height: auto; width: 980px; margin-left: 210px;">
		<div id="left"
			style="background-color: #f2f2f2; height: 400px; width: 300px; float: left">
			<div
				style="width: 270px; hight: 100px; margin: 0px auto; font-size: 20px; float: left; padding-left: 30px;">
				@
				<s:property value="user.nickname" />
			</div>
			<a
				href="goodsZr/noint_goodszr_toListByUserMore?userId=<s:property value="user.userId" />">
				<div
					style="width: 250px; hight: 300px; font-size: 12px; float: left; margin: 50px 100px;">
					<c:if test="${user.photoUrl != null }">
						<img width="100px" height="100px"
							src="userImg${fn:substringAfter(user.photoUrl, 'userImg')}" />
					</c:if>
					<c:if test="${user.photoUrl== null }">
						<img src="index_img/user1.png" />
					</c:if>
				</div>
			</a>
			<center>
				<div
					style="width: 250px; hight: 300px; font-size: 16px; float: left; margin-left: 30px; line-height: 24px;">
					<!-- 卖家已售出商品评价反馈，在goodsOrder -->
					<a
						href="order/noint_order_findEvaluateNotNullByUser?userId=<s:property value="user.userId" />">卖家已出售商品评价</a><br />
					<input id="userId" value="<s:property value="user.userId" />" type="hidden" />
					<s:property value="lv" />
					<br />
					<s:property value="user.depart.school.city.cityName" />
					<br />
					<s:property value="user.depart.school.schoolName" />
					【
					<s:property value="user.depart.facultyName" />
					】<br /> 电话：
					<s:property value="user.phone" />
					<br /> qq:
					<s:property value="user.qq" />
					<br />
				</div>
			</center>
		</div>
		<div id="right" style="height: auto; width: 680px; float: right">
			<div id="title"
				style="font-size: 20px; line-height: 35px; color: #e4393c; font-weight: bolder;">
				卖家闲置正在出售 <img title="正在出售" src="index_img/changeStatu_button.png"
					width="20px" height="20px" style="margin-top: 5px;" />
			</div>
			<s:iterator value="goodsZrlist" var="goodsZr" status="sta">
				<div id="goods" style="height: 220px; width: 680px; float: right">
					<div
						style="width: 180px; hight: 300px; font-size: 12px; float: left; margin: 5px; margin-top: 15px;">
						<a
							href="goodsZr/noint_goodszr_toDetailPage.action?id=${goodsZr.goodsZrId}"><img
							width="100%" height="180px"
							src="goodspic${fn:substringAfter(goodsZr.goodspicone, 'goodspic')}"></img></a>
					</div>

					<div
						style="width: 480px; hight: 300px; font-size: 16px; float: left; margin: 5px; margin-top: 15px; background-color: #f2f2f2; line-height: 24px;">
						<div
							style="width: 400px; height: 25px; line-height: 35px; font-size: 20px; font-weight: bold; color: #666666; margin-bottom: 15px;">

							<s:property value="#goodsZr.goodsName" />
							<img title="正在出售" src="index_img/changeStatu_button.png"
								width="20px" height="20px" style="margin-top: 5px;" />
						</div>
						<span
							style="font-size: 20px; line-height: 35px; color: #e4393c; font-weight: bolder; margin-bottom: 10px;">￥价格<s:property
								value="#goodsZr.price " /></span> 
								&nbsp;&nbsp;
								<font color="#e4393c"> <c:if
								test="${goodsZr.tradeType==0}">仅同校交易</c:if> <c:if
								test="${goodsZr.tradeType==1}">仅同校或同城交易</c:if> <c:if
								test="${goodsZr.tradeType==2}">全国范围可邮寄</c:if>
						</font> <br />
						<div
							style="width: 400px; height: 60px; line-height: 30px; font-size: 15px; margin-bottom: 10px; color: red">
							商品描述：
							<s:property value="#goodsZr.goodsMsg" />
						</div>
						<div
							style="width: 300px; height: 25px; line-height: 30px; font-size: 15px; margin-bottom: 10px; float: left;">

							<c:if test="${goodsZr.talkPrice == '0' }">
            		可以小刀
            	</c:if>
							<c:if test="${goodsZr.talkPrice == '1' }">
            		不可小刀  
            	</c:if>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预交易地点：
							<s:property value="#goodsZr.address" />
						</div>
						<a
							href="goodsZr/noint_goodszr_toDetailPage.action?id=${goodsZr.goodsZrId}"><div
								style="width: 160px; height: 25px; line-height: 30px; font-size: 15px; margin-bottom: 10px; float: right;">
								留言条数：
								<s:property value="#goodsZr.comCount" />
								&nbsp;&nbsp;&nbsp;赞(
								<s:property value="#goodsZr.praise" />
								)
							</div></a>
					</div>
				</div>
				<hr
					style="width: 680px; height: 1px; border: none; border-top: 1px dotted #0066cc"></hr>
			</s:iterator>
		</div>
	</div>
	  <div style="width:1200px; height:40px; margin-left:1%; float:left; background-color: #ffffff;">
            	<div onclick="jump();" style="width:60px; height:30px; float:right; margin:5px; border:1px solid #f5f5f5; line-height:30px; text-align:center; border-radius:3px; margin-right:20px; cursor:pointer; ">
                	跳转
                </div>
                <div style="width:100px; height:30px; float:right;margin:5px; border-radius:3px; overflow:hidden; border:1px solid #f5f5f5;">
                	<input id="jumppage" style="width:100px;height:30px;border:0px;" />
                </div>
                <c:if test="${(page + 1) <= maxPage }">
                 <div  onclick="nextPage();" style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                </c:if>
                <c:if test="${page + 1 > maxPage }">
                 <div style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                </c:if>
                	<img src="index_img/nextpage.png"  width="100%" height="100%"/>
                </div>
                <div style="width:60px; font-size:18px; height:30px; float:right; margin:5px; line-height:30px; text-align:center; border-radius:3px; cursor:pointer; ">
                	${page} / ${maxPage }
                	<input id="max" value="${maxPage }" type="hidden"></input>
                </div>
                <c:if test="${page > 1 }">
                 <div onclick="shangPage();" style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                 </c:if>
                 <c:if test="${page == 1 }">
                 <div  style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                 </c:if>
				<img src="index_img/beforepage.png"  width="100%" height="100%"/>
                </div>
                </div>

	<div style="height: 60px; width: 100%;">
		<iframe src="homePage/foot.html" width="100%" height="100%"
			frameborder="no" border="0" scrolling="no"></iframe>
	</div>
</body>
</html>

