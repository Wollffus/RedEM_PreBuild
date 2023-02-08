var Resetting = false;
$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.type === "balanceHUD") {
			$('.username1').html(event.data.player);
			$('.curbalance').html(event.data.balance);
		} else if (event.data.type === "openGeneral") {
			$('#general').show();
			$('body').addClass('active');
		} else if (event.data.type === "closeAll") {
			$('#waiting, #general, #transferUI, #withdrawUI, #depositUI, #taxUI, #topbar').hide();
			$('body').removeClass("active");
		}
	});
});

$('.btn-out').click(function() {
	$('#general, #waiting, #transferUI, #withdrawUI, #depositUI, #taxUI, #topbar').hide();
	$('body').removeClass("active");
	$.post(`https://${GetParentResourceName()}/NUIFocusOff`);
});

$('.back').click(function() {
	Resetting = true;
	$('#depositUI,#withdrawUI').hide();
	$('#general').show();
});

$('#back2').click(function() {
	Resetting = true;
	$('#taxUI').hide();
	$('#general').show();
});

$('#deposit').click(function() {
	$('#general').hide();
	$("#amount").val('');
	$('#depositUI').show();
	Resetting = false;
});

$('#taxes').click(function() {
	$('#general').hide();
	$("#amountt").val('');
	$('#taxUI').show();
	Resetting = false;
});

$('#safedeposit').click(function() {
	$('#waiting, #general, #transferUI, #withdrawUI, #depositUI, #topbar').hide();
	$('body').removeClass("active");
	$.post(`https://${GetParentResourceName()}/BankStash`);
});

$('#withdraw').click(function() {
	$('#general').hide();
	$("#amountw").val('');
	$('#withdrawUI').show();
	Resetting = false;
});

$("#depositsubmit").click(function() {
	if (!Resetting) {
		var amountValue = $("#amount").val();
		if (amountValue.length > 0) {
			var intAmount = Number(amountValue);
			if (intAmount > 0) {
				$.post(`https://${GetParentResourceName()}/Deposit`, JSON.stringify({
					amount: intAmount
				}));
				$('#depositUI').hide();
				$('#general').show();
				$("#amount").val('');
			} else {
				console.log("0 or less");
			}
		} else {
			console.log("length 0 or less");
		}
	}
});

$("#withdrawsubmit").click(function() {
	if (!Resetting) {
		var amountValue = $("#amountw").val();
		if (amountValue.length > 0) {
			var intAmount = Number(amountValue);
			if (intAmount > 0) {
				$.post(`https://${GetParentResourceName()}/Withdraw`, JSON.stringify({
					amount: intAmount
				}));
				$('#withdrawUI').hide();
				$('#general').show();
				$("#amountw").val('');
			} else {
				console.log("0 or less");
			}
		} else {
			console.log("length 0 or less");
		}
	}
});

document.onkeyup = function(data) {
	if (data.which == 27) {
		$('#general,#withdrawUI, #depositUI').hide();
		$('body').removeClass("active");
		$.post(`https://${GetParentResourceName()}/NUIFocusOff`, JSON.stringify({}));
	}
}