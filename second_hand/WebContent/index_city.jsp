<%@page import="com.second_hand.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>">
<title>首页</title>
<link type="text/css" rel="stylesheet" href="css/common.css" />
<link type="text/css" rel="stylesheet" href="css/style1.css" />
<script type="text/javascript" language="javascript"
	src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" language="javascript" src="js/com.js"></script>
<script type="text/javascript" language="javascript">
	$(function() {
		//前台动态刷新所有的城市
		$("#cityLoad").html("");
		$
				.ajax({
					// 数据发送方式
					type : 'POST',
					url : "index/index!city",
					// 接受数据格式
					dataType : "json",
					// 要传递的数据

					// 回调函数，接受服务器端返回给客户端的值，即result值
					success : function show(data) {
						var json = eval("(" + data + ")");
						var str = "";
						str += "<form type='post' action='index/index!addCity'>";
						str += "<div style='width: 300px; height: 34px; float: left; margin-top: 43px;'>";
						str += "选择您的城市： <select name='cityId' id='city' style='width: 300px;border-radius: 5px; height: 30px; font-size: 12px;'>";
						$.each(json, function(index, item) {
							str += "<option value="+item.cityId+">"
									+ item.cityName + "</option>";
						});
						str += "</select>";
						str += "</div>";
						str += "<div style='width: 200px; height: 34px; float: left; margin-top: 43px;'></div>";
						str += "<div style='width: 120px; height: 340px; margin-top: 43px; float: left;'>";

						str += "<input type='submit' style='width: 120px; height: 38px; cursor: pointer; background-color: #cccccc; border: 1px; border-color: #2cb2ff; font-family: Microsoft YaHei; font-size: 15px; color: #FFFFFF;' value='进入首页' />";
						str += "</div>";
						str += "</form>";
						$("#cityLoad").append(str);
					},
					error : function(xhr) {
						alert('select出错。。\n' + xhr.responseText);
					}
				});
	});
</script>
</head>
<body>
	<!-- 用户城市信息定位 -->
	<div style="height: 120px; width: 1200px; margin: 0px auto;">
		<div style="width: 1200px; height: 120px; margin: 0px auto;">
			<div style="width: 400px; height: 120px; float: left;">
				<div onclick="location='index.jsp'"
					style="cursor: pointer; width: 200px; height: 80px; margin: 20px 25px;">
					<img src="index_img/logo.png" width="100%" height="100%" />
				</div>
			</div>

			<div style="width: 800px; height: 120px; float: left;" id="cityLoad">
			<!-- 提交所选择城市，进入首页 -->
				<form type="post" action="index/index!addCity">
					<div
						style="width: 300px; height: 34px; float: left; margin-top: 43px;">

						选择您的城市： <select id="city"
							style="width: 300px; border-radius: 5px; height: 30px; font-size: 12px;"
							name="cityId">
							<c:forEach items="${cityList}" var="city">
								<option value="${city.cityId}">${city.cityName}</option>
							</c:forEach>
						</select>

					</div>
					<div
						style="width: 200px; height: 34px; float: left; margin-top: 43px;"></div>
					<div
						style="width: 120px; height: 340px; margin-top: 43px; float: left;">
						<input type="submit"
							style="width: 120px; height: 38px; cursor: pointer; background-color: #cccccc; border: 1px; border-color: #2cb2ff; font-family: Microsoft YaHei; font-size: 15px; color: #FFFFFF;"
							value="进入首页" />
					</div>
				</form>
			</div>



		</div>

		<div style="width: 1200px; height: 2px; background-color: #b1191a"></div>
		<center>
			<div style="width: 1200px; height: 500px;">
				<div
					style="float: left; height: 460px; width: 600px; margin-top: 43px; background: url(index_img/map1.jpg) no-repeat;">

				</div>
				<div style="width: 400px; height: 480px; float: left">
					<div
						style="width: 300px; height: 360px; margin-top: 43px; clear: left">
						<!-- banner-star -->
						<div class="banner_wraper" id="banner">
							<div id="banner-huxi">
								<ul class="banner-tuul">
									<li class="banner1"><a href="#"></a></li>
									<li class="banner2"><a href="#"></a></li>
									<li class="banner3"><a href="#"></a></li>
									<li class="banner4"><a href="#"></a></li>
									<li class="banner5"><a href="#"></a></li>
									<li class="banner6"><a href="#"></a></li>
									<li class="banner7"><a href="#"></a></li>
									<li class="banner8"><a href="#"></a></li>
									<li class="banner9"><a href="#"></a></li>
									<li class="banner10"><a href="#"></a></li>

								</ul>
							</div>
							<div class="inner">
								<ol class="dianul">
									<li class="cur"><a></a></li>
									<li><a></a></li>
									<li><a></a></li>
									<li><a></a></li>
									<li><a></a></li>
									<li><a></a></li>
									<li><a></a></li>
									<li><a></a></li>
									<li><a></a></li>
									<li><a></a></li>

								</ol>
							</div>
						</div>
						<script type="text/javascript">
							$(document).ready(function() {
								bannerhuxi(800, 1000);
							});
						</script>
						<!-- banner-end -->
					</div>
					<div
						style="width: 500px; height: 150px; clear: left; margin-left: 60px">
						<font size="4px" color="red">选择您所在城市，为在校大学生提供了同城在线二手交易的平台，快来注册，发布您的二手商品和求购信息吧，精彩持续不断！如果没有您所在城市和高校，请留言给我们，我们会继续完善的！</font>
					</div>
				</div>
			</div>
</body>
</html>

