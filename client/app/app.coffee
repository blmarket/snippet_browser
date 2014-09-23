'use strict'

angular.module 'snippetBrowserApp', [
  'ngCookies'
  'ngResource'
  'ngSanitize'
  'ui.router'
  'ui.bootstrap'
  'ab-base64'
  'hljs'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, hljsServiceProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true

  hljsServiceProvider.setOptions {
    tabReplace: '  '
  }
