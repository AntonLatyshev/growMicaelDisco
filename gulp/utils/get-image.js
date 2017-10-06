const getImage = (prefix) => {
  let newPrefix;
  if (prefix.indexOf('.')===0) {
    newPrefix = `${prefix.replace(/\./g, '')}`;
  } else {
    newPrefix = `${prefix}`;
  }
  return (source, options) => {
    let newSource;
    if (source.indexOf('/')!==0) {
      newSource = `/${source}`;
    } else {
      newSource = source;
    }
    const returningOptions = Object.assign({
      title: 'Image title',
      alt: 'Image alt'
    }, options);
    let optionsToString = '';
    for (let key in returningOptions) {
      if (Object.prototype.hasOwnProperty.call(returningOptions, key)) {
        optionsToString += `${key}="${returningOptions[key]}" `
      }
    }
    return `<img src="${newPrefix}${newSource}" ${optionsToString}>`
  }
}
export default getImage;
