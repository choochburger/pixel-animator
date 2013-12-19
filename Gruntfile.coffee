module.exports = (grunt) ->

  grunt.initConfig
    dirs:
      jasmine: 'tests/jasmine'
      assets:
        root: 'assets',
        js:   '<%= dirs.assets.root %>/javascripts'
      dest:
        root: 'public'
        js:   '<%= dirs.dest.root %>/javascripts'

    symlink:
      options:
        overwrite: true
      explicit:
        src:  '<%= dirs.assets.js %>'
        dest: '<%= dirs.dest.js %>'

    concat:
      dist:
        dest: '<%= dirs.dest.js %>/app.concat.js'

    jasmine:
      dist:
        src: '<%= dirs.jasmine %>/**/*.spec.js'

    watch:
      scripts:
        files: ['<%= dirs.assets.js %>/**/*.js']

  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-symlink'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  # Tasks
  grunt.registerTask 'test',    ['jasmine']
  grunt.registerTask 'dev',     ['symlink']
  grunt.registerTask 'default', ['test', 'concatJs']

  # Grab all javascript paths from the manifest, prepend them with the assets dir, and squash 'em
  grunt.registerTask 'concatJs',  ->
    dirs = grunt.config.get('dirs')
    assetsDir = dirs.assets.root
    scripts = require('./assets/javascripts')['development']
    scripts.forEach (path, i) ->
      scripts[i] = assetsDir + path
    grunt.config.set 'concat.dist.src', scripts
    grunt.task.run 'concat'
