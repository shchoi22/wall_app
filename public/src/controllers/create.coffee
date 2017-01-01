define [], () ->
  ($scope, Message, $state, $cacheFactory) ->
    $scope.createMessage = (content) ->
      Message.create({ content: content }).$promise
        .then () ->
          $cacheFactory.get("$http").removeAll()
          $state.go "home"
        .catch (err) ->
          console.log(err)