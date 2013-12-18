module.exports = (grunt) ->

  grunt.initConfig
    dirs:
      jasmine: 'tests/jasmine'
      assets:
        js: 'assets/javascripts'
      dest:
        js: 'public/javascripts'

    symlink:
      options:
        overwrite: true
      explicit:
        src:  '<%= dirs.assets.js %>'
        dest: '<%= dirs.dest.js %>'

    jasmine:
      dist:
        src: '<%= dirs.jasmine %>/**/*.spec.js'

    watch:
      scripts:
        files: ['<%= dirs.assets.js %>/**/*.js']

  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-symlink'

  # Tasks
  grunt.registerTask 'test',    ['jasmine']
  grunt.registerTask 'dev',     ['symlink']
  grunt.registerTask 'default', ['test']
