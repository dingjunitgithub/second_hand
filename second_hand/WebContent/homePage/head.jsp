<%@page import="com.second_hand.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email = (String) session.getAttribute("email");
	String userType = (String) session.getAttribute("userType");
	String nickname = (String) session.getAttribute("nickname");
	String lv = (String) session.getAttribute("lv");
	String cityName = (String) session.getAttribute("cityName");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="../css/common.css" />
<style>
#over_div {
	background-color: #000000;
	width: 100%;
	height: 100%;
	left: 0;
	top: 0; /*FF IE7*/
	filter: alpha(opacity =        60); /*IE*/
	opacity: 0.6; /*FF*/
	z-index: 1;
	position: fixed !important; /*FF IE7*/
	position: absolute; /*IE6*/
	_top: expression(eval(document.compatMode &&        
	 document.compatMode ==        'CSS1Compat')?        
	documentElement.scrollTop+         (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		 /*IE6*/        
	document.body.scrollTop+         (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}

#login_div {
	/*border:2px solid #06F;*/
	background-color: #3f495b;
	z-index: 2;
	border: 1px solid #3f495b;
	width: 300px;
	height: 400px;
	left: 61%; /*FF IE7*/
	top: 40%; /*FF IE7*/
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
	 document.compatMode ==        'CSS1Compat')?        
	documentElement.scrollTop+         (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		 /*IE6*/        
	document.body.scrollTop+         (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}

#sugg_div {
	/*border:2px solid #06F;*/
	background-color: #3f495b;
	z-index: 2;
	border: 1px solid #3f495b;
	width: 300px;
	height: 400px;
	left: 61%; /*FF IE7*/
	top: 40%; /*FF IE7*/
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
	 document.compatMode ==        'CSS1Compat')?        
	documentElement.scrollTop+         (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		 /*IE6*/        
	document.body.scrollTop+         (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}

#rule {
	/*border:2px solid #06F;*/
	background-color: #3f495b;
	z-index: 2;
	border: 1px solid #3f495b;
	width: 300px;
	height: 400px;
	left: 61%; /*FF IE7*/
	top: 40%; /*FF IE7*/
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
	 document.compatMode ==        'CSS1Compat')?        
	documentElement.scrollTop+         (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		 /*IE6*/        
	document.body.scrollTop+         (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}

#level {
	/*border:2px solid #06F;*/
	background-color: #3f495b;
	z-index: 2;
	border: 1px solid #3f495b;
	width: 300px;
	height: 400px;
	left: 61%; /*FF IE7*/
	top: 40%; /*FF IE7*/
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
	 document.compatMode ==        'CSS1Compat')?        
	documentElement.scrollTop+         (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		 /*IE6*/        
	document.body.scrollTop+         (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}

#regedit_div {
	/*border:2px solid #06F;*/
	background-color: #3f495b;
	z-index: 2;
	border: 1px solid #3f495b;
	width: 300px;
	height: 400px;
	left: 61%; /*FF IE7*/
	top: 40%; /*FF IE7*/
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
	 document.compatMode ==        'CSS1Compat')?        
	documentElement.scrollTop+         (document.documentElement.clientHeight-this.offsetHeight)/2:
		
		 /*IE6*/        
	document.body.scrollTop+         (document.body.clientHeight-
		this.clientHeight)/2);
	/*IE5 IE5.5*/
}
</style>
<script type="text/javascript" language="javascript">
	function login_div_open() {
		$("#login_div").css("display", "");
		$("#over_div").css("display", "");
	}
	function login_div_close() {
		$("#login_div").css("display", "none");
		$("#over_div").css("display", "none");
	}
	function regedit_div_open() {
		$("#regedit_div").css("display", "");
		$("#over_div").css("display", "");
	}
	function regedit_div_close() {
		$("#regedit_div").css("display", "none");
		$("#over_div").css("display", "none");
	}
	function sugg_div_open() {
		$("#sugg_div").css("display", "");
		$("#over_div").css("display", "");
	}
	function sugg_div_close() {
		$("#sugg_div").css("display", "none");
		$("#over_div").css("display", "none");
	}

	//积分规则
	function rule_div_open() {
		$("#rule").css("display", "block");
		$("#rule").html("");
		var params = null;
		$
				.ajax({
					url : "rule/rule_list.action",
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
						str += "<div style='width: 120px; height: 50px; margin: 30px 90px; float: left;'>";
						str += "<h2 style='color: white; font-size: 18px;'>积分规则</h2>";
						str += "</div>";
						str += "<div style='width: 300px; height: 260px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left;'>";
						str += "<table>";
						str += "<thead>";
						str += "<tr>";
						str += "<td width='130px'>项目</td>";
						str += "<td width='70px'>加分</td>";
						str += "<td width='100px'>有效时间</td>";
						str += "</tr>";
						str += "</thead>";
						str += "<tbody>";

						$.each(json, function(index, item) {

							str += "<tr>";
							str += "<td>" + item.ruleName + "</td>";
							str += "<td>" + item.ruleValue + "</td>";
							str += "<td>" + item.validTime + "</td>";
							str += "</tr>";
						});

						str += "</tbody>";
						str += "</table>";
						str += "</div>";
						str += "<div style='width: 24px; height: 24px; position: absolute; top: 0; right: 0; margin: 5px; cursor: pointer;' onclick='rule_div_close();'>";
						str += "<img width='100%' height='100%' src='index_img/close_login.png' />";
						str += "</div>";

						$("#rule").append(str);
					},
					error : function(xhr) {
						alert('select出错。。\n' + xhr.responseText);
					}
				});
	}
	function rule_div_close() {
		$("#rule").css("display", "none");
		$("#over_div").css("display", "none");
	}
	function level_div_open() {
		$("#level").css("display", "");
		$("#over_div").css("display", "");
	}
	function level_div_close() {
		$("#level").css("display", "none");
		$("#over_div").css("display", "none");
	}

	function getStyle(obj, name) {
		if (obj.currentStyle) {
			return obj.currentStyle[name];
		} else {
			return getComputedStyle(obj, false)[name];
		}
	};

	function startMove(obj, json, fnEnd) {
		clearInterval(obj.timer);
		obj.timer = setInterval(function() {
			var bStop = true; //假设：所有值都已经到了
			for ( var attr in json) {
				var cur = 0;
				if (attr == 'opacity') {
					cur = Math.round(parseFloat(getStyle(obj, attr)) * 100);
				} else {
					cur = parseInt(getStyle(obj, attr));
				}
				var speed = (json[attr] - cur) / 6;
				speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);

				if (cur != json[attr]) {
					bStop = false;
				}
				if (attr == 'opacity') {
					obj.style.filter = 'alpha(opacity:' + (cur + speed) + ')';
					obj.style.opacity = (cur + speed) / 100;
				} else {
					obj.style[attr] = cur + speed + 'px';
				}
			}
			if (bStop) {
				clearInterval(obj.timer);
				if (fnEnd)
					fnEnd();
			}
		}, 30);
	};

	//上导航栏的事件
	//个人中心
	$(function() {
		$("#users").mouseover(function() {
			var oeditdiv = $("#users_hidden").get(0);
			$("#users_img").attr("src", "index_img/jiantou_1.png");
			startMove(oeditdiv, {
				height : 94
			});
		});
		$("#users").mouseout(function() {
			var oeditdiv = $("#users_hidden").get(0);
			$("#users_img").attr("src", "index_img/jiantou.png");
			startMove(oeditdiv, {
				height : 0
			});
		});
	});
	//我的发布
	$(function() {
		$("#wdfb").mouseover(function() {
			var oeditdiv = $("#wdfb_hidden").get(0);
			$("#wdfb_img").attr("src", "index_img/jiantou_1.png");
			startMove(oeditdiv, {
				height : 32
			});
		});
		$("#wdfb").mouseout(function() {
			var oeditdiv = $("#wdfb_hidden").get(0);
			$("#wdfb_img").attr("src", "index_img/jiantou.png");
			startMove(oeditdiv, {
				height : 0
			});
		});
	});
	//我的求购
	$(function() {
		$("#wdqg").mouseover(function() {
			var oeditdiv = $("#wdqg_hidden").get(0);
			$("#wdqg_img").attr("src", "index_img/jiantou_1.png");
			startMove(oeditdiv, {
				height : 32
			});
		});
		$("#wdqg").mouseout(function() {
			var oeditdiv = $("#wdqg_hidden").get(0);
			$("#wdqg_img").attr("src", "index_img/jiantou.png");
			startMove(oeditdiv, {
				height : 0
			});
		});
	});

	//我的订单
	$(function() {
		$("#wdorder").mouseover(function() {
			var oeditdiv = $("#wdorder_hidden").get(0);
			$("#wdorder_img").attr("src", "index_img/jiantou_1.png");
			startMove(oeditdiv, {
				height : 64
			});
		});
		$("#wdorder").mouseout(function() {
			var oeditdiv = $("#wdorder_hidden").get(0);
			$("#wdorder_img").attr("src", "index_img/jiantou.png");
			startMove(oeditdiv, {
				height : 0
			});
		});
	});

	//网站导航
	$(function() {
		$("#wzdh").mouseover(function() {
			var oeditdiv = $("#wzdh_hidden").get(0);
			$("#wzdh_img").attr("src", "index_img/jiantou_1.png");
			startMove(oeditdiv, {
				height : 160
			});
		});
		$("#wzdh").mouseout(function() {
			var oeditdiv = $("#wzdh_hidden").get(0);
			$("#wzdh_img").attr("src", "index_img/jiantou.png");
			startMove(oeditdiv, {
				height : 0
			});
		});
	});

	//注册
	function regedit() {
		var nickname = $("#nickname1").val();
		if (nickname == "") {
			alert("昵称不能为空！");
			return;
		}
		var email = $("#register_email").val();
		if (email == "") {
			alert("邮箱不能为空！");
			return;
		}
		var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		if (!myreg.test(email)) {
			alert('请输入有效的E_mail！');
			return;
		}
		var password = $("#password").val();
		if (password == "") {
			alert("密码不能为空！");
			return;
		}
		if (password.length < 6) {
			alert("密码长度不能小于6位！");
			return;
		}
		var repassword = $("#repassword").val();//第二次输入密码
		if (repassword != password) {
			alert("两次密码输入不一致，请重新输入！");
			return;
		}

		$
				.ajax({
					type : 'post',
					data : {
						email : email,
						nickname : nickname,
						password : password
					},
					url : encodeURI('user/addAction!addUser'),
					beforeSend : function(XMLHttpRequest) {
						$("#regedit_submit")
								.html(
										'<img width="100%" height="100%" src="index_img/loading.png"/>');
					},
					success : function(data, textStatus) {
						if (data == "success") {
							alert("恭喜您注册成功！");
							$("#regedit_div").css("display", "none");
							$("#over_div").css("display", "none");
							$("#login_div").css("display", "");
							$("#over_div").css("display", "");
						} else if (data == "username_exist") {
							alert("改邮箱已经被注册！");
						} else if (data == "unsuccess") {
							alert("注册失败，请联系管理员！");
						}
						$("#regedit_submit")
								.html(
										'<img width="100%" height="100%" src="index_img/regedit.png"/>');
					},
					error : function() {
						alert("服务器异常，请联系管理员！");
					}
				});
	};
	//网站建议及意见
	function sugg() {
		var sugg = $("#mysugg").val();
		if (sugg == "") {
			alert("请输入您的建议！");
			return;
		}
		$
				.ajax({
					type : 'post',
					data : {
						content : sugg
					},
					url : encodeURI('suggest/sugg_add.action'),
					beforeSend : function(XMLHttpRequest) {
						$("#sugg_submit")
								.html(
										'<img width="100%" height="100%" src="index_img/loading.png"/>');
					},
					success : function(data, textStatus) {
						$("#sugg_div").css("display", "none");
						$("#over_div").css("display", "none");
						alert("提交成功！");
					},
					error : function() {
						alert("服务器异常，请联系管理员！");
					}
				});
	}

	//登录
	function tologin() {
		var email = $("#login_email").val();
		if (email == "") {
			alert("邮箱不能为空！");
			return;
		}
		var password = $("#login_password").val();
		if (password == "") {
			alert("密码不能为空！");
			return;
		}
		$
				.ajax({
					url : "user/loginAction!userLogin?user.email=" + email
							+ "&user.password=" + password,
					type : 'post',
					beforeSend : function(XMLHttpRequest) {
						$("#login_submit")
								.html(
										'<img width="100%" height="100%" src="index_img/loading.png"/>');
					},
					success : function(data, textStatus) {
						if (data == "success") {
							location = 'index/index!toIndexPage';

						} else if (data == "unsuccess") {
							alert("登录失败，请检查邮箱和密码，重新登录！");
							$("#login_submit")
									.html(
											'<img width="100%" height="100%" src="index_img/login.png"/>');
						}
					},
					error : function() {
						alert("服务器异常，请联系管理员！");
					}
				});
	}

	//退出登录
	function login_out() {
		location = "user/loginOutAction!userOutLogin";
	}

	//没有账号 请注册
	function no_user_regedit() {
		$("#login_div").css("display", "none");
		$("#over_div").css("display", "none");
		$("#regedit_div").css("display", "");
		$("#over_div").css("display", "");
	}

	//转让商品关键字搜索
	function submitSearch() {
		var keyword = $("#keyword").val();
		$.ajax({
			type : 'post',
			data : {
				keyword : keyword
			},
			url : encodeURI('goodsZr/noint_goodszr_indexSearch.action'),
			beforeSend : function(XMLHttpRequest) {
			},
			success : function(data, textStatus) {
				$("#goodszrlist").html(data);
				$(document).scrollTop(600);
			},
			error : function() {
			}
		});
	}

	$(function() {
		document.onkeydown = function(e) {
			var ev = document.all ? window.event : e;
			if (ev.keyCode == 13) {
				submitSearch();
			}
		}
	});

	/* 购物车数量,在购物车上的图标是通过方法直接取出来的*/
	$(function() {
		$.ajax({
			type : 'post',
			url : encodeURI('cart/noint_cart_getCartNum.action'),
			beforeSend : function(XMLHttpRequest) {

			},
			success : function(data, textStatus) {
				$("#cartNum").html(data);
			},
			error : function() {
				alert("errorr");
			}
		});
	});
