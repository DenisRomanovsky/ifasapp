controllers = angular.module('controllers')
controllers.controller("UserInfoController", ($scope, $routeParams, $location, $resource) ->
  res = $resource('/user_info/:id')
  id = $routeParams.id
  res.get({id: id}, (resp) ->
    console.log(resp))
  res.create = () ->
    a = 4;
)
