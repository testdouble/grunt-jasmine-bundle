/*global module:false*/
require('coffee-script')

module.exports = function(grunt) {
  grunt.initConfig({
    spec: {
      unit: {
        minijasminenode: {
          showColors: true
        }
      }
    }
  });

  grunt.loadNpmTasks("grunt-jasmine-bundle")
  grunt.registerTask('default', ['spec']);
};
