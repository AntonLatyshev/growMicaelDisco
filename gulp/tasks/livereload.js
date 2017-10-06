import browserSync from 'browser-sync';
import gulp from 'gulp';
import gutil from 'gulp-util';
import paths from '../paths';
import options from '../../options';

gulp.task('livereload', () => {
  browserSync.init({
    files: [{
      match: [`${paths.baseDist}/**/*`, '!./.idea/**/*'],
      fn: (event, file) => {
        /** Custom event handler **/
      },
      options: {
        ignored: '*.css.map'
      }
    }],
    open: 'local',
    reloadOnRestart: true,
    port: gutil.env.port || 3000,
    proxy: options.proxy,    
    ghostMode: {
      clicks: false,
      forms: false,
      scroll: false
    },
    tunnel: !!gutil.env.tunnel
  })
});
