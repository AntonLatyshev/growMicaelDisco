const customSelect = () => {
  if ($('select').length) {
    jcf.setOptions('Select', {
      wrapNative: false,
      wrapNativeOnMobile: true,
      flipDropToFit: false
    });
    jcf.replaceAll();
  }
}
export default customSelect;
