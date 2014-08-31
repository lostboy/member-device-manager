angular.module("hubud")
  .controller "SidebarCtrl", ($scope) ->

    $scope.menuItems = [
      {
        state: "dashboard"
        text: "Overview"
      }, {
        state: "members"
        text: "Members"
      }

    ]
