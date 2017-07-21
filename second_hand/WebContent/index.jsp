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
<link type="text/css" rel="stylesheet" href="css/style.css" />
<script type="text/javascript" language="javascript"
	src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" language="javascript" src="js/com.js"></script>
<script type="text/javascript" language="javascript">
	$(function (){
		var noLogin = $("#noLogin").val();;
		if (noLogin == 'noLogin') {
			$("#over_div").css("display", "");
			alert('请您先登录！');
			$("#over_div").css("display", "none");
		}
		/* 加载最新转让商品 */
		$.ajax({
			type:'get',
			url:encodeURI("goodsZr/noint_goodszr_indexGoodsZr"),
			beforeSend:function(XMLHttpRequest){
				
			},
			success:function (data, textStatus){
				$("#goodszrlist").html(data);
			},
			error:function (){
				alert("服务器异常，请联系管理员a！");
			}
		});
		/* 加载最新求购商品 */
	 	$.ajax({
			type:'get',
			url:encodeURI("goodsQg/noint_goodsqg_indexGoodsQg"),
			beforeSend:function(XMLHttpRequest){
				
			},
			success:function (data, textStatus){
				$("#goodsqglist").html(data);
			},
			error:function (){
				alert("服务器异常，请联系管理员a！");
			}
		}); 
	 	
	 	/* 加载商品类型 */
		$("#classes").html("");
		
					  		$.ajax({
					  					// 数据发送方式
					  					type : 'POST',
					  			        url:"index/indexOne!indexOne",
					  					// 接受数据格式
					  					dataType : "json",
					  					// 要传递的数据
					  					
					  					// 回调函数，接受服务器端返回给客户端的值，即result值
					  					success : function show(data) {
					  						var json = eval("(" + data + ")");
					  						var str ="";
					  						str+="<div  id='classes' style='width:170px;height:430px; background-color:#c81623;float:left; margin-top:10px;'>";
					  						str+="<div style='width:170px;height:50px; line-height:50px;color:#ffffff; text-align:left; background-color:#b1191a;font-size:16px; '>";
					  						str+="&nbsp;&nbsp;全部商品分类";
					  						str+="</div>";
					  						$.each(json, function(index, item) {
					  							/* 根据类型查询	 */
					  							str+=" <div  onclick='submitSearchBygoodsclass("+item.classId+");' style='width:170px;height:30px; line-height:30px;color:#ffffff; text-align:left; border-bottom:1px solid #b1191a;cursor:pointer;'>";
					  							
					  							str+="&nbsp;&nbsp;"+item.className;
					  							str+="</div>";
					  				
					  						});
					  						str+="</div>";
					  						$("#classes").append(str); 
					  					},
					  					error : function(xhr) {
					  						alert('select出错。。\n' + xhr.responseText);
					  					}
					  				});     
	 	
	});

	//根据类型查询
	function submitSearchBygoodsclass(classId){

		$.ajax({
			type:'post',
			data:{classId:classId},
			url:encodeURI('goodsZr/noint_goodszr_indexSearchByGoodsclass'),
			beforeSend:function(XMLHttpRequest){

			},
			success:function (data, textStatus){
				$("#goodszrlist").html(data);
				$(document).scrollTop(600);
			},
			error:function (){

			}
		});	
	}
	//将滚动条置顶
	function totop(){
		scroll(0,0);
	}
	
