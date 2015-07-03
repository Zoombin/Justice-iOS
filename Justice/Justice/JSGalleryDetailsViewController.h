//
//  JSGalleryDetailsViewController.h
//  Justice
//
//  Created by zhangbin on 6/26/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSGallery.h"

@interface JSGalleryDetailsViewController : UIViewController

@property (nonatomic, strong) JSGallery *gallery;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@end
