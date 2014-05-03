App.factory('APIFactory', function($http) {
  return {
    subscriptions: {
      index: function() {
        return $http({
          url: '/subscriptions.json',
          method: 'GET'
        });
      },
      
      show: function(id) {
        if(!id) {
          console.log("No id supplied to subscription#show");
          return null;
        }
        
        return $http({
          url: '/subscriptions/'+id+'.json',
          method: 'GET'
        });
      }
    },
    
    users: {  
      create: function(data) {
        return $http({
          url: '/users.json',
          method: 'POST',
          data: data,
          headers: {'Content-Type': 'application/json'}
        });
      },
      
      charges: {
        show: function(params) {
          if(!params) {
            console.log("No params supplied to users/:user_id/charges/:charge_id route.");
            return false;
          }
          
          return $http({
            url: '/users/'+params["user_id"]+'/charges/'+params["charge_id"]+'.json',
            method: 'GET'
          });
        }
      }
      
    }
    
  };
});