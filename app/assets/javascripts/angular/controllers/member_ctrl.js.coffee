angular.module("hubud")
  .controller "MemberCtrl", ($scope, $state, $http, Restangular) ->

    Restangular.one("members", $state.params.id).get().then (response) ->
      $scope.member = response

    Restangular.all("devices/types").getList().then (response) ->
      $scope.deviceTypes = response

    # Add device input
    $scope.addDevice = ->
      $scope.member.devices.push {}

    # Submit handler
    $scope.submit = ->
      devices = _.map($scope.member.devices, (device) ->
        {
          id: device.id,
          mac_address: device.mac_address,
          type_id: device.type_id,
          _destroy: device.destroy || false
        }
      )

      # If the need for updating more than devices arise, we need to add those
      # attributes here.
      payload = $.param({
        member: {
          devices_attributes: devices,
        }
      })

      $http(
        method: "PATCH"
        url: '/members/' + $scope.member.id
        data: payload
        headers:
          "Content-Type": "application/x-www-form-urlencoded"
      ).success (data, status, headers, config) ->
        console.log "Success!"

        # Remove all devices that we have deleted, this is important
        # so that we don't try to remove the device again.
        _.remove($scope.member.devices, (device) ->
          device.destroy
        )
