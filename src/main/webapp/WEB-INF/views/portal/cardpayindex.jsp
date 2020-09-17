<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Stripe Card Elements sample</title>
    <meta name="description" content="A demo of Stripe Payment Intents" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
		/* Variables */
		* {
			box-sizing: border-box;
		}
		
		input {
			border-radius: 6px;
			margin-bottom: 6px;
			padding: 12px;
			border: 1px solid rgba(50, 50, 93, 0.1);
			height: 44px;
			font-size: 16px;
			width: 100%;
			background: white;
		}
		
		.hidden {
			display: none;
		}
		/* spinner/processing state, errors */
		.spinner,
		.spinner:before,
		.spinner:after {
			border-radius: 50%;
		}
		.spinner {
			color: #ffffff;
			font-size: 22px;
			margin-right: 10px;
			position: relative;
			width: 20px;
			height: 20px;
			box-shadow: inset 0 0 0 2px;
			-webkit-transform: translateZ(0);
			-ms-transform: translateZ(0);
			transform: translateZ(0);
		}
		.spinner:before,
		.spinner:after {
			position: absolute;
			content: "";
			background: #5469d4;
		}
		
		.spinner:before {
			width: 10.4px;
			height: 20.4px;
			border-radius: 20.4px 0 0 20.4px;
			top: -0.2px;
			left: -0.2px;
			-webkit-transform-origin: 10.4px 10.2px;
			transform-origin: 10.4px 10.2px;
			-webkit-animation: loading 2s infinite ease 1.5s;
			animation: loading 2s infinite ease 1.5s;
		}
		
		.spinner:after {
			width: 10.4px;
			height: 10.2px;
			border-radius: 0 10.2px 10.2px 0;
			top: -0.1px;
			left: 10.2px;
			-webkit-transform-origin: 0px 10.2px;
			transform-origin: 0px 10.2px;
			-webkit-animation: loading 2s infinite ease;
			animation: loading 2s infinite ease;
		}
		
		@-webkit-keyframes loading {
		  0% {
				-webkit-transform: rotate(0deg);
				transform: rotate(0deg);
		  }
		  100% {
				-webkit-transform: rotate(360deg);
				transform: rotate(360deg);
		  }
		}
		@keyframes loading {
		  0% {
				-webkit-transform: rotate(0deg);
				transform: rotate(0deg);
		  }
		  100% {
				-webkit-transform: rotate(360deg);
				transform: rotate(360deg);
		  }
		}
		#card-error {
			color: rgb(105, 115, 134);
			text-align: left;
			font-size: 13px;
			line-height: 17px;
			margin-top: 12px;
		}
		
		.card-element-box {
			position: relative;
			background-color: #ccc;
		}
		
		.card-element-box .spinner {
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			display: none;
		}
		
		.card-element-box .spinner:before,
		.card-element-box .spinner:after {
		  	background-color: #cccc;
		}
		
		#card-element {
			border-radius: 4px 4px 0 0 ;
			padding: 12px;
			border: 1px solid rgba(50, 50, 93, 0.1);
			height: 44px;
			width: 100%;
			background-color: #fff;
		}
		
		.card-element-box.mask #card-element {
		  	background-color: #ccc;
		}
		
		.card-element-box.mask .spinner {
		  	display: block;
		}
		
		#payment-request-button {
		  	margin-bottom: 32px;
		}
		
		/* Buttons and links */
		button {
			background: #5469d4;
			color: #ffffff;
			font-family: Arial, sans-serif;
			border-radius: 0 0 4px 4px;
			border: 0;
			padding: 12px 16px;
			font-size: 16px;
			font-weight: 600;
			cursor: pointer;
			display: flex;
			justify-content: center;
			transition: all 0.2s ease;
			box-shadow: 0px 4px 5.5px 0px rgba(0, 0, 0, 0.07);
			width: 100%;
		}
		button:hover {
		 	filter: contrast(115%);
		}
		button:disabled {
			opacity: 0.5;
			cursor: default;
		}
    </style>
  </head>

  <body>
    <!-- Display a payment form -->
    <div class="card-element-box mask">
      <div class="spinner"></div>
      <div id="card-element"></div>
    </div>
    <p id="card-error" role="alert"></p>
    <button id="payment-form" disabled>
      <div class="spinner hidden"></div>
      <span class="btn-text">Pay Secure</span>
    </button>
    
    <script src="https://js.stripe.com/v3/"></script>
    <script src="${APP_PATH}/static/common/jquery.min.js"></script>
    <script>
    	var stripe = Stripe("pk_test_51HNEjlGgEkMvvUCbMCN9IWPKBXCZv6ldWEq3XdnEGX9MtF3NqE3WfzQ6xZtLiYfiXdZh5F7gqkHAzKfm5s0OuSew00FQWoN8UA");

		// The items the customer wants to buy
		var purchase = {
		  	items: [{ id: "xl-tshirt" }]
		};
		
		// Disable the button until we have Stripe set up on the page
		$('#payment-form').eq(0).disabled = true;
		
		var elements = stripe.elements();
		var style = {
			base: {
				color: "#32325d",
				fontFamily: 'Arial, sans-serif',
				fontSmoothing: "antialiased",
				fontSize: "16px",
				"::placeholder": { }
			},
			invalid: {
				fontFamily: 'Arial, sans-serif',
				color: "#fa755a",
			}
		};
		var card = elements.create("card", { style: style });
		// Stripe injects an iframe into the DOM
		card.mount("#card-element");
		card.on("ready", function (event) {
			$('.card-element-box').removeClass('mask');
		});
		card.on("change", function (event) {
			// Disable the Pay button if there are no card details in the Element
			$('#payment-form').eq(0).disabled = event.empty;
			$("#card-error").text(event.error ? event.error.message : "");
		});
		
		$("#payment-form").on("click", function(event) {
		    event.preventDefault();
		    loading(true);
		    // Complete payment when the submit button is clicked
		    $.ajax({
				url: '${APP_PATH}/stripe/create-payment-intent',
				data: JSON.stringify(purchase),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					payWithCard(stripe, card, data.clientSecret);
				},
				error: function () {}
		    });
		});
		
		function payWithCard(stripe, card, clientSecret) {
			stripe
				.confirmCardPayment(clientSecret, {
				payment_method: {
					card: card
				}
				})
				.then(function(result) {
				if (result.error) {
					// Show error to your customer
					payError(result.error.message);
				} else {
					// The payment succeeded!
					paySuccess(result.paymentIntent.id);
				}
			});
		}
		
		function paySuccess() {
			loading(false);
			// modalTip
			setTimeout(function() {
				window.location.href = '/success.html'
			}, 1500);
		}
		
		function payError(errorMsgText) {
			loading(false);
			var errorMsg = $("#card-error");
			errorMsg.textContent = errorMsgText;
			setTimeout(function() {
				errorMsg.textContent = "";
			}, 4000);
		}
		
		// Show a spinner on payment submission
		var loading = function(isLoading) {
			if (isLoading) {
				// Disable the button and show a spinner
				$("#payment-form").disabled = true;
				$r("#payment-form .spinner").removeClass("hidden");
				$("#payment-form .btn-text").addClass("hidden");
			} else {
				$("#payment-form").disabled = false;
				$("#payment-form .spinner").addClass("hidden");
				$("#payment-form .btn-text").removeClass("hidden");
			}
		};
    </script>  
  </body>
</html>