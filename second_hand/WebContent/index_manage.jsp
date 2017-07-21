<%@page import="com.second_hand.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%	
	String email_session = (String)session.getAttribute("email");
	String tag= request.getParameter("tag");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人中心</title>
<link type="text/css" rel="stylesheet" href="css/common.css" />
<script type="text/javascript" language="javascript"
	src="js/jquery-1.7.2.min.js"></script>

<style>
.chooes_div {
	font-weight: bolder;
	color: #e4393c;
}
</style>
<script type="text/javascript" language="javascript">
$(function (){
	var tag ="<%=tag%>";
	var url = "";
	if(tag == "user_center"){//用户中心
		url = "user/user_findUserByEmail.action?email=<%=email_session %>";
		$("#user_center_div").addClass("chooes_div");
	}else if(tag == "goods_fb_manage"){
		url = "goodsZr/goodszr_toList.action";
		$("#goods_fb_manage").addClass("chooes_div");	
	}else if(tag == "user_updatepassword"){//修改密码
		url = "user/user_toupdatepassword.action?email=<%=email_session %>";
		$("#user_updatepassword").addClass("chooes_div");
	}else if(tag == "user_updatepaypassword"){//修改密码
		url = "user/user_toupdatepaypassword.action?email=<%=email_session %>";
		$("#user_updatepaypassword").addClass("chooes_div");
	}else if(tag == "citylist"){
		url = "city/city_toList";
		$("#citylist").addClass("chooes_div");
	}else if(tag == "schoollist"){
		url = "school/school_toList";
		$("#schoollist").addClass("chooes_div");
	}else if(tag == "departlist"){
		url = "depart/depart_toList";
		$("#departlist").addClass("chooes_div");
	}else if(tag == "good_fenlei_manage"){
		url = "gClass/goodsclass_toList.action";
		$("#good_fenlei_manage").addClass("chooes_div");
	}else if(tag == "myfb"){
		url = "goodsZr/goodszr_toListByUser.action";
		$("#myfb").addClass("chooes_div");
	}else if(tag == "cart"){
		url = "cart/cart_findAllByUserid.action";
		$("#mycart").addClass("chooes_div");
	}else if(tag == "myorderbuy"){
		url = "order/order_toListBuy.action";
		$("#myorderbuy").addClass("chooes_div");
	}else if(tag == "myordersale"){
		url = "order/order_toListSale.action";
		$("#myordersale").addClass("chooes_div");
	}else if(tag == "myqg"){
		url = "goodsQg/goodsqg_toListByUser.action";
		$("#myqg").addClass("chooes_div");
	}else if(tag == "adminmanage"){
		url = "user/user_toAdminList.action";
		$("#adminmanage").addClass("chooes_div");
	}else if(tag == "usermanage"){
		url = "user/user_toList.action";
		$("#usermanage").addClass("chooes_div");
	}else if(tag == "wzjy"){
		url = "suggest/sugg_toList.action";
		$("#wzjy").addClass("chooes_div");
	}else if(tag == "mycom"){
		url = "comment/comment_toListByUser.action";
		$("#mycom").addClass("chooes_div");
	}else if(tag == "myrevert"){
		url = "comment/comment_toListToMeNo.action";
		$("#myrevert").addClass("chooes_div");
	}else if(tag == "comAndRevert"){
		url = "comment/comment_toList.action";
		$("#comAndRevert").addClass("chooes_div");
	}else if(tag == "evaluateList"){
		url = "order/order_findEvaluateNotNull.action";
		$("#evaluateList").addClass("chooes_div");
	}else if(tag == "ruleList"){
		url = "rule/rule_toList.action";
		$("#ruleList").addClass("chooes_div");
	}else if(tag == "myIntegration"){
		url = "integration/integration_toList.action";
		$("#myIntegration").addClass("chooes_div");
	}else{
		
	}
	if(document.getElementById("email").value!=""){
		$.ajax({
			type:'post',
			url:encodeURI(url),
			beforeSend:function(XMLHttpRequest){
			},
			success:function (data, textStatus){	
				$("#content").html(data);
			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	}else{
		$.ajax({
			type:'post',
			url:encodeURI(url),
			beforeSend:function(XMLHttpRequest){
			},
			success:function (data, textStatus){	
				$("#all").html(data);
			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	}
		

	
	
});
</script>
</head>
<body id="all">
<!-- 用户的个人中心和管理员的后台管理的侧导航栏 -->
<input id="email" value="${session.email}" type="hidden" />
	<div style="width: 100%; height: 150px;">
		<%@ include file="homePage/head.jsp"%>
	</div>

	<div style="width: 100%; height: 2px; background-color: #b1191a">

	</div>
	<div style="width: 1200px; height: 450px; margin: 0px auto;">
		<div
			style="width: 170px; height: 430px; background-color: #f5f5f5; float: left; margin-top: 10px;">
			<%
      	if("1".equals(userType)){//管理员
      		%>
			<div id="adminmanage"
				onclick="location='index_manage.jsp?tag=adminmanage'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				管理员管理</div>
			<div id="usermanage"
				onclick="location='index_manage.jsp?tag=usermanage'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				普通用户管理</div>
			<div id="good_fenlei_manage"
				onclick="location='index_manage.jsp?tag=good_fenlei_manage'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				商品分类管理</div>
			<div id="citylist" onclick="location='index_manage.jsp?tag=citylist'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; cursor: pointer; border-bottom: 1px solid #cccccc; padding-left: 10px">
				城市信息管理</div>
			<div id="schoollist"
				onclick="location='index_manage.jsp?tag=schoollist'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; cursor: pointer; border-bottom: 1px solid #cccccc; padding-left: 10px">
				学校信息管理</div>
			<div id="departlist"
				onclick="location='index_manage.jsp?tag=departlist'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; cursor: pointer; border-bottom: 1px solid #cccccc; padding-left: 10px">
				院系信息管理</div>
			<div id="evaluateList"
				onclick="location='index_manage.jsp?tag=evaluateList'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; cursor: pointer; border-bottom: 1px solid #cccccc; padding-left: 10px">
				评价管理</div>
			<div id="comAndRevert"
				onclick="location='index_manage.jsp?tag=comAndRevert'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; cursor: pointer; border-bottom: 1px solid #cccccc; padding-left: 10px">
				留言及回复管理</div>
			<div id="ruleList" onclick="location='index_manage.jsp?tag=ruleList'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; cursor: pointer; border-bottom: 1px solid #cccccc; padding-left: 10px">
				积分规则管理</div>
			<div id="wzjy" onclick="location='index_manage.jsp?tag=wzjy'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; cursor: pointer; border-bottom: 1px solid #cccccc; padding-left: 10px">
				网站建设建议及意见管理</div>
			<%
      	}if("2".equals(userType)){
      		%>
			<div id="user_center_div"
				onclick="location='index_manage.jsp?tag=user_center'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				个人中心</div>
			<div id="user_updatepassword"
				onclick="location='index_manage.jsp?tag=user_updatepassword'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				修改密码</div>
			<div id="user_updatepaypassword"
				onclick="location='index_manage.jsp?tag=user_updatepaypassword'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				重设支付密码</div>
			<div onclick="location='index_manage.jsp?tag=myorderbuy'" id="myorderbuy"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				我买买买</div>
			<div onclick="location='index_manage.jsp?tag=myordersale'" id="myordersale"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				我卖卖卖</div>
			<div id="mycart" onclick="location='index_manage.jsp?tag=cart'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				我的购物车</div>
			<div id="myfb" onclick="location='index_manage.jsp?tag=myfb'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				我的发布</div>
			<div id="myqg" onclick="location='index_manage.jsp?tag=myqg'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				我的求购</div>
			<div id="mycom" onclick="location='index_manage.jsp?tag=mycom'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				我的留言</div>
			<div id="myrevert" onclick="location='index_manage.jsp?tag=myrevert'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				给我的留言</div>
			<div id="myIntegration"
				onclick="location='index_manage.jsp?tag=myIntegration'"
				style="width: 160px; height: 30px; line-height: 30px; text-align: left; border-bottom: 1px solid #cccccc; cursor: pointer; padding-left: 10px">
				我的积分明细</div>
			<%
      	}
      %>



		</div>
		<div id="content"
			style="width: 1008px; min-height: 200px; float: left; margin: 10px; border: 1px solid #f5f5f5">


		</div>
	</div>
	<div style="height: 60px; width: 100%;">
		<iframe src="homePage/foot.html" width="100%" height="100%"
			frameborder="no" border="0" scrolling="no"></iframe>
	</div>
</body>

</html>

