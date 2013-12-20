module.exports = (grunt) ->

  grunt.initConfig
    dirs:
      jasmine: 'tests/jasmine'
      assets:
        root:      'assets',
        js:        '<%= dirs.assets.root %>/javascripts'
        sass:      '<%= dirs.assets.root %>/sass'
        templates: '<%= dirs.assets.root %>/templates'
      dest:
        root: 'public'
        js:   '<%= dirs.dest.root %>/javascripts'
        css:  '<%= dirs.dest.root %>/stylesheets'

    symlink:
      options:
        overwrite: true
      explicit:
        src:  '<%= dirs.assets.js %>'
        dest: '<%= dirs.dest.js %>'

    jade_handlebars:
      options:
        namespace: 'App.templates'
        processName: (filePath) ->
          dirs = grunt.config.get('dirs')
          templatesDir = dirs.assets.templates
          /(assets\/templates\/)(.*)(.hbs.jade)/g.exec(filePath)[2]
      dist:
        files:
          '<%= dirs.assets.js %>/app/templates.js': '<%= dirs.assets.templates %>/**/*.hbs.jade'

    concat:
      dist:
        dest: '<%= dirs.dest.js %>/app.concat.js'

    jasmine:
      dist:
        src: '<%= dirs.jasmine %>/**/*.spec.js'

    sass:
      dist:
        options:
          lineNumbers: true
        files:
          '<%= dirs.dest.css %>/app.css': '<%= dirs.assets.sass %>/app.scss'

    watch:
      templates:
        files: '<%= dirs.assets.templates %>/**/*.hbs.jade'
        tasks: ['jade_handlebars']
        options:
          debounceDelay: 1500
      sass:
        files: '<%= dirs.assets.sass %>/**/*.scss'
        tasks: ['sass']

  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-symlink'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-jade-handlebars'

  # Tasks
  grunt.registerTask 'test',    ['jasmine']
  grunt.registerTask 'assets',  ['jade_handlebars', 'sass']
  grunt.registerTask 'dev',     ['symlink', 'assets', 'watch']
  grunt.registerTask 'default', ['test', 'assets', 'concatJs']

  # Grab all javascript paths from the manifest, prepend them with the assets dir, and squash 'em
  grunt.registerTask 'concatJs',  ->
    dirs = grunt.config.get('dirs')
    assetsDir = dirs.assets.root
    scripts = require('./assets/javascripts')['development']
    scripts.forEach (path, i) ->
      scripts[i] = assetsDir + path
    grunt.config.set 'concat.dist.src', scripts
    grunt.task.run 'concat'
