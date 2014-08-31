angular.module("hubud")
  .controller "MemberCtrl", ($scope, $state, Restangular) ->
    Restangular.one("members", $state.params.id).get().then (response) ->
      $scope.member = response
