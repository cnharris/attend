App.factory("Charge", [ '$http', 'APIFactory', function(http, APIFactory){
  
  function Charge(data){
    if(data){
      this.load(data);
    }
  }
  
  Charge.prototype = {
    
    load: function(data){
      angular.extend(this,data);
    },
    
    fetch: function(params){
      if(!params.user_id || !params.charge_id) {
        console.log("Invalid params sent to Charge#fetch");
        return null;
      }
      
      var scope = this;
      APIFactory.users.charges.show(params).success(function(response) {
        scope.load(response);
        scope.status = 200;
      }).error(function(error) {
        console.log("ChargeModel create error: "+error);
        scope.status = 400;
      });
    },
    
    create: function(scope) {
      var form = scope.userForm;
      payload = {
          name: form.name.$viewValue,
          company: form.company.$viewValue,
          email: form.email.$viewValue,
          phone: form.phone.$viewValue,
          subscription: form.subscription.$viewValue,
          token: scope.token,
          card_token: scope.cardToken
      };
      
      var scope = this;
      return APIFactory.users.create(payload).success(function(response) {
      }).error(function(error) {
        console.log("User create error: "+error);
      });
    }
    
  };
  
  return Charge;
  
}]);