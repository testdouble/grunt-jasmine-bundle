module.exports = (grunt) ->
  _ = grunt.util._

  grunt.registerTask "spec", "run unit specs with Jasmine", (target) ->
    done = @async()

    jasmine = require("minijasminenode")
    #duck-punch the heck out of global jasmine:
    global.context = global.describe
    global.xcontext = global.xdescribe
    require("jasmine-given")
    require("jasmine-only")
    require("jasmine-before-all")
    require("jasmine-stealth")

    jasmine.executeSpecs
      specs: grunt.file.expand(["spec/helpers/**/*.{js,coffee}", "spec/**/*.{js,coffee}"])
      onComplete: (runner, log) ->
        done(runner.results().failedCount == 0)
