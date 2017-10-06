import gulp from 'gulp';
import runSequence from 'run-sequence';

gulp.task('default', () => {
  runSequence(
    [
      'images',
      'static',
      'png-sprite',
      'svg-sprite',
      'fonts',
      'markup',
      'markup-menu',
      'scss',
      'scripts:compile',
      'scripts:copy',
      'components',
      'favicon'
    ],
    'livereload',
    'watch'
  );
});
