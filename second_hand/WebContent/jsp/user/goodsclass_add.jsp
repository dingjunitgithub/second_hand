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
	function schoolsaveSubmit(){
		var name = $("#name").val();
		
		if(name == ""){
			alert("请输入分类名称");
			return;
		}
		
		$.ajax({
			type:'post',
			data:{className:name},
			url:encodeURI('gClass/goodsclass_add.action'),

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
			url:encodeURI("goodsclass_toList.action"),
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
                	添加商品类别
                </div>
    		</div>
           <div style="width:98%; height:300px; margin:0px auto; background-color:#f9f9f9; margin-bottom: 10px;">
           		<table width="100%" style="width:100%;">
                	<tr height="50px">
                    	<td width="280px" align="right">分类名称：</td>
                        <td><input id="name" style="border-radius:5px; width:300px; height:30px; padding-left:5px;" /> </td>
                    </tr>
                  	<tr height="50px">
                    	<td>
                    	</td>
                    	<td>
                    		<button class="mybutton" style="width:100px;" onclick="schoolsaveSubmit();" >保存</button>
                    		<button class="mybutton" style="width:100px;" onclick="back();" >返回</button>
                    	</td>
                    </tr>
                    
                </table>
           </div>
            
</body>
</html>

