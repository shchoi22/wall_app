define [], () ->
  ($resource, REST_API_URL) ->
    $resource(
      "#{REST_API_URL}/api/v1/messages/",
      {},
      {
        get:
          cache: true
        create:
          method: "POST"
          url: "#{REST_API_URL}/api/v1/messages/"
      }
    )
