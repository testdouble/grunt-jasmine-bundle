/*global module:false*/
require('coffee-script')

module.exports = function(grunt) {
  grunt.initConfig({
    spec: {
      unit: {
        options: {
          minijasminenode: {
            showColors: true
          }
        }
      }
    }
  });

  grunt.loadNpmTasks("grunt-jasmine-bundle")
  grunt.registerTask('default', ['spec']);
};
