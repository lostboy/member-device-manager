angular.module("hubud")
  .controller "MembersCtrl", ($scope, Restangular, $timeout) ->

    fetchMembers = ->
      console.log "Update members"
      Restangular.all("members").getList().then (response) ->
        $scope.members = response

        # Fetch new members every 5 seconds
        $timeout fetchMembers, 5000

    fetchMembers()
