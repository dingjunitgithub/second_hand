<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String email_session_pay = (String)session.getAttribute("email");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" language="javascript">
	function toadd(){
		$.ajax({
			type:'post',
			url:encodeURI("depart/depart_toAdd.action"),
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
	function schooltoupdate(id){
		$.ajax({
			type:'get',
			url:encodeURI("depart/depart_toUpdate.action?departId="+id),
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
	function schooltodelete(id){
		$.ajax({
			type:'get',
			url:encodeURI("depart/depart_delete.action?departId="+id),
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
	function shangPage(){
		$.ajax({
			type:'get',
			url:encodeURI("depart/depart_toList.action?page=${page-1}"),
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
	function nextPage(){
		$.ajax({
			type:'get',
			url:encodeURI("depart/depart_toList.action?page=${page+1}"),
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
	function jump(){
		var jumppage = $("#jumppage").val();
		var max = $("#max").val();
		if(isNaN(jumppage)){
			alert("页码为数字！");
			return;
		}
		if(parseInt(jumppage)<1){
			alert("您输入的页码不存在！");
			return;
		}
		if(parseInt(jumppage)>parseInt(max)){
			alert("超过最大页数，最大页数为"+max);
			return;
		}
		$.ajax({
			type:'get',
			url:encodeURI("depart/depart_toList.action?page="+jumppage),
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
                	院系管理
                </div>
                <div style="width:30px; height:30px; float:right;margin:15px;cursor: pointer;" onclick="toadd();">
                	 <img src="index_img/add_button.png" width="100%" height="100%"  />
                </div>
    		</div>
           <div style="width:98%; height:510px; margin:0px auto; background-color:#ffffff;">
           		<table width="100%" border="0">
                	<tr height="40px" align="center" bgcolor="#f5f5f5">
                    	<td width="50px">序号</td>
                        <td width="200px">院系名称</td>
                        <td>对应学校</td>
                        <td>对应城市</td>
                        <td width="70px">操作</td>
                    </tr>
                    <c:forEach items="${departList}" var="depart" varStatus="status">
                    	<tr height="30px" align="center" >
                    	<td>${status.count }</td>
                        <td>${depart.facultyName }</td>
                        <td>${depart.school.schoolName }</td>
                        <td>${depart.school.city.cityName }</td>
                        <td>
	                        <div style="width:20px; height:20px;float:left; cursor: pointer;margin-left:10px;">
	                        	 <img src="index_img/update_button.png" width="100%" height="100%"  onclick="schooltoupdate('${depart.departId}');"/>
	                        </div>
	                         <div style="width:20px; height:20px;float:left;cursor: pointer;margin-left:10px;">
	                        	 <img src="index_img/delete_button.png" width="100%" height="100%"  onclick="schooltodelete('${depart.departId}');"/>
	                        </div>
                        </td>
	                    </tr>
	                    <tr>
	                    	<td colspan="4">
	                        	<div style="width:100%; height:1px; background-color:#f5f5f5;">
	                            	
	                            </div>
	                        </td>
	                       
	                    </tr>
                    </c:forEach>

                </table>
           </div>
   <div style="width:98%; height:40px; margin-left:1%; float:left; background-color: #ffffff;">
            	<div onclick="jump();" style="width:60px; height:30px; float:right; margin:5px; border:1px solid #f5f5f5; line-height:30px; text-align:center; border-radius:3px; margin-right:20px; cursor:pointer; ">
                	跳转
                </div>
                <div style="width:100px; height:30px; float:right;margin:5px; border-radius:3px; overflow:hidden; border:1px solid #f5f5f5;">
                	<input id="jumppage" style="width:100px;height:30px;border:0px;" />
                </div>
                <c:if test="${(page + 1) <= maxPage }">
                 <div  onclick="nextPage();" style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                </c:if>
                <c:if test="${page + 1 > maxPage }">
                 <div style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                </c:if>
                	<img src="index_img/nextpage.png"  width="100%" height="100%"/>
                </div>
                <div style="width:60px; font-size:18px; height:30px; float:right; margin:5px; line-height:30px; text-align:center; border-radius:3px; cursor:pointer; ">
                	${page } / ${maxPage }
                	<input id="max" value="${maxPage }" type="hidden"></input>
                </div>
                <c:if test="${page > 1 }">
                 <div onclick="shangPage();" style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                 </c:if>
                 <c:if test="${page == 1 }">
                 <div  style="width:30px; height:30px; float:right;margin:5px; cursor:pointer;">
                 </c:if>
				<img src="index_img/beforepage.png"  width="100%" height="100%"/>
                </div>
         
</body>
</html>

