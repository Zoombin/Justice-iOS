//
//  JSNewsDetailViewController.m
//  Justice
//
//  Created by yc on 15-7-1.
//  Copyright (c) 2015年 zoombin. All rights reserved.
//

#import "JSNewsDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "JSGalleryDetailsViewController.h"
#import "JSGalleryPhoto.h"

@interface JSNewsDetailViewController ()

@end

@implementation JSNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.titleLabel.text = _news.title;
    NSMutableString *detailsString = [NSMutableString string];
    [detailsString appendString:_news.content];
    self.contentLabel.text = detailsString;
    
    if (_news.imagePath.length) {
        [self.imgView
         setImageWithURL:[NSURL URLWithString:_news.imagePath] placeholderImage:[UIImage imageNamed:@"NewsPlaceholder"]];
    }
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageDetail)];
    [self.imgView addGestureRecognizer:gesture];
}

- (void)showImageDetail {
    JSGalleryDetailsViewController *detailViewController = [JSGalleryDetailsViewController new];
    JSGalleryPhoto *photo = [[JSGalleryPhoto alloc] init];
    photo.imagePath = _news.imagePath;
    JSGallery *gallery = [[JSGallery alloc] initWithAttributes:nil];
    gallery.photos = @[photo];
    detailViewController.gallery = gallery;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
