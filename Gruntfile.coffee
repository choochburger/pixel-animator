module.exports = (grunt) ->

  grunt.initConfig
    dirs:
      jasmine: 'tests/jasmine'
      assets:
        js: 'assets/javascripts'
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
  grunt.registerTask 'default', ['test', 'concatJs:views/layout.jade:assets']

  # Grab javascript file paths (in order) and hand them off to concat
  grunt.registerTask 'concatJs', 'Parse JS paths from file', (filePath, rootDir) ->
    manifest = grunt.file.read filePath
    tags = /(\/\/- javascripts)([\s\S]*)(\/\/- \/javascripts)/g.exec(manifest)[2]
    scripts = tags.match /\/.*.js/g
    scripts.forEach (script, i) ->
      scripts[i] = rootDir + script
    grunt.config.set 'concat.dist.src', scripts
    grunt.task.run 'concat'
