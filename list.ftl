<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="北斗云购">
	<meta name="copyright" content="北斗云购">
	<title>${message("shop.cart.title")}[#if showPowered] - 北斗云购[/#if]</title>
	<link href="${base}/favicon.ico" rel="icon">
	<link href="${base}/resources/common/css/bootstrap.css" rel="stylesheet">
	<link href="${base}/resources/common/css/iconfont.css" rel="stylesheet">
	<link href="${base}/resources/common/css/font-awesome.css" rel="stylesheet">
	<link href="${base}/resources/common/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/base.css" rel="stylesheet">
	<link href="${base}/resources/mobile/shop/css/cart.css" rel="stylesheet">
	<link href="${base}/resources/mobile/my/css/add_gouwuche.css" rel="stylesheet">
	<!--[if lt IE 9]>
		<script src="${base}/resources/common/js/html5shiv.js"></script>
		<script src="${base}/resources/common/js/respond.js"></script>
	<![endif]-->
	<script src="${base}/resources/common/js/jquery.js"></script>
	<script src="${base}/resources/common/js/bootstrap.js"></script>
	<script src="${base}/resources/common/js/bootstrap-growl.js"></script>
	<script src="${base}/resources/common/js/jquery.scrolltofixed.js"></script>
	<script src="${base}/resources/common/js/bootbox.js"></script>
	<script src="${base}/resources/common/js/jquery.spinner.js"></script>
	<script src="${base}/resources/common/js/jquery.cookie.js"></script>
	<script src="${base}/resources/common/js/underscore.js"></script>
	<script src="${base}/resources/common/js/url.js"></script>
	<script src="${base}/resources/common/js/velocity.js"></script>
	<script src="${base}/resources/common/js/velocity.ui.js"></script>
	<script src="${base}/resources/common/js/base.js"></script>
	<script src="${base}/resources/mobile/shop/js/base.js"></script>
	<script src="${base}/resources/mobile/my/js/font.js"></script>
	<script id="cartItemGroupFooterTemplate" type="text/template">
		<%if (!_.isEmpty(store.promotionNames)) {%>
			<dl class="clearfix">
				<dt>${message("shop.cart.promotion")}</dt>
				<%_.each(store.promotionNames, function(promotionName, i) {%>
					<dd class="text-overflow" title="<%-promotionName%>"><%-promotionName%></dd>
				<%});%>
			</dl>
		<%}%>
		<%if (!_.isEmpty(store.giftNames)) {%>
			<dl class="clearfix">
				<dt>${message("shop.cart.gift")}</dt>
				<%_.each(store.giftNames, function(giftName, i) {%>
					<dd class="text-overflow" title="<%-giftName%>"><%-giftName%></dd>
				<%});%>
			</dl>
		<%}%>
	</script>
	[#noautoesc]
		[#escape x as x?js_string]
			<script>
			$().ready(function() {
				
				var $document = $(document);
				var $modify = $("#modify");
				var $spinner = $("[data-trigger='spinner']");
				var $removeCart = $("[data-action='removeCart']");
				var $addProductFavorite = $("[data-action='addProductFavorite']");
				var $redirectLogin = $("#redirectLogin");
				var $effectivePrice = $("#effectivePrice");
				var $clear = $("#clear");
				var cartItemGroupFooterTemplate = _.template($("#cartItemGroupFooterTemplate").html());

				// 修改
				$modify.click(function() {
					var $element = $(this);

					$element.toggleClass("active");
					if ($element.hasClass("active")) {
						$element.text("完成");
						$removeCart.add($clear).velocity("fadeIn", {
							display: "block",
							begin: function() {
								$spinner.hide();
							}
						});
						$addProductFavorite.add($clear).velocity("fadeIn", {
							display: "block",
							begin: function() {
								$spinner.hide();
							}
						});
					} else {
						$element.text("编辑");
						$removeCart.add($clear).velocity("fadeOut", {
							complete: function() {
								$spinner.show();
							}
						});
						$addProductFavorite.add($clear).velocity("fadeOut", {
							complete: function() {
								$spinner.show();
							}
						});
					}
				});

				// 修改
				$document.on("success.shopxx.modifyCart", function(event, data) {
					var $element = $(event.target);
					
					if (!data.cartItem.isLowStock) {
						$element.closest(".media").find(".product-image strong").remove();
					}
					
					$element.closest(".cart-item-group").find(".cart-item-group-footer").html(cartItemGroupFooterTemplate(data)).toggle(data.store.promotionNames.length > 0 || data.store.giftNames.length > 0);
					$effectivePrice.text($.currency(data.effectivePrice, true, true));
				});
				
				// 移除 绑定事件和数据
				$document.on("success.shopxx.removeCart", function(event, data) {
					var $element = $(event.target);
					
					$element.closest(".media").velocity("fadeOut", {
						complete: function() {
							var $cartItemGroup = $element.closest(".cart-item-group");
							
							$(this).remove();
							if ($cartItemGroup.find("[data-action='removeCart']").length < 1) {
								$cartItemGroup.remove();
							}
							if ($("[data-action='removeCart']").length < 1) {
								location.reload(true);
							}
							
							$cartItemGroup.find(".cart-item-group-footer").html(cartItemGroupFooterTemplate(data)).toggle(data.store.promotionNames.length > 0 || data.store.giftNames.length > 0);
							$effectivePrice.text($.currency(data.effectivePrice, true, true));
						}
					});
				});

				// 清空
				$document.on("success.shopxx.clearCart", function() {
					location.reload(true);
				});
				
				// 重定向登录页面
				$redirectLogin.click(function() {
					$.redirectLogin({
						redirectUrl: Url.getLocation()
					});
				});
			
			});
			</script>
		[/#escape]
	[/#noautoesc]
</head>
<body class="shop cart-list">
	<header class="header-default" data-spy="scrollToFixed">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-1">
					<a href="javascript:;" data-action="back">
						<i class="iconfont icon-back"></i>
					</a>
				</div>
				<div class="col-xs-10">
					<h5>${message("shop.cart.title")}</h5>
				</div>
				[#if currentCart?? && !currentCart.isEmpty()]
					<div class="col-xs-1">
						<a id="modify" href="javascript:;">${message("shop.cart.modify")}</a>
					</div>
				[/#if]
			</div>
		</div>
	</header>
	<form name="form" id="form" action="${base}/order/checkout" method="get">
	<main>
		${currentCart.quantity}
		<div class="container-fluid">
			[#if currentCart?? && !currentCart.isEmpty()]
				[#if !currentUser??]
					<p class="tips">
						<a id="redirectLogin" href="javascript:;">${message("shop.cart.redirectLogin")}</a>
					</p>
				[/#if]
				[#list currentCart.cartItemGroup.entrySet() as entry]
					[#assign store = entry.key /]
					[#assign cartItems = entry.value /]
					<div class="cart-item-group panel panel-default">
						<div class="panel-heading">
							<a href="${base}${store.path}">${store.name}</a>
							[#if store.type == "SELF"]
								<span class="label label-primary">${message("Store.Type.SELF")}</span>
							[/#if]
						</div>
						<div class="panel-body">
							<ul class="media-list">
								[#list cartItems as cartItem]
									<li class="media">
										<div class="media-left media-middle">
											[#--check box--]
                                            <div class="checkbox2">
                                                <input id="good_${cartItem.id}" class="xuanze" type="checkbox" value="${cartItem.id}" name ='carItemIds'>
                                                <label for="good_${cartItem.id}"></label>
                                            </div>
											<a class="product-image" href="${base}${cartItem.sku.path}" title="${cartItem.sku.name}">
												<img class="media-object img-thumbnail" src="${cartItem.sku.thumbnail!setting.defaultThumbnailProductImage}" alt="${cartItem.sku.name}">
												[#if !cartItem.isMarketable]
													<strong>${message("shop.cart.notMarketable")}</strong>
												[#elseif cartItem.isLowStock]
													<strong>${message("shop.cart.lowStock")}</strong>
												[#elseif !store.isEnabled]
													<strong>${message("shop.cart.notActive")}</strong>
												[/#if]
											</a>
										</div>
										<div class="media-body media-middle">
											<h5 class="media-heading">
												<a href="${base}${cartItem.sku.path}" title="${cartItem.sku.name}">${cartItem.sku.name}</a>
											</h5>
											<button type="button" class="btn btn-default btn-xs"  style="border-color:#de1616;color:#de1616;">金豆可抵${cartItem.sku.product.jindou}%</button><br/>
											[#if cartItem.sku.specifications?has_content]
												<span class="small text-gray">[${cartItem.sku.specifications?join(", ")}]</span>
											[/#if]
											<strong class="cp_jiage">${currency(cartItem.price, true)}</strong>
										</div>
										<div class="media-right media-middle text-right">
											<div class="spinner input-group input-group-sm" data-trigger="spinner">
												<span class="input-group-addon" data-spin="down">-</span>
												<input class="form-control" type="text" value="${cartItem.quantity}" maxlength="5" data-rule="quantity" data-min="1" data-max="10000" data-action="modifyCart" data-sku-id="${cartItem.sku.id}">
												<span class="input-group-addon" data-spin="up">+</span>
											</div>
											<button class="hidden-element btn btn-default btn-xs" type="button" data-action="removeCart" data-sku-id="${cartItem.sku.id}">${message("common.delete")}</button>
											<button class="hidden-element btn btn-default btn-xs"  style="margin-top:0.2em;;"  type="button" data-action="addProductFavorite" data-product-id="${cartItem.sku.product.id}">收藏</button>
										</div>
									</li>
								[/#list]
							</ul>
						</div>
						<div class="cart-item-group-footer panel-footer[#if !currentCart.getPromotionNames(store)?has_content && !currentCart.getGiftNames(store)?has_content] hidden-element[/#if]">
							[#if currentCart.getPromotionNames(store)?has_content]
								<dl class="clearfix">
									<dt>${message("shop.cart.promotion")}</dt>
									[#list currentCart.getPromotionNames(store) as promotionName]
										<dd class="text-overflow" title="${promotionName}">${promotionName}</dd>
									[/#list]
								</dl>
							[/#if]
							[#if currentCart.getGiftNames(store)?has_content]
								<dl class="clearfix">
									<dt>${message("shop.cart.gift")}</dt>
									[#list currentCart.getGiftNames(store) as giftName]
										<dd class="text-overflow" title="${giftName}">${giftName}</dd>
									[/#list]
								</dl>
							[/#if]
						</div>
					</div>
				[/#list]
			[#else]
				<p class="empty">
					<a href="${base}/">${message("shop.cart.empty")}</a>
				</p>
			[/#if]
		</div>
	</main>
	</form>
	<footer class="footer-default scroll-to-fixed-fixed add_footer" data-spy="scrollToFixed" data-bottom="0">

		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-6 text-left">
					[#if currentCart?? && !currentCart.isEmpty()]
                        <div class="checkbox2">
                            <input id="checkall" class="checkall" type="checkbox" value="" name ='checkall'>
                            <label for="checkall"></label>
                        </div>
						<span>
							${message("shop.cart.effectivePrice")}:
							<strong id="effectivePrice" style="display:none">${currency(currentCart.effectivePrice, true, true)}</strong>
							<strong id="sum_all">￥0.00元</strong>
						</span>
					[/#if]
				</div>
				<div class="col-xs-3">
					<button id="clear" class="clear btn btn-orange btn-lg btn-block" type="button" data-action="clearCart">${message("shop.cart.clear")}</button>
				</div>
				<div class="col-xs-3">
					<button  id ="cart_jiesuan" class="btn btn-red btn-lg btn-block " type="submit" data-action=""[#if !currentCart?? || currentCart.isEmpty()] disabled[/#if]>${message("shop.cart.checkout")}</button>
                    [#if currentCart?? && !currentCart.isEmpty()]
					<button  id ="isEmpty" class="btn btn-red btn-lg btn-block disabled" type="submit">${message("shop.cart.checkout")}</button>
					[/#if]
				</div>
			</div>
		</div>
	</footer>
	<script>
		//提交结算
		$(document).ready(function(){
			$("#cart_jiesuan").click(function(){
				$("#form").submit();
			});
		});
	</script>
 	<script>
		//
        function Toast(msg,duration){
            duration=isNaN(duration)?3000:duration;
            var m = document.createElement('div');
            m.innerHTML = msg;
            //cssText;
            m.style.cssText="max-width:60%;min-width: 150px;padding:0 14px;height: 40px;color: rgb(255, 255, 255);line-height: 40px;text-align: center;border-radius: 4px;position: fixed;top: 50%;left: 50%;transform: translate(-50%, -50%);z-index: 999999;background: rgba(0, 0, 0,.7);font-size:0.22rem;";
            document.body.appendChild(m);
            setTimeout(function() {
                var d = 0.8;
                m.style.webkitTransition = '-webkit-transform ' + d + 's ease-in, opacity ' + d + 's ease-in';
                m.style.opacity = '0';
                setTimeout(function() { document.body.removeChild(m) }, d * 1000);
            }, duration);
        }
		//购物车结算 只是前端显示；
        let checkAll = document.querySelector('#checkall');
		let price = document.querySelectorAll('.cp_jiage');
		let sumPrice = document.querySelector('#sum_all')//价格
        let oCheck = document.querySelectorAll('.xuanze');
        let oNum = document.querySelectorAll('.form-control');
        let oBtn = document.querySelector("#cart_jiesuan");
        let oClick = document.querySelectorAll('.input-group-addon');
        let isEmpty = document.querySelector("#isEmpty");
        let arrPrice=[];
        let arrNum=[]
        for(let i=0;i<oCheck.length;i++){
            // id=value;
            oCheck[i].value =  oCheck[i].id.substr(5);
        }
        let initPrice = null;
        //初始化anniu
        if(checkAll.checked){
            console.log(sumPrice)
            oBtn.style.display = 'block';
            isEmpty.style.display = 'none';
            //计算价格;
            for(let i=0;i<price.length;i++){
                arrPrice[i] = parseInt(price[i].innerHTML.substr(1));
                arrNum[i] = parseInt(oNum[i].value);
                initPrice = initPrice + arrPrice[i]*arrNum[i]
            };
            sumPrice.innerHTML = '￥'+ initPrice.toFixed(2) + '元'
        }else{//没有全选中;
            for(let i=0;i<oCheck.length;i++){
                console.log(oCheck[i].checked)
                if(oCheck[i].checked){
                    oBtn.style.display = 'block';
                    isEmpty.style.display = 'none';
                }else{
                    oBtn.style.display = 'none';
                    isEmpty.style.display = 'block';
                }
                initPrice = initPrice + arrPrice[i]*arrNum[i]
            }
            if(!isNaN(initPrice)){
                sumPrice.innerHTML = '￥'+ initPrice.toFixed(2) + '元'
			}else{
                sumPrice.innerHTML = '￥0.00元';
            }

        }
        //1.价格计算,加减是触发价格修改;
		oClick.forEach(function(item,index){
		    item.addEventListener('click',function(){
                //点击加号选择对应的商品;
				//修改按钮状态；
                oBtn.style.display = 'block';
                isEmpty.style.display = 'none';
                for(let i=0;i<price.length;i++){
                    arrPrice[i] = parseInt(price[i].innerHTML.substr(1));
                    arrNum[i] = parseInt(oNum[i].value);
                };
                if(index%2==0){// -
                    if(arrNum[Math.floor(index/2)]!==1){
                        arrNum[Math.floor(index/2)]-=1
					}
                }else{//+
                    arrNum[Math.floor(index/2)]+=1
                }
                //点击加号选择对应的商品；
                console.log(arrPrice,arrNum,Math.floor(index/2));
		        //数量，是否被选中；
                let sum = 0;
				for(let i=0;i<oCheck.length;i++){
				    if(Math.floor(index/2)==i){
                        oCheck[i].checked ='checked';
					}
				    if(oCheck[i].checked){
						sum = sum + arrPrice[i]*arrNum[i];
					}
				}
                sumPrice.innerHTML = '￥'+ sum.toFixed(2) + '元';
			})
		});
		//2计算;
        oCheck.forEach(function(item,index){
            item.onchange=function(){
                let sum1 = 0 ;
                for(let i=0;i<price.length;i++){
                    arrPrice[i] = parseInt(price[i].innerHTML.substr(1));
                    arrNum[i] = parseInt(oNum[i].value);
                };
                for(let i=0;i<oCheck.length;i++){
                    if(oCheck[i].checked){
                        sum1 = sum1 + arrPrice[i]*arrNum[i];
                        checkAll.checked = true;
                    }else{
                        //console.log(i);
                        checkAll.checked = false;
					}
                };
                if(sum1==0){
                    oBtn.style.display = 'none';
                    isEmpty.style.display = 'block';
				}else{
                    oBtn.style.display = 'block';
                    isEmpty.style.display = 'none';
				}
                //修改价格
                sumPrice.innerHTML = '￥'+ sum1.toFixed(2) + '元';
			}
		});
        //全选呀；
		checkAll.onchange = function(){
		    let sum4 = 0;
		    if(this.checked){
                oBtn.style.display = 'block';
                isEmpty.style.display = 'none';
		        //全部选中并且计算价格;
                for(let i=0;i<oCheck.length;i++){
                    oCheck[i].checked = true;//选中
                    arrPrice[i] = parseInt(price[i].innerHTML.substr(1));
                    arrNum[i] = parseInt(oNum[i].value);
                    sum4 = sum4 + arrPrice[i]*arrNum[i];
				}
                sumPrice.innerHTML = '￥'+ sum4.toFixed(2) + '元';
			}else{
                for(let i=0;i<oCheck.length;i++){
                    oCheck[i].checked = false;
                }
                oBtn.style.display = 'none';
                isEmpty.style.display = 'block';
                sumPrice.innerHTML = '￥'+ '0.00' + '元';
			}
		}
		//没有选中的时候不能提交并且提示勾选;isEmpty
        isEmpty.addEventListener('click',function(){
            Toast('请添加需要购买的商品')
		})
	</script>
</body>
</html>