angular.module("hubud")
  .filter "markdown", ->
    (input) ->
      if input
        marked.setOptions
          tables: false
          sanitize: true
        marked input
