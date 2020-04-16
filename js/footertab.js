//图片切换；
$(function(){
	$('.footer_tab ul li').click(function(){
		var index = $(this).index();
		//console.log(index);
		$(this).addClass('act').siblings().removeClass('act');
	});
});
// app