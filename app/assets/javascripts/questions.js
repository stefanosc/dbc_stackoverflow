$(document).on('page:change', function() {
  $("#new_question").on('ajax:success', function(event, data, status, xhr) {
    var template = '<li><a href="/questions/' + data.id + '">' + data.title +'</a></li>';
    $("#question-list").append(template);
    /* Act on the event */
  });
  $(".question-vote-container").on('ajax:success', ".question-vote-up", function(event, data, status, xhr) {
    var voteElSelector = "div#question" + data.id;
    $(voteElSelector).html(data.votes);
  }).on('ajax:error', function(event, data, status, xhr) {
  });
  $(".question-vote-container").on('ajax:success', ".question-vote-down", function(event, data, status, xhr) {
    var voteElSelector = "div#question" + data.id;
    $(voteElSelector).html(data.votes);
  }).on('ajax:error', function(event, data, status, xhr) {
  });
});
