angular.module("hubud")
  .config ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode true

    $stateProvider
      .state "dashboard",
        url: "/"
        templateUrl: "/?format=html"
        controller: 'DashboardCtrl'

      .state "members",
        url: "/members"
        templateUrl: "/members.html"
        controller: 'MembersCtrl'

    $urlRouterProvider.otherwise "/"
