var answer_template = '<div class="row">' +
                        '<div class="col-sm-1">' +
                          '<a data-method="patch" href="/questions/<%= question_id %>/answers/<%= id %>/vote?vote=1" rel="nofollow"><i class="glyphicon glyphicon-thumbs-up"></i>' +
                          '</a>' +
                          '<div class="vote"><%= votes %></div>' +
                          '<a data-method="patch" href="/questions/<%= question_id %>/answers/<%= id %>/vote?vote=-1" rel="nofollow"><i class="glyphicon glyphicon-thumbs-down"></i>'+
                          '</a>'+
                        '</div>'+
                        '<div class="col-sm-5">' +
                          '<h2><%= title %></h2>'+
                          '<p><%= content %></p>' +
                          '<a data-method="delete" href="/questions/<%= question_id %>/answers/<%= id %>" rel="nofollow">delete</a>'+
                        '</div>'+
                      '</div>';

var compiled = _.template(answer_template);

$(document).on('page:change', function() {
  $("#new_answer").on('ajax:success', function(event, data, status, xhr) {
    var lastAnswer = $('.container.answers .row').last();
    lastAnswer.after($(compiled(data)));
  }).on('ajax:error', function(event, xhr, status, error) {
    var errorsArray = $.parseJSON(xhr.responseText);
    var errorLi = '';
    $.each(errorsArray, function(index, val) {
      errorLi += '<li>'+ val + '</li>';
    });
    errorDiv = $(".alert.alert-danger#answer-form");
    errorDiv.html($(errorLi));
    errorDiv.show(500).delay(2500).hide(500);
  });
});
