const customScroll = (elements) => {
  $(elements).mCustomScrollbar({
      scrollInertia: $(window).width() > 1024 ? 800 : 0
  });
}
export default customScroll;
