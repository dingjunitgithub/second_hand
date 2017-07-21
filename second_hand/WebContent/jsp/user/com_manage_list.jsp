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
		url:encodeURI("comment/comment_toList.action?page=${page-1}"),
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
		url:encodeURI("comment/comment_toList.action?page=${page+1}"),
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
		url:encodeURI("comment/comment_toList.action?page="+jumppage),
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
function delete_com(comId){
	$.ajax({
		type:'post',
		data:{comId:comId},
		url:encodeURI('comment/comment_delete.action'),
		success:function (data, textStatus){
			alert("删除成功！");
			window.location=window.location.href;
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
function delete_revert(revertId,comId){
	 document.getElementById("box").style.display="block";
	   $("#box").html("");
		var params = null;
		$.ajax({   
					 url:"revert/revert_delete?revertId="+revertId+"&comId="+comId,
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
						str+="<div style='width:1000px;height: 100%; margin: 0px auto; background-color: #cccccc;'>";
						str+="<div class='navChoose'>回复详情</div>";
						str+="<div style='width:24px;height:24px; position:absolute;top:0;right:0;margin:5px; cursor:pointer;' onclick='box_close()'>";
						str+="<img width='100%' height='100%' src='index_img/close_login.png'/>";
						str+="</div>";
						str+="<table width='100%'>";
						str+="<thead>";
						str+="<tr>";
						str+="<th style='width:100px;'><div align='center'>回复编号</div></th>";
						str+="<th style='width:200px;'><div align='center'>回复时间</div></th>";
						str+="<th style='width:150px;'><div align='center'>回复者</div></th>";
						str+="<th style='width:300px;'><div align='center'>回复内容</div></th>";
						str+="<th style='width:100px;'><div align='center'>操作</div></th>";
						str+="</tr>";
						str+="</thead>";
						str+="<tbody>";
						$.each(json, function(index, item) {
							str+="<tr>";
							str+="<td class='a-center'><div align='center'>"+item.id+"</div></td>";
							str+="<td><div align='center'>"+item.rdate+"</div></td>";
							str+="<td ><div align='center'>"+item.userName+"</div></td>";
							str+="<td ><div align='center'>"+item.revert+"</div></td>";
							str+="<td ><div align='center' onclick='delete_revert("+item.id+")'>删除</div></td>";
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
<!-- 后台留言管理页面 -->
	<div
		style="width: 98%;; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">留言管理</div>
	</div>
	<div
		style="width: 98%; height: 510px; margin: 0px auto; background-color: #ffffff;">
		<table width="100%" border="0">
			<tr height="40px" align="center" bgcolor="#f5f5f5">
				<td  width="30px"  id="div_${status.count}">序号</td>
				<td width="80px">留言编号</td>
				<td >商品名称</td>
				<td >留言时间</td>
				<td width="300px" >留言内容</td>
				<td >留言者</td>
				<td >给谁留言</td>
				<td>操作</td>
			</tr>
		
		<s:iterator value="commentList" var="comment" status="sta">
		
				<tr height="30px" align="center">
					<td >${sta.count }</td>
					<td><s:property value="#comment.comId" /></td>
					<td><s:property value="#comment.goodsZr.goodsName" /></td>
					<td><s:property value="#comment.cdate" /></td>
					<td><s:property value="#comment.content" /></td>
					<td><s:property value="#comment.user.nickname" /></td>
					<td><s:property value="#comment.toUser.nickname" /></td>
					<td><a onclick="delete_com(<s:property value="#comment.comId" />)"><img src="index_img/delete_button.png" title="删除" width="18" height="18" /></a></td>		
					</tr>
		</s:iterator>
		</table>
</div>
		

<div style="width:98%; height:40px; margin-left:1%; float:left; background-color: #ffffff;">
            	<div onclick="jump();" style="width:60px; height:30px; float:right; margin:5px; border:1px solid #f5f5f5; line-height:30px; text-align:center; border-radius:3px; margin-right:20px; cursor:pointer; ">
                	跳转
                </div>
                <div style="width:100px; height:30px; float:right;margin:5px; border-radius:3px; overflow:hidden; border:1px solid #f5f5f5;">
                	<input id="jumppage" style="width:100px;height:30px;border:0px;" />
                </div>
                <c:if test="${(page + 1) <= maxPage }">
                 <div  onclick="nextPage();" style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                </c:if>
                <c:if test="${page + 1 > maxPage }">
                 <div style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                </c:if>
                	<img src="index_img/nextpage.png"  width="100%" height="100%"/>
                </div>
                <div style="width:80px; font-size:18px; height:30px; float:right; margin:5px; line-height:30px; text-align:center; border-radius:3px; cursor:pointer; ">
                	${page } / ${maxPage }
                	<input id="max" value="${maxPage }" type="hidden"></input>
                </div>
                <c:if test="${page > 1 }">
                 <div onclick="shangPage();" style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                 </c:if>
                 <c:if test="${page == 1 }">
                 <div  style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                 </c:if>
				<img src="index_img/beforepage.png"  width="100%" height="100%"/>
                </div>
	<div id="box" style="position: absolute;top:35%;left:35%">
					
               
	</div>

</div>
</body>
</html>

