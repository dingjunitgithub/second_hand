<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String)session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">

function selectUserGoodsZr(){
	var condition= document.getElementById("condition").value; 
	$.ajax({
		type:'get',
		url:encodeURI("goodsZr/goodszr_toListByUser.action?condition="+condition+""),
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
	function toadd(){
		$.ajax({
			type:'get',
			url:encodeURI("goodsZr/goodszr_toAdd.action"),
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
	function schooltoupdate(id){
		$.ajax({
			type:'get',
			url:encodeURI("goodsZr/goodszr_toUpdate.action?id="+id),
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
	function schooltodelete(id){
		$.ajax({
			type:'get',
			url:encodeURI("goodsZr/goodszr_deleteByUser.action?id="+id),
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
	function shangPage(){
		$.ajax({
			type:'get',
			url:encodeURI("goodsZr/goodszr_toListByUser.action?page=${page-1}"),
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
			url:encodeURI("goodsZr/goodszr_toListByUser.action?page=${page+1}"),
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
			url:encodeURI("goodsZr/goodszr_toListByUser.action?page="+jumppage),
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
	function changeStatu(statu,id){
		$.ajax({
			type:'post',
			data:{statu:statu,id:id},
			url:encodeURI('goodsZr/goodszr_updateStatu.action'),
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
	function toDetailPage(id){
		$.ajax({
			type:'get',
			url:encodeURI("goodsZr/goodszr_toDetail.action?id="+id),
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
</script>
</head>

<body>
	<div
		style="width: 98%;; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose" style="float: left">发布管理</div>
		<div style="width:400px; height: 40px; border-radius: 5px; float: left; margin: 10px; cursor: pointer;line-height: 40px; text-align: center; font-size: 16px;">
			<table width="100%" style="width: 100%;">
				<tr height="50px">
					<td width="100px" align="right">查询条件：</td>
					<td>
						<select id="condition"
						style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;" onchange="selectUserGoodsZr()">
						
						 	<c:if test="${condition == 2 }">
                            			<option value="0">所有转让商品</option>
										<option value="2" selected="selected">正在出售的商品</option>
										<option value="3">已售出的商品</option>
										<option value="4">停售的商品</option>
                            		</c:if>
                            		<c:if test="${condition == 3 }">
                            			<option value="0">所有转让商品</option>
										<option value="2">正在出售的商品</option>
										<option value="3" selected="selected">已售出的商品</option>
										<option value="4">停售的商品</option>
                            		</c:if>
                            		<c:if test="${condition == 4 }">
                            			<option value="0">所有转让商品</option>
										<option value="2">正在出售的商品</option>
										<option value="3">已售出的商品</option>
										<option value="4" selected="selected">停售的商品</option>
                            		</c:if>
                            		<c:if test="${condition == 0 }">
                            			<option value="0" selected="selected">所有转让商品</option>
										<option value="2">正在出售的商品</option>
										<option value="3">已售出的商品</option>
										<option value="4">停售的商品</option>
                            		</c:if>
						
					</select>
					
					
					</td>
				</tr>
			</table>
		</div>
		<div
			style="width: 120px; height: 40px; border-radius: 5px; float: right; margin: 10px; cursor: pointer; background-color: #ffb300; line-height: 40px; text-align: center; color: #ffffff; font-size: 16px;"
			onclick="toadd();">发布新品</div>
	</div>
	<div
		style="width: 98%; height: 510px; margin: 0px auto; background-color: #ffffff; font-size: 12px;">
		<table width="100%" border="0">
			<tr height="40px" align="center" bgcolor="#f5f5f5">
				<td width="30px">序号</td>
				<td width="150px">商品名称</td>
				<td align="left">商品详细信息</td>
				<td width="60px">价格</td>
				<td width="90px">手机号码</td>
				<td width="90px">发布时间</td>
				<td width="60px">状态</td>
				<td width="200px">操作</td>
			</tr>
			<c:forEach items="${goodsZrlist}" var="goodsZr" varStatus="status">
				<tr height="40px" align="center">
					<td width="30px">${status.count }</td>
					<td width="150px">${goodsZr.goodsName }</td>
					<td>${goodsZr.goodsMsg }</td>
					<td width="60px">${goodsZr.price }</td>
					<td width="150px">${goodsZr.phone }</td>
					<td width="120px">${goodsZr.pubDate }</td>
					<td width="80px"><c:if test="${goodsZr.statu == '0'}">
                        		正在出售
                        	</c:if> <c:if test="${goodsZr.statu == '1'}">
                        		停售
                        	</c:if> <c:if test="${goodsZr.statu == '2'}">
                        		已售
                        	</c:if></td>
					<td width="200px"><c:if test="${goodsZr.statu == '0'}">
							<div
								style="width: 20px; height: 20px; float: left; cursor: pointer; margin-left: 10px;"
								title="停售" onclick="changeStatu(1,'${goodsZr.goodsZrId}');">
								<img src="index_img/changeStatu_button.png" width="100%"
									height="100%" />
						</c:if> <c:if test="${goodsZr.statu == '1'}">
							<div
								style="width: 20px; height: 20px; float: left; cursor: pointer; margin-left: 10px;"
								title="出售" onclick="changeStatu(0,'${goodsZr.goodsZrId}');">
								<img src="index_img/changeStatu_button.png" width="100%"
									height="100%" />
						</c:if> <c:if test="${goodsZr.statu == '2'}">
							<div
								style="width: 20px; height: 20px; float: left; cursor: pointer; margin-left: 10px;"
								title="已售出">
								<img src="index_img/changeStatu_button1.png" width="100%"
									height="100%" />
						</c:if>
						</div>

						<div
							style="width: 20px; height: 20px; float: left; cursor: pointer; margin-left: 10px;"
							onclick="schooltoupdate('${goodsZr.goodsZrId}');">
							<img src="index_img/update_button.png" width="100%" height="100%" />
						</div>
						<div
							style="width: 20px; height: 20px; float: left; cursor: pointer; margin-left: 10px;">
							<img src="index_img/detail_button.png" width="100%" height="100%"
								onclick="toDetailPage('${goodsZr.goodsZrId}');" />
						</div>
						<div
							style="width: 20px; height: 20px; float: left; cursor: pointer; margin-left: 10px;">
							<img src="index_img/delete_button.png" width="100%" height="100%"
								onclick="schooltodelete('${goodsZr.goodsZrId}');" />
						</div></td>
				</tr>
				<tr>
					<td width="50px" colspan="8">
						<div style="width: 100%; height: 1px; background-color: #f5f5f5;">

						</div>
					</td>
				</tr>
			</c:forEach>

		</table>
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
		style="width: 80px; font-size: 18px; height: 30px; float: right; margin: 5px; line-height: 30px; text-align: center; border-radius: 3px; cursor: pointer;">
		${page } / ${maxPage } <input id="max" value="${maxPage }"
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
	</div>
	</div>
</body>
</html>

