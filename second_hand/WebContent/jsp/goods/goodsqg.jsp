<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String tags = request.getParameter("tags");
%>
<style type="text/css">
.mygoodszr:hover {
	border: 1px solid #cccccc;
}

.mygoodszr {
	cursor: pointer;
	width: 220px;
	height: 300px;
	border: 1px solid #f5f5f5;
	float: left;
	margin: 16px;
	position: relative;
	margin-right: 0px;
}
</style>
<script type="text/javascript" language="javascript">
function shangPage(){
	$.ajax({
		type:'get',
		url:encodeURI("goodsQg/noint_goodsqg_indexGoodsQg?page=${page-1}"),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			$("#goodsqglist").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
function nextPage(){
	$.ajax({
		type:'get',
		url:encodeURI("goodsQg/noint_goodsqg_indexGoodsQg?page=${page+1}"),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			$("#goodsqglist").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
function jump(){
	var jumppage = $("#bbb").val();
	var max1 = $("#max1").val();
	if(isNaN(jumppage)){
		alert("页码为数字！");
		return;
	}
	if(parseInt(jumppage)<1){
		alert("您输入的页码不存在！");
		return;
	}
	if(parseInt(jumppage)>parseInt(max1)){
		alert("超过最大页数，最大页数为"+max1);
		return;
	}
	$.ajax({
		type:'get',
		url:encodeURI("goodsQg/noint_goodsqg_indexGoodsQg?page="+jumppage),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			$("#goodsqglist").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
	
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
	<!-- 首页求购信息展示 -->
	<c:forEach items="${goodsQgList}" var="goodsqg">
		<div
			onclick="window.open('goodsQg/noint_goodsqg_toDetailPage.action?id=${goodsqg.goodsQgId }');"
			style="cursor: pointer; width: 578px; height: 160px; margin: 10px; float: left; border: 1px solid #f5f5f5; background-color: #f9f9f9;">
			<div
				style="width: 80px; height: 80px; background-color: blue; margin: 30px; border-radius: 50px; overflow: hidden; float: left;">
				<img src="index_img/test_touxiang.png" width="100%" height="100%" />
			</div>
			<div
				style="width: 410px; height: 80px; float: left; margin-top: 30px;">
				<div
					style="width: 100%; height: 30px; line-height: 30px; font-size: 16px; color: #1b816c;">
					${goodsqg.goodsName}</div>


				<div
					style="width: 100%; height: 30px; line-height: 30px; font-size: 12px; color: #4bbfa5;">
					期望价格 <span style="color: #f06951; font-size: 18px;">￥${goodsqg.price }</span>
					交易地点：${goodsqg.address }
				</div>
				<div
					style="width: 100%; height: 20px; line-height: 30px; font-size: 12px; color: #4bbfa5;">
					手机：${goodsqg.phone } QQ：${goodsqg.qq }</div>
				<div
					style="width: 100%; height: 40px; line-height: 30px; font-size: 12px; color: #4bbfa5;">
					求购描述：${goodsqg.goodsMsg}</div>
			</div>
		</div>
	</c:forEach>

	<div
		style="width: 98%; height: 40px; margin-left: 1%; float: left; background-color: #ffffff;">
		<div onclick="jump();"
			style="width: 60px; height: 30px; float: right; margin: 5px; border: 1px solid #f5f5f5; line-height: 30px; text-align: center; border-radius: 3px; margin-right: 20px; cursor: pointer;">
			跳转</div>
		<div
			style="width: 100px; height: 30px; float: right; margin: 5px; border-radius: 3px; overflow: hidden; border: 1px solid #f5f5f5;">

			<input id="bbb" style="width: 100px; height: 30px; border: 0px;" />
		</div>
		<c:if test="${(page + 1) <= maxPage}">
			<div onclick="nextPage();"
				style="width: 30px; height: 30px; float: right; margin: 5px; cursor: pointer;">
		</c:if>
		<c:if test="${page + 1 > maxPage }">
			<div
				style="width: 30px; height: 30px; float: right; margin: 5px; cursor: pointer;">
		</c:if>
		<img src="index_img/nextpage.png" width="100%" height="100%" />
	</div>
	<div
		style="width: 80px; font-size: 18px; height: 30px; float: right; margin: 5px; line-height: 30px; text-align: center; border-radius: 3px; cursor: pointer;">
		${page } / ${maxPage } <input id="max1" value="${maxPage }"
			type="hidden"></input>
	</div>
	<c:if test="${page > 1 }">
		<div onclick="shangPage();"
			style="width: 30px; height: 30px; float: right; margin: 5px; cursor: pointer;">
	</c:if>
	<c:if test="${page == 1 }">
		<div
			style="width: 30px; height: 30px; float: right; margin: 5px; cursor: pointer;">
	</c:if>
	<img src="index_img/beforepage.png" width="100%" height="100%" />
	</div>

</body>
</html>
