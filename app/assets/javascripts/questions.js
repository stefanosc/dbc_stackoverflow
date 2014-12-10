$(document).on('page:change', function() {
  $("#new_question").on('ajax:success', function(event, data, status, xhr) {
    var template = '<li><a href="/questions/' + data.id + '">' + data.title +'</a></li>';
    $("#question-list").append(template);
    /* Act on the event */
  });
});