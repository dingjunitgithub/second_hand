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
.chooes_div {
	font-weight: bolder;
	color: #e4393c;
}
a:link{
text-decoration:none;
color:#000000;
}

a:visited{
color:#000000;
}

a:hover{
color:red;
font-size:16px;
}

a:active{
color:#FF6600;
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
	 document.compatMode ==      'CSS1Compat')?      
	documentElement.scrollTop+       (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		
		
		
		
		 /*IE6*/      
	document.body.scrollTop+       (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}
</style>
<script type="text/javascript" language="javascript">
/* 打开回复的div */
function open_revert_div(comId,toUserId,goodsId,divNum){
	if(document.getElementById("revert_div_"+divNum).style.display=="block"){
		document.getElementById("revert_div_"+divNum).style.display="none"; 
	}else{
		document.getElementById("revert_div_"+divNum).style.display="block"; 
		document.getElementById("toUserId").value=toUserId;
		document.getElementById("goodsId").value=goodsId;
		document.getElementById("comId").value=comId;
	}
	
}
/* 关闭卖家已售出商品评价反馈div */
function userDetails_close(){
	document.getElementById("userDetails").style.display="none"; 
}
/* 打开卖家已售出商品评价的div */
function showUserDetails(userId){
	document.getElementById("userDetails").style.display="block"; 
	 $("#userDetails").html("");
	 var phone= document.getElementById("phone"); 
	 var qq= document.getElementById("qq"); 
	$.ajax({
		type:'post',
		data:{userId:userId,flag:1},
		url:encodeURI('order/noint_order_findEvaluateNotNullByUser.action'),
		success : function show(data) {
			
			var json = eval("(" + data + ")");
			var str ="";    
			
			str+="<font color='#ffffff'><br/>卖家已出售商品评价反馈：<br/></font>";
			$.each(json, function(index, item) {
			str+="<div style='width:300px; height:auto;color:#ffffff;font-size:14px; background-color:#4bc0a5;float:left;'>";	
			str+="<table width='100%' height='100%'>";
			str+="<tr>";
			str+="<div style='width:300px; height:110px;margin:10px;'>";
			var img=item.picOne;
			/* var img1=img.replace(/\\/g,"/"); */
			/* alert(img); */
			var img1=img.substring(img.indexOf('goodspic')+10);
			/* alert(img1); */
			str+="<img src='goodspic\\"+img1+"' width='100px' height='100px'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='red' size='2px'>"+item.goodsName+"</font>";
			str+="</div>";
			str+=" </tr>";
			str+=" <tr>";
			str+="评价："+item.evaluation+"";
			str+="</tr>";
			str+="</table>";
			str+=" </div>";
			str+="<hr></hr>";
			});
			str+=" <div style='width:24px;height:24px; position:absolute;top:0;right:0;margin:5px; cursor:pointer;' onclick='userDetails_close();'>";
			str+="<img width='100%' height='100%' src='index_img/close_login.png'/>";	 
			str+="</div>";
			$("#userDetails").append(str); 
		},
		error : function(xhr) {
			alert('select出错。。\n' + xhr.responseText);
		}
	}); 
}

/* 点赞 */
function addPraise(){
	if(document.getElementById("email").value!=""){
		if(document.getElementById("email").value==document.getElementById("goodsUserEmail").value){
			//自己的商品
			alert("亲，不可以给自己商品点赞呦！");
		}else{
			//不是自己的商品
			var goodsId = $("#goodsZrId").val();
			$("#praiseCount").html("");
			$.ajax({
				type:'get',
				
				url:encodeURI("goodsZr/goodszr_addPraise.action?id="+goodsId+""),
				beforeSend:function(XMLHttpRequest){
				},
				success:function (data, textStatus){
					var json = eval("(" + data + ")");
					var str ="";    
					$.each(json, function(index, item) {
						str="("+item.praiseCount+")";
					});
					$("#praiseCount").append(str); 
				},
				error:function (){
					
				}
			});
		}
		
		
	}else{
		alert("请先登录吧!");
	}

}
/* 加入购物车 */
function addCart(){
	if(document.getElementById("email").value!=""){
		if(document.getElementById("email").value==document.getElementById("goodsUserEmail").value){
			//自己的商品
			alert("亲，这是您自己的商品呦！");
		}else{
			//不是自己的商品
			var goodsId = $("#goodsZrId").val();
			var goodspicone = $("#goodspicone").val();
			$.ajax({
				type:'get',
				url:encodeURI("cart/cart!add?goodsId="+goodsId+"&goodspicone="+goodspicone),
				beforeSend:function(XMLHttpRequest){
				},
				success:function (data, textStatus){
					
					if(data == "success"){
						alert("添加成功，在购物车等着亲呢！");
						window.location=window.location.href;
					}else if(data == "unsuccess"){
						alert("该宝贝已在购物车中，快去结算吧！");
						window.location=window.location.href;
					}else{
						
					}
				},
				error:function (){
					
				}
			});
		}
		
	}else{
		alert("请先登录，再来购买吧!");
	}

}
/* 商品留言 */
function test(goodsId,toUserId){
var comments= document.getElementById("comments").value; 
$("#com").html("");
var goodsId = $("#goodsZrId").val();
var ctype = 0;
var params = null;		
			  		$.ajax({
			  					// 数据发送方式
			  					type : 'POST',
			  			        url:"comment/comment_add?ctype="+ctype+"&toUserId="+toUserId+"&goodsId="+goodsId,
			  					// 接受数据格式
			  					dataType : "json",
			  					// 要传递的数据
			  					data :{content:comments,goodsid:goodsId},
			  					// 回调函数，接受服务器端返回给客户端的值，即result值
			  					success : function show(data) {
			  						
			  						window.location=window.location.href;
			  					},
			  					error : function(xhr) {
			  						alert('select出错。。\n' + xhr.responseText);
			  					}
			  				});     
}
/* 留言回复 */
function revert(divNum){
	var toUserId= document.getElementById("toUserId").value;
	var goodsId= document.getElementById("goodsId").value; 
	var comId= document.getElementById("comId").value; 
	var revert= document.getElementById("revert_"+divNum).value; 
	var ctype= 1; 
	 $("#com").html("");
	var params = null;		
				  		$.ajax({
				  					// 数据发送方式
				  					type : 'POST',
				  			        url:"comment/comment_add",
				  					// 接受数据格式
				  					dataType : "json",
				  					// 要传递的数据
				  					data :{content:revert,goodsId:goodsId,toUserId:toUserId,ctype:ctype,comId:comId},
				  					// 回调函数，接受服务器端返回给客户端的值，即result值
				  					success : function show(data) {
				  						window.location=window.location.href;
				  					},
				  					error : function(xhr) {
				  						alert('select出错。。\n' + xhr.responseText);
				  					}
				  				});      
}
</script>
</head>
<body>
<!-- 转让的商品的详细信息 -->
	<div style="width: 100%; height: 150px;">
		<%@ include file="homePage/head.jsp"%>
	</div>

	<div style="width: 100%; height: 2px; background-color: #b1191a">

	</div>
	<div style="width: 100%; height: 50px; background-color: #f2f2f2;">
		<input id="email" value="${session.email}" type="hidden" />
		<input id="goodsUserEmail" value="${goodsZr.user.email}" type="hidden" />
	</div>
	<div style="width: 1200px; height: 430px; margin: 0px auto;">
		<div style="width: 350px; height: 380px; margin: 25px; float: left;">
			<img
				src="goodspic${fn:substringAfter(goodsZr.goodspicone,'goodspic')}"
				width="100%" height="100%" />
		</div>
		<div
			style="width: 775px; height: 350px; margin: 25px 25px 25px 0px; float: left;">
			<div id="left"
				style="width: 500px; height: 150px; margin: 0px; float: left;">
				<div
					style="width: 500px; height: 25px; line-height: 30px; font-size: 20px; font-weight: bolder; color: #666666">
					<s:property value="goodsZr.goodsName" />
				</div>
				<div
					style="width: 500px; height: 50px; line-height: 25px; font-size: 16px; color: #e4393c; font-weight: bold;">
					商品描述：
					<s:property value="goodsZr.goodsMsg" />
				</div>
				<div
					style="width: 500px; height: 25px; line-height: 30px; font-size: 13px; color: #666666">
					所在城市：
					<s:property value="goodsZr.user.depart.school.city.cityName" />
				</div>
				<div
					style="width: 500px; height: 25px; line-height: 30px; font-size: 13px; color: #666666">
					所在院校：
					<s:property value="goodsZr.user.depart.school.schoolName" />
					【
					<s:property value="goodsZr.user.depart.facultyName" />
					】
				</div>
				
				<div
					style="width: 500px; height: 25px; line-height: 30px; font-size: 13px; color: #666666">
					<font color="#e4393c">
						交易类型：
					<c:if test="${goodsZr.tradeType==0}">仅同校交易</c:if>
                    <c:if test="${goodsZr.tradeType==1}">仅同校或同城交易</c:if>
                    <c:if test="${goodsZr.tradeType==2}">全国范围可邮寄</c:if>
					</font>
					&nbsp;&nbsp;&nbsp;交易地点：
					<s:property value="goodsZr.address" />
				</div>
			</div>
			<div id="right"
				style="width: 235px; height: 150px; margin-left: 35px; float: right; color: #e4393c">
				<!-- 点击用户头像，查看用户售出商品的评价反馈信息页面 -->
				<a href="order/noint_order_findEvaluateNotNullByUser?userId=<s:property value="goodsZr.user.userId" />">
					<div
						style="width: 100px; hight: 150px; float: left; margin-left: 40px; margin-top: 5px;">
						<c:if test="${goodsZr.user.photoUrl != null}">
							<img width="100px" height="100px"
								src="userImg${fn:substringAfter(goodsZr.user.photoUrl, 'userImg')}" />
						</c:if>
						<c:if test="${goodsZr.user.photoUrl== null }">
							<img src="index_img/user1.png" />
						</c:if>
					</div>
				</a>
				<div id="top"
					style="width: 120px; hight: 20px; float: left; margin-left: 40px; margin-top: 5px;">
					@${goodsZr.user.nickname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<s:property value="lv" />
					<br />
					
				</div>
				<div
					style="width: 300px; hight: 20px; float: left; margin-top: 5px;color:#000000">
					<!-- 弹出div显示用户已售出商品的评价 -->
					<a onclick="showUserDetails(${goodsZr.user.userId})">该卖家已售出商品评价</a>
					<input id="phone" value="${goodsZr.user.phone}" type="hidden"></input>
					<input id="qq" value="${goodsZr.user.qq}" type="hidden"></input>&nbsp;&nbsp;&nbsp;
					<!-- 显示卖家更多闲置 -->
					<a href="goodsZr/noint_goodszr_toListByUserMore?userId=<s:property value="goodsZr.user.userId" />">该卖家更多闲置</a>
				</div>
			</div>

			<div
				style="clear: both; width: 780px; height: 30px; line-height: 40px; font-size: 13px; background-color: #f2f2f2">
				&nbsp;&nbsp;<span
					style="font-size: 20px; color: #e4393c; font-weight: bolder;">￥<s:property
						value="goodsZr.price " /></span>
				<c:if test="${goodsZr.talkPrice == '0' }">
            		&nbsp;&nbsp;可以小刀
            	</c:if>
				<c:if test="${goodsZr.talkPrice == '1' }">
            		&nbsp;&nbsp;不可小刀  
            	</c:if>
				&nbsp;&nbsp;
				<s:property value="goodsZr.newAndOld" />
				成新
			</div>
			<c:forEach items="${goodsPicList}" var="goodpic">
				<div
					style="width: 150px; height: 150px; float: left; margin: 15px; margin-left: 0px;">
					<img src="goodspic${fn:substringAfter(goodpic, 'goodspic')}"
						width="100%" height="100%" />
				</div>
			</c:forEach>
			
			<div style="width: 755px; height: 50px;clear: both;">
				<%
					if (!"1".equals(userType)) {
				%>
				<c:if test="${goodsZr.statu == '0' }">
				<div style="width: 136px; height: 36px; cursor: pointer;float: left">
					<input id="goodsZrId" type="hidden"
						value="<s:property value='goodsZr.goodsZrId'/>" /> <input
						id="goodspicone" type="hidden"
						value="<s:property value='goodsZr.goodspicone'/>" /> <a
						onclick="addCart()"><img src="index_img/cartbutton.png" /></a>
				</div>
				<div style="width:36px; height: 36px; cursor: pointer;float: left;margin-left: 10px;">
					<a onclick="addPraise()"><img src="index_img/praise.png" /></a>
				</div>
				<div id="praiseCount" style="font-size:18px;width:50px; height: 20px; cursor: pointer;float: left;margin-top:10px;">
					(<s:property value="goodsZr.praise" />)
				</div>
				</c:if>
				<%
					}
				%>

			</div>
		</div>
	</div>
	<div id="userDetails"
		style="display: none; position: relative; overflow-y: scroll; overflow-x: hidden">

	</div>
	<%
		if (email_session != null) {
	%>
	<div
		style="width: 1190px; height: 50px; margin: 0px auto; background-color: #cccccc; font-weight: bolder; line-height: 50px; padding-left: 10px;">
		发布留言</div>
	<div
		style="width: 1200px; height: 110px; margin: 0px auto; background-color: #f5f5f5; font-weight: bolder;">
		<textarea id="comments" rows="4" cols="165"></textarea>
		<button class="mybutton" style="width: 100px;"
			onclick="test(<s:property value='goodsZr.goodsZrId'/>,<s:property value='goodsZr.user.userId'/>)">发布留言</button>
	</div>
	<%
		}
	%>

	<div
		style="width: 1190px; height: 50px; margin: 0px auto; background-color: #cccccc; font-weight: bolder; line-height: 50px; padding-left: 10px;">
		商品留言</div>
	<div id="com" style="width: 1200px; hight: auto; margin: 0px auto;">
		<s:iterator value="commentList" var="comment" status="sta">
			<div style="width: 1200px; margin: 0px auto; font-size: 12px;">

				<div
					style="width: 590px; height: 30px; line-height: 30px; float: left; text-align: left; padding-left: 10px">
					<s:property value="#sta.count" />
					楼：
					<s:property value="#comment.user.nickname" />
					&nbsp;&nbsp;&nbsp;
					<c:if test="${comment.ctype==1}">
						回复&nbsp;&nbsp;&nbsp;<s:property value="#comment.toUser.nickname" />
					</c:if>
				</div>
				<div
					style="width: 590px; height: 30px; line-height: 30px; float: right; text-align: right; padding-right: 10px">
					发布时间：
					<s:property value="#comment.cdate" />
				</div>
				<div
					style="width: 590px; height: 30px; line-height: 30px; float: left; padding-left: 10px; font-family: sans-serif;">
					<s:property value="#comment.content" />
				</div>
				<%
					if (email_session != null) {
				%><div
					style="width: 30px; color: red; height: 10px; line-height: 30px; float: right; text-align: right; padding-right: 10px"
					onclick="open_revert_div(<s:property value='#comment.comId'/>,<s:property value='#comment.user.userId'/>,<s:property value='#comment.goodsZr.goodsZrId'/>,'${sta.count}')">回复</div>
				<%
					}
				%>
				<div id="revert_div_${sta.count}"
					style="display: none; float: left; width: 1200px; height: 110px; margin: 0px auto; background-color: #f5f5f5; font-weight: bolder;">
					<div id="toUserId"></div>
					<div id="goodsId"></div>
					<div id="comId"></div>
					<textarea id="revert_${sta.count}" rows="4" cols="165"></textarea>
					<button class="mybutton" style="width: 100px;"
						onclick="revert('${sta.count}')">回复</button>

				</div>

			</div>
			<hr
				style="width: 1200px; height: 1px; border: none; border-top: 1px dotted #0066cc"></hr>
		</s:iterator>

	</div>
	<div style="height: 60px; width: 100%;">
		<iframe src="homePage/foot.html" width="100%" height="100%"
			frameborder="no" border="0" scrolling="no"></iframe>
	</div>
</body>
</html>

