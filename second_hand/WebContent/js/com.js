// 大banner js
function bannerhuxi(huxishijian,jiangeshijian) {
	var nowimg = 0;
	//============定时器一堆=================
	var timer = setInterval(youanniuyewu,jiangeshijian);
   $("#banner").mouseenter(
		function() {
			clearInterval(timer);	//停止定时		
		}
	);

	$("#banner").mouseleave(
		function() {
			clearInterval(timer);	//设表先关
			timer = setInterval(youanniuyewu,jiangeshijian);
			
	});
	
	//============定时器一堆=================
    $("#banner span.right_button").click(youanniuyewu);
	//下面是右按钮的业务，提炼出来的原因，就是定时器调用
	function youanniuyewu(){
		if(!$("#banner-huxi .banner-tuul li").is(":animated")){
			//让老的信号量的元素淡出
			$("#banner-huxi .banner-tuul li").eq(nowimg).fadeOut(huxishijian);

			//改变信号量
			if(nowimg < $("#banner-huxi .banner-tuul li").length - 1){
				nowimg = nowimg + 1;
			}else{
				nowimg = 0;
			}
			$("#banner-huxi .banner-tuul li").eq(nowimg).fadeIn(huxishijian);
			$("#banner .dianul li").eq(nowimg).addClass("cur").siblings().removeClass("cur");
		}
	}

      $("#banner span.left_button").click(
		function(){
			if(!$("#banner-huxi .banner-tuul li").is(":animated")){
				//让老的信号量的元素淡出
				$("#banner-huxi .banner-tuul li").eq(nowimg).fadeOut(huxishijian);

				//改变信号量
				if(nowimg > 0){
					nowimg = nowimg - 1;
				}else{
					nowimg = $("#banner-huxi .banner-tuul li").length - 1;
				}
				$("#banner-huxi .banner-tuul li").eq(nowimg).fadeIn(huxishijian);
				$("#banner .dianul li").eq(nowimg).addClass("cur").siblings().removeClass("cur");
			}
		});

	$("#banner .dianul li").click(function(){
			//让老的淡出
			$("#banner-huxi .banner-tuul li").eq(nowimg).fadeOut(huxishijian);
			nowimg = $(this).index();	//让信号量改变为用户点击的那个序号
			//让新的淡入
			$("#banner-huxi .banner-tuul li").eq(nowimg).fadeIn(huxishijian);
			//小圆点跟着变：
			$("#banner .dianul li").eq(nowimg).addClass("cur").siblings().removeClass("cur");
		});
}
// 大banner js-end

// 6大保障轮播js-star

function banner_move(jiangeshijian,yundongshijian,tupiankuandu){
	var nowimg = 0;	//当前的图片编号
	//克隆
	$("#banner_move .tuul li").eq(0).clone().appendTo("#banner_move .tuul");
	//右按钮的监听：
	$(".ensure_wraper .anniu .rightbut").click(youanniuyewu);
	function youanniuyewu(){
		if(!$("#banner_move .tuul").is(":animated")){
			if(nowimg < $("#banner_move .tuul li").length - 2){
				nowimg = nowimg + 1;
				huan();	
			}else{
				nowimg = 0;	
				$("#banner_move .tuul").animate({"left":-tupiankuandu * ($("#banner_move .tuul li").length - 1)}
					,yundongshijian
					,function(){
						$("#banner_move .tuul").css("left",0);
				});	
				$("#banner_move .dianul li").eq(nowimg).addClass("cur").siblings().removeClass("cur");
			}
		}
	}

	$(".ensure_wraper .anniu .leftbut").click(function(){
		if(!$("#banner_move .tuul").is(":animated")){
				if(nowimg > 0){
					nowimg = nowimg - 1;
					huan();	
				}else{
					nowimg = $("#banner_move .tuul li").length - 2;
					
					$("#banner_move .tuul").css("left",-tupiankuandu*($("#banner_move .tuul li").length - 1));
					$("#banner_move .tuul").animate(
						{
							"left":-tupiankuandu * ($("#banner_move .tuul li").length - 2)
						}
					,yundongshijian);
			
					$(".ensure_wraper .top ul li").eq(nowimg).addClass("cur").siblings().removeClass("cur");
				}
		}	
	});

	$(".ensure_wraper .top ul li").click(function(){
		if(!$(".tuul").is(":animated")){
				nowimg = $(this).index();
				huan();
		}
	});

	function huan(){
		$("#banner_move .tuul").animate({"left":nowimg * -tupiankuandu},yundongshijian);
		$(".ensure_wraper .top ul li").eq(nowimg).addClass("cur").siblings().removeClass("cur");
	}
}

// 6大保障轮播js-star



$(function(){
   // 施工主要内容tab
   $(".main_content .head ul li").click(function(){
   	  var _index=$(this).index();
   	  $(this).addClass("cur").siblings().removeClass("cur");
   	  $(".main_content .body ul li").eq(_index).fadeIn(0).siblings().fadeOut(0);
   });

  // 侧边导航事件
   $(".slide_nav ul li").click(function(){
   	  var _index=$(this).index();
   	  $(this).addClass("cur").siblings().removeClass("cur");  
   	  var ind = $(this).index()+ 1;
	  var topVal = $('#float0'+ind).offset().top;
	  $('body,html').animate({scrollTop:topVal},800);
   });
   
  fixSlideNav();
   function fixSlideNav(){
        var wHeight = $(window).height();
	    var sHeight= $('.slide_nav').height();
	    var fixedTop = (wHeight - sHeight)/2;
	    $(".slide_nav").css("top",fixedTop);
   }

   $(window).resize(function(){
      fixSlideNav();

   });
   
   //返回顶部事件
   $("#backTop").click(function(){
   	$("html,body").animate({scrollTop:0},1000);
   });

//打开案例展示部分

$(".our_cases .pUl .pLi").click(function(){
 	 var oString=$(this).html();
 	 $(".layer_box .inner").html(oString);
 	 $(".layer_box").fadeIn(200);
 });
//关闭案例展示部分
$(".layer_box .close_btn").click(function(){
	 $(this).parents(".layer_box").fadeOut(200);
});




















});
