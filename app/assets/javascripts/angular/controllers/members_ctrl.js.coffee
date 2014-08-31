angular.module("hubud")
  .controller "MembersCtrl", ($scope, Restangular) ->
    Restangular.all("members").getList().then (response) ->
      $scope.members = response
