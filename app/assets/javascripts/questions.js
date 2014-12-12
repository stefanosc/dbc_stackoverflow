$(document).on('page:change', function() {

  function renderVote (event, data, status, xhr) {
    var voteElSelector = "div#question" + data.id;
    $(voteElSelector).html(data.votes);
  }

  function renderQuestion (event, data, status, xhr) {
    var template = '<li><a href="/questions/' + data.id + '">' + data.title +'</a></li>';
    $("#question-list").append(template);
  }

  $("#new_question").on('ajax:success', renderQuestion);

  $(".question-vote-container").on('ajax:success', ".question-vote.up", renderVote)
    .on('ajax:error', function(event, data, status, xhr) {
  });
  $(".question-vote-container").on('ajax:success', ".question-vote.down", renderVote)
    .on('ajax:error', function(event, data, status, xhr) {
  });
});
