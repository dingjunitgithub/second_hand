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
//充值
	function paySubmit(){
		var jine = $("#jine").val();
		var id = $("#id").val();
		var kahao = $("#kahao").val();
		var mima = $("#mima").val();
		
		if(jine == ""){
			alert("请输入金额");
			return;
		}
		if(isNaN(jine)){
			alert("金额只能为数字");
			return;
		}
		
		var myprice=/^(0(\.\d{1,2})?|[1-9]\d{0,3}|[1-9]\d{0,3}\.\d{1,2})$/;
		 if(!myprice.test(jine)){
			alert("为了您的账户安全，价格位数最多为四位整数，两位小数哦！");
			return;
		}
		
		if(kahao == ""){
			alert("请输入银行卡号");
			return;
		}
		
		var mykahao=/^(\d{16}|\d{19})$/;
		if(!mykahao.test(kahao)){
			alert("请输入正确的银行卡号，卡号为16或19位数字！");
			return;
		}
		
		if(mima == ""){
			alert("请输入密码");
			return;
		}
		
		var mymima=/^(\d{6})$/;
		if(!mymima.test(mima)){
			alert("密码为六位数字！");
			return;
		}
	
		$.ajax({
			type:'get',
			url:encodeURI("user/user_pay.action?email=<%=email_session_pay%>&paynumber="+jine+"&id="+id),
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
			type:'get',
			url:encodeURI("user/user_findUserByEmail.action?email=<%=email_session_pay %>"),
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
	function showBank(){
		if(document.getElementById("bank").style.display=="none"){
			document.getElementById("bank").style.display="block";
		}else{
			document.getElementById("bank").style.display="none";
		}
	}
</script>
</head>

<body>
			<input type="hidden" id="id" value="${user.userId }"/>
			<div style="width:98%;; height:60px; margin:10px auto; margin-bottom:0px;background-color: #f9f9f9; border:1px solid #f5f5f5; border-bottom:0px;">
            	<div class="navChoose">
                	账户充值
                </div>
    		</div>
          <div style="width:98%; height:600px; margin:0px auto; background-color:#f9f9f9; margin-bottom: 10px;">
           		<table width="100%" style="width:100%;">
                	<tr height="50px">
                    	<td width="280px" align="right"> 账户：</td>
                        <td><input disabled="disabled" style="border-radius:5px; width:300px; height:30px; padding-left:5px;" value="<%=email_session_pay %>" /> </td>
                    </tr>
                  
                    <tr height="50px">
                    	<td width="80px" align="right"> 充值金额：</td>
                        <td><input id="jine" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="￥" /> </td>
                    </tr>
                     <tr height="50px" width="300px">
                    	<td width="80px" align="right"> 银行卡号：</td>
                        <td><input id="kahao" style="border-radius:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入银行卡号" />
                        		<font size="3px;" style="margin-left: 5px;color: red"><span onclick="showBank()">选择支付行</span></font>
                        </td>   
                    </tr>
                    
                    	 <div id="bank"  style="width:250px;height:300px;display:none;float: left;position: absolute;left:950px;top:200px;">
                    		<input name="hang" type="radio" checked="checked" value="1"  style="border-radius:5px; width:20px; height:30px; padding-left:5px;margin: 15px 10px;" /><img src="index_img/gong1.jpg" alt="工行" />
                    		<input name="hang" type="radio"  value="2"  style="border-radius:5px; width:20px; height:30px; padding-left:5px;margin: 15px  10px;" /><img src="index_img/nong1.jpg" alt="农行" />
                    		<input name="hang" type="radio"  value="3"  style="border-radius:5px; width:20px; height:30px; padding-left:5px;margin: 15px 10px;"/><img src="index_img/jian1.jpg" alt="建行" />
                    		<input name="hang" type="radio"  value="4"  style="border-radius:5px; width:20px; height:30px; padding-left:5px;margin: 15px 10px;" /><img src="index_img/zhong1.jpg" alt="中行" />
                    		<input name="hang" type="radio"  value="5"  style="border-radius:5px; width:20px; height:30px; padding-left:5px;margin: 15px 10px;"/><img src="index_img/jiao1.jpg" alt="交行" />

                      </div>
                     <tr height="50px">
                    	<td width="80px" align="right"> 交易密码(模拟与银行联网)：</td>
                        <td><input id="mima" type="password" style="border-radius:5px; padding-left:5px; width:300px; height:30px; padding-left:5px;"  placeholder="请输入交易密码" /> </td>
                    </tr>
                  	<tr height="50px">
                    	<td>
                    	</td>
                    	<td>
                    		<button class="mybutton" style="width:100px;" onclick="paySubmit();" >充值</button>
                    		<button class="mybutton" style="width:100px;" onclick="back();" >返回</button>
                    	</td>
                    </tr>
                    
                </table>
           </div>
            
</body>
</html>

