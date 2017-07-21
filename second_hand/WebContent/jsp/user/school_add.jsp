<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String)session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript" src="../../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" language="javascript">
	function schoolsaveSubmit(){
		var name = $("#name").val();
		var cityId = document.getElementById("city").value;
		
		if(name == ""){
			alert("请输入学校名称");
			return;
		}
		$.ajax({
			type:'post',
			data:{schoolName:name,cityId:cityId},
			url:encodeURI('school/school_addSchool.action'),
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
	function back(){
		$.ajax({
			type:'post',
			url:encodeURI("school/school_toList.action"),
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
		<div class="navChoose">添加学校</div>
	</div>
	<div
		style="width: 98%; height: 300px; margin: 0px auto; background-color: #f9f9f9; margin-bottom: 10px;">
		<table width="100%" style="width: 100%;">
			<tr height="50px">
				<td width="280px" align="right">城市名称：</td>
				<td><select id="city"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;"
					">
						<c:forEach items="${cityList}" var="city">
							<option value="${city.cityId}">${city.cityName}</option>
						</c:forEach>
				</select></td>
			</tr>


			<tr height="50px">
				<td width="280px" align="right">学校名称：</td>
				<td><input id="name"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;" />
				</td>
			</tr>
			<tr height="50px">
				<td></td>
				<td>
					<button class="mybutton" style="width: 100px;"
						onclick="schoolsaveSubmit();">保存</button>
					<button class="mybutton" style="width: 100px;" onclick="back();">返回</button>
				</td>
			</tr>

		</table>
	</div>


</body>
</html>

