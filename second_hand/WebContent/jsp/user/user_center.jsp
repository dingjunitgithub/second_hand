<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_userCenter = (String)session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/ajaxfileupload.js"></script>
<script type="text/javascript" language="javascript">
function savePhoto(){
	var photoUrl=$("#photo").val();
	$.ajax({
		type:'get',
		url:encodeURI("user/user_updatePhotoUrl.action?photoUrl="+photoUrl),
		beforeSend:function(XMLHttpRequest){
			
		},
		success:function (data, textStatus){
			if(data=="success"){
				alert("恭喜您，您终于是有头有脸的人啦！");
				document.getElementById("bu").style.display="none"; 
			}
			
		},
		error:function (){
			alert("服务器异常，请联系管理员！");
		}
	});
}
function ajaxFileUpload() {  
var timestamp = new Date().getTime(); 

	 $.ajaxFileUpload({
	        url : 'upload/upload_uploadUserImg.action',//请求路径  
	        secureuri : false, 
	        fileElementId : 'file',// 上传控件的id 
	        dataType : 'json',  
	        success : function(data, status) {
	        	if(data.message == "0" ){
	        		 $("#myremark_common").html("文件上传失败！");
					 $("#xy_over_div").show();
					 $("#xy_remark_common_div").show();
	        	}else if(data.message == "1" ){
	        		/* alert("aaa"+data.filePath); */
		  		    var filePath = data.filePath.replace(/\\/g,"\\\\");
		  		   /*  alert("bbb"+filePath); */
		  		    var filePath1 = filePath.substring(filePath.indexOf('userImg'));
		  		   /*  alert("ccc"+filePath1); */
		  		    var time = timestamp;
		  		    $("#pics").html("");
		  		    $("#pics").append('<div class="goodspic"><input type="hidden" id="photo" value="'+filePath+'" /><img src="'+filePath1+'" alt="" width="100px" height="100px"/><img title="确认保存" style="width:20px;heght:20px;" src="index_img/save.png" onclick="savePhoto()" id="bu"/></div>');
  
	        	}else{
	        		
	        	}
	        	
	        },  
	        error : function(data, status, e) {  

	        }  
	    });  
	    return false; 


}
	
function update_userzl(){
	$.ajax({
		type:'get',
		url:encodeURI("user/user_toUpdatePage.action?email=<%=email_session_userCenter%>"),
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
function outmoney(id){
	$.ajax({
		type:'get',
		url:encodeURI("user/user_toOutMoney.action?id="+id),
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

function pay(id){
	$.ajax({
		type:'get',
		url:encodeURI("user/user_topay.action?id="+id),
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
		style="width: 950px; height: 60px; margin: 20px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">个人资料</div>
	</div>

	<div
		style="width: 950px; height: 120px; margin: 20px auto; border: 1px solid #f5f5f5; margin-top: 0px;">
		
		<div id="pics"
			style="width: 150px; height: 120px; float:left; margin:10px;">
			<c:if test="${user.photoUrl != null }">
			<img width="100px" height="100px" src="userImg${fn:substringAfter(user.photoUrl, 'userImg')}" />
			</c:if>
			<c:if test="${user.photoUrl== null }"><img src="index_img/user1.png" /></c:if>	
		</div>
		<div
			style="width: 100px; height: 100px; float:left; margin:10px;background-image: url(index_img/pic1.png);">
			<input type="file" id="file" name="file" onchange="ajaxFileUpload();"
				style="width: 160px; cursor: pointer; height: 160px; position: relative; filter: alpha(opacity = 0); opacity: 0;" />
			
		</div>
		
		
		
		<div
			style="width: 200px; height: 80px; float: left; margin: 10px; line-height: 80px; font-size: 16px; color: gray; font-weight: bolder; font-family: 'MS Serif', 'New York', serif">
			${user.nickname} <span style="color: #beba89">（${lv}）</span>
		</div>
		<div
			style="width: 200px; height: 80px; float: right; margin: 10px; color: gray; font-weight: bolder;">
			<table width="100%" height="100%">
				<tr>
					<td width="150px" align="left" style="cursor: pointer">账户余额<span
						style="font-size: 20px; color: blue;">
							￥${user.accountBalance} </span></td>
					<td><button class="mybutton" style="width: 60px;"
							onclick="pay('${user.userId}');">充 值</button></td>

				</tr>

				<tr>
					<td align="left" style="cursor: pointer">当前积分：<span
						style="font-size: 20px; color: blue;"> ${user.integral } </span></td>
					<td><button class="mybutton" style="width: 60px;"
							onclick="outmoney('${user.userId}');">提 现</button></td>

				</tr>
			</table>
		</div>
	</div>

	<div
		style="width: 930px; height: 300px; margin: 0px auto; border: 1px solid #f5f5f5; padding: 10px; color: gray;">
		<table width="930px" border="0" style="font-size: 14px;">
			<tr>
				<td width="80px" align="right" height="30px">账号：</td>
				<td width="780px">${user.email }</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width: 930px; height: 1px; background-color: #f5f5f5;">

					</div>
				</td>
			</tr>
			<tr>
				<td align="right" height="30px">昵称：</td>
				<td>${user.nickname }</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width: 930px; height: 1px; background-color: #f5f5f5;">

					</div>
				</td>
			</tr>
			<tr>
				<td align="right" height="30px">城市：</td>
				<td>${user.depart.school.city.cityName}</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width: 930px; height: 1px; background-color: #f5f5f5;">

					</div>
				</td>
			</tr>
			<tr>
				<td align="right" height="30px">学校：</td>
				<td>${user.depart.school.schoolName}</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width: 930px; height: 1px; background-color: #f5f5f5;">

					</div>
				</td>
			</tr>
			<tr>
				<td align="right" height="30px">院系：</td>
				<td>${user.depart.facultyName}</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width: 930px; height: 1px; background-color: #f5f5f5;">

					</div>
				</td>
			</tr>

			<tr>
				<td align="right" height="30px">手机：</td>
				<td>${user.phone }</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width: 930px; height: 1px; background-color: #f5f5f5;">

					</div>
				</td>
			</tr>

			<tr>
				<td align="right" height="30px">QQ：</td>
				<td>${user.qq}</td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width: 930px; height: 1px; background-color: #f5f5f5;">

					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left" height="30px">
					<button class="mybutton" style="width: 100px;"
						onclick="update_userzl();">修改资料</button>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>

