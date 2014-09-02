angular.module("hubud")
  .controller "ApplicationCtrl", ($rootScope, $scope, $location) ->

    $scope.menuItems = [
      {
        state: "dashboard"
        text: "Dashboard"
      }, {
        state: "members"
        text: "Members"
      }

    ]
