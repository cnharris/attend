App.factory("Charge", [ '$http', 'APIFactory', function(http, APIFactory){
  
  function Charge(data){
    if(data){
      this.load(data);
    }
  }
  
  Charge.prototype = {
    
    load: function(data) {
      angular.extend(this, data);
    },
    
    fetch: function(params){
      if(!params.user_id || !params.charge_id) {
        console.log("Invalid params sent to Charge#fetch");
        return null;
      }
      
      var scope = this;
      return APIFactory.users.charges.show(params);
    },
    
    create: function(scope) {
      var form = scope.view.form[0];
      payload = {
        name: form.name.value,
        company: form.company.value,
        email: form.email.value,
        phone: form.phone.value,
        subscription: form.subscription.value,
        token: scope.token,
        card_token: scope.cardToken
      };
      
      return APIFactory.users.create(payload);
    }
    
  };
  
  return Charge;
  
}]);