receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
])

receta.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
    .when('/',
      templateUrl: "home.html"
      controller: 'RecipesController'
    )    
    .when('/user_info/:id',
      templateUrl: "user_info.html"
      controller: 'UserInfoController'
    )
])

controllers = angular.module('controllers',[])