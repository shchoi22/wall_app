define [], () ->
  ($scope, $state, AuthService, $stateParams, $cookies) ->
    $scope.signup = (username, password) ->
      AuthService.signup(username, password)
        .then () ->
          $state.go "welcome"
      .catch (error) ->
        $scope.error_message = error