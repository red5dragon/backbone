define [
  "text!component/field/age.html"
  "component/field/model"
  "component/field/animate.error"
], (
  template
  FieldModel
  AnimateError
) ->

  Backbone.View.extend

    model: new FieldModel

    events:
      "input input": (event) ->
        value = event.target.value  
        if !value.length || /^\d{1,3}$/.test(value) and parseInt(value) <= 150
          @animateError.hideAnimate ".empty"
          @animateError.hideAnimate ".incorrect"
        else if value.length
          @animateError.showAnimate ".incorrect"
        @model.set result: value

    getValue: ->
      result = @model.get "result"
      if result then result else  @animateError.showAnimate(".empty") and undefined

    initialize: ->
      $template = $(template)
      @$el.append $template
      @animateError = new AnimateError $template, [ ".empty", ".incorrect" ]