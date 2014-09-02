angular.module("hubud")
  .controller "MembersCtrl", ($scope, Restangular, $timeout, hotkeys) ->

    fetchMembers = ->
      console.log "Update members"
      Restangular.all("members").getList().then (response) ->
        $scope.members = response

        # Fetch new members every 5 seconds
        $timeout fetchMembers, 5000

    fetchMembers()

    # Bind hotkeys
    hotkeys.bindTo($scope)
      .add
        combo: '/'
        description: 'Focus on the search field'
        callback: (event, callback) ->
          $("#member-search").focus()
          event.preventDefault()
