<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String keyword = request.getParameter("keyword");
	String goodsclass = request.getParameter("goodsclass");
	String tags = request.getParameter("tags");
	String action = "goodsZr/noint_goodszr_indexGoodsZr";
	if("keyword".equals(tags)){
		action = "goodsZr/noint_goodszr_indexSearch.action?keyword="+keyword;
	}else if("goodsclass".equals(tags)){
		action = "goodsZr/noint_goodszr_indexSearchByGoodsclass.action?goodsClassName="+goodsclass;
	}else{
		 action = "goodsZr/noint_goodszr_indexGoodsZr";
	}
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
	function shangPage1(){
		var goodsclass = $("#classId").val();
		
		$.ajax({
			type:'post',
			url:encodeURI("goodsZr/noint_goodszr_indexSearchByGoodsclass.action?classId="+goodsclass+"&page=${page-1}"),
			beforeSend:function(XMLHttpRequest){
				
			},
			success:function (data, textStatus){
				$("#goodszrlist").html(data);
			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	}
	function nextPage1(){
		var goodsclass = $("#classId").val();
		
		$.ajax({
			type:'post',
			url:encodeURI("goodsZr/noint_goodszr_indexSearchByGoodsclass.action?classId="+goodsclass+"&page=${page+1}"),
			beforeSend:function(XMLHttpRequest){
				
			},
			success:function (data, textStatus){
				$("#goodszrlist").html(data);
			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	}
	function jump1(){
		var goodsclass = $("#classId").val();
		
		var jumppage = $("#aaa").val();
		var max = $("#max").val();
		if(isNaN(jumppage)){
			alert("页码为数字！");
			return;
		}
		if(parseInt(jumppage)<1){
			alert("您输入的页码不存在！");
			return;
		}
		if(parseInt(jumppage)>parseInt(max)){
			alert("超过最大页数，最大页数为"+max);
			return;
		}
		$.ajax({
			type:'post',
			url:encodeURI("goodsZr/noint_goodszr_indexSearchByGoodsclass.action?classId="+goodsclass+"&page="+jumppage),
			beforeSend:function(XMLHttpRequest){
				
			},
			success:function (data, textStatus){
				$("#goodszrlist").html(data);
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
	<!-- 根据商品类别查询 -->
	<c:forEach items="${goodsZrlist}" var="goodszr">
		<input id="classId" type="hidden" value="${goodszr.classes.classId}" />
		<div class="mygoodszr"
			onclick="window.open('goodsZr/noint_goodszr_toDetailPage.action?id=${goodszr.goodsZrId }');">
			<div style="width: 220px; height: 220px;">
				<img width="100%" height="100%"
					src="goodspic${fn:substringAfter(goodszr.goodspicone, 'goodspic')}" />
			</div>
			<div
				style="width: 94%; height: 40px; text-align: left; line-height: 50px; padding: 0px 3%; color: #1b816c; font-weight: bolder; font-size: 15px;">
				${goodszr.goodsName }</div>
			<div
				style="width: 94%; word-wrap: break-word; word-break: break-all; height: 40px; text-align: left; line-height: 20px; padding: 0px 3%; color: #1b816c; font-size: 12px;">
				${goodszr.user.depart.school.schoolName}${goodszr.user.depart.facultyName}
			</div>
			<div
				style="position: absolute; left: 0; top: 0; width: 80px; height: 24px; background-color: #eb5055; color: #ffffff; line-height: 24px; text-align: center">
				￥${goodszr.price}</div>
		</div>
	</c:forEach>

	<div
		style="width: 98%; height: 40px; margin-left: 1%; float: left; background-color: #ffffff;">
		<div onclick="jump1();"
			style="width: 60px; height: 30px; float: right; margin: 5px; border: 1px solid #f5f5f5; line-height: 30px; text-align: center; border-radius: 3px; margin-right: 20px; cursor: pointer;">
			跳转</div>
		<div
			style="width: 100px; height: 30px; float: right; margin: 5px; border-radius: 3px; overflow: hidden; border: 1px solid #f5f5f5;">

			<input id="aaa" style="width: 100px; height: 30px; border: 0px;" />
		</div>
		<c:if test="${(page + 1) <= maxPage}">
			<div onclick="nextPage1();"
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
		${page } / ${maxPage } <input id="max" value="${maxPage }"
			type="hidden"></input>
	</div>
	<c:if test="${page > 1 }">
		<div onclick="shangPage1();"
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
