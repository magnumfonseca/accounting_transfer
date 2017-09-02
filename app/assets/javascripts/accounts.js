function getBalance(account_id) {
  $.get("/api/v1/balance/"+account_id).
    done(function(data) {
      $('#balance').text(data.balance);
    });
}

function tradeAmount(account_id) {
  var destination_account = $('#destination_account_id');
  var amount = $('#amount');
  $.post("/api/v1/trades", {
    source_account_id: account_id,
    destination_account_id: destination_account.val(),
    amount: amount.val()
  }).done(function(data) {
    getBalance(account_id);
    destination_account.val("");
    amount.val("");
    alert("Successful transfer");
  }).fail(function(data) {
    alert(data.responseJSON.errors);
  });
}
