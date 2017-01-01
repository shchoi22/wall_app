define [], () ->
  ($scope, messages, authenticated) ->
    $scope.messages = messages.objects
    $scope.authenticated = authenticated