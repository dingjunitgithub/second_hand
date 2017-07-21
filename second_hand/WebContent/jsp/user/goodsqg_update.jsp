<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		
		var id = $("#id").val();
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
		if(price == "" || isNaN(price)){
			alert("请输入价格，只能为数字");
			return;
		}
		
		$.ajax({
		    type:'post',
			data:{goodsName:goodsname,classId:goodsclass,address:address,price:price,qq:qq,phone:phone,id:id,goodsMsg:goodsmsg},
			url:encodeURI('goodsQg/goodsqg_update.action'),
		
			beforeSend:function(XMLHttpRequest){
				
			},
			success:function (data, textStatus){
				$("#content").html(data);
			},
			error:function (){
				alert("服务器异常，请联系管理员a！");
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
			<input type="hidden" id="id" value="${goodsQg.goodsQgId}"/>
			 <div style="width:98%;; height:60px; margin:10px 1% 0px 1%;background-color: #f9f9f9; border:1px solid #f5f5f5; border-bottom:0px;float:left;">
            	<div class="navChoose">
                	求购修改
                </div>
    		</div>
           <div style="width:98%; height:600px; margin:0px auto; background-color:#f9f9f9; margin-bottom: 10px;float:left;">
           		<table width="100%" style="width:100%;" border="0">
           		  <tr height="50px">
                    	<td width="80px" align="right"> 分类：</td>
                        <td>
                        	<select id="goodsclass" style="width:300px;border-radius:5px;height:30px;  padding-left:5px; font-size:12px;">
                            	<c:forEach items="${goodsClassList }" var="goodsClass">
                            		<c:choose>
                            			<c:when test="${goodsQg.classes.className == goodsClass.className }">
                            				<option value="${goodsClass.classId }" selected="selected">${goodsClass.className }</option>
                            			</c:when>
                            			<c:otherwise>
                            				<option value="${goodsClass.classId}">${goodsClass.className }</option>
                            			</c:otherwise>
                            		</c:choose>
                            		
                            	</c:forEach>
                            </select>
                        </td>
                    </tr>
                	<tr height="50px">
                    	<td width="380px" align="right"> 商品名称：</td>
                        <td><input id="goodsname" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入商品名称" value="${goodsQg.goodsName }"/> </td>
                    </tr>
                      <tr height="50px">
                    	<td width="380px" align="right"> 求购描述</td>
                        <td><textarea id="goodsmsg" rows="5"
						style="width: 300px; font-size: 12px; border-radius: 5px; padding: 5px 0px 0px 5px;">${goodsQg.goodsMsg}</textarea></td>
                    </tr>
                    <tr height="50px">
                    	<td width="80px" align="right">预交易地点：</td>
                        <td><input id="address" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入交易地点" value="${goodsQg.address}"/> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 价格：</td>
                        <td><input id="price" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入价格" value="${goodsQg.price}" /> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 手机：</td>
                        <td><input id="phone" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入手机号码" value="${goodsQg.phone }"/> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> QQ：</td>
                        <td><input id="qq" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入QQ号码" value="${goodsQg.qq }"/> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> </td>
                        <td>
                       		<button class="mybutton" style="width:100px;" onclick="Submit();" >修改</button>
                       		<button class="mybutton" style="width:100px;" onclick="back();" >返回</button>
                        </td>
                    </tr>
                </table>
           </div>
</body>

</html>

