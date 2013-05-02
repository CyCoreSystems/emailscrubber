module.exports = (grunt)->
  grunt.initConfig {
    pkg: grunt.file.readJSON 'package.json'
    coffeelint:
      options:
        no_trailing_whitespace:
          level: 'error'
        indentation:
          level: 'error'
        max_line_length:
          level: 'ignore'
      app: 'src/**/*.coffee'
    coffee:
      main:
        options:
          bare: true
        expand: true
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: 'lib/'
  }

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default',[ 'coffeelint', 'coffee' ]

