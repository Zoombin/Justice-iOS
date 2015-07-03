//
//  PoiSearchViewController.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI/BMapKit.h>

@interface JSRouteSearchViewController : UIViewController<BMKMapViewDelegate, BMKPoiSearchDelegate,CLLocationManagerDelegate, UITextFieldDelegate> {
    IBOutlet BMKMapView* _mapView;
    IBOutlet UITextField* _cityText;
    IBOutlet UITextField* _keyText;
    IBOutlet UIButton* _nextPageButton;
    IBOutlet UIButton* _searchButton;
    BMKPoiSearch* _poisearch;
    int curPage;
}
@property (nonatomic, strong) CLLocationManager  *locationManager;
- (IBAction)onClickOk;
- (IBAction)onClickNextPage;
@end
