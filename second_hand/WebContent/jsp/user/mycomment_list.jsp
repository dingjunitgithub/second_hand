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
function deleteCom(comId){
	$.ajax({
		type:'get',
		url:encodeURI("comment/comment_deleteByUser.action?comId="+comId),
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

function revert(divNum){
	var toUserId= document.getElementById("toUserId").value;
	var goodsId= document.getElementById("goodsId").value; 
	var revert= document.getElementById("revert_"+divNum).value; 
	 $("#com").html("");
	 var ctype= 1; 
	var params = null;		
				  		$.ajax({
				  					// 数据发送方式
				  					type : 'POST',
				  			        url:"comment/comment_add",
				  					// 接受数据格式
				  					dataType : "json",
				  					// 要传递的数据
				  					data :{content:revert,goodsId:goodsId,toUserId:toUserId,ctype:ctype},
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
		url:encodeURI("comment/comment_toListByUser.action?page=${page-1}"),
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
		url:encodeURI("comment/comment_toListByUser.action?page=${page+1}"),
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
		url:encodeURI("comment/comment_toListByUser.action?page="+jumppage),
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
function box_close(){
	document.getElementById("box").style.display="none"; 
}

function revert_div_open(comId){
	
	document.getElementById("revert_div").style.display="block"; 
	document.getElementById("comId").value=comId;
}

function revert_div_close(){
	
	document.getElementById("revert_div").style.display="none"; 

}


function showRevert(comId){
	   document.getElementById("box").style.display="block";
	   $("#box").html("");
		var params = null;
		$.ajax({   
					 url:"revert/revert_toList?comId="+comId,
					// 数据发送方式
					type : 'POST',
					// 接受数据格式
					dataType : "json",
					// 要传递的数据
					data : params,
					// 回调函数，接受服务器端返回给客户端的值，即result值
					success : function show(data) {
						var json = eval("(" + data + ")");
						var str ="";
						str+="<div style='width:500px;height: 100%; margin: 0px auto; background-color: #cccccc;'>";
						str+="<div class='navChoose'>回复详情</div>";
						str+="<div style='width:24px;height:24px; position:absolute;top:0;right:0;margin:5px; cursor:pointer;' onclick='box_close()'>";
						str+="<img width='100%' height='100%' src='index_img/close_login.png'/>";
						str+="</div>";
						str+="<table width='100%'>";
						str+="<thead>";
						str+="<tr>";
						str+="<th><div align='center'>回复编号</div></th>";
						str+="<th><div align='center'>回复时间</div></th>";
						str+="<th><div align='center'>回复者</div></th>";
						str+="<th style='width:300px;'><div align='center'>回复内容</div></th>";
						
						str+="</tr>";
						str+="</thead>";
						str+="<tbody>";

						$.each(json, function(index, item) {
							str+="<tr>";
							str+="<td class='a-center'><div align='center'>"+item.id+"</div></td>";
							str+="<td><div align='center'>"+item.rdate+"</div></td>";
							str+="<td ><div align='center'>"+item.userName+"</div></td>";
							str+="<td ><div align='center'>"+item.revert+"</div></td>";
							
							str+="</tr>";
						});
						str+="</tbody>";
						str+="</table>";
						str+="</div>";
						$("#box").append(str); 
					},
					error : function(xhr) {
						alert('select出错。。\n' + xhr.responseText);
					}
				}); 

}

</script>
</head>

<body>
<!-- 我的留言 -->
	<div
		style="width: 98%;; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">我的留言</div>
		
	</div>
	<div
		style="width: 98%; height: 560px; margin: 0px auto; background-color: #ffffff;">
		<s:iterator value="commentList" var="comment" status="sta">
			<div id="user"
				style="width: 110px; hight: 400px; margin: 0px auto; font-size: 12px; float: left;">
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
				style="width: 870px; hight: 250px; margin: 0px auto; font-size: 12px; float: right;">
				<div id="goods"
					style="width: 860px; height: 130px; line-height: 30px; float: left; text-align: left; padding-left: 10px;">
					<div
						style="width: 100px; height: 100px; margin-top: 20px; float: left;">
						<a href="goodsZr/noint_goodszr_toDetailPage.action?id=${goodsZr.goodsZrId}"><img
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
					onclick="deleteCom(<s:property value='#comment.comId'/>)">删除</div>
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
	<div id="box" style="position: absolute; top: 35%; left: 35%"></div>

	</div>
</body>
</html>