</script>
</head>
<body>
	<input value="<s:property value="noLoginStr"/>" id="noLogin"
		type="hidden">
	<div style="width: 100%; height: 150px;">
		<%@ include file="homePage/head.jsp"%>
	</div>
	<div style="width: 100%; height: 2px; background-color: #b1191a">
	</div>
	<!-- 首页中间部分（分类和banner）开始 -->
	<div style="width: 1200px; height: 450px; margin: 0px auto;">
		<!-- 商品分类开始 -->
		<div id="classes"
			style="width: 170px; height: 430px; background-color: #c81623; float: left; margin-top: 10px;">
			<div
				style="width: 170px; height: 50px; line-height: 50px; color: #ffffff; text-align: left; background-color: #b1191a; font-size: 16px;">
				&nbsp;&nbsp;全部商品分类</div>
			<c:forEach items="${goodsClassList}" var="classes">
				<div onclick="submitSearchBygoodsclass();"
					style="width: 170px; height: 30px; line-height: 30px; color: #ffffff; text-align: left; border-bottom: 1px solid #b1191a; cursor: pointer;">
					&nbsp;&nbsp;${classes.className}<input type="hidden" id="className"
						value="${classes.className}" />
				</div>
			</c:forEach>

		</div>
		<!-- 商品分类结束 -->
		<div style="width: 1010px; height: 430px; float: left; margin: 10px">
			<!-- banner-star -->
			<div class="banner_wraper" id="banner">
				<div id="banner-huxi">
					<ul class="banner-tuul">
						<li class="banner1"><a href="#"></a></li>
						<li class="banner2"><a href="#"></a></li>
						<li class="banner3"><a href="#"></a></li>
					</ul>
				</div>
				<div class="inner">
					<ol class="dianul">
						<li class="cur"><a></a></li>
						<li><a></a></li>
						<li><a></a></li>
					</ol>
				</div>
			</div>
			<script type="text/javascript">
	 			$(document).ready(function(){
	 			//呼吸时间、间隔时间
				bannerhuxi(1000,8000);
	 		   });
			</script>
			<!-- banner-end -->
		</div>
	</div>
	<!-- 首页中间部分（分类和banner）结束 -->
	<!-- 转让商品最新发布开始 -->
	<div id="zxfbs" style="width: 1200px; height: 40px; margin: 0px auto;">
		<div style="width: 30px; height: 30px; float: left; margin: 5px;">
			<img src="index_img/1f.png" width="100%" height="100%" />
		</div>
		<div
			style="height: 30px; float: left; margin: 5px; line-height: 30px; font-size: 16px; font-family: 'MS Serif', 'New York', serif; font-weight: bolder; color: #333333;">
			最新发布</div>
	</div>

	<div
		style="width: 1200px; height: 1px; margin: 0px auto; background-color: #f5f5f5;">
	</div>
	
	<!-- 加载goods.jsp或goods_keyword.jsp或goods_className.jsp开始 -->
	<div id="goodszrlist"
		style="width: 1200px; height: 720px; margin: 0px auto;">
	</div>
	<!-- 加载goods.jsp或goods_keyword.jsp或goods_className.jsp结束 -->
	
	<!-- 转让商品最新发布结束 -->
	
	<!-- 求购商品最新发布开始 -->
	<div style="width: 1200px; height: 40px; margin: 0px auto;">
		<div style="width: 30px; height: 30px; float: left; margin: 5px;">
			<img src="index_img/2f.png" width="100%" height="100%" />
		</div>
		<div
			style="height: 30px; float: left; margin: 5px; line-height: 30px; font-size: 16px; font-family: 'MS Serif', 'New York', serif; font-weight: bolder; color: #333333;">
			最新求购
		</div>
	</div>
	
	<div
		style="width: 1200px; height: 1px; margin: 0px auto; background-color: #f5f5f5;">
	</div>
	
	<!-- 加载goodsqg.jsp开始 -->
	<div id="goodsqglist"
		style="width: 1200px; height: 360px; margin: 0px auto;">
	</div>
	<!-- 加载goodsqg.jsp结束 -->
	
	<!-- 求购商品最新发布结束 -->

	<div style="height: 60px; width: 100%;">
		<iframe src="homePage/foot.html" width="100%" height="100%"
			frameborder="no" border="0" scrolling="no"></iframe>
	</div>

	<!-- 右侧的购物车和置顶箭头 -->
	<div
		style="position: fixed; right: 0; bottom: 200px; width: 40px; height: 200px; line-height: 40px; color: #ffffff; text-align: center; background-color: #7a6e6e; font-size: 12px; border-radius: 3px;">
		<div onclick="window.open('index_manage.jsp?tag=cart')"
			style="width: 30px; height: 30px; margin: 5px; cursor: pointer;">
			<img src="index_img/sp.png" width="100%" height="100%" />
		</div>
		<div onclick="totop();"
			style="width: 20px; height: 20px; margin: 135px 10px; cursor: pointer;">
			<img src="index_img/top.png" width="100%" height="100%" />
		</div>
	</div>

	</div>
</body>
</html>

