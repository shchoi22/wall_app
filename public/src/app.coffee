define [], () ->
  angular.module 'wallapp', [
    'ngResource', 'ngSanitize','ngCookies', "ngStorage", 'ui.router'
  ]
  .constant "REST_API_URL", ENV.REST_API_URL
  .service 'AuthService', require("./services/authService.coffee")
  .factory "Message", require("./resources/message.coffee")
  .config ($urlMatcherFactoryProvider, $locationProvider, $resourceProvider) ->
    $urlMatcherFactoryProvider.strictMode false
    $urlMatcherFactoryProvider.caseInsensitive true
    $locationProvider.html5Mode(true).hashPrefix('!')
    $resourceProvider.defaults.stripTrailingSlashes = false
  .config require('./routes.coffee')
  .config ($httpProvider) ->
    $httpProvider.interceptors.push () ->
      'request': (config) ->
        config.withCredentials = true
        config
  .run ($urlRouter, $rootScope, $cacheFactory, $localStorage, $state, REST_API_URL) ->
    $rootScope.REST_API_URL = REST_API_URL

    $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, promise) ->
      event.preventDefault()
      console.log('state change error!')

    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      if not toState.public
        if AuthService.authenticated()
          $urlRouter.sync()
        else
          AuthService.getMe()
            .then () ->
              if AuthService.authenticated()
                $urlRouter.sync()
              else
                $state.go "home"

    $rootScope.$storage = $localStorage