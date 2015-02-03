gulp =         require('gulp')
gutil =        require('gulp-util')
coffee =       require('gulp-coffee')
http =         require('http')
runSequence =  require('run-sequence')
es =  				 require('event-stream')
sass =         require('gulp-sass')
autoprefixer = require('gulp-autoprefixer')
minifycss =    require('gulp-minify-css')
jshint =       require('gulp-jshint')
rename =       require('gulp-rename')
uglify =       require('gulp-uglify')
clean =        require('gulp-clean')
concat =       require('gulp-concat')
imagemin =     require('gulp-imagemin')
cache =        require('gulp-cache')
open =         require('gulp-open')
livereload =   require('gulp-livereload')
embedlr =      require('gulp-embedlr')
filter =       require('gulp-filter')
ngAnnotate =   require('gulp-ng-annotate')
lr =           require('tiny-lr')
fs = 					 require('fs')

bowerrc = JSON.parse(fs.readFileSync('.bowerrc'))
server = lr()

config =
	httpPort: 9882
	livereloadPort: '35729'

	# markup
	srcViews: 'src/views/**/*'
	destViews: 'app/views'

	# styles
	srcSass: 'src/public/styles/**/*.s*ss'
	srcCss: 'src/public/styles/**/*.css'
	destCss: 'app/public/styles'
	cssConcatTarget: 'out.css'

	# scripts
	srcAllScripts: 'src/**/*.coffee'
	srcClientScripts: 'src/public/**/*.coffee'
	srcClientExclude: '!public/**/*.coffee'
	destClientScripts: 'app/public/scripts'
	jsConcatTarget: 'main.js'
	destServerScripts: 'app'

	# bower
	srcBower: bowerrc.directory + '/**/*'
	destBower: 'app/public/scripts/components'

	# plugins
	# srcPlugins: 'src/assets/scripts/plugins/*.js'
	# destPlugins: 'dist/assets/scripts'
	# pluginsConcat: 'plugins.js'

	# images
	srcImg: 'src/public/images/**/*.*'
	destImg: 'app/public/images'


# sass task
gulp.task 'styles', ->
	css = gulp.src(config.srcCss)
	sass = gulp.src(config.srcSass)
		.pipe(sass(style: 'expanded', sourceComments: 'normal'))

	es.merge(css, sass)
		.pipe(concat(config.cssConcatTarget))
		.pipe(autoprefixer('last 2 version', 'safari 5', 'ie 7', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
		.pipe(gulp.dest(config.destCss))
		.pipe(rename(suffix: '.min'))
		.pipe(minifycss())
		.pipe(gulp.dest(config.destCss))
		.pipe livereload(server, auto:false)


# compile client-side coffeescript, concat, & minify js
gulp.task 'clientScripts', ->
	gulp.src(config.srcClientScripts)
		.pipe(coffee().on('error', gutil.log))
		.pipe(concat(config.jsConcatTarget))
		.pipe(ngAnnotate())
		.pipe(gulp.dest(config.destClientScripts))
		.pipe(rename(suffix: '.min'))
		.pipe(uglify())
		.pipe(gulp.dest(config.destClientScripts))
		.pipe livereload(server, auto:false)

# compile server-side coffeescript
gulp.task 'serverScripts', ->
	gulp.src(config.srcAllScripts)
		.pipe(filter(['**/*', config.srcClientExclude]))
		.pipe(coffee().on('error', gutil.log))
		# .pipe(jshint())
		# .pipe(jshint.reporter('default'))
		.pipe(gulp.dest(config.destServerScripts))
		.pipe livereload(server, auto:false)


# # concat & minify plugins
# gulp.task 'plugins', ->
# 	# ".jshintrc"
# 	gulp.src(config.srcPlugins)
# 		.pipe(jshint())
# 		.pipe(jshint.reporter('default'))
# 		.pipe(concat(config.pluginsConcat))
# 		.pipe(gulp.dest(config.destPlugins))
# 		.pipe(rename(suffix: '.min'))
# 		.pipe(uglify())
# 		.pipe(gulp.dest(config.destApp))
# 		.pipe livereload(server)


# minify images
gulp.task 'images', ->
	gulp.src(config.srcImg)
		.pipe(imagemin())
		.pipe gulp.dest(config.destImg)

# copy bower scripts
# gulp.task 'bower', ->
# 	gulp.src(config.srcBower)
# 		# .pipe(embedlr())
# 		.pipe(gulp.dest(config.destBower))
# 		.pipe livereload(server, auto:false)

# watch html
gulp.task 'views', ->
	gulp.src(config.srcViews)
		# .pipe(embedlr())
		.pipe(gulp.dest(config.destViews))
		.pipe livereload(server, auto:false)


# clean '.dist/'
gulp.task 'clean', ->
	gulp.src([
		config.destViews,
		config.destCss,
		'app/*.js',
		'app/controllers/*.js',
		'app/public/scripts/*.js'
	], read: false)
	.pipe clean()


# site launcher
gulp.task 'open', ->
	gulp.src('app/index.js') # dummy source, but must match a real file to run
		.pipe open '',
			url: 'http://localhost:' + config.httpPort


gulp.task 'watch', (callback) ->

	gulp.watch([config.srcSass, config.srcCss], ['styles']).Watcher.on 'all', livereload
	# gulp.watch(config.srcPlugins, ['plugins']).Watcher.on 'all', livereload
	# gulp.watch(config.srcBower, ['bower']).Watcher.on 'all', livereload
	gulp.watch(config.srcClientScripts, ['clientScripts']).Watcher.on 'all', livereload
	gulp.watch([config.srcAllScripts, '!' + config.srcClientScripts], ['serverScripts']).Watcher.on 'all', livereload
	gulp.watch(config.srcViews, ['views']).Watcher.on 'all', livereload
	gulp.watch(config.srcImg, ['images']).Watcher.on 'all', livereload

# default task -- run 'gulp' from cli
gulp.task 'default', (callback) ->

	runSequence 'clean', [
		# 'plugins'
		# 'bower'
		'clientScripts'
		'serverScripts'
		'styles'
		'images'
		'views'
	], 'watch', callback

	server.listen config.livereloadPort
	# http.createServer(ecstatic(root: 'dist/')).listen config.httpPort

