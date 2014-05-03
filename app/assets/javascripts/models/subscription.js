App.factory("Subscription", function(APIFactory){
  
  function Subscription(data){
    if(data) {
      this.load(data);
    }
  }
  
  // Instance methods 
  Subscription.prototype = {
    
    load: function(data) {
      if(data) {
        angular.extend(this, data);
        console.log(data);
      }
    }
    
  };
  
  // Static methods
  Subscription.all = function(){
    return APIFactory.subscriptions.index().success(function(response) {
    }).error(function(error) {
      console.log("failed");
      console.log("SubscriptionModel list error: "+error);
    });
  };
  
  return Subscription;
  
});