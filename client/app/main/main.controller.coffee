'use strict'

angular.module 'snippetBrowserApp'
.controller 'MainCtrl', ($scope, $resource) ->
  $scope.awesomeThings = [ {
    name: 'Dev Tools'
    info: 'haha'
  } ]

  endPoint = 'https://api.github.com/repos/:owner/:repo'
  Master = $resource "#{endPoint}/git/refs/:ref", {
    owner: 'blmarket'
    repo: 'icpc'
    ref: 'heads/master'
  }

  Commit = $resource "#{endPoint}/git/commits/:sha", {
    owner: 'blmarket'
    repo: 'icpc'
  }

  Contents = $resource "#{endPoint}/contents/:path", {
    owner: 'blmarket'
    repo: 'icpc'
    callback: 'JSON_CALLBACK'
  }, { fetch: { method: 'JSONP', isArray: false } }

  content = Contents.fetch path: 'snippets/graph.cpp', ->
    console.log content
