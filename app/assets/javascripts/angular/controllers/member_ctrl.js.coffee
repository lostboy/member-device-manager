angular.module("hubud")
  .controller "MemberCtrl", ($scope, $state, Restangular) ->

    Restangular.one("members", $state.params.id).get().then (response) ->
      $scope.member = response

    Restangular.all("devices/types").getList().then (response) ->
      $scope.deviceTypes = response

    # Add device input
    $scope.addDevice = ->
      $scope.member.devices.push {}

