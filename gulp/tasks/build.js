import gulp from 'gulp';
import runSequence from 'run-sequence';

gulp.task('build', () => {
  runSequence(
    [
      'images',
      'static',
      'png-sprite',
      'svg-sprite',
      'fonts',
      'scss',
      'scripts:compile',
      'scripts:copy',
      'components'
    ]
  );
});
