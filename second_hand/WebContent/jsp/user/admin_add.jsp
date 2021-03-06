<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String) session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">
	function cityChange() {
		var cityId = document.getElementById("city").value;

		$("#schoolInfo").html("");
		var params = null;
		$
				.ajax({
					url : "school/findSchool!findSchoolByCityId?city.cityId="
							+ cityId,
					// 数据发送方式
					type : 'POST',
					// 接受数据格式
					dataType : "json",
					// 要传递的数据
					data : params,
					// 回调函数，接受服务器端返回给客户端的值，即result值
					success : function show(data) {
						var json = eval("(" + data + ")");
						var str = "";

						str += "<select name='depart.school.schoolId' id='school' style='width:300px;border-radius:5px;height:30px;padding-left:5px; font-size:12px'  onchange='schoolChange()'>";

						$.each(json, function(index, item) {
							str += "<option value="+item.schoolId+">"
									+ item.schoolName + "</option>";

						});
						str += "</select>";

						$("#schoolInfo").append(str);
					},
					error : function(xhr) {
						alert('select出错。。\n' + xhr.responseText);
					}
				});
	}
	function schoolChange() {
		var schoolId = document.getElementById("school").value;

		$("#departInfo").html("");
		var params = null;
		$
				.ajax({
					url : "depart/findDepart!findDepartBySchoolId?school.schoolId="
							+ schoolId,
					// 数据发送方式
					type : 'POST',
					// 接受数据格式
					dataType : "json",
					// 要传递的数据
					data : params,
					// 回调函数，接受服务器端返回给客户端的值，即result值
					success : function show(data) {
						var json = eval("(" + data + ")");
						var str = "";

						str += "<select name='user.depart.departId' id='depart' style='width:300px;border-radius:5px;height:30px;padding-left:5px; font-size:12px'> ";

						$.each(json, function(index, item) {
							str += "<option value="+item.departId+">"
									+ item.departName + "</option>";

						});
						str += "</select>";

						$("#departInfo").append(str);
					},
					error : function(xhr) {
						alert('select出错。。\n' + xhr.responseText);
					}
				});
	}
	function saveSubmit() {
		var email = $("#name").val();
		var password = $("#password").val();
		var qq = $("#qq").val();
		var phone = $("#phone").val();
		var depart = $("#depart").val();

		if (email == "") {
			alert("请输入用户名！");
			return;
		}

		if (password == "") {
			alert("请输入登录密码！");
			return;
		}

		$.ajax({
			type : 'post',
			data : {
				email : email,
				password : password,
				phone : phone,
				qq : qq,
				departId : depart
			},
			url : encodeURI('user/user_addAdmin'),
			beforeSend : function(XMLHttpRequest) {
			},
			success : function(data, textStatus) {
				if (data == "success") {
					alert("" + email + "已成为网站管理员!");
				}
				$("#content").html(data);
			},
			error : function() {
				alert("服务器异常，请联系管理员！");
			}
		});
	}
	function back() {
		$.ajax({
			type : 'post',
			url : encodeURI("city/city_toList.action"),
			beforeSend : function(XMLHttpRequest) {

			},
			success : function(data, textStatus) {
				$("#content").html(data);
			},
			error : function() {
				alert("服务器异常，请联系管理员！");
			}
		});
	}
</script>
</head>

<body>
	<!-- 管理员添加 -->
	<div
		style="width: 98%;; height: 60px; margin: 10px auto; margin-bottom: 0px; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px;">
		<div class="navChoose">添加管理员</div>
	</div>
	<div
		style="width: 98%; height: 400px; margin: 0px auto; background-color: #f9f9f9; margin-bottom: 10px;">
		<table width="100%" style="width: 100%;">
			<tr height="50px">
				<td width="280px" align="right">用户名（提示：登录时的邮箱）：</td>
				<td><input name="" id="name"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;" />
				</td>
			</tr>
			<tr height="50px">
				<td width="280px" align="right">密码：</td>
				<td><input type="password" id="password"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;" />
				</td>
			</tr>
			<tr height="50px">
				<td width="280px" align="right">城市：</td>
				<td><select name="user.depart.school.city.cityId" id="city"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;"
					onchange="cityChange()">
						<c:forEach items="${cityList}" var="city">
							<c:choose>
								<c:when
									test="${user.depart.school.city.cityName == city.cityName }">
									<option value="${city.cityId}" selected="selected">${city.cityName}</option>
								</c:when>
								<c:otherwise>
									<option value="${city.cityId}">${city.cityName}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
				</select></td>
			</tr>
			<tr height="50px">
				<td width="280px" align="right">学校：</td>
				<td>
					<div id="schoolInfo">
						<select name="user.depart.school.schoolId" id="school"
							style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;"
							onchange="schoolChange()">
							<c:forEach items="${schoolList}" var="school">
								<c:choose>
									<c:when
										test="${user.depart.school.schoolName == school.schoolName }">
										<option value="${school.schoolId}" selected="selected">${school.schoolName}</option>
									</c:when>
									<c:otherwise>
										<option value="${school.schoolId}">${school.schoolName}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>

			<tr height="50px">
				<td width="80px" align="right">院系：</td>
				<td>
					<div id="departInfo">
						<select name="user.depart.departId" id="depart"
							style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
							<c:forEach items="${departList}" var="depart">

								<c:choose>
									<c:when
										test="${user.depart.facultyName == depart.facultyName }">
										<option value="${depart.departId}" selected="selected">${depart.facultyName}</option>
									</c:when>
									<c:otherwise>
										<option value="${depart.departId}">${depart.facultyName}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">手机：</td>
				<td><input id="phone"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入手机号码" value="${user.phone}" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">QQ：</td>
				<td><input id="qq"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入QQ号码" value="${user.qq}" /></td>
			</tr>
			<tr height="50px">
				<td></td>
				<td>
					<button class="mybutton" style="width: 100px;"
						onclick="saveSubmit();">注册管理员</button>
					<button class="mybutton" style="width: 100px;" onclick="back();">返回</button>
				</td>
			</tr>

		</table>
	</div>


</body>
</html>

