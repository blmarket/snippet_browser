'use strict'

angular.module 'snippetBrowserApp'
.controller 'MainCtrl', ($scope, $resource, base64) ->
  $scope.codes = []
  $scope.codeCache = {}
  $scope.selected = null

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
    $scope.codes = (for it in data.data
      { name: it.name, info: it.path }
    )

    return

  $scope.load = (path) ->
    if $scope.codeCache[path]
      $scope.selected = $scope.codeCache[path]
      return
    Snippets.fetch { path: path }, (res) ->
      { content, type, encoding } = res.data
      return unless type == 'file'
      res.content = base64.decode content.replace(/\n/g, '')
      $scope.selected = $scope.codeCache[path] = res
      return
    return
  return
