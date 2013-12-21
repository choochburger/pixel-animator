module.exports = (grunt) ->

  grunt.initConfig
    dirs:
      jasmine:
        root:   'tests/jasmine'
        specs:  '<%= dirs.jasmine.root %>/specs'
        vendor: '<%= dirs.jasmine.root %>/vendor'
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
        src: require('./assets/javascripts')['development']
        options:
          specs:    '<%= dirs.jasmine.specs %>/**/*.spec.js'
          vendor:   '<%= dirs.jasmine.vendor %>/**/*.js'
          template: '<%= dirs.jasmine.root %>/runner.tmpl'

    connect:
      server:
        options:
          directory: '.'
          port:      9999
          keepalive: true

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
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-jade-handlebars'

  # Tasks
  grunt.registerTask 'test',     ['setJsPaths', 'jasmine:dist:build', 'connect']
  grunt.registerTask 'assets',   ['jade_handlebars', 'sass']
  grunt.registerTask 'dev',      ['symlink', 'assets', 'watch']
  grunt.registerTask 'codeship', ['jade_handlebars', 'setJsPaths', 'jasmine']
  grunt.registerTask 'default',  ['assets', 'setJsPaths', 'jasmine', 'concat']

  # Grab all javascript paths from the manifest, prepend them with the assets dir, and set them on the tasks that need them
  grunt.registerTask 'setJsPaths',  ->
    dirs = grunt.config.get('dirs')
    assetsDir = dirs.assets.root
    scripts = require('./assets/javascripts')['development']
    scripts.forEach (path, i) ->
      scripts[i] = assetsDir + path
    grunt.config.set 'concat.dist.src',  scripts
    grunt.config.set 'jasmine.dist.src', scripts
