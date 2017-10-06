const video = () => {
  $('video').prop("muted", false);
  var videoMute = false;
  const videoHeight = 853;
  $('.about-video__mute').on("click", function(e) {
    if (!videoMute) {
      $('video').prop("muted", true);
      $(this).addClass("disabled");
    } else {
      $('video').prop("muted", false);
      $(this).removeClass("disabled");
    }
    videoMute = !videoMute;
  });
  var offsetTop = $(window).height()
  $(window).on('scroll', () => {
    if($(window).scrollTop() >= offsetTop) {
      $('video').prop("muted", true);
      $('.about-video__mute').addClass("disabled");
    } else {
        $('video').prop("muted", false);
        $('.about-video__mute').removeClass("disabled");
    }
  });
}
export default video;
