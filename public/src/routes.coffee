define [], () ->
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state('home',
        url: '^/',
        template: require('./views/home.html')
        resolve:
          messages: (Message) ->
            Message.get().$promise
          authenticated: (AuthService) ->
            if not AuthService.authenticated()
              AuthService.getMe()
                .then () ->
                  return AuthService.authenticated()
            else
              return true
        controller: require('./controllers/home.coffee')
        public: true
      )
      .state('login',
        url: '/login',
        template: require('./views/login.html')
        controller: require('./controllers/login.coffee')
        public: true
      )
      .state('signup',
        url: '/signup',
        template: require('./views/signup.html')
        controller: require('./controllers/signup.coffee')
        public: true
      )
      .state('welcome',
        url: '/welcome',
        template: require('./views/welcome.html')
        public: true
      )
      .state('create', 
        url: '/create', 
        template: require('./views/create.html')
        controller: require('./controllers/create.coffee')
        public: false
      )

    $urlRouterProvider.otherwise ($injector, $location) -> 
      $injector.get("$state").go "home"