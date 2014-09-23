'use strict'

angular.module 'snippetBrowserApp'
.controller 'MainCtrl', ($scope, $resource, base64) ->
  $scope.codes = []
  $scope.awesomeThings = [ {
    name: 'Dev Tools'
    info: 'haha'
  } ]

  endPoint = 'https://api.github.com/repos/:owner/:repo'
  Snippets = $resource "#{endPoint}/contents/snippets", {
    owner: 'blmarket'
    repo: 'icpc'
    callback: 'JSON_CALLBACK'
  }, {
    query: { method: 'JSONP', isArray: false }
    fetch: { url: "#{endPoint}/contents/:path", method: 'JSONP', isArray: false }
  }

  Snippets.query (data) ->
    $scope.awesomeThings = (for it in data.data
      { name: it.name, info: it.path }
    )

    $scope.codes = for it in data.data
      Snippets.fetch { path: it.path }, (res) ->
        { content, type, encoding } = res.data
        return unless type == 'file'
        res.content = base64.decode content.replace(/\n/g, '')
        return
    return

  return
