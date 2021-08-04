<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<style type="text/css">.lottery-box{position:fixed;top:0;right:0;bottom:0;left:0;z-index:9999999999;padding:3rem 0;background-color:rgba(0,0,0,.3)}.lottery-close{position:absolute;top:-.8rem;right:-.8rem;z-index:11;width:2rem;height:2rem;background-color:#555;color:#fff;text-align:center;cursor:pointer;border-radius:50%}.lottery-close:hover{background-color:#333}.lottery{width:100%;max-height:90vh;overflow:auto;text-align:center}.lottery::after{content:"";display:inline-block;width:0;height:90vh;vertical-align:middle}.lottery-container{position:relative;display:inline-block;vertical-align:middle}.lottery-oh{border-radius:1rem;box-shadow:0 0 .5rem #000;background-color:#fff;overflow:hidden}.lottery-email{position:relative;width:100%;text-align:center;background-size:100% 100%;background-repeat:no-repeat}.lottery-title{width:100%;color:#fff;text-align:center}.lottery-title>span{display:block}.lottery-title>span:nth-of-type(1){background-image:url(${APP_PATH}/static/pc/img/lottery/lottery-logo.png);background-size:contain;background-repeat:no-repeat;background-position:center}.lottery-email>input{display:inline-block;background-color:#fff;border-style:none}.lottery-join-tip{font-weight:400;color:#fff}.lottery-join-tip div{display:none;opacity:0;visibility:hidden}.lottery-email-tip{width:100%;color:#ff0;font-style:italic}.lottery-inner-box{margin:0 auto;background-color:#fff;box-shadow:0 0 8px #bbb}.lottery-game{padding:3% 1%;background-color:#e1e1e1;cursor:pointer}.lottery-game-list{display:flex;flex-wrap:wrap;justify-content:space-evenly;width:100%;height:100%}.lottery-game-item,.lottery-startgame{width:30%;margin:1% 0;overflow:hidden;background-color:#fff;border:2px solid transparent;box-shadow:0 0 .25rem #cdcdcd;background-size:cover;background-position:center;background-repeat:no-repeat}.lottery-game-list>.lottery-game-item.active{border-color:red;box-shadow:0 0 6px red}.lottery-result{display:inline-block;vertical-align:middle;height:auto;overflow:hidden;border-radius:6px;background-color:#fff}.lottery-other{width:100%;height:auto;margin:0 auto;text-align:center;background-size:contain;background-repeat:no-repeat}.lottery-result-title>span{display:block}.lottery-result-title>span:nth-of-type(1){font-size:24px;font-weight:bolder;color:#fff}.lottery-result-title>span:nth-of-type(2){font-size:14px;color:#fff}.lottery-card{padding:2rem 1rem;margin:1rem auto;border-radius:1rem;box-shadow:0 0 .5rem #dc81e2;text-align:center;background-color:#fff}.lottery-card .card-item>span{display:block}.lottery-card .card-code,.lottery-card .card-price{margin-bottom:1rem}.lottery-card .card-price>span:nth-of-type(1){font-size:1.625rem;font-weight:bolder;color:#f30927}.lottery-card .card-price>span:nth-of-type(2){font-size:1rem;color:#383838;margin-top:8px}.lottery-card .card-code>span{display:block}.lottery-card .card-code>span:nth-of-type(1){font-size:.5rem;color:#383838}.lottery-card .card-code>span:nth-of-type(2){font-size:1.625rem;font-weight:bolder;color:#000;margin-top:.5rem}.lottery-card .card-use{font-style:italic;color:#fe186e}.card-tip{font-size:.75rem;color:#fe186e}.card-op{padding:0 1rem;margin-top:1rem;overflow:auto;text-align:center}.card-op>.btn{position:relative;display:inline-block;width:50%;padding:.5rem;font-size:1rem;line-height:1.4;color:#fff;border:1px solid #ccc;border-radius:.2rem;background-color:#f30927}@media only screen and (max-width:798px){.lottery-container{width:90%;margin:0 auto}.lottery-email{padding:1.25rem 0;background-image:url(${APP_PATH}/static/pc/img/lottery/lottery-wap.jpg)}.lottery-title>span:nth-of-type(1){padding-top:30px}.lottery-title>span:nth-of-type(2){margin-top:.25rem;font-size:.75rem;letter-spacing:.1rem;font-weight:400}.lottery-email>input{width:94%;padding:.5rem 1rem;margin-top:1rem;font-size:1rem;border-radius:.5rem}.lottery-join-tip{margin-top:.75rem;margin-bottom:.5rem;font-size:.875rem}.lottery-join-tip .wap{display:block;opacity:1;visibility:visible}.lottery-email-tip{position:absolute;bottom:.75rem;font-size:.75rem}.lottery-game{padding:2% 1%}.lottery-game-item,.lottery-startgame{margin:1% 0;height:60px;border-radius:.5rem}.lottery-startgame{background-image:url(${APP_PATH}/static/pc/img/lottery/start-game-pc.png)}.lottery-other{padding:30px;background-image:url(${APP_PATH}/static/pc/img/lottery/lottery-success-wap.jpg)}.card-op>.btn,.lottery-card{width:80%}}@media only screen and (min-width:799px){.lottery-container,.lottery-result{width:700px;margin:0 auto}.lottery-email{height:300px;padding-top:2rem;background-image:url(${APP_PATH}/static/pc/img/lottery/lottery-pc.jpg)}.lottery-title>span:nth-of-type(1){padding-top:50px}.lottery-title>span:nth-of-type(2){margin-top:1rem;font-size:1rem;letter-spacing:.125rem;font-weight:400}.lottery-email>input{width:80%;padding:.75rem 1.25rem;margin-top:1rem;font-size:1rem;border-radius:2rem}.lottery-join-tip{margin-top:.875rem;margin-bottom:.5rem;font-size:1rem}.lottery-join-tip .pc{display:block;opacity:1;visibility:visible}.lottery-email-tip{margin-top:1rem;font-size:.75rem}.lottery-game-box{width:500px;padding:10px;margin:2rem auto}.lottery-inner-box{overflow:hidden;border-radius:1rem}.lottery-game-item,.lottery-startgame{height:110px;border-radius:1rem}.lottery-startgame{background-image:url(${APP_PATH}/static/pc/img/lottery/start-game-pc.png)}.lottery-other{padding:60px 0;background-image:url(${APP_PATH}/static/pc/img/lottery/lottery-success-pc.jpg)}.card-op>.btn,.lottery-card{width:350px}}.lottery-trigger-side{position:fixed!important;top:50%!important;color:#000;background:#fff!important;box-shadow:0 0 15px 0 rgba(0,0,0,.2)!important;cursor:pointer!important;font-family:Inherit!important;-webkit-transform:translate(0,-50%);transform:translate(0,-50%);z-index:999}.lottery-trigger-close{position:absolute;top:-13px;width:30px;height:30px;border-radius:15px;box-shadow:0 0 25px rgb(0 0 0 / 40%);background:#fff}.lottery-trigger-close .icon:not(:hover){animation-name:spin-back;animation-duration:250ms}.lottery-trigger-close .icon{width:30px;height:30px;cursor:pointer;color:#333;font-size:22px;text-align:center}.lottery-trigger-text{position:relative;overflow:hidden;min-height:0;-webkit-writing-mode:vertical-lr;writing-mode:tb;transform:rotate(180deg);text-align:center;font-family:Inherit!important;line-height:21px}.lottery-gift-image{background:url(${APP_PATH}/static/pc/img/lottery/lottery-gift-icon.png);background-size:cover;-webkit-tap-highlight-color:transparent}@media screen and (max-width:767px){.lottery-trigger-side{right:0;width:auto;min-height:30px;max-height:330px;max-width:41px;border-top-left-radius:10px!important;border-bottom-left-radius:10px!important}.lottery-trigger-close{left:-13px}.lottery-trigger-box{padding:7px 7px}.lottery-trigger-text{max-width:22px;margin:10px auto 15px auto;font-size:17px}.lottery-gift-image{width:27px;height:24px;margin:0 auto}@-webkit-keyframes spin-back{from{-webkit-transform:rotate(0)}to{-webkit-transform:rotate(-90deg)}}@keyframes spin-back{from{transform:rotate(0)}to{transform:rotate(-90deg)}}}@media screen and (min-width:768px){.lottery-trigger-side{width:70px;min-height:39px;border-top-right-radius:10px!important;border-bottom-right-radius:10px!important}.lottery-trigger-close{right:-13px}.lottery-trigger-text{max-height:300px;max-width:22px;margin:15px 25px;font-size:18px}.lottery-gift-image{width:41px;height:37px;margin:15px 15px}@-webkit-keyframes spin-back{from{-webkit-transform:rotate(0)}to{-webkit-transform:rotate(90deg)}}@keyframes spin-back{from{transform:rotate(0)}to{transform:rotate(90deg)}}}</style>
<div class="lottery-box hide">
	<div class="lottery">
        <div class="lottery-container">
			<div class="lottery-close icon close"></div>
			<div class="lottery-oh">			
	        	<div class="lottery-email">
		        	<div class="lottery-title">
		        		<span></span>
		        		<span>Your Hair Your Surprise</span>
		        	</div>
		            <input type="text" placeholder="E-mail address">
		            <div class="lottery-join-tip">
		            	<div class="wap">Enter Your Email,Try Your Luck!</div>
		            	<div class="pc">Enter Your Email,Try Your Luck!</div>
		            </div>
		            <div class="lottery-email-tip"></div>
		        </div>
				
		        <div class="lottery-game-box">
		        	<div class="lottery-inner-box">
			            <div class="lottery-game">
			                <div class="lottery-game-list">
			                	<div class="lottery-game-item"></div>
			                	<div class="lottery-game-item"></div>
			                	<div class="lottery-game-item"></div>
			                	<div class="lottery-game-item"></div>
			                	<div class="lottery-startgame"></div>
			                	<div class="lottery-game-item"></div>
			                	<div class="lottery-game-item"></div>
			                	<div class="lottery-game-item"></div>
			                	<div class="lottery-game-item"></div>
			                </div>
			            </div>
			         </div>
		        </div>
			</div>
        	<div class="lottery-result hide"></div>
        </div>
    </div>
</div>
<div class="lottery-trigger-side hide">
	<div class="lottery-trigger-close hide"><i class="icon close"></i></div>
	<div class="lottery-trigger-box">
		<div class="lottery-trigger-text">Click me to Win?</div>
		<div class="lottery-gift-image"></div>
	</div>
</div>
<script type="text/javascript">function isValidEmail(t){var e=/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;return e.test(t)}function startGame(){isPushEmail||$.ajax({url:"${APP_PATH}/MlbackCoupon/getCouponLuckDrawResultAndUserEmail",type:"post",data:{userEmail:emailEl.val(),couponId:String(lotteryData.couponId)},success:function(t){100==t.code?isPushEmail=!0:lotteryEmailTipEl.text("Lucky draw failed, please try again!")},error:function(){lotteryEmailTipEl.text("Lucky draw failed, please try again!")}});var t=null,e=100,o=$(".lottery-game-item"),a=o[rollCount%8];rollCount>=lotteryIndex+defaultTimes?(clearTimeout(t),rollCount=0,$(prevItem).removeClass("active"),isStartLottery=!1,lotteryIndex=-1,isPushEmail?($(".lottery-oh").hide(),renderLotterySuccess(),lotteryData=null,logStatus()):lotteryEmailTipEl.text("Lucky draw failed, please try again!")):(e=rollCount<=defaultTimes?e-5:e+20,prevItem&&$(prevItem).removeClass("active"),$(a).addClass("active"),prevItem=a,rollCount+=1,t=setTimeout(startGame,e))}function logStatus(){var t=new Date;document.cookie="isHideLottery=true;expires="+(t.setTime(t.getTime()+18e5),t.toGMTString())}function renderLotterySuccess(){var t="";t+='<div class="lottery-other"><div class="lottery-result-title"><span>Congratulations!</span><span>You got a</span></div><div class="lottery-card"><div class ="card-item card-price"><span>',parseInt(lotteryData.couponType)?t+=parseInt(lotteryData.couponPriceoff)+"%":t+="$"+lotteryData.couponPrice,t+='</span><span>Discount</span></div><div class="card-item card-code"><span>Your Discount Code is:</span><span>'+lotteryData.couponCode+'</span></div><div class="card-use">'+(lotteryData.couponPriceBaseline?"Upon Order $"+lotteryData.couponPriceBaseline:"No limit!")+'.</div></div><div class="card-tip">in order to use this discount add it to the relevant field in checkout!</div><div class="card-op"><a class="btn" href="javascript: window.location.reload();">Use Discount</a></div></div>',$(".lottery-result").removeClass("hide").html(t)}function getLotteryIndex(){var t=[],e=[],o=0,a=null;if($.ajax({url:"${APP_PATH}/MlbackCoupon/getMlbackCouponShowByLuckDrawType",type:"post",dataType:"json",contentType:"application/json",async:!1,success:function(t){100==t.code&&(a=t)}}),a){var l=$(".lottery-game-item");return e=a.extend.mlbackCouponResList,8!=e.length?0:(lotteryCount<1&&e.forEach(function(e,o){t.push(e.couponId),l.eq(o).css("background-image","url("+e.couponImgUrl+")")}),o=t.indexOf(a.extend.luckDrawDate&&a.extend.luckDrawDate.luckDrawCouponId),lotteryData=e[o],o>-1?o+1:0)}}function checkUserEmail(t){var e=!1;return $.ajax({url:"${APP_PATH}/MlbackCoupon/checkCouponLuckDrawResultAndUserEmail",type:"post",dataType:"json",data:{userEmail:t,couponId:String(lotteryData.couponId)},async:!1,success:function(t){100==t.code&&(e=!(!t.extend||!t.extend.emailIsCan))},fail:function(){lotteryEmailTipEl.text("The email address validation failed, please try again!")}}),e}function getCookie(t){var e,o=new RegExp("(^| )"+t+"=([^;]*)(;|$)");return(e=document.cookie.match(o))?e[2]:null}function isShowLottery(){return!isHideLottery&&lotteryIndex}var lotteryBoxEl=$(".lottery-box"),lotteryEl=$(".lottery"),emailEl=$(".lottery-email input"),gameStartEl=$(".lottery-startgame"),lotteryEmailTipEl=$(".lottery-email-tip"),isPushEmail=!1,lotteryCount=0,defaultTimes=16,rollCount=0,lotteryData=null,isStartLottery=!1,isHideLottery=getCookie("isHideLottery")||!1,lotteryIndex=getLotteryIndex(),prevItem=null;isShowLottery()?(lotteryBoxEl.removeClass("hide"),$(".lottery-result").html("")):(window.localStorage&&window.localStorage.getItem("lottery-trigger-close")&&$(".lottery-trigger-close").removeClass("hide"),$(".lottery-trigger-side").removeClass("hide")),$(".lottery-trigger-close").on("click",function(){$(".lottery-trigger-side").addClass("hide"),window.localStorage&&window.localStorage.removeItem("lottery-trigger-close")}),$(".lottery-close").click(function(t){lotteryBoxEl.addClass("hide"),logStatus(),setTimeout(function(){$(".lottery-trigger-side").removeClass("hide")}),window.localStorage&&window.localStorage.setItem("lottery-trigger-close",!0)}),$(".lottery-trigger-box").on("click",function(){function t(){$(".lottery-trigger-close").removeClass("hide"),$(".lottery-box").removeClass("hide")}function e(t){lotteryData=t,$(".lottery-oh").hide(),$(".lottery-box").removeClass("hide"),renderLotterySuccess()}function o(t){return t?{couponId:t.couponluckydrawCouponid,couponCode:t.couponluckydrawCouponcode,couponName:t.couponluckydrawCouponname,couponPrice:t.couponluckydrawCouponprice,couponPriceBaseline:t.couponluckydrawCouponpricebaseline,couponPriceoff:t.couponluckydrawCouponpriceoff,couponType:t.couponluckydrawCoupontype}:null}$.ajax({url:"${APP_PATH}/MlfrontCouponLuckyDraw/selectMlfrontCouponLuckyDrawBySessionId",type:"get",dataType:"json",contentType:"application/json",success:function(a){var l=o(a.extend.mlfrontCouponLuckyDrawReturn);$(".lottery-trigger-side").addClass("hide"),l?e(l):t()},fail:function(){t()}})}),emailEl.on("change",function(){lotteryEmailTipEl.text("")}),gameStartEl.on("click",function(t){var e=null;isStartLottery||(isValidEmail(emailEl.val())?(isStartLottery=!0,checkUserEmail(emailEl.val())?(lotteryEmailTipEl.text("This email address has been used!"),isStartLottery=!1):startGame()):lotteryEmailTipEl.text("Please enter a valid email address first!"),gameStartEl.hasClass("active")||(gameStartEl.addClass("active"),e=setTimeout(function(){gameStartEl.removeClass("active"),clearTimeout(e)},300)))});</script>