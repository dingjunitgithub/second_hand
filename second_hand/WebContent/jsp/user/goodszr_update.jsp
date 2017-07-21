<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%
	String email_session_pay = (String)session.getAttribute("email");
%>
<style type="text/css">
.goodspic {
	width: 128px;
	height: 128px;
	float: left;
	position: relative;
}

.goodspic_delete {
	width: 20px;
	height: 20px;
	position: absolute;
	top: 0;
	right: 0;
	cursor: pointer;
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
		var tradeType = $("#tradeType").val();
		
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
			data:{goodsName:goodsname,goodsMsg:goodsmsg,newAndOld:newandold,talkPrice:talkprice,address:address,price:price,classId:goodsclass,goodsPic:goodspic,qq:qq,phone:phone,id:id,tradeType:tradeType},
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
	<input type="hidden" id="id" value="${goodsZr.goodsZrId }" />
	<div
		style="width: 98%;; height: 60px; margin: 10px 1% 0px 1%; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px; float: left;">
		<div class="navChoose">发布修改</div>
	</div>
	<div
		style="width: 98%; height: 200px; background-color: #ffffff; float: left; margin-left: 1%;">
		<div id="pics"
			style="min-width: 0px; height: 128px; margin: 36px 10px; float: left;">
			<c:forEach items="${goodsPicList }" var="goodpic">
				<%
                			String random = UUID.randomUUID().toString();
                		%>
				<div id="picdiv_<%=random %>" class="goodspic">
					<input type="hidden" id="pathInput_<%=random %>" value="${goodpic}" />
					<img src="goodspic${fn:substringAfter(goodpic, 'goodspic')}" alt=""
						width="100%" height="100%" />
					<div class="goodspic_delete"
						onclick="deleteFile('<%=random %>','${goodpic }');">
						<img src="index_img/delete_button.png" alt="" width="100%"
							height="100%" />
					</div>
				</div>
			</c:forEach>
		</div>
		<div
			style="width: 128px; height: 128px; margin: 36px 10px; float: left; background-image: url(index_img/add_pic.png);">
			<input type="file" id="file" name="file" onchange="ajaxFileUpload();"
				style="width: 160px; cursor: pointer; height: 160px; position: relative; filter: alpha(opacity = 0); opacity: 0;" />
			<input type="hidden" id="allfile" value="${goodsZr.goodsPic}" />
		</div>
	</div>
	<div
		style="width: 98%; height: 600px; margin: 0px auto; background-color: #f9f9f9; margin-bottom: 10px; float: left;">
		<table width="100%" style="width: 100%;" border="0">
			<tr height="50px">
				<td width="380px" align="right">商品名称：</td>
				<td><input id="goodsname"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入商品名称" value="${goodsZr.goodsName }" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">商品描述：</td>
				<td><textarea id="goodsmsg" rows="5"
						style="width: 300px; font-size: 12px; border-radius: 5px; padding: 5px 0px 0px 5px;">${goodsZr.goodsMsg }</textarea>
				</td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">新旧程度：</td>
				<td><select id="newandold"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
						<c:choose>
							<c:when test="${goodsZr.newAndOld == '10' }">
								<option value="${goodsZr.newAndOld }">全新</option>
							</c:when>
							<c:otherwise>
								<option value="${goodsZr.newAndOld}">${goodsZr.newAndOld  }成新</option>
							</c:otherwise>
						</c:choose>

						<option value="10">全新</option>
						<option value="9">9成新</option>
						<option value="8">8成新</option>
						<option value="7">7成新</option>
						<option value="6">6成新</option>
						<option value="5">5成新</option>
						<option value="4">4成新</option>
						<option value="3">3成新</option>
						<option value="2">2成新</option>
						<option value="1">1成新</option>
				</select></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">能否讲价：</td>
				<td><select id="talkprice"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
						<c:choose>
							<c:when test="${goodsZr.talkPrice == '0' }">
								<option value="0" selected="selected">能</option>
								<option value="1">不能</option>
							</c:when>
							<c:otherwise>
								<option value="0">能</option>
								<option value="1" selected="selected">不能</option>
							</c:otherwise>
						</c:choose>


				</select></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">送货类型：</td>
				<td><select id="tradeType"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
					<c:if test="${goodsZr.tradeType==0}">
						<option value="0" selected="selected">仅同校交易</option>
						<option value="1">仅同校或同城交易</option>
						<option value="2">全国范围可邮寄</option>
					</c:if>
					<c:if test="${goodsZr.tradeType==1}">
						<option value="0">仅同校交易</option>
						<option value="1" selected="selected">仅同校或同城交易</option>
						<option value="2">全国范围可邮寄</option>
					</c:if>
					<c:if test="${goodsZr.tradeType==2}">
						<option value="0" >仅同校交易</option>
						<option value="1">仅同校或同城交易</option>
						<option value="2" selected="selected">全国范围可邮寄</option>
					</c:if>
						
				</select></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">交易地点：</td>
				<td><input id="address"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入交易地点" value="${goodsZr.address}" /></td>
			</tr>

			<tr height="50px">
				<td width="80px" align="right">价格：</td>
				<td><input id="price"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入价格" value="${goodsZr.price}" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">分类：</td>
				<td><select id="goodsclass"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
						<c:forEach items="${goodsClassList }" var="goodsClass">
							<c:choose>
								<c:when
									test="${goodsZr.classes.className == goodsClass.className }">
									<option value="${goodsClass.classId }" selected="selected">${goodsClass.className }</option>
								</c:when>
								<c:otherwise>
									<option value="${goodsClass.classId}">${goodsClass.className }</option>
								</c:otherwise>
							</c:choose>

						</c:forEach>
				</select></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">手机：</td>
				<td><input id="phone"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入手机号码" value="${goodsZr.phone }" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">QQ：</td>
				<td><input id="qq"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入QQ号码" value="${goodsZr.qq }" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right"></td>
				<td>
					<button class="mybutton" style="width: 100px;" onclick="Submit();">修改</button>
					<button class="mybutton" style="width: 100px;" onclick="back();">返回</button>
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript" src="js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	var counts = 0;
 	function ajaxFileUpload() {  
 		if(counts>2){
 			alert("最多上传三张照片");
 		}else{
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
					counts--;
				},
				error: function(){			
				}
			}); 
	}
</script>
</body>

</html>

