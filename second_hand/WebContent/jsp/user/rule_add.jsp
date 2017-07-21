<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
        <%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String)session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">
	function ruleSaveSubmit(){
		var ruleName = $("#ruleName").val();
		var ruleValue = $("#ruleValue").val();
		var validTime = $("#validTime").val();
		var fuhaos = document.getElementsByName("fuhao");
		var fuhao="";
		for(var i = 0;i<fuhaos.length;i++){
		if(fuhaos[i].checked==true){
			fuhao=fuhaos[i].value;	}
		}
		if(ruleName == ""){
			alert("请输入积分项目名称");
			return;
		}
		if(ruleValue == ""){
			alert("请输入积分的值");
			return;
		}
		if(validTime == ""){
			alert("请输入有效期限");
			return;
		}

		$.ajax({
			type:'post',
			data:{ruleName:ruleName,ruleValue:ruleValue,validTime:validTime,fuhao:fuhao},
			url:encodeURI('rule/rule_add'),
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
			url:encodeURI("city/city_toList.action"),
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
           <div style="width:98%;; height:60px; margin:10px auto; margin-bottom:0px;background-color: #f9f9f9; border:1px solid #f5f5f5; border-bottom:0px;">
            	<div class="navChoose">
                	添加积分规则
                </div>
    		</div>
           <div style="width:98%; height:300px; margin:0px auto; background-color:#f9f9f9; margin-bottom: 10px;">
           		<table width="100%" style="width:100%;">
                	<tr height="50px">
                    	<td width="280px" align="right">积分项目：</td>
                        <td><input name="rule.ruleName" id="ruleName" style="border-radius:5px; width:300px; height:30px; padding-left:5px;" /> </td>
                    </tr>
                    <tr height="50px">
                    	<td width="280px" align="right">加减规则：</td>
                        <td>加<input name="fuhao" type="radio" checked="checked" value="+"  style="border-radius:5px; width:20px; height:30px; padding-left:5px;" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             	减<input name="fuhao" type="radio" value="-" style="border-radius:5px; width:20px; height:30px; padding-left:5px;" />           
                         </td>
                    </tr>
                    <tr height="50px">
                    	<td width="280px" align="right">分值：</td>
                        <td><input name="rule.ruleValue" id="ruleValue" style="border-radius:5px; width:300px; height:30px; padding-left:5px;" /> </td>
                    </tr>
                    <tr height="50px">
                    	<td width="280px" align="right">有效时间：</td>
                        <td><input name="rule.validTime" id="validTime" style="border-radius:5px; width:300px; height:30px; padding-left:5px;" /> </td>
                    </tr>
                  	<tr height="50px">
                    	<td>
                    	</td>
                    	<td>
                    		<button class="mybutton" style="width:100px;" onclick="ruleSaveSubmit();" >保存</button>
                    		<button class="mybutton" style="width:100px;" onclick="back();" >返回</button>
                    	</td>
                    </tr>
                    
                </table>
           </div>
            
         
</body>
</html>

