beforeEach ->
  @addMatchers
    toHaveFlavor: ->
      @actual.flavor == true
