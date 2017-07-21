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
		
		var filePathstr = "";
		if($("input[id^=pathInput_]")[0]){
			$("input[id^=pathInput_]").each(function (){
				filePathstr += $(this).val()+'|';
			});
			filePathstr = filePathstr.substring(0, filePathstr.length-1);
			filePathstr=filePathstr.replace(/\'/g,"\"");
			filePathstr=filePathstr.replace(/\\/g,"/");
			$("#allfile").val(filePathstr);
		}		
		
		var id = $("#id").val();
		var goodsname = $("#goodsname").val();
		var goodsmsg = $("#goodsmsg").val();
		var newandold = $("#newandold").val();
		var talkprice = $("#talkprice").val();
		var address = $("#address").val();
		var price = $("#price").val();
		var goodsclass = $("#goodsclass").val();
		var goodspic = $("#allfile").val();
		var phone = $("#phone").val();
		var qq = $("#qq").val();
		
		if(goodsname == ""){
			alert("请输入商品名称");
			return;
		}
		if(goodsmsg == "" || goodsmsg.length < 15){
			alert("请输入商品描述，至少15个字");
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
			data:{goodsname:goodsname,goodsmsg:goodsmsg,newandold:newandold,talkprice:talkprice,address:address,price:price,goodsclass:goodsclass,goodspic:goodspic,qq:qq,phone:phone,id:id},
			url:encodeURI('goodsZr/goodszr_update.action'),
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
			url:encodeURI("goodsZr/goodszr_toListByUser.action"),
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
			<input type="hidden" id="id" value="${goodsZr.goodsZrId }"/>
			 <div style="width:98%;; height:60px; margin:10px 1% 0px 1%;background-color: #f9f9f9; border:1px solid #f5f5f5; border-bottom:0px;float:left;">
            	<div class="navChoose">
                	详细信息
                </div>
    		</div>
            <div style="width:98%; height:200px;  background-color:#ffffff; float:left;margin-left:1%; ">
           		<div id="pics" style="min-width:0px; height:128px; margin:36px 10px;float:left;">
                	<c:forEach items="${goodsPicList}" var="goodpic">
                		<%
                			String random = UUID.randomUUID().toString();
                		%>
                	<div id="picdiv_<%=random %>" class="goodspic">
                		<input type="hidden" id="pathInput_<%=random %>" value="${goodpic }" />
                		<img src="goodspic${fn:substringAfter(goodpic, 'goodspic')}" alt="" width="100%" height="100%"/>
                	</div>
                	</c:forEach>
                </div>
           </div>
           <div style="width:98%; height:600px; margin:0px auto; background-color:#ffffff; margin-bottom: 10px;float:left;">
           		<table width="100%" style="width:100%;" border="0">
                	<tr height="50px">
                    	<td width="100px" align="right"> 商品名称：</td>
                        <td>${goodsZr.goodsName } </td>
                    </tr>
                    <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                    <tr height="50px">
                    	<td width="80px" align="right"> 商品描述：</td>
                        <td>
                        	${goodsZr.goodsMsg }	
                        </td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 新旧程度：</td>
                        <td>
                        	${goodsZr.newAndOld}
                        </td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 能否讲价：</td>
                        <td>
                            	<c:choose>
                            		<c:when test="${goodsZr.talkPrice == '0' }">
                            			能
                            		</c:when>
                            		<c:otherwise>
                            			不能
                            		</c:otherwise>
                            	</c:choose>
                        </td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                    <tr height="50px">
                    	<td width="80px" align="right"> 送货类型：</td>
                        <td>
                        	<c:if test="${goodsZr.tradeType==0}">仅同校交易</c:if>
                        	<c:if test="${goodsZr.tradeType==1}">仅同校或同城交易</c:if>
                        	<c:if test="${goodsZr.tradeType==2}">全国范围可邮寄</c:if>
						</td>
                    </tr>
                    <tr height="50px">
                    	<td width="80px" align="right"> 交易地点：</td>
                        <td>${goodsZr.address} </td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 价格：</td>
                        <td>${goodsZr.price} </td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                      <tr height="50px">
                    	<td width="80px" align="right"> 分类：</td>
                        <td>
                        	${goodsZr.classes.className}
                        </td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> 手机：</td>
                        <td>${goodsZr.phone }</td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> QQ：</td>
                        <td>${goodsZr.qq } </td>
                    </tr>
                      <tr>
                    	<td colspan="2">
                    		<div style="width:100%;height:1px; background-color: #f5f5f5;"></div>
                    	</td>
                    </tr>
                     <tr height="50px">
                    	<td width="80px" align="right"> </td>
                        <td>
                       		<button class="mybutton" style="width:100px;" onclick="back();" >返回</button>
                        </td>
                    </tr>
                </table>
           </div>
<script type="text/javascript" src="js/ajaxfileupload.js"></script>
<script type="text/javascript">
	var counts = 0;
 	function ajaxFileUpload() {  
	var timestamp = new Date().getTime();  
    $.ajaxFileUpload({
        url : 'upload/upload_upload.action',//请求路径  
        secureuri : false, 
        fileElementId : 'file',// 上传控件的id 
        dataType : 'json',  
       // data : {myid :myid}, // 其它请求参数  
        success : function(data, status) {
        	if(data.message == "0" || data.message == "2" ){
        		 $("#myremark_common").html("文件上传失败！");
					$("#xy_over_div").show();
					$("#xy_remark_common_div").show();
        	}else if(data.message == "1" ){
	        	var fileStr = "{'filepath':'"+data.filePath+"','filesize':'"+data.fileSize+"','filename':'"+data.fileFileName+"'}";
	  		    var filePath = data.filePath.replace(/\\/g,"\\\\");
	  		    var filePath1 = filePath.substring(filePath.indexOf('goodspic'));
	  		    var time = timestamp;
	  		    $("#pics").append('<div id="picdiv_'+time+'" class="goodspic"><input type="hidden" id="pathInput_'+time+'"value="'+filePath+'" /><img src="'+filePath1+'" alt="" width="100%" height="100%"/><div class="goodspic_delete" onclick="deleteFile(\''+time+'\',\''+filePath+'\');"><img src="index_img/delete_button.png" alt="" width="100%" height="100%"/></div></div>');
	            counts ++;
        	}
        },  
        error : function(data, status, e) {  

        }  
    });  
    return false;  

}
 	function deleteFile(time,filePath){
		var _filePath = filePath;		
		var _url = "upload/upload_deleteFile.action";
		 $.ajax({
				type: "POST",
				url: _url,
				data:{ path:_filePath},
				beforeSend: function(XMLHttpRequest){
				},
				success: function(data, textStatus){
					$("#picdiv_"+time).remove();
				},
				error: function(){			
				}
			}); 
	}
</script>          
</body>

</html>

