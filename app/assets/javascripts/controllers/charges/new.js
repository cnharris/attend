App.controller("ChargesController", function($scope, $http, $routeParams, $location, Charge, Subscription){
    
  Subscription.all().then(function(response){
    if(response && response.data) {
      $scope.subscriptions = _.map(response.data,function(data){
        return new Subscription(data);
      });
      $scope.loadDependencies([ "setMonthsAndYearsValues" ]);
    } else {
      console.log("Could not fetch subscription#index data");
    }
  });
  
  //Helpers
  $scope.loadDependencies = function(){
    _.each(arguments,function(arg){
      var func = $scope[arg];
      if(typeof func === "function"){
        $scope[arg].call($scope);
      }
    });
  };
  
  $scope.setMonthsAndYearsValues = function(){
    this.months = [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
    this.years = [ "2015", "2016", "2017", "2018" ];
  };
  
  $scope.setupValidation = function(){
    $scope.formErrors = $(".user-form-errors");
    $("input").bind("focus", function(){
      $scope.formErrors.fadeOut(400);
      $scope.formErrors.html("");
    });
    $("button").bind("mouseenter", function(){
      $scope.formErrors.fadeOut(400,function(){
        $scope.formErrors.html("");
      });
    });
  }();
  
  $scope.validateUserForm = function(){
    var invalid = [];
    var errored = false;
    var r = null;
    $scope.formErrors.html("");
    _.each($scope.userForm,function(element){
      var value = element.$viewValue;
      if(element.$name == "email") {
        r = /^\S+@\S+$/;
        if(!(r.test(value))){
          invalid.push("valid email address");
          errored = true;
        }
      } else if(element.$name == "phone") {
          r = /^(\(\d{3}\)(|\s)|\d{3}|)-?\d{3}-?\d{4}$/;
          if(!(r.test(value))){
            invalid.push("valid phone");
            errored = true;
          }
      } else if(element.$name == "number") {
          r = /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/; 
          if(!(r.test(value))){
            invalid.push("valid credit card number");
            errored = true;
          }
      } else if(element.$name == "cvv") {
          r = /^\d{3,4}$/; 
          if(!(r.test(value))){
            invalid.push("valid cvv");
            errored = true;
          }
      } else if(element.$invalid) {
        invalid.push(element.$name);
        errored = true;
      }
    });
    
    if(errored) {
      $scope.formErrors.html("Come on now! You have to add or select a(n) "+invalid.join(", "));
      $scope.formErrors.fadeIn(400);
      return false;
    }
    
    $scope.submitForm();
  };
  
  $scope.submitForm = function(){
    var token = null;
    var cardToken = null;
    $('#user-form').click(function(event) {
      $(".btn-loader").fadeIn(200);
      $(".btn-submit").fadeOut(200);
      var form = $(this);
      form.find('button').prop('disabled', true);
      var attrs = {
        "number": form.find("input[name='number']").val(),
        "exp_month": form.find("select[name='month']").val(),
        "exp_year": form.find("select[name='year']").val(),
        "cvc": form.find("input[name='cvv']").val()
      };
       
      Stripe.card.createToken(attrs, function(status, response){
        $scope.token = response.id;
        $scope.cardToken = response.card.id
        $scope.charge = new Charge();
        $scope.charge.create($scope).then(function(response){
          if(response && response.data){
            $scope.charge.load(response.data.charge);
            $location.path("/users/"+$scope.charge.user_id+"/charges/"+$scope.charge.id);
          } else {
            $(".btn-loader").fadeOut(200);
            $(".btn-submit").fadeIn(200);
          }
        });
      });
    });
  };
});
