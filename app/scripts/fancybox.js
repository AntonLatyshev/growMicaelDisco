const fancybox = (node) => {
  $(node).fancybox({
    padding: 0,
    helpers: {
      overlay: {
        locked: false,
        css: {
          'background': 'rgba(0,0,0,.8)'
        }
      }
    }
  });
}
export default fancybox;
