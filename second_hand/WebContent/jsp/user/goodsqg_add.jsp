<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%
	String email_session_pay = (String)session.getAttribute("email");
%>
<style type="text/css">	
	.goodspic{
		width:128px; height:128px;float:left; position: relative;
	}
	.goodspic_delete{
		width:20px; height:20px; position:absolute;top:0;right:0; cursor: pointer;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">
	function Submit(){
		var goodsname = $("#goodsname").val();
		var address = $("#address").val();
		var price = $("#price").val();
		var phone = $("#phone").val();
		var qq = $("#qq").val();
		var goodsclass = $("#goodsclass").val();
		var goodsmsg = $("#goodsmsg").val();
		
		if(goodsname == ""){
			alert("请输入商品名称");
			return;
		}
		if(address == ""){
			alert("请输入交易地点");
			return;
		}
		
		var myprice=/^(0(\.\d{1,2})?|[1-9]\d{0,3}|[1-9]\d{0,3}\.\d{1,2})$/;
		if(price == ""){
			alert("请输入价格！");
			return;
		}else if(isNaN(price)){
			alert("价格只能为数字！");
			return;
		}else if(!myprice.test(price)){
			alert("价格位数最多为四位整数，两位小数哦！");
			return;
		}
		
		$.ajax({
			type:'post',
			data:{goodsName:goodsname,classId:goodsclass,address:address,price:price,qq:qq,phone:phone,goodsMsg:goodsmsg},
			url:encodeURI('goodsQg/goodsqg_add.action'),
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
			url:encodeURI("goodsQg/goodsqg_toListByUser.action"),
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
			 <div style="width:98%;; height:60px; margin:10px 1% 0px 1%;background-color: #f9f9f9; border:1px solid #f5f5f5; border-bottom:0px;float:left;">
            	<div class="navChoose">
                	发布求购
                </div>
    		</div>
           <div style="width:98%; height:600px; margin:0px auto; background-color:#f9f9f9; margin-bottom: 10px;float:left;">
           		<table width="100%" style="width:100%;" border="0">
           		<tr height="50px">
				<td width="80px" align="right">分类：</td>
				<td><select id="goodsclass"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
						<c:forEach items="${goodsClassList }" var="goodsClass">
							<option value="${goodsClass.classId }">${goodsClass.className }</option>
						</c:forEach>
				</select></td>
			</tr>
                	<tr height="50px">
                    	<td width="380px" align="right"> 商品名称：</td>
                        <td><input id="goodsname" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入商品名称" /> </td>
                    </tr>
                    <tr height="50px">
                    	<td width="380px" align="right"> 求购描述</td>
                        <td><textarea id="goodsmsg" rows="5"
						style="width: 300px; font-size: 12px; border-radius: 5px; padding: 5px 0px 0px 5px;"></textarea></td>
                    </tr>
                    <tr height="50px">
                    	<td width="80px" align="right"> 预交易地点：</td>
                        <td><input id="address" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入交易地点" /> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 价格：</td>
                        <td><input id="price" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入价格" /> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 手机：</td>
                        <td><input id="phone" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入手机号码" value="${user.phone }"/> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> QQ：</td>
                        <td><input id="qq" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入QQ号码" value="${user.qq }"/> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> </td>
                        <td>
                       		<button class="mybutton" style="width:100px;" onclick="Submit();" >求购</button>
                       		<button class="mybutton" style="width:100px;" onclick="back();" >返回</button>
                        </td>
                    </tr>
                </table>
           </div>
         
</body>

</html>

