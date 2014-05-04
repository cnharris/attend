App.controller("ReceiptsController", function($scope, $http, $routeParams, Charge){
  window.scrollTo(0,0);
  $scope.status = null;
  
  var urlParams = {
    charge_id: $routeParams.charge_id,
    user_id: $routeParams.user_id
  };
  
  $scope.charge = new Charge();
  $scope.charge.fetch(urlParams).then(
    function(response) {
      if(response.status == 200) {
        $scope.status = 200;
        $scope.charge.load(response);
      }
    },
    function(response) {
      $scope.status = 400;
      console.log("ChargeModel create error: "+response);
    }
  );

});
