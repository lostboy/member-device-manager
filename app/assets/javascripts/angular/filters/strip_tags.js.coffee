angular.module("hubud")
  .filter "stripTags", () ->
    (input) ->
      input.replace /(<([^>]+)>)/ig, " "
