<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String)session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">
	function updatepasswordSubmit(){
		var password = $("#paypassword").val();
		var newpassword = $("#newpaypassword").val();
		var renewpassword = $("#renewpaypassword").val();
		var id = $("#id").val();
		
		if(password == ""){
			alert("请输入旧密码");
			return;
		}
		if(newpassword == ""){
			alert("请输入新密码");
			return;
		}
		if(renewpassword == ""){
			alert("请确认新密码");
			return;
		}
		if(newpassword != renewpassword){
			alert("两次输入不一致，请重新输入");
			return;
		}
		$.ajax({
			type:'get',
			url:encodeURI("user/user_updatepaypassword.action?id="+id+"&payPassword="+password+"&newPayPassword="+newpassword),
			beforeSend:function(XMLHttpRequest){
				
			},
			success:function (data, textStatus){
				if(data == "ok"){
					location = "index.jsp";
				}else{
					alert("旧密码错误");
				}
			},
			error:function (){
				alert("服务器异常，请联系管理员！");
			}
		});
	}
</script>
</head>

<body>
			<input type="hidden" id="id" value="${user.userId }"/>
			 <div style="width:98%;; height:60px; margin:10px auto; margin-bottom:0px;background-color: #f9f9f9; border:1px solid #f5f5f5; border-bottom:0px;">
            	<div class="navChoose">
                	重设支付密码
                </div>
    		</div>
          <div style="width:98%; height:300px; margin:0px auto; background-color:#f9f9f9; margin-bottom: 10px;">
           		<table width="100%" style="width:100%;">
                	<tr height="50px">
                    	<td width="280px" align="right"> 旧密码（温馨提示：初始密码为000000）：</td>
                        <td><input type="password" id="paypassword" style="border-radius:5px; width:300px; height:30px; padding-left:5px;" placeholder="请输入旧支付密码"/> </td>
                    </tr>
                  
                    <tr height="50px">
                    	<td width="80px" align="right"> 新密码：</td>
                        <td><input type="password"  id="newpaypassword" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入新支付密码" /> </td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 确认新密码：</td>
                        <td><input type="password"  id="renewpaypassword" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请重新输入新支付密码" /> </td>
                    </tr>
                      
                  	<tr height="50px">
                    	<td>
                    	</td>
                    	<td>
                    		<button class="mybutton" style="width:100px;" onclick="updatepasswordSubmit();" >修改</button>
                    		
                    	</td>
                    </tr>
                </table>
           </div>
            
</body>
</html>

