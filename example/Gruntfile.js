/*global module:false*/
require('coffee-script')

module.exports = function(grunt) {
  grunt.loadNpmTasks("grunt-jasmine-bundle")
  grunt.registerTask('default', ['spec']);
};
