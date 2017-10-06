import gulp from 'gulp';
import uglify from 'gulp-uglify';
import plumber from 'gulp-plumber';
import minifyCss from 'gulp-clean-css';
import rename from 'gulp-rename';
import runSequence from 'run-sequence';
import errorHandler from '../utils/errorHandler';
import paths from '../paths';

gulp.task('minify:css', () => {
  return gulp.src(`${paths.dist.styles}/index.css`)
    .pipe(minifyCss())
    .pipe(rename('index.min.css'))
    .pipe(gulp.dest(`${paths.dist.styles}`));
});


gulp.task('minify:js', () => {
  return gulp.src(`${paths.dist.scripts}/app.js`)
    .pipe(uglify())
    .pipe(rename('app.min.js'))
    .pipe(gulp.dest(`${paths.dist.scripts}`));
});

gulp.task('minify', () => {
  runSequence(['minify:css', 'minify:js'])
});
