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
function chooseNo(){
	var url="comment/comment_toListToMeNo.action";
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
}

function chooseYes(){
	var url="comment/comment_toListToMeYes.action";
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
}
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
function shangPage(){
	$.ajax({
		type:'get',
		url:encodeURI("comment/comment_toListToMeYes.action?page=${page-1}"),
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
		url:encodeURI("comment/comment_toListToMeYes.action?page=${page+1}"),
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
		url:encodeURI("comment/comment_toListToMeYes.action?page="+jumppage),
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
<!-- 留言已回复页面 -->
	<div
		style="width: 98%;; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">给我的留言</div>
		<div style="width:40px; height: 36px; cursor: pointer;float: left;margin-left: 30px;margin-top: 5px;">
			 <a onclick="chooseNo()"><img src="index_img/norevert.png" /><font color="#00bb00">待回复</font></a>
					
		</div>
		<div id="sendCount" style="width: 42px; height: 40px; position: absolute; left:395px; top:160px; background-image: url(index_img/save1.png); line-height: 32px; text-align: center; color: #ffffff; font-size: 16px; font-weight: bolder;">
			${waitRevertCount}
		</div>
		<div style="width:40px; height: 36px; cursor: pointer;float: left;margin-left: 50px;margin-top: 5px;">
			<a onclick="chooseYes()"><img src="index_img/yesrevert.png" /><font color="#00bb00">已回复</font></a>
					
		</div>
	</div>
	<div
		style="width: 98%; height: 560px; margin: 0px auto; background-color: #ffffff;">
		<div style="width:98%;margin: 10px auto; font-size:20px;font-style:bolder; float: left;color:red;">
			已回复
		</div>
		<s:iterator value="commentList" var="comment" status="sta">
			<div id="user"
				style="width: 110px; hight:600px; margin: 0px auto; font-size: 12px; float: left;">
				<div
					style="width: 110px; hight: 300px; margin: 0px auto; font-size: 12px; float: left; margin: 38px;">
					<c:if test="${comment.user.photoUrl != null }">
						<img width="60px" height="60px"
							src="userImg${fn:substringAfter(comment.user.photoUrl, 'userImg')}" />
					</c:if>
					<c:if test="${comment.user.photoUrl== null }">
						<img width="60px" height="60px" src="index_img/user1.png" />
					</c:if>
				</div>
				<div
					style="width: 80px; hight: 100px; margin: 0px auto; font-size: 16px; float: left; padding-left: 30px;">
					<s:property value="#comment.user.nickname" />
				</div>
			</div>
			<div id="right"
				style="width: 870px; hight:600px; margin: 0px auto; font-size: 12px; float: right;">
				<div id="goods"
					style="width: 860px; height: 130px; line-height: 30px; float: left; text-align: left; padding-left: 10px;">
					<div
						style="width: 100px; height: 100px; margin-top: 20px; float: left;">
						<a
							href="goodsZr/noint_goodszr_toDetailPage.action?id=${goodsZr.goodsZrId}"><img
							src="goodspic${fn:substringAfter(comment.goodsZr.goodspicone,'goodspic')}"
							width="100%" height="100%" /></a>

					</div>
					<div
						style="width: 300px; height: 100px; margin-top: 80px; float: left; padding-left: 10px;">
						<font color='red' size='5px'><s:property
								value="#comment.goodsZr.goodsName" /></font>
					</div>
				</div>
				<hr
					style="width: 850px; height: 1px; border: none; border-top: 1px dotted #0066cc"></hr>
				<div id="com"
					style="width: 200px; height: 30px; line-height: 30px; float: left; text-align: left; padding-left: 10px;">
					<s:property value="#comment.user.nickname" />
					&nbsp;&nbsp;&nbsp;
					<c:if test="${comment.ctype==1}">
						回复&nbsp;&nbsp;&nbsp;<s:property value="#comment.toUser.nickname" />
					</c:if>
				</div>
				<div
					style="width: 580px; height: 30px; line-height: 30px; float: right; text-align: right; padding-right: 10px">
					发布时间：
					<s:property value="#comment.cdate" />
				</div>
				<div
					style="width: 590px; height: 30px; line-height: 30px; float: left; padding-left: 10px; font-family: sans-serif;">
					<s:property value="#comment.content" />
				</div>
				<div
					style="width: 40px; color: red; height: 10px; line-height: 30px; float: right; text-align: right; padding-right: 10px"
					onclick="open_revert_div(<s:property value='#comment.comId'/>,<s:property value='#comment.user.userId'/>,<s:property value='#comment.goodsZr.goodsZrId'/>,'${sta.count}')">回复</div>
					<hr
					style="width: 850px; height: 1px; border: none; border-top: 1px dotted #0066cc"></hr>
					<c:forEach items="${comment.revertList}" var="revert">
				<div id="re"
					style="width: 200px; height: 30px; line-height: 30px; float: left; text-align: left; padding-left: 10px;">
					${revert.user.nickname} &nbsp;&nbsp;&nbsp;
					<c:if test="${revert.ctype==1}">
						回复&nbsp;&nbsp;&nbsp;${revert.toUser.nickname}
					</c:if>
				</div>
				<div
					style="width: 580px; height: 30px; line-height: 30px; float: right; text-align: right; padding-right: 10px">
					发布时间： ${revert.cdate}</div>
				<div
					style="width: 590px; height: 30px; line-height: 30px; float: left; padding-left: 10px; font-family: sans-serif;">

					${revert.content}</div>
					<hr
					style="width: 850px; height: 1px; border: none; border-top: 1px dotted #0066cc"></hr>
	
	</c:forEach>

			</div>

			<div style="width: auto; margin: 0px auto; font-size: 12px;">

				<div id="revert_div_${sta.count}"
					style="display: none; float: left; width: 985px; height: 110px; margin: 0px auto; background-color: #f5f5f5; font-weight: bolder;">
					<div id="toUserId"></div>
					<div id="goodsId"></div>
					<div id="comId"></div>
					<textarea id="revert_${sta.count}" rows="4" cols="135"></textarea>
					<button class="mybutton" style="width: 100px;"
						onclick="revert('${sta.count}')">回复</button>
				</div>

			</div>
			
		

	<hr
		style="width: 980px; height: 1px; border: none; border-top: 1px dotted #0066cc"></hr>

	</s:iterator>
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
		${page } / ${maxPage }</div>
	<input id="max" value="${maxPage }" type="hidden"></input>
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
	<div id="box" style="position: absolute; top: 35%; left: 35%"></div>

	</div>
</body>
</html>