</script>
</head>
<body>
	<!-- 最上面的导航栏 -->
	<!-- 上导航栏左侧	 -->
	<div style="width: 100%; height: 30px; background-color: #f1f1f1;">
		<div style="width: 1200px; height: 30px; margin: 0px auto;">
			<%
				if (StringUtil.notNull(email)) {//用户已经登录
			%>
			<div style="width: 20px; height: 20px; margin: 4px 0px; float: left;">

				<c:if test="${session.user.photoUrl != null }">
					<img width="100%" height="100%"
						src="userImg${fn:substringAfter(session.user.photoUrl, 'userImg')}" />
				</c:if>
				<c:if test="${user.photoUrl == null }">
					<img src="index_img/user-blue.png" width="100%" height="100%" />
				</c:if>
			</div>
			<div id="users"
				style="min-width: 20px; position: relative; height: 30px; line-height: 30px; float: left; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
				<%=nickname%>
				<div id="users_hidden"
					style="width: 100px; height: 0px; overflow: hidden; position: absolute; top: 29px; left: -20px; background-color: #f5f5f5; border-radius: 3px;">
					<%
						if (!"1".equals(userType)) {
					%>

					<div onclick="window.open('index_manage.jsp?tag=user_center')"
						style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						个人中心</div>
					<%
						} else {
					%>
					<div onclick="window.open('index_manage.jsp?tag=usermanage')"
						style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						后台管理</div>
					<%
						}
					%>

					<div style="width: 100%; height: 1px; background-color: #f1f1f1;">

					</div>
					<div
						onclick="window.open('index_manage.jsp?tag=user_updatepassword')"
						style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						修改密码</div>
					<div style="width: 100%; height: 1px; background-color: #f1f1f1;">

					</div>
					<div onclick="login_out();"
						style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						退出登录</div>
				</div>
			</div>
			<div
				style="width: 10px; height: 10px; float: left; margin: 10px 5px;">
				<img id="users_img" src="index_img/jiantou.png" width="100%"
					height="100%" />
			</div>
			<%
				if (!"1".equals(userType)) {
			%>
			<div id="users"
				style="min-width: 20px; height: 30px; line-height: 30px; float: left; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
				等级：<a onclick="level_div_open()"><%=lv%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
					onclick="rule_div_open()">积分规则</a>
			</div>
			<div
				style="width: 150px; text-align: center; height: 30px; line-height: 30px; float: left; font-size: 12px; color: #666666; cursor: pointer; margin-left: 5px;">
				您当前所在城市：<%=cityName%>
			</div>
			<div
				style="width: 150px; text-align: center; height: 30px; line-height: 30px; float: left; font-size: 12px; color: #666666; cursor: pointer; margin-left: 5px;">
				<a href="index_city.jsp">切换城市</a>
			</div>
			<%
				}
			%>

			<%
				} else {//用户没有登录
			%>
			<div
				style="width: 90px; text-align: center; height: 30px; line-height: 30px; float: left; font-size: 12px; color: #666666; cursor: pointer; margin-left: 5px;"
				onclick="login_div_open();">亲，请登录！</div>
			<div
				style="width: 60px; text-align: center; height: 30px; line-height: 30px; float: left; font-size: 12px; color: #666666; cursor: pointer; margin-left: 5px;"
				onclick="regedit_div_open();">免费注册</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div
				style="width: 150px; text-align: center; height: 30px; line-height: 30px; float: left; font-size: 12px; color: #666666; cursor: pointer; margin-left: 5px;">
				您当前所在城市：<%=cityName%>
			</div>
			<div
				style="width: 150px; text-align: center; height: 30px; line-height: 30px; float: left; font-size: 12px; color: #666666; cursor: pointer; margin-left: 5px;">
				<a href="index_city.jsp">切换城市</a>
			</div>
			<%
				}
			%>
			<%
				if (!"1".equals(userType)) {
			%>
			<span style="float: right;"> <%
 	} else {
 %> <span style="float: right; display: none"> <%
 	}
 %> <!-- 上导航栏右侧 -->
					<div onclick="location='index/index!toIndexPage'"
						style="min-width: 20px; position: relative; height: 30px; line-height: 30px; float: left; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						首页</div>
					<div
						style="width: 1px; height: 14px; float: left; margin: 8px 8px; background-color: #dddddd">
					</div>
					<div id="wdfb"
						style="min-width: 20px; position: relative; height: 30px; line-height: 30px; float: left; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						我的发布
						<div id="wdfb_hidden"
							style="width: 80px; overflow: hidden; height: 0px; position: absolute; top: 29px; left: -8px; background-color: #f5f5f5; border-radius: 3px;">
							<div onclick="window.open('index_manage.jsp?tag=myfb')"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								我的发布</div>

						</div>
					</div>
					<div
						style="width: 10px; height: 10px; float: left; margin: 10px 5px;">
						<img id="wdfb_img" src="index_img/jiantou.png" width="100%"
							height="100%" />

					</div>
					<div
						style="width: 1px; height: 14px; float: left; margin: 8px 8px; background-color: #dddddd">
					</div>
					<div id="wdqg"
						style="min-width: 20px; height: 30px; line-height: 30px; float: left; position: relative; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						我的求购
						<div id="wdqg_hidden"
							style="width: 80px; height: 0px; overflow: hidden; position: absolute; top: 29px; left: -8px; background-color: #f5f5f5; border-radius: 3px;">
							<div onclick="window.open('index_manage.jsp?tag=myqg');"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								我的求购</div>

						</div>
					</div>
					<div
						style="width: 10px; height: 10px; float: left; margin: 10px 5px;">
						<img id="wdqg_img" src="index_img/jiantou.png" width="100%"
							height="100%" />


					</div>
					<div
						style="width: 1px; height: 14px; float: left; margin: 8px 8px; background-color: #dddddd">
					</div>


					<div id="wdorder"
						style="min-width: 20px; height: 30px; line-height: 30px; float: left; position: relative; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						我的订单
						<div id="wdorder_hidden"
							style="width: 80px; height: 0px; overflow: hidden; position: absolute; top: 29px; left: -8px; background-color: #f5f5f5; border-radius: 3px;">
							<div onclick="window.open('index_manage.jsp?tag=myordersale');"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								我的出售</div>
							<div onclick="window.open('index_manage.jsp?tag=myorderbuy');"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								我的购买</div>

						</div>
					</div>
					<div
						style="width: 10px; height: 10px; float: left; margin: 10px 5px;">
						<img id="wdorder_img" src="index_img/jiantou.png" width="100%"
							height="100%" />


					</div>
					<div
						style="width: 1px; height: 14px; float: left; margin: 8px 8px; background-color: #dddddd">
					</div>

					<div onclick="sugg_div_open();"
						style="min-width: 20px; height: 30px; line-height: 30px; float: left; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						网站建议</div> <!-- 网站建议开始 -->
					<div id="sugg_div" style="display: none; position: relative;">
						<div
							style="width: 120px; height: 120px; margin: 30px 90px; float: left;">
							<img width="100%" height="100%" src="index_img/sugg.png" />
						</div>
						<div
							style="width: 300px; height: 200px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left;">
							<table width="100%" height="100%">
								<tr>
									<td align="right" width="50px">建议：</td>
									<td><textarea id="mysugg" rows="10" cols="27"></textarea>
									</td>
								</tr>

							</table>
						</div>
						<div
							style="width: 300px; height: 80px; background-color: #4bc0a5; float: left;">
							<div id="sugg_submit"
								style="width: 270px; height: 50px; margin: 15px 15px; cursor: pointer;"
								onclick="sugg();">
								<img width="100%" height="100%" src="index_img/sugsubmit.png" />
							</div>
						</div>

						<div
							style="width: 24px; height: 24px; position: absolute; top: 0; right: 0; margin: 5px; cursor: pointer;"
							onclick="sugg_div_close();">
							<img width="100%" height="100%" src="index_img/close_login.png" />
						</div>

					</div> <!-- 网站建议结束 -->
					<div id="rule" style="display: none; position: relative;"></div>
					<div id="level" style="display: none; position: relative;">
						<div
							style="width: 120px; height: 50px; margin: 30px 90px; float: left;">
							<h2 style="color: white; font-size: 18px;">等级规则</h2>
						</div>
						<div
							style="width: 300px; height: 260px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left;">
							<table>
								<thead>
									<tr>
										<td width="300px">积分范围</td>
										<td width="70px">等级</td>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td>0-50</td>
										<td>lv1</td>

									</tr>

									<tr>
										<td>51-100</td>
										<td>lv2</td>
									</tr>
									<tr>
										<td>101-200</td>
										<td>lv3</td>
									</tr>
									<tr>
										<td>201-300</td>
										<td>lv4</td>
									</tr>
									<tr>
										<td>301-500</td>
										<td>lv5</td>
									</tr>



								</tbody>
							</table>
						</div>
						<div
							style="width: 24px; height: 24px; position: absolute; top: 0; right: 0; margin: 5px; cursor: pointer;"
							onclick="level_div_close();">
							<img width="100%" height="100%" src="index_img/close_login.png" />
						</div>
					</div>
					<div
						style="width: 1px; height: 14px; float: left; margin: 8px 8px; background-color: #dddddd">
					</div>
					<div id="wzdh"
						style="min-width: 20px; height: 30px; line-height: 30px; float: left; position: relative; margin-left: 5px; font-size: 12px; color: #666666; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
						网站导航
						<div id="wzdh_hidden"
							style="width: 80px; height: 0px; overflow: hidden; position: absolute; top: 29px; left: -8px; background-color: #f5f5f5; border-radius: 3px;">
							<div onclick="window.open('http://www.jd.com/')"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								京东</div>
							<div style="width: 100%; height: 1px; background-color: #f1f1f1;">

							</div>
							<div onclick="window.open('https://www.tmall.com')"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								天猫</div>
							<div style="width: 100%; height: 1px; background-color: #f1f1f1;">

							</div>
							<div onclick="window.open('https://www.taobao.com/')"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								淘宝</div>
							<div style="width: 100%; height: 1px; background-color: #f1f1f1;">

							</div>
							<div onclick="window.open('http://www.amazon.cn/')"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								亚马逊</div>
							<div style="width: 100%; height: 1px; background-color: #f1f1f1;">

							</div>
							<div onclick="window.open('http://www.suning.com/')"
								style="width: 100%; height: 30px; line-height: 30px; text-align: center; font-size: 12px; font-family: 'MS Serif', 'New York', serif; cursor: pointer;">
								苏宁易购</div>

						</div>
					</div>
					<div
						style="width: 10px; height: 10px; float: left; margin: 10px 5px;">
						<img id="wzdh_img" src="index_img/jiantou.png" width="100%"
							height="100%" />

					</div>
			</span>
		</div>
	</div>

	<!-- 网站logo一行开始-->
	<div style="height: 120px; width: 1200px; margin: 0px auto;">
		<div style="width: 1200px; height: 120px; margin: 0px auto;">
			<!-- 网站logo开始-->
			<div style="width: 250px; height: 120px; float: left;">
				<div onclick="location='index.jsp'"
					style="cursor: pointer; width: 200px; height: 80px; margin: 20px 0px;">
					<img src="index_img/logo.png" width="238px" height="90px" />
				</div>
			</div>
			<!-- 网站logo结束-->
			<!-- 转让商品关键字搜索开始-->
			<div style="width: 750px; height: 120px; float: left;">
				<div
					style="width: 630px; height: 34px; float: left; margin-top: 43px;">
					<input id="keyword"
						style="width: 621px; height: 34px; border: 2px solid #cccccc; padding-left: 5px; font-size: 14px"
						placeholder="搜索你想要的商品" />
				</div>
				<div
					style="width: 120px; height: 340px; margin-top: 43px; float: left;"
					onclick="submitSearch();">
					<input type="button"
						style="width: 120px; height: 38px; cursor: pointer; background-color: #cccccc; border: 1px; border-color: #2cb2ff; font-family: Microsoft YaHei; font-size: 15px; color: #FFFFFF;"
						value="搜 索 一 下" />
				</div>
			</div>
			<!-- 转让商品关键字搜索结束-->

			<!-- 购物车小图片带气泡开始-->
			<div
				style="width: 200px; height: 120px; float: left; cursor: pointer;"
				onclick="window.open('index_manage.jsp?tag=cart')">
				<div
					style="width: 50px; height: 50px; margin: 35px 75px; position: relative;">
					<img src="index_img/empty-shopping-cart.png" width="100%"
						height="100%" />
					<div id="cartNum"
						style="width: 30px; height: 25px; position: absolute; left: 40px; top: -10px; background-image: url(index_img/qipao.png); line-height: 17px; text-align: center; color: #ffffff; font-size: 12px; font-weight: bolder;">
					</div>
				</div>
			</div>
			<!-- 购物车小图片带气泡结束-->
		</div>

	</div>
	<!-- 网站logo一行结束-->

	<div id="over_div" style="display: none;"></div>
	<!-- 登录开始 -->
	<div id="login_div" style="display: none; position: relative;">
		<div
			style="width: 120px; height: 120px; margin: 30px 90px; float: left;">
			<img width="100%" height="100%" src="index_img/user.png" />
		</div>
		<div
			style="width: 300px; height: 100px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left;">
			<table width="100%" height="100%">
				<tr>
					<td align="right" width="60px">邮箱：</td>
					<td><input id="login_email"
						style="width: 200px; height: 30px; padding-left: 5px; font-size: 12px"
						placeholder="请在此输入邮箱" value="751653796@qq.com" /></td>
				</tr>
				<tr>
					<td align="right">密码：</td>
					<td><input id="login_password" type="password"
						style="width: 200px; height: 30px; padding-left: 5px; font-size: 12px"
						placeholder="请在此输入密码" value="" /></td>
				</tr>
			</table>
		</div>
		<div
			style="width: 300px; height: 80px; background-color: #4bc0a5; float: left;">
			<div id="login_submit" onclick="tologin();"
				style="width: 270px; height: 50px; margin: 15px 15px; cursor: pointer;">
				<img width="100%" height="100%" src="index_img/login.png" />
			</div>
		</div>
		<div onclick="no_user_regedit();"
			style="width: 300px; cursor: pointer; height: 50px; background-color: #4bc0a5; float: left; text-align: center; color: #ffffff; line-height: 50px;">
			没有账号？请注册</div>
		<div
			style="width: 24px; height: 24px; position: absolute; top: 0; right: 0; margin: 5px; cursor: pointer;"
			onclick="login_div_close();">
			<img width="100%" height="100%" src="index_img/close_login.png" />
		</div>
	</div>
	<!-- 登录结束 -->

	<!-- 注册开始 -->
	<div id="regedit_div" style="display: none; position: relative;">
		<div
			style="width: 120px; height: 120px; margin: 30px 90px; float: left;">
			<img width="100%" height="100%" src="index_img/user.png" />
		</div>
		<div
			style="width: 300px; height: 200px; color: #ffffff; font-size: 14px; background-color: #4bc0a5; float: left;">
			<table width="100%" height="100%">
				<tr>
					<td align="right" width="80px">昵称：</td>
					<td><input id="nickname1"
						style="width: 180px; height: 30px; padding-left: 5px; font-size: 12px"
						placeholder="请在此输入昵称" /></td>
				</tr>
				<tr>
					<td align="right">邮箱：</td>
					<td><input id="register_email"
						style="width: 180px; height: 30px; padding-left: 5px; font-size: 12px"
						placeholder="请在此输入邮箱" /></td>
				</tr>
				<tr>
					<td align="right">密码：</td>
					<td><input id="password" type="password"
						style="width: 180px; height: 30px; padding-left: 5px; font-size: 12px"
						placeholder="请在此输入密码" /></td>
				</tr>
				<tr>
					<td align="right">确认密码：</td>
					<td><input id="repassword" type="password"
						style="width: 180px; height: 30px; padding-left: 5px; font-size: 12px"
						placeholder="请在此输入密码" /></td>
				</tr>
			</table>
		</div>
		<div
			style="width: 300px; height: 80px; background-color: #4bc0a5; float: left;">
			<div id="regedit_submit"
				style="width: 270px; height: 50px; margin: 15px 15px; cursor: pointer;"
				onclick="regedit();">
				<img width="100%" height="100%" src="index_img/regedit.png" />
			</div>
		</div>

		<div
			style="width: 24px; height: 24px; position: absolute; top: 0; right: 0; margin: 5px; cursor: pointer;"
			onclick="regedit_div_close();">
			<img width="100%" height="100%" src="index_img/close_login.png" />
		</div>

	</div>
	<!-- 注册结束 -->
</body>
</html>


