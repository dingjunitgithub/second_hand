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
function test(){
	var cityId= document.getElementById("city").value; 
	  $("#schoolInfo").html("");
		var params = null;
		$.ajax({
			        url:"school/findSchool!findSchoolByCityId?city.cityId="+cityId,
					// 数据发送方式
					type : 'POST',
					// 接受数据格式
					dataType : "json",
					// 要传递的数据
					data : params,
					// 回调函数，接受服务器端返回给客户端的值，即result值
					success : function show(data) {
						var json = eval("(" + data + ")");
						var str ="";

						str+="<select name='depart.school.schoolId' id='school' style='width:300px;border-radius:5px;height:30px;padding-left:5px; font-size:12px'>";
			
						$.each(json, function(index, item) {
						str+="<option value="+item.schoolId+">"+item.schoolName+"</option>";
						
						});
						str+="</select>";
		
						
						$("#schoolInfo").append(str); 
					},
					error : function(xhr) {
						alert('select出错。。\n' + xhr.responseText);
					}
				}); 
}
	function schoolsaveSubmit(){
		var name = $("#departName").val();
		var schoolId = document.getElementById("school").value;
		if(name == ""){
			alert("请输入院系");
			return;
		}
		
		$.ajax({
			type:'post',
			data:{departName:name,schoolId:schoolId},
			url:encodeURI('depart/depart_addDepart.action'),
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
			url:encodeURI("depart/depart_toList.action"),
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
                	添加院系
                </div>
    		</div>
           <div style="width:98%; height:300px; margin:0px auto; background-color:#f9f9f9; margin-bottom: 10px;">
           		<table width="100%" style="width:100%;">
                	<tr height="50px">
                    	<td width="280px" align="right">城市名称：</td>
                        <td><select name="school.city.cityId" id="city" style="width:300px;border-radius:5px;height:30px;  padding-left:5px; font-size:12px;" onchange="test()">
                            	<c:forEach items="${cityList}" var="city">
                            		<option value="${city.cityId}">${city.cityName}</option>
                            	</c:forEach>
                            </select></td>
                    </tr>
                    <tr height="50px">
                    	<td width="280px" align="right">学校名称：</td>
                        <td><div id="schoolInfo">
<select name="depart.school.schoolId" id="school" style="width:300px;border-radius:5px;height:30px;  padding-left:5px; font-size:12px;">
                            	<c:forEach items="${schoolList}" var="school">
                            		<option value="${school.schoolId}">${school.schoolName}</option>
                            	</c:forEach>
</select>
</div></td>
                    </tr>
                  
                   <tr height="50px">
                    	<td width="280px" align="right">院系名称：</td>
                        <td><input id="departName" style="border-radius:5px; width:300px; height:30px; padding-left:5px;" /> </td>
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

