define [], () ->
  ($http, $rootScope, $cacheFactory, REST_API_URL) ->
    AuthService =
      authenticated: () -> 
        $rootScope.user?
      signup: (username, password) ->
        register_data =
          username: username
          password: password
        $http.post "#{REST_API_URL}/api/v1/users/signup/",
          register_data
      login: (username, password) ->
        $cacheFactory.get("$http").removeAll()
        $http.post "#{REST_API_URL}/api/v1/users/login/",
          username: username
          password: password
        .then (user) ->
          $rootScope.user = user
        .catch (err) ->
          err
      getMe: () ->
        $cacheFactory.get("$http").removeAll()
        $http.get "#{REST_API_URL}/api/v1/users/"
          .then (user) ->
            $rootScope.user = user
          .catch (err) ->
            err

    AuthService