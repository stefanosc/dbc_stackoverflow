$(document).on('page:change', function() {

  function markdownToHtml (match, p1, p2, p3) {
    var symbolMap = {
      "*": "em>",
      "_": "em>",
      "**": "strong>",
      "__": "strong>",
      "#": "h1>",
      "##": "h2>",
      "###": "h3>",
      "####": "h4>",
      "#####": "h5>",
      "######": "h6>",
      "`": "code>"
    };
    var tag = symbolMap[p1];
    return '<' + tag + p2 + '</' + tag;
  }

  function renderLivePreview (textAreaEl) {
    var boldEmCodeRegex = /(?=[*_`]+.*?[*_`]+)([*_`]+)((?!\1).*)(\1)/;
    var headingRegex = /^(?=#{1,6}[^#]+(?:#{1,6})?)(#{1,6})(.*?)(\1)?$/m;
    var text = ($(textAreaEl).val());
    while ( boldEmCodeRegex.test(text) ) {
      text = text.replace(boldEmCodeRegex, markdownToHtml);
    }
    while ( headingRegex.test(text) ) {
      text = text.replace(headingRegex, markdownToHtml);
    }
    $("div.preview .content").html(text);
  }

  function populateFormHiddenField (textAreaEl) {
    var questionOrAnswer = textAreaEl.classList[1];
    var hiddenFieldSelector = "#" + questionOrAnswer + "_content";
    $(hiddenFieldSelector).val($("div.preview .content").html());
  }

  function processTextInput (event) {
    renderLivePreview(this);
    populateFormHiddenField(this);
  }

  function populateTitlePreview (event) {
    var title = $(this).val();
    $("div.preview h3").html(title);
  }

  $("#answer_text_area").keyup(processTextInput);
  $("#answer_title").keyup(populateTitlePreview);
  $("#question_text_area").keyup(processTextInput);
  $("#question_title").keyup(populateTitlePreview);

});
