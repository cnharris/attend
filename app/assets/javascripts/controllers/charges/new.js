App.controller("ChargesController", function($scope, $http, $routeParams, $location, Charge, Subscription){
  
  Subscription.all().then(
      function(response){
        if(response.status == 200){
          $scope.subscriptions = _.map(response.data,function(data){
            return new Subscription(data);
          });
          $scope.setMonthsAndYearsValues();
        }
      }, 
      function(response){
         console.log("Could not fetch subscription#index data");
      }
  );
  
  //Helpers
  $scope.view = {
    button: $(".btn-submit"),
    buttonLoader: $(".btn-loader"),
    form: $("form"),
    formErrors: $(".user-form-errors"),
    responseErrors: $(".user-response-errors")
  };
 
  $scope.setMonthsAndYearsValues = function(){
    this.months = [ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
    this.years = [ "2015", "2016", "2017", "2018" ];
  };
  
  $scope.setupValidation = function(){
    $("input").bind("focus", function(){
      $scope.view.responseErrors.fadeOut(400);
      $scope.view.formErrors.fadeOut(400);
      $scope.view.formErrors.html("");
    });
    $("button").bind("mouseenter", function(){
      $scope.view.formErrors.fadeOut(400,function(){
        $scope.view.formErrors.html("");
        $scope.view.responseErrors.html("")
      });
    });
  }();
  
  $scope.validateUserForm = function() {
    var invalid = [];
    var errored = false;
    var r = null;
    $scope.view.formErrors.html("");
    var elements = $scope.view.form.find("input,select");
    _.each(elements,function(element){
      var ename = element.name
      var evalue = element.value;
      if(ename == "email") {
        r = /^\S+@\S+$/;
        if(!(r.test(evalue))){
          invalid.push("valid email address");
          errored = true;
        }
      } else if(ename == "phone") {
          r = /^(\(\d{3}\)(|\s)|\d{3}|)-?\d{3}-?\d{4}$/;
          if(!(r.test(evalue))){
            invalid.push("valid phone");
            errored = true;
          }
      } else if(ename == "number") {
          r = /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/; 
          if(!(r.test(evalue))){
            invalid.push("valid credit card number");
            errored = true;
          }
      } else if(ename == "cvv") {
          r = /^\d{3,4}$/; 
          if(!(r.test(evalue))){
            invalid.push("valid cvv");
            errored = true;
          }
      } else if(!evalue || evalue == "") {
        invalid.push(ename);
        errored = true;
      }
    });
    
    if(errored) {
      $scope.view.formErrors.html("Come on now! You have to add or select a(n) "+invalid.join(", "));
      $scope.view.formErrors.fadeIn(400);
      return false;
    }
    
    $scope.submitForm();
  };
  
  $scope.handleError = function(response){
    $scope.view.responseErrors.html(response.error.message);
    $scope.view.responseErrors.fadeIn(200);
    $scope.view.buttonLoader.fadeOut(200);
    $scope.view.button.fadeIn(400);
    $scope.view.button.removeAttr('disabled');
  };
  
  $scope.submitForm = function(){
    var view = $scope.view;
    view.buttonLoader.fadeIn(200);
    view.button.fadeOut(200);
    view.button.attr('disabled', true);
    var form = view.form;
    $scope.stripeCardAttributes = {
      "number": form.find("input[name='number']").val(),
      "exp_month": form.find("select[name='month']").val(),
      "exp_year": form.find("select[name='year']").val(),
      "cvc": form.find("input[name='cvv']").val()
    };
    
    $scope.createStripeCardToken();
  };
  
  $scope.createStripeCardToken = function(){
    var view = $scope.view;
    Stripe.card.createToken($scope.stripeCardAttributes, function(status, response){
      if(response && response.error) {
        $scope.handleError(response);
        return false;
      }
      
      $scope.token = response.id;
      $scope.cardToken = response.card.id
      $scope.charge = new Charge();
      $scope.charge.create($scope).then(
          function(response){
            if(response.status == 200){
              $scope.charge.load(response.data.charge);
              $location.path("/users/"+$scope.charge.user_id+"/charges/"+$scope.charge.id);
            }
          }, 
          function(response){
             view.buttonLoader.fadeOut(200);
             view.button.fadeIn(200);
             view.button.removeAttr('disabled');
             $scope.handleError(response);
          }
      );
    });
  }
  
});