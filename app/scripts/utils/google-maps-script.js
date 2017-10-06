const googleMapScript = (key, cb) => {
  const script = document.createElement('script');
  script.src = `https://maps.googleapis.com/maps/api/js?key=${key}`;
  script.async = true;
  script.onload = () => {
    const google = global.google;
    cb(google);
  };
  return script;
}

export default googleMapScript;
