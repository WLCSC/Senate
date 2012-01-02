// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $("#title_user_tokens").tokenInput("/users.json", {
    crossDomain: false,
    prePopulate: $("#title_user_tokens").data("pre"),
    theme: "facebook"
  });
});

$(function() {
  $("#group_user_tokens").tokenInput("/users.json", {
    crossDomain: false,
    prePopulate: $("#group_user_tokens").data("pre"),
    theme: "facebook"
  });
});