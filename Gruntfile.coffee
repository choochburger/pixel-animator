module.exports = (grunt) ->

  grunt.initConfig
    dirs:
      jasmine: 'tests/jasmine'

    jasmine:
      dist:
        src: '<%= dirs.jasmine %>/**/*.spec.js'

  grunt.loadNpmTasks 'grunt-contrib-jasmine'

  # Tasks
  grunt.registerTask 'test', ['jasmine']
  grunt.registerTask 'default', ['test']
