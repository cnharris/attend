App.config(['$routeProvider', '$locationProvider',
  function($routeProvider) {
    $routeProvider.
      when('/charges/new', {
        templateUrl: 'assets/templates/charges/new.html',
        controller: 'ChargesController'
      }).
      when('/users/:user_id/charges/:charge_id', {
        templateUrl: 'assets/templates/charges/show.html',
        controller: 'ReceiptsController'
      }).
      otherwise({
        redirectTo: '/charges/new'
      });
  }]
).run(function ($rootScope, $location) { //Insert in the function definition the dependencies you need.
    //Do your $on in here, like this:
    $rootScope.$on("$routeChangeStart",function(event, next, current){
      $(".loading").show();
    });
    
    $rootScope.$on("$routeChangeSuccess",function(event, next, current){
      $(".loading").hide();
    });
});
