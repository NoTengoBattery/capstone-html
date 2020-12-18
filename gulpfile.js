/*
 * GULP build file to automatically prefix CSS files when they change
 */

const gulp = require('gulp');
const autoprefixer = require('autoprefixer');
const cleancss = require('gulp-clean-css');
const postcss = require('gulp-postcss');
const purgecss = require('gulp-purgecss');
const purgecssFromHtml = require('purgecss-from-html');

gulp.task('styles', function (done) {
  gulp.src('src/**/*.css')
    .pipe(purgecss({
      content: ['src/**/*.html', 'index.html'],
      extractors: [{
        extractor: purgecssFromHtml,
        extensions: ['html']
      }],
      fontFace: true,
      keyframes: true,
      variables: true
    }))
    .pipe(cleancss({
      level: {
        2: {
          all: true
        }
      }
    }))
    .pipe(postcss([autoprefixer()]))
    .pipe(gulp.dest('build'));
  done();
});

gulp.task('watch', function () {
  gulp.watch('src/**/*.css', gulp.series('styles'));
});
