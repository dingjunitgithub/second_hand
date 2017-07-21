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
			type:'get',
			url:encodeURI("goodsQg/goodsqg_toAdd.action"),
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
			url:encodeURI("goodsQg/goodsqg_toUpdate.action?id="+id),
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
			url:encodeURI("goodsQg/goodsqg_deleteByUser.action?id="+id),
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
			url:encodeURI("goodsQg/goodsqg_toListByUser.action?page=${page-1}"),
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
			url:encodeURI("goodsQg/goodsqg_toListByUser.action?page=${page+1}"),
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
			url:encodeURI("goodsQg/goodsqg_toListByUser.action?page="+jumppage),
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
	function changeStatu(statu,id){
		$.ajax({
			type:'post',
			data:{statu:statu,id:id},
			url:encodeURI('goodsQg/goodsqg_updateStatu.action'),
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
	function toDetailPage(id){
		$.ajax({
			type:'get',
			url:encodeURI("goodsQg/goodsqg_toDetail.action?id="+id),
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
                	我的求购
                </div>
                <div style="width:120px; height:40px; border-radius:5px; float:right;margin:10px;cursor: pointer;background-color: #ffb300;line-height:40px;text-align:center;color:#ffffff;font-size:16px;" onclick="toadd();">
                	 发布求购
                </div>
    		</div>
           <div style="width:98%; height:510px; margin:0px auto; background-color:#ffffff;font-size:12px;">
           		<table width="100%" border="0">
                	<tr height="40px" align="center" bgcolor="#f5f5f5">
                    	<td width="50px">序号</td>
                        <td width="200px">商品名称</td>
                        <td >预交易地点</td>
                        <td width="60px">价格</td>
                        <td width="90px">手机号码</td>
                        <td width="90px">QQ号码</td>
                        <td width="90px">发布时间</td>
                        <td width="60px">状态</td>
                        <td width="90px">操作</td>
                    </tr>
                    <c:forEach items="${goodsQgList}" var="goodsQg" varStatus="status">
                    	<tr height="40px" align="center">
                    	<td width="50px">${status.count }</td>
                        <td width="200px">${goodsQg.goodsName }</td>
                        <td >${goodsQg.address }</td>
                        <td width="40px">${goodsQg.price }</td>
                        <td width="80px">${goodsQg.phone }</td>
                        <td width="80px">${goodsQg.qq }</td>
                        <td width="120px">${goodsQg.pubDate }</td>
                        <td width="80px">
                        <c:choose>
                        	<c:when test="${goodsQg.statu == '0'}">
                        		求购中......
                        	</c:when>
                        	<c:otherwise>
                        		暂不需要
                        	</c:otherwise>
                        </c:choose>
                        </td>
                        <td width="90px">
                        	<c:if test="${goodsQg.statu == '0'}">
                        		<div style="width:20px; height:20px;float:left; cursor: pointer;margin-left:10px;" title="停售" onclick="changeStatu(1,'${goodsQg.goodsQgId}');">
                        	</c:if>
                        	<c:if test="${goodsQg.statu == '1'}">
                        		<div style="width:20px; height:20px;float:left; cursor: pointer;margin-left:10px;"  title="出售" onclick="changeStatu(0,'${goodsQg.goodsQgId}');">
                        	</c:if>
	                        	 <img src="index_img/changeStatu_button.png" width="100%" height="100%" />
	                        </div>
	                        
	                        <div style="width:20px; height:20px;float:left; cursor: pointer;margin-left:10px;" onclick="schooltoupdate('${goodsQg.goodsQgId}');">
	                        	 <img src="index_img/update_button.png" width="100%" height="100%" />
	                        </div>
	                         <div style="width:20px; height:20px;float:left;cursor: pointer;margin-left:10px;">
	                        	 <img src="index_img/delete_button.png" width="100%" height="100%"  onclick="schooltodelete('${goodsQg.goodsQgId}');"/>
	                        </div>
                        </td>
                    </tr>
                    <tr>
                    	<td width="50px" colspan="8">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;">
                    			
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
            </div>
         </div>
</body>
</html>

