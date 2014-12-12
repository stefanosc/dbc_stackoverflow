$(document).on('page:change', function() {

  function renderAnswer (event, data, status, xhr) {
    var answer_template = $('script#answer-template').html();
    var compiled = _.template(answer_template);
    var lastAnswer = $('.container.answers .row').last();
    lastAnswer.after($(compiled(data)));
  }

  function renderError (event, xhr, status, error) {
    var errorsArray = $.parseJSON(xhr.responseText);
    var errorLi = '';
    $.each(errorsArray, function(index, val) {
      errorLi += '<li>'+ val + '</li>';
    });
    errorDiv = $(".alert.alert-danger#answer-form");
    errorDiv.html($(errorLi));
    errorDiv.show(500).delay(2500).hide(500);
  }

  function renderVote (event, data, status, xhr) {
    var voteElSelector = "div#answer" + data.id;
    $(voteElSelector).html(data.votes);
  }

  $("#new_answer").on('ajax:success', renderAnswer).on('ajax:error', renderError);

  $(".answer-vote-container").on('ajax:success', ".answer-vote-up", renderVote)
    .on('ajax:error', function(event, data, status, xhr) {
  });
  $(".answer-vote-container").on('ajax:success', ".answer-vote-down", renderVote)
    .on('ajax:error', function(event, data, status, xhr) {
  });


});
