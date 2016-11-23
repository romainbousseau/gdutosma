$(document).ready(function(){
  $(".tab").on("click", function(event) {
    $(".tab").removeClass('active');
    $(this).toggleClass('active');
    $(".tab-content").addClass('hidden');
    tabSelector = $(this).data("target");
    $(tabSelector).toggleClass('hidden')
  });
});
