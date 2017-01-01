define [], () ->
  ($scope, $state, AuthService, $stateParams) ->
    $scope.login = (username, password) ->
      AuthService.login(username, password)
        .then ->
          $state.go "home"
        .catch ->
          #TODO Implement