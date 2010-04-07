/* js/jquery script for a simple slideshow */

function imageSwitch(obj, direction) {
  project = $("#" + obj.attr("id").replace("-" + direction, "-images"));
  current = project.find("li.current");
  first = project.find("li:first");
  last = project.find("li:last");
  if (direction == "next") {
    next = ( current.next().is("li") ) ? current.next() : first;
  } else {
    next = ( current.prev().is("li") ) ? current.prev() : last;
  }
  
  current.removeClass('current');
  next.addClass('current');
}

$(document).ready(function() {
  $(".button-list .next").click(function() {
    imageSwitch($(this), "next");
    return false;
  });
  $(".button-list .prev").click(function() {
    imageSwitch($(this), "prev");
    return false;
  });
});