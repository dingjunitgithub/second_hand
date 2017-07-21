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

<SCRIPT src="js/jquery-1.7.2.min.js" type="text/javascript"></SCRIPT>
<script type="text/javascript" language="javascript">
/* 关闭输入支付密码的框框 */
function check_div_close() {
	$("#check").css("display", "none");
}
/* 全选 */
function selectAllCheckbox(){
	 var checkedAll=document.getElementById("allSelect");
	var product=document.getElementsByName("mycheckbox");
	for(var i=0;i<product.length;i++)
	{
		//全选为true 则复选框都选
		if(checkedAll.checked)
		{
			product[i].checked=true;
			var price = 0;
			$("input[name='mycheckbox']").each(function (){
				if(this.checked){
					price += parseFloat($(this).attr("index"));
				}
			});
			$("#myprice").html("￥"+price);
			$("#myprice1").html("￥"+price);
		}
		else
		{
			product[i].checked=false;
			$("#myprice").html("￥"+0);
			$("#myprice1").html("￥"+0);
		}
	} 
} 
function shangPage(){
	$.ajax({
		type:'get',
		url:encodeURI("cart/cart_findAllByUserid.action?page=${page-1}"),
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
		url:encodeURI("cart/cart_findAllByUserid.action?page=${page+1}"),
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
		url:encodeURI("cart/cart_findAllByUserid.action?page="+jumppage),
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

	//删除
	function mydelete(id,divNum){
		$.ajax({
			type:'get',
			url:encodeURI("cart/cart_delete.action?id="+id),
			beforeSend:function(XMLHttpRequest){
			},
			success:function (data, textStatus){
				$("#div_"+divNum).remove();
				var price = 0;
				$("input[name='mycheckbox']").each(function (){
					if(this.checked){
						price += parseFloat($(this).attr("index"));
					}
				});
				$("#myprice").html("￥"+price); 
			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	}
	/* 复选框改变 */
	function changeCheckbox(){
		var price = 0;
		$("input[name='mycheckbox']").each(function (){
			if(this.checked){
				price += parseFloat($(this).attr("index"));
			}
		});
		$("#myprice").html("￥"+price);
		document.getElementById("myprice1").value=price;
	}
	//购买
	function buy(){
		var goodsids = "";
		$("input[name='mycheckbox']").each(function (){
			if(this.checked){
				goodsids += $(this).val()+",";
			}
		});
		goodsids = goodsids.substring(0,goodsids.length-1);
		if(goodsids==""){
			alert("请选择商品再结账！！！");
		}else{
			/* 检查账户余额再验证支付密码 */
			$.ajax({
				type:'get',
				url:encodeURI("cart/cart_buy.action?goodsids="+goodsids),
				beforeSend:function(XMLHttpRequest){	
				},
				success:function (data, textStatus){
					if(data == "yebz"){
						alert("账户余额不足，请充值！");
					}else{
						/* 打开输入支付密码的框框 */
						document.getElementById("check").style.display="block"; 
					}
				},
				error:function (){
					alert("服务器异常，请联系管理员！");
				}
			});
		}
		
	}
	
	//批量删除
	function deleteMore(){
		var goodsids = "";
		$("input[name='mycheckbox']").each(function (){
			if(this.checked){
				goodsids += $(this).val()+",";
			}
		});
		if(goodsids==""){
			alert("请选择后删除！！！");
		}else{
			$.ajax({
				type:'get',
				url:encodeURI("cart/cart_deleteMore.action?goodsids="+goodsids),
				beforeSend:function(XMLHttpRequest){
				},
				success:function (data, textStatus){
					$("#content").html(data);
					window.location=window.location.href;
				},
				error:function (){
					alert("服务器异常，请联系管理员！");
				}
			});
		}
		
	}
	//输入支付密码	
	function check(){
		var goodsids = "";
		$("input[name='mycheckbox']").each(function (){
			if(this.checked){
				goodsids += $(this).val()+",";
			}
		});
		goodsids = goodsids.substring(0,goodsids.length-1);
		var payPassword = $("#payPassword").val();
		var myprice = $("#myprice1").val();
		$.ajax({
			type:'get',
			url:"cart/check!checkPayPassword?goodsids="+goodsids+"&payPassword="+payPassword+"&buyye="+myprice,
			beforeSend:function(XMLHttpRequest){	
			},
			success:function (data, textStatus){
			if(data == "success"){
			alert("购买成功，请前往交易地点取货！");
			window.location=window.location.href;
			
					}else{
						alert("支付密码错误!");
					}

			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	} 
</script>
</head>

<body>
	<!-- 购物车页面 -->
	<input type="hidden" id="id" value="${user.userId }" />
	<div
		style="width: 98%;; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">购物车</div>
	</div>
	<div
		style="width: 98%; min-height: 300px; margin: 0px auto; margin-bottom: 10px;">

		<div
			style="width: 1000px; height: 40px; float: left; border-bottom: 1px solid #f5f5f5; color: red; font-size: 16px;">
			<div
				style="width: 40px; height: 20px; margin: 5px 15px; float: left;">

				<input id="allSelect" name="allcheckbox"
					onchange="selectAllCheckbox()" type="checkbox" index="0"
					checked="checked" />

			</div>
			<div
				style="width: 80px; word-wrap: break-word; word-break: break-all; display: block; height: 20px; margin: 5px 30px; float: left; line-height: 30px;">
				商品图片</div>
			<div
				style="width: 80px; word-wrap: break-word; word-break: break-all; display: block; height: 20px; margin: 5px 30px; float: left; line-height: 30px;">
				商品名称</div>

			<div
				style="width: 300px; word-wrap: break-word; word-break: break-all; display: block; height: 20px; margin: 5px 30px; float: left; line-height: 30px;">
				商品简介</div>
			<div
				style="width: 210px; height: 20px; margin: 5px 15px; margin-left: 0px; float: left; text-align: center; line-height: 20px;">
				<span style="font-weight: bolder; font-size: 15px;">价格 </span>
			</div>
			<div onclick="mydelete(${cart.cartId},'${status.count}')"
				style="cursor: pointer; width: 50px; height: 20px; margin: 5px 15px; font-size: 12px; color: gray; margin-left: 0px; float: left; text-align: center; line-height: 20px;">
				操作</div>
		</div>


		<c:set var="endprice" value="0"></c:set>
		<c:forEach items="${carList }" var="cart" varStatus="status">
			<c:set var="endprice" value="${total}"></c:set>
			<div
				style="width: 1000px; height: 90px; float: left; border-bottom: 1px solid #f5f5f5;"
				id="div_${status.count }">
				<div
					style="width: 40px; height: 60px; margin: 15px 15px; float: left;">
					<table width="100%" height="100%">
						<tr>
							<td><input name="mycheckbox" onchange="changeCheckbox();"
								type="checkbox" checked="checked" index="${cart.goodsZr.price}"
								value="${cart.goodsZr.goodsZrId}" /></td>
						</tr>
					</table>
				</div>
				<div
					style="width: 80px; height: 60px; margin: 15px 30px; float: left;">
					<img
						src="goodspic${fn:substringAfter(cart.goodsPicOne, 'goodspic')}"
						width="100%" height="100%" />
				</div>
				<div
					style="width: 80px; word-wrap: break-word; word-break: break-all; display: block; height: 60px; margin: 30px; float: left; line-height: 30px;">
					${cart.goodsZr.goodsName}</div>

				<div
					style="width: 300px; word-wrap: break-word; word-break: break-all; display: block; height: 60px; margin: 30px; float: left; line-height: 30px;">
					${cart.goodsZr.goodsMsg }</div>
				<div
					style="width: 210px; height: 60px; margin: 15px; margin-left: 0px; float: left; text-align: center; line-height: 60px;">
					<span style="font-weight: bolder; font-size: 15px;">${cart.goodsZr.price}
					</span>
				</div>
				<div onclick="mydelete(${cart.cartId},'${status.count}')"
					style="cursor: pointer; width: 50px; height: 60px; margin: 15px; font-size: 12px; color: gray; margin-left: 0px; float: left; text-align: center; line-height: 60px;">
					删除</div>

			</div>
		</c:forEach>
	</div>
	<div
		style="width: 1000px; height: 50px; float: left; border-bottom: 1px solid #f5f5f5;">
		<div onclick="buy();"
			style="width: 100px; cursor: pointer; font-size: 16px; font-weight: bolder; height: 50px; line-height: 50px; text-align: center; color: #ffffff; float: right; background-color: #e54346">
			去结算</div>

		<div id="myprice"
			style="width: 100px; height: 50px; line-height: 50px; color: #e4393c; float: right; font-size: 20px; font-weight: bolder;">
			￥${endprice}</div>
		<div id="ye"
			style="width: 150px; height: 50px; line-height: 50px; color: gray; float: right; font-size: 14px;">
			账户余额：￥${zhye}</div>
		<div id="deleteAll"
			style="width: 150px; height: 50px; line-height: 50px; color: gray; float: right; font-size: 14px;"
			onclick="deleteMore()">删除</div>

	</div>
	<div id="check"
		style="position: absolute; top: 35%; left: 45%; width: 300px; height: 200px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left; display: none">

		<table width="100%" height="100%">
			<tr>
				<td align="right" width="80px">总计</td>
				<td><input id="myprice1"
					style="width: 180px; height: 30px; padding-left: 5px; font-size: 12px"
					value="${endprice}" placeholder="￥" />
					</div></td>
			</tr>
			<tr>
				<td align="right">请输入支付密码：</td>
				<td><input id="payPassword" type="password"
					style="width: 180px; height: 30px; padding-left: 5px; font-size: 12px"
					placeholder="请在此输入您的支付密码" /></td>
			</tr>
			<tr>
				<td align="right" colspan="2"><input type="button" value="确认支付"
					onclick="check()" /></td>
			</tr>
		</table>
		<div
			style="width: 24px; height: 24px; position: absolute; top: 0; right: 0; margin: 5px; cursor: pointer;"
			onclick="check_div_close();">
			<img width="100%" height="100%" src="index_img/close_login.png" />
		</div>

	</div>
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


</body>
</html>

