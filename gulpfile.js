/*
 * GULP build file to automatically prefix CSS files when they change
 */

const gulp = require('gulp');
const autoprefixer = require('autoprefixer');
const cleancss = require('gulp-clean-css');
const postcss = require('gulp-postcss');
const purgecss = require('gulp-purgecss');

gulp.task('styles', function (done) {
  gulp.src('src/**/*.css')
    .pipe(purgecss({
      content: ['src/**/*.html', 'index.html']
    }))
    .pipe(cleancss({
      format: 'beautify',
      level: 2
    }))
    .pipe(postcss([autoprefixer()]))
    .pipe(gulp.dest('build'));
  done();
});

gulp.task('watch', function () {
  gulp.watch('src/**/*.css', gulp.series('styles'));
});
