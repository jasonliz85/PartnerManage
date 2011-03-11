// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}
function add_remove_date(type, link) {
	$(link).closest("dates").hide();
}
$(function() {
	$("#holiday_start_at").datepicker({ autoSize: true, dateFormat: 'dd-mm-yy'});
});
$(function() {
	$("#holiday_end_at").datepicker({autoSize: true, dateFormat: 'dd-mm-yy'}); /*appendText: '(dd-mm-yyyy)'*/
});
$(function() {
	$("#populate_start_date").datepicker({autoSize: true, dateFormat: 'dd-mm-yy'}); /*appendText: '(dd-mm-yyyy)'*/
});
$(function() {
	$("#populate_end_date").datepicker({autoSize: true, dateFormat: 'dd-mm-yy'}); /*appendText: '(dd-mm-yyyy)'*/
});

$(function() {
  $("#partners th a, #partners .pagination a").live("click", function() {
  	$.getScript(this.href);
  	return false;
	});
	$("#partners_search input").keyup(function() {
		$.get($("#partners_search").attr("action"), $("#partners_search").serialize(), null, "script");
		return false;
	});
});


