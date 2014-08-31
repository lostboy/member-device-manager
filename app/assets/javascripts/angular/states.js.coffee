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

      .state "member",
        url: "/members/:id"
        templateUrl: (params) ->
          "/members/#{params.id}.html"
        controller: 'MemberCtrl'

    $urlRouterProvider.otherwise "/"
