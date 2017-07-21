<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			/* alert("aaa"+filePathstr); */
			filePathstr = filePathstr.substring(0, filePathstr.length-1);
			/* alert("bbb"+filePathstr); */
			/* filePathstr=filePathstr.replace(/\'/g,"\"");
			alert("ccc"+filePathstr); */
			filePathstr=filePathstr.replace(/\\/g,"/");
			/* alert("ddd"+filePathstr); */
			$("#allfile").val(filePathstr);
		}		
		
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
		var myprice=/^(0(\.\d{1,2})?|[1-9]\d{0,3}|[1-9]\d{0,3}\.\d{1,2})$/;
		if(price == ""){
			alert("请输入价格！");
			return;
		}else if(isNaN(price)){
			alert("价格只能为数字！");
			return;
		}else if(!myprice.test(price)){
			alert("价格位数最多为四位整数，两位小数哦！");
			return;
		}
		
		var myphone = /^((\(\d{3}\))|(\d{3}\-))?13[0-9]\d{8}|15[0-9]\d{8}|18[0-9]\d{8}/;
		if(!myphone.test(phone)){
			   alert('请输入有效的电话号码！');
			   return;
		}
		
		$.ajax({
			type:'post',
			data:{goodsName:goodsname,goodsMsg:goodsmsg,newAndOld:newandold,talkPrice:talkprice,address:address,price:price,classId:goodsclass,goodsPic:goodspic,qq:qq,phone:phone,tradeType:tradeType},
			url:encodeURI('goodsZr/goodszr_add.action'),
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
	<div
		style="width: 98%;; height: 60px; margin: 10px 1% 0px 1%; background-color: #f9f9f9; border: 1px solid #f5f5f5; border-bottom: 0px; float: left;">
		<div class="navChoose">发布新品</div>
	</div>
	<div
		style="width: 98%; height: 200px; background-color: #ffffff; float: left; margin-left: 1%;">
		<div id="pics"
			style="min-width: 0px; height: 128px; margin: 36px 10px; float: left;">

		</div>
		<div
			style="width: 128px; height: 128px; margin: 36px 10px; float: left; background-image: url(index_img/add_pic.png);">
			<input type="file" id="file" name="file" onchange="ajaxFileUpload();"
				style="width: 160px; cursor: pointer; height: 160px; position: relative; filter: alpha(opacity = 0); opacity: 0;" />
			<input type="hidden" id="allfile" />
		</div>
	</div>
	<div
		style="width: 98%; height: 600px; margin: 0px auto; background-color: #f9f9f9; margin-bottom: 10px; float: left;">
		<table width="100%" style="width: 100%;" border="0">
			<tr height="50px">
				<td width="380px" align="right">商品名称：</td>
				<td><input id="goodsname"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入商品名称" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">商品描述：</td>
				<td><textarea id="goodsmsg" rows="5"
						style="width: 300px; font-size: 12px; border-radius: 5px; padding: 5px 0px 0px 5px;"></textarea>
				</td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">新旧程度：</td>
				<td><select id="newandold"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
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
						<option value="0">能</option>
						<option value="1">不能</option>
				</select></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">送货类型：</td>
				<td>
				<select id="tradeType"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
						<option value="0" selected="selected">仅同校交易</option>
						<option value="1">仅同校或同城交易</option>
						<option value="2">全国范围可邮寄</option>
				</select>
				</td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">交易地点：</td>
				<td><input id="address"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入交易地点" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">价格：</td>
				<td><input id="price"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入价格" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">分类：</td>
				<td><select id="goodsclass"
					style="width: 300px; border-radius: 5px; height: 30px; padding-left: 5px; font-size: 12px;">
						<c:forEach items="${goodsClassList }" var="goodsClass">
							<option value="${goodsClass.classId }">${goodsClass.className }</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right">手机：</td>
				<td><input id="phone"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入手机号码" value="${user.phone }"></input></td>			
			</tr>
			<tr height="50px">
				<td width="80px" align="right">QQ：</td>
				<td><input id="qq"
					style="border-radius: 5px; width: 300px; height: 30px; padding-left: 5px;"
					placeholder="请输入QQ号码" value="${user.qq }" /></td>
			</tr>
			<tr height="50px">
				<td width="80px" align="right"></td>
				<td>
					<button class="mybutton" style="width: 100px;" onclick="Submit();">发布</button>
					<button class="mybutton" style="width: 100px;" onclick="back();">返回</button>
				</td>
			</tr>
		</table>
	</div>
	<script type="text/javascript" src="js/ajaxfileupload.js"></script>
	<script type="text/javascript">
	var counts = 0;
 	function ajaxFileUpload() {  
	var timestamp = new Date().getTime(); 
	if(counts>2){
		alert("最多上传三张照片");
	}else{
		 $.ajaxFileUpload({
		        url : 'upload/upload_upload.action',//请求路径  
		        secureuri : false, 
		        fileElementId : 'file',// 上传控件的id 
		        dataType : 'json',  
		        success : function(data, status) {
		        	if(data.message == "0" ){
		        		 $("#myremark_common").html("文件上传失败！");
						 $("#xy_over_div").show();
						 $("#xy_remark_common_div").show();
		        	}else if(data.message == "1" ){
		        		/* alert("aaa"+data.filePath); */
			  		    var filePath = data.filePath.replace(/\\/g,"\\\\");
			  		   /*  alert("bbb"+filePath); */
			  		    var filePath1 = filePath.substring(filePath.indexOf('goodspic'));
			  		   /*  alert("ccc"+filePath1); */
			  		    var time = timestamp;
			  		    $("#pics").append('<div id="picdiv_'+time+'" class="goodspic"><input type="hidden" id="pathInput_'+time+'"value="'+filePath+'" /><img src="'+filePath1+'" alt="" width="100%" height="100%"/><div class="goodspic_delete" onclick="deleteFile(\''+time+'\',\''+filePath+'\');"><img src="index_img/delete_button.png" alt="" width="100%" height="100%"/></div></div>');
			            counts ++;
			            
		        	}else{
		        		
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
				data:{path:_filePath},
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

