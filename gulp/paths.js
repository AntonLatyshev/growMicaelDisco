export default {
  baseSrc: './app',
  baseDist: './markup',

  src: {
    styles: './app/scss',
    components: './app/components',
    pngsprite: './app/png-sprite',
    svgsprite: './app/svg-sprite',
    images: './app/images',
    svg: './app/svg',
    scripts: './app/scripts',
    static: './app/data',
    includes: './app/includes',
    fonts: './app/fonts',
    pug: './app/pug'
  },

  dist: {
    components: './catalog/view/components',
    styles: './catalog/view/theme/default/stylesheet',
    images: './catalog/view/theme/default/image',
    optimizedImg: './optimized/images-optimized',
    scripts: './catalog/view/javascript',
    static: './image/data',
    optimizedData: './optimized/data-optimized',
    fonts: './catalog/view/theme/default/fonts'
  },

  inline: {
    styles: '/css',
    images: '../image'
  },

  catalog: './catalog',
  admin: './admin'

};
