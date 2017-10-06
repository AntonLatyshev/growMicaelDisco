import gulp from 'gulp';
import gitmodified from 'gulp-gitmodified';
import path from 'path';
import { log } from 'gulp-util';
import ftp from 'vinyl-ftp';
import paths from '../paths';
import ftpopts from '../ftpopts';
import runSequence from 'run-sequence';

const {
  host,
  user,
  password,
  port,
  parallel
} = ftpopts;

const {
  styles,
  scripts,
  components,
  fonts,
  images,
  data,
  markup
} = ftpopts.paths;

const conn = ftp.create({
  host,
  user,
  password,
  port,
  parallel,
  log
});

const options = {
  buffer: false
};

gulp.task('modified', () => {
  const files = gulp.src(['./**/*', '!node_modules/**/*'])
    .pipe(gitmodified('modified'));
  files.on('data', function (file) {
    const name = `./${file.relative.replace(/\\/g, '/')}`;
    const destPath = `/example.org${name.substr(1, name.lastIndexOf('/'))}`;
    console.log('Modified file: ', name);
    console.log(`Ftp path: ${destPath}`);
    return gulp
      .src(name)
      .pipe(conn.dest(destPath));
  });
  return files;
})
