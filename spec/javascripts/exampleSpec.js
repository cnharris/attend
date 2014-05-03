describe("Addition", function () {
  var $rootScope, testController;

  beforeEach(angular.mock.module('Attend'));

  it('should create "phones" model with 3 phones', inject(function($controller) {
    var scope = {},
        ctrl = $controller('SubscriptionsController', { $scope: scope });

    expect(scope.phones.length).toBe(3);
  }));

});