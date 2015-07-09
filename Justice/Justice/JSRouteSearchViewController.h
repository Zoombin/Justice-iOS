//
//  RouteSearchDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JSRouteSearchViewController : UIViewController<BMKMapViewDelegate, BMKRouteSearchDelegate, CLLocationManagerDelegate> {
    IBOutlet BMKMapView* _mapView;
//    IBOutlet UITextField* _startCityText;
//    IBOutlet UITextField* _startAddrText;
//    IBOutlet UITextField* _endCityText;
//    IBOutlet UITextField* _endAddrText;
    float currentLat;
    float currentLng;
    BMKRouteSearch* _routesearch;
    NSString *cityName;
}
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) CLLocationManager  *locationManager;
//-(IBAction)onClickBusSearch;
-(IBAction)onClickDriveSearch;
//-(IBAction)onClickWalkSearch;
- (IBAction)textFiledReturnEditing:(id)sender;


@end