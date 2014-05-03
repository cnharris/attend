App.controller("ReceiptsController", function($scope, $http, $routeParams, Charge){
  window.scrollTo(0,0);
  $scope.status = null;
  
  var urlParams = {
    charge_id: $routeParams.charge_id,
    user_id: $routeParams.user_id
  };
  
  $scope.charge = new Charge();
  $scope.charge.fetch(urlParams);
});
