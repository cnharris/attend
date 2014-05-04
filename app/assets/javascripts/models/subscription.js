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
      }
    }
    
  };
  
  // Static methods
  Subscription.all = function(){
    return APIFactory.subscriptions.index()
  };
  
  return Subscription;
  
});