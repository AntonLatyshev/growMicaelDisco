const parsePage = () => {
  if ($('body').find('#not-found').length) {
    $('body').addClass('parse');
  }
}
export default parsePage;
