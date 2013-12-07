# spec
#
# Options:
#   helpers - "spec/helpers/**/*.{js,coffee}" - a glob (or array of globs) to your spec helpers
#   specs - "spec/**/*.{js,coffee}" - a glob (or array of globs) to your specs
#   minijasminenode - {} - an object to set or override any options to minijasmine node. See options here: https://github.com/juliemr/minijasminenode#usage

module.exports = (grunt) ->
  _ = require("lodash")

  grunt.registerMultiTask "spec", "run unit specs with Jasmine", (target) ->
    done = @async()

    options = _(@options
        helpers: "spec/helpers/**/*.{js,coffee}"
        specs: "spec/**/*.{js,coffee}"
        minijasminenode: {}
      ).chain()
      .extend(extractDeprecatedOptions(@data))
      .tap(userOnCompleteWrapper(done))
      .tap(expandSpecFiles)
      .value()

    jasmine = require("minijasminenode")
    #duck-punch the heck out of global jasmine:
    global.context = global.describe
    global.xcontext = global.xdescribe
    require("jasmine-given")
    require("jasmine-only")
    require("jasmine-before-all")
    require("jasmine-stealth")

    jasmine.executeSpecs(options.minijasminenode)

  extractDeprecatedOptions = (data) ->
    _(data).chain()
      .pick('specs', 'helpers', 'minijasminenode')
      .each((value,option) -> grunt.log.writeln "Specifying '#{option}' directly on a target is deprecated. Please use `options.#{option}` instead." )
      .value()

  userOnCompleteWrapper = (done) ->
    (options) ->
      userOnComplete = options.minijasminenode.onComplete
      options.minijasminenode.onComplete = (runner, log) ->
        userOnComplete?(runner, log)
        done(runner.results().failedCount == 0)

  expandSpecFiles = (options) ->
    options.minijasminenode.specs = grunt.file.expand([].concat(options.helpers, options.specs))

  # because this is a multi-task, it's necessary to have a default task defined
  grunt.config("spec", default: {}) unless grunt.config("spec")?
