 var mainApp = angular.module("frm", ['nouislider','ngtimeago','ui.materialize']);
         
         mainApp.controller('ListingController', function($scope,$http) {
            $scope.listings = []
            $scope.areas = []
            $scope.cities = []
            $scope.amenities = []

            $http.get("/listings_json.json").success(function (data) { 
               $scope.listings_length = data.length;                 
                angular.forEach(data,function (key) {
                    $scope.listings.push(key);                   
                });
            });  
            $http.get("/areas_json.json").success(function (data) {               
                angular.forEach(data,function (key) {
                    $scope.areas.push(key);                   
                });
            });  
            $http.get("/cities_json.json").success(function (data) {               
                angular.forEach(data,function (key) {
                    $scope.cities.push(key);                   
                });
            }); 
              $http.get("/amenities_json.json").success(function (data) {               
                angular.forEach(data,function (key) {
                    $scope.amenities.push(key);                   
                });
            });       

             $scope.filter = {};
             $scope.searchText = '';
             $scope.ListingCity = '';




              $scope.$watchGroup(['test.from', 'test.to'], function (newVals, oldVals) {
                   
                      $scope.range = {
                        minRent: newVals[0],
                        maxRent: newVals[1]
                    };

                     $scope.filterRange = function(obj) {
                        return obj.rent >= $scope.range.minRent && obj.rent <= $scope.range.maxRent;
                     };


                });
              $scope.rentorder = '-rent';
              $scope.$watch('rentOrder', function (val) {                   
                      $scope.rentorder = (val == 1) ? '-rent' : 'rent';                     
                });


              $scope.amenityIncludes = [];
    
              $scope.includeAmenity = function(amenity) {
                  var i = $.inArray(amenity, $scope.amenityIncludes);
                  if (i > -1) {
                      $scope.amenityIncludes.splice(i, 1);
                  } else {
                      $scope.amenityIncludes.push(amenity);
                  }
                  // console.log($scope.amenityIncludes)
              }
              
              $scope.amenityFilter = function(listing) {

                  if ($scope.amenityIncludes.length > 0) {
                      angular.forEach(listing.amenities, function(amenity){                        
                        if ($.inArray(amenity.name, $scope.amenityIncludes) < 0)
                          return;
                      });                      
                  }         
                  return listing;
              }


                
             
                // set the default amount of items being displayed
                $scope.limit = 100;
                $scope.loadMore = function() {  
                          $scope.limit += 5
                };
                
                $scope.loadMore();


         });


mainApp.directive('whenScrolled', function($window) {
    return function(scope, elm, attr) {
        var raw = elm[0];        
        elm.bind('scroll', function() {
            if (raw.scrollTop + raw.offsetHeight >= raw.scrollHeight) {
                scope.$apply(attr.whenScrolled);
            }
        });
    };
});
