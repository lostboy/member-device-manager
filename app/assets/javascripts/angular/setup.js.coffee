angular.module "hubud", [
  "ngAnimate",
  "ngTouch",
  "ngSanitize",
  "ui.router",
  "restangular",
  "ui.bootstrap",
  "cfp.hotkeys"
]

angular.module("hubud")
  .config ($httpProvider) ->
    authToken = $("meta[name=\"csrf-token\"]").attr("content")
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
    $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"
    $httpProvider.defaults.headers.common["Accept"] = "text/html,application/json"
  .config (RestangularProvider) ->
    RestangularProvider.setRequestSuffix '.json'
