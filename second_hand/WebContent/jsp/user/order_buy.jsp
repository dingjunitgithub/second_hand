<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String) session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">

function selectUserOrder(flag){
	var condition;
	if(flag==3){
		condition=0;
	}else if(flag==1){
		condition=1;
	}else if(flag==2){
		condition=2;
	}else{
		condition= document.getElementById("condition").value;
	}
	$.ajax({
		type:'get',
		url:encodeURI("order/order_toListBuy.action?condition="+condition+""),
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

/* 提醒卖家发货 */
function sendMessageToSaleUser(id,divNum){
	var condition=document.getElementById("condition").value;
	$.ajax({
		type:'post',
		data:{orderId:id,condition:condition},
		url:encodeURI('comment/comment_sendMessageToSaleUser.action'),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			alert("提醒成功！");
			$("#content").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}

function updateStatu(id,divNum){
	var condition=document.getElementById("condition").value;
	$.ajax({
		type:'post',
		data:{id:id,condition:condition},
		url:encodeURI('order/order_updateStatuToWaitEvalu.action'),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			alert("钱已转给对方，感谢您的信任！快来评价，积分换奖品啦！");
			$("#content").html(data);
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
	function mydelete(id,divNum){
		var condition= document.getElementById("condition").value;
		var flag=1;
		$.ajax({
			type:'post',
			data:{id:id,flag:flag,condition:condition},
			url:encodeURI('order/order_delete.action'),
			beforeSend:function(XMLHttpRequest){
			},
			success:function (data, textStatus){
				$("#content").html(data);
				/* window.location=window.location.href; */
			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	}
	function shangPage(){
		var condition= document.getElementById("condition").value;
		$.ajax({
			type:'get',
			url:encodeURI("order/order_toListBuy.action?page=${page-1}&condition="+condition+""),
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
		var condition= document.getElementById("condition").value;
		$.ajax({
			type:'get',
			url:encodeURI("order/order_toListBuy.action?page=${page+1}&condition="+condition+""),
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
		var condition= document.getElementById("condition").value;
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
			url:encodeURI("order/order_toListBuy.action?page="+jumppage+"&condition="+condition+""),
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
	function evaluate_div_open(orderId){
		alert(orderId); 
		document.getElementById("evaluate_div").style.display="block"; 
		document.getElementById("orderId").value=orderId;
		document.getElementById("condi").value= 3;
		alert("condi"+document.getElementById("condi").value);
	}
	
	function evaluate_div_close(){
		document.getElementById("evaluate_div").style.display="none"; 
	}
	
	
	function evaluate_close(){
		document.getElementById("evaluation").style.display="none"; 
	}
	
	function evaluation(orderId){
		document.getElementById("evaluation").style.display="block"; 
		 $("#evaluation").html("");
		$.ajax({
			type:'post',
			data:{id:orderId},
			url:encodeURI('order/order_findById.action'),
			success : function show(data) {
				var json = eval("(" + data + ")");
				var str ="";        
				str+="<span style='font-size: 16px; line-height: 26px; color: #e4393c; font-weight: bold; margin-left: 15px;'>宝贝评价</span>";
				str+="<br />";
				str+="<div id='userImgLeft' style='width: 80px; hight: 80px; float: left; margin-bottom: 5px; margin-left: 20px;'>";
					$.each(json, function(index, item) {
						var img=item.photoUrl;
						if(img!=null){
							var img1=img.substring(img.indexOf('userImg')+9);
							
							str+="<img width='60px' height='60px' src='userImg\\"+img1+"' />";
						}else{
							str+="<img width='60px' height='60px' src='index_img/user1.png'/>";
						}
									str+="</div>";
										str+="<div id='userInfo' style='width: 80px; hight: 80px; float: left; margin-top: 5px; margin-left: 10px;'>";
					str+=""+item.userName+"";
					str+="<br />";
						str+="<br />";
							str+=""+item.lv+"";
							str+="</div>";
								str+="<div id='evaluationCon' style='height: 40px; width:200px; margin-left: 40px; padding-top: 20px; float: right;'>";
					str+=""+item.evaluation+"";
						});
				str+="</div>";
				str+=" <div style='width:24px;height:24px; position:absolute;top:0;right:0;margin:5px; cursor:pointer;' onclick='evaluate_close();'>";
				str+="<img width='100%' height='100%' src='index_img/close_login.png'/>";	 
				str+="</div>";
				$("#evaluation").append(str); 
			},
			error : function(xhr) {
				alert('select出错。。\n' + xhr.responseText);
			}
		}); 
	}
	
	
	
	function test(){
		var orderId=document.getElementById("orderId").value;
		var evaluate = $("#evaluate").val();
		var condition = $("#condi").val();
		if(evaluate == ""){
			alert("亲，请评价商品!");
			return;
		}
		$.ajax({
			type:'post',
			data:{evaluate:evaluate,id:orderId,condition:condition},
			url:encodeURI('order/order_evaluate.action'),
			beforeSend:function(XMLHttpRequest){
				$("#sugg_submit").html('<img width="100%" height="100%" src="index_img/loading.png"/>');
			},
			success:function (data, textStatus){
				$("#evaluate_div").css("display","none");	
				alert("提交成功！");
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
<!-- 购买者订单 -->
	<div
		style="width: 98%;; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">我的购买</div>
		<div style="width:400px; height: 40px; border-radius: 5px; float: left; margin: 10px; cursor: pointer;line-height: 40px; text-align: center; font-size: 16px;">
			<table width="100%" style="width: 100%;">
				<tr height="50px">
					<td width="100px" align="right">订单状态：</td>
					<td><select id="condition"
						style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;" onchange="selectUserOrder(0)">
							<c:if test="${condition==4 }">
							<option value="4" selected="selected">所有购买订单</option>
							<option value="0">待发货订单</option>
							<option value="1">卖家已发货，待收货订单</option>
							<option value="2">待评价订单</option>
							<option value="3">交易已完成订单</option>
							</c:if>
							<c:if test="${condition==0 }">
							<option value="4">所有购买订单</option>
							<option value="0" selected="selected">待发货订单</option>
							<option value="1">卖家已发货，待收货订单</option>
							<option value="2" >待评价订单</option>
							<option value="3">交易已完成订单</option>
							</c:if>
							<c:if test="${condition==1 }">
							<option value="4">所有购买订单</option>
							<option value="0">待发货订单</option>
							<option value="1" selected="selected">卖家已发货，待收货订单</option>
							<option value="2">待评价订单</option>
							<option value="3">交易已完成订单</option>
							</c:if>
							<c:if test="${condition==2 }">
							<option value="4">所有购买订单</option>
							<option value="0">待发货订单</option>
							<option value="1">卖家已发货，待收货订单</option>
							<option value="2" selected="selected">待评价订单</option>
							<option value="3">交易已完成订单</option>
							</c:if>
							<c:if test="${condition==3}">
							<option value="4">所有购买订单</option>
							<option value="0">待发货订单</option>
							<option value="1">卖家已发货，待收货订单</option>
							<option value="2" >待评价订单</option>
							<option value="3" selected="selected">交易已完成订单</option>
							</c:if>
					</select></td>
				</tr>
			</table>
		</div>
		<div style="width:40px; height: 36px; cursor: pointer;float: left;margin-left: 30px;margin-top: 5px;">
					<a onclick="selectUserOrder(3)"><img src="index_img/send.png" /><font color="#ffcc00">待发货</font></a>
					
		</div>
		<div id="sendCount" style="width: 42px; height: 40px; position: absolute; left:820px; top:160px; background-image: url(index_img/save1.png); line-height: 32px; text-align: center; color: #ffffff; font-size: 16px; font-weight: bolder;">
			${sendCountToBuy}
		</div>
		<div style="width:40px; height: 36px; cursor: pointer;float: left;margin-left:60px;margin-top: 5px;">
					<a onclick="selectUserOrder(1)"><img src="index_img/receive.png" /><font color="#ffcc00">待收货</font></a>			
		</div>
		<div id="sendCount" style="width: 42px; height: 40px; position: absolute; left:915px; top:160px; background-image: url(index_img/save1.png); line-height: 32px; text-align: center; color: #ffffff; font-size: 16px; font-weight: bolder;">
			${receiveCount}
		</div>
		<div style="width:40px; height: 36px; cursor: pointer;float: left;margin-left: 60px;margin-top: 5px;">
					<a onclick="selectUserOrder(2)"><img src="index_img/evaluation.png" /><font color="#ffcc00">待评价</font></a>			
		</div>
		<div id="sendCount" style="width: 42px; height: 40px; position: absolute; left:1017px; top:160px; background-image: url(index_img/save1.png); line-height: 32px; text-align: center; color: #ffffff; font-size: 16px; font-weight: bolder;">
			${evaluationCount}
		</div>
	</div>
	<div
		style="width: 98%; height: 510px; margin: 0px auto; background-color: #ffffff;">
		<table width="100%" border="0">
			<tr height="40px" align="center" bgcolor="#f5f5f5">
				<td width="30px">序号</td>
				<td width="80px">商品</td>
				<td>商品名称</td>
				<td>交易地点</td>
				<td>价格</td>
				<td>交易类型</td>
				<td width="200px">订单状态</td>
				<td width="150px">操作</td>
			</tr>
			<c:forEach items="${orderList}" var="order" varStatus="status">
				<tr height="30px" align="center" id="div_${status.count }">
					<td>${status.count }</td>
					<td>

						<div style="width: 60px; height: 60px; margin: 10px;">
							<img
								src="goodspic${fn:substringAfter(order.goodsPicOne, 'goodspic')}"
								width="100%" height="100%" />
						</div>
					</td>
					<td>${order.goodsZr.goodsName  }</td>
					<td>${order.goodsZr.address }</td>
					<td>${order.goodsZr.price  }</td>

					<td>
						<%-- <c:choose> --%> <c:if
							test="${session.user.userId  == order.user.userId }">购买</c:if> <c:if
							test="${session.user.userId != order.user.userId }">售出</c:if>

					</td>
					<td><c:if test="${order.statu=='0'}">待发货</c:if> <c:if
							test="${order.statu=='1'}">待收货</c:if> <c:if
							test="${order.statu=='2'}">待评价</c:if> <c:if
							test="${order.statu=='3'}">交易完成</c:if></td>
					<td><c:if test="${order.statu=='0'}">
							<input type="button" value="提醒卖家发货"
								onclick="sendMessageToSaleUser(${order.orderId},'${status.count}') " />
						</c:if> 
					<c:if test="${order.statu=='1'}">
							<input type="button" value="收货"
								onclick="updateStatu(${order.orderId},'${status.count}') " />
						</c:if> <c:if test="${order.statu=='2'}">
							<input type="button" value="评价"
								onclick="evaluate_div_open(${order.orderId})" />
						</c:if> <c:if test="${order.statu=='3'}">
							<div onclick="evaluation(${order.orderId})"
								style="cursor: pointer; width: 60px; height: 60px; margin: 15px; font-size: 12px; color: gray; margin-left: 0px; float: right; text-align: center; line-height: 60px;">
								查看评价</div>
							<div onclick="mydelete(${order.orderId},'${status.count}')"
								style="cursor: pointer; width: 40px; height: 60px; margin: 15px; font-size: 12px; color: gray; margin-left: 0px; float: left; text-align: center; line-height: 60px; float: left">
								删除</div>
						</c:if> <%-- <c:choose>
							<c:when
								test="${order.statu=='1' && session.user.userId  == order.user.userId && order.evaluate==null}">
								<div onclick="evaluate_div_open(${order.orderId})"
									style="cursor: pointer; width: 40px; height: 60px; margin: 15px; font-size: 12px; color: gray; margin-left: 0px; float: right; text-align: center; line-height: 60px;">
									评价</div>
							</c:when>
							<c:otherwise>
								<c:if test="${order.evaluate!=null}">
									<div onclick="evaluation(${order.orderId})"
										style="cursor: pointer; width: 60px; height: 60px; margin: 15px; font-size: 12px; color: gray; margin-left: 0px; float: right; text-align: center; line-height: 60px;">
										查看评价</div>
								</c:if>

							</c:otherwise>
						</c:choose> --%>



						<div id="evaluate_div"
							style="display: none; position: absolute; top: 35%; left: 45%; width: 300px;">
							<div
								style="width: 299px; height: 180px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left;">
								<table width="100%" height="100%">
									<tr>
										
										<td align="left" width="50px">亲，评价吧：</td>
									</tr>
									<tr>
										<div id="orderId"></div>
										<td><textarea id="evaluate" rows="8" cols="39"></textarea>
										</td>
									</tr>
								</table>
							</div>
							<div
								style="width:299px; height: 80px; background-color: #4bc0a5; float: left;">
								<div id="sugg_submit"
									style="width: 270px; height: 50px; margin: 15px 15px; cursor: pointer;"
									onclick="test()">
									<img width="100%" height="100%" src="index_img/sugsubmit.png" />
								</div>
							</div>
							<div
								style="width: 24px; height: 24px; position: absolute; top: 0; right: 0; margin: 5px; cursor: pointer;"
								onclick="evaluate_div_close();">
								<img width="100%" height="100%" src="index_img/close_login.png" />
							</div>


						</div></td>
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
		style="display: none; position: absolute; top: 35%; left:37%; height: 150px; color: #ffffff; font-size: 14px; background-color:#ccc; float: left;">

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


</body>
</html>

