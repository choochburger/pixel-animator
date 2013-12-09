module.exports = (grunt) ->

  grunt.initConfig
    dirs:
      jasmine: 'tests/jasmine'
      assets:
        js: 'assets/javascripts'
      dest:
        js: 'public/javascripts'

    copy:
      dev:
        expand:  true
        flatten: true
        src:   ['<%= dirs.assets.js %>/**/*.js']
        dest:   '<%= dirs.dest.js %>'

    jasmine:
      dist:
        src: '<%= dirs.jasmine %>/**/*.spec.js'

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'

  # Tasks
  grunt.registerTask 'test',    ['jasmine']
  grunt.registerTask 'dev',     ['copy:dev']
  grunt.registerTask 'default', ['test']
