<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String)session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">
function shangPage(){
	$.ajax({
		type:'get',
		url:encodeURI("order/order_findEvaluateNotNull?page=${page-1}"),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			$("#content").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
function nextPage(){
	$.ajax({
		type:'get',
		url:encodeURI("order/order_findEvaluateNotNull?page=${page+1}"),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			$("#content").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
function jump(){
	var jumppage = $("#jumppage").val();
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
		type:'get',
		url:encodeURI("order/order_findEvaluateNotNull?page="+jumppage),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			$("#content").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
	
}
function delete_evaluate(id,divNum){
	alert(divNum);
	$.ajax({
		type:'post',
		data:{id:id},
		url:encodeURI('order/order_delete_evaluate.action'),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			$("#div_"+divNum).remove();
			window.location=window.location.href;
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
</script>
</head>

<body>

	<div
		style="width: 98%; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">评价管理</div>
	</div>
	<div
		style="width: 98%; height: 510px; margin: 0px auto; background-color: #ffffff;">
		<table width="100%" border="0">
			<tr height="40px" align="center" bgcolor="#f5f5f5">
				<td width="30px" id="div_${status.count }">序号</td>
				<td width="80px">商品</td>
				<td width="80px">商品名称</td>
				<td width="250px">评价内容</td>
				<td width="30px">操作</td>
			</tr>
			<c:forEach items="${orderList}" var="order" varStatus="status">
				<tr height="30px" align="center">
					<td>${status.count }</td>
					<td>

						<div style="width: 60px; height: 60px; margin: 10px;">
							<img
								src="goodspic${fn:substringAfter(order.goodsPicOne, 'goodspic')}"
								width="100%" height="100%" />
						</div>
					</td>
					<td>${order.goodsZr.goodsName}</td>
					<td>${order.evaluate }</td>
					<td><div onclick="delete_evaluate(${order.orderId},${status.count})"
						style="cursor: pointer;height: 60px; margin: 15px; font-size: 12px; color: gray; margin-left: 0px; float: left; text-align: center; line-height: 60px;">
						删除评价</div></td>

				</tr>
				<tr>
					<td colspan="4">
						<div style="width: 100%; height: 1px; background-color: #f5f5f5;">

						</div>
					</td>

				</tr>
			</c:forEach>

		</table>
	</div>
	<div id="evaluation"
		style="display: none; position: absolute; top: 35%; left: 45%; height: 200px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left;">

	</div>

	<div
		style="width: 98%; height: 40px; margin-left: 1%; float: left; background-color: #ffffff;">
		<div onclick="jump();"
			style="width: 60px; height: 30px; float: right; margin: 5px; border: 1px solid #f5f5f5; line-height: 30px; text-align: center; border-radius: 3px; margin-right: 20px; cursor: pointer;">
			跳转</div>
		<div
			style="width: 100px; height: 30px; float: right; margin: 5px; border-radius: 3px; overflow: hidden; border: 1px solid #f5f5f5;">
			<input id="jumppage" style="width: 100px; height: 30px; border: 0px;" />
		</div>
		<c:if test="${(page + 1) <= maxPage }">
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
		style="width: 60px; font-size: 18px; height: 30px; float: right; margin: 5px; line-height: 30px; text-align: center; border-radius: 3px; cursor: pointer;">
		${page } / ${maxPage }
		<input id="max" value="${maxPage }" type="hidden"></input>
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
	</div>


</body>
</html>

