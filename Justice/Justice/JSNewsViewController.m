//
//  JSNewsViewController.m
//  Justice
//
//  Created by zhangbin on 6/23/15.
//  Copyright (c) 2015 zoombin. All rights reserved.
//

#import "JSNewsViewController.h"
#import "Header.h"
#import "JSNews.h"
#import "JSGallery.h"
#import "JSGalleryPhoto.h"
#import "JSGalleryDetailsViewController.h"
#import "JSVideo.h"
#import "JSNewsTableViewCell.h"
#import "JSNewsDetailViewController.h"
#import "JSVideoTableViewCell.h"
#import "JSWebViewViewController.h"
#import "JSImgTableViewCell.h"

@interface JSNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite) UITableView *tableView;
@property (readwrite) UICollectionView *collectionView;
@property (readwrite) UITableView *videosTableView;
@property (readwrite) NSArray *bannerNews;
@property (readwrite) NSArray *multiNews;
@property (readwrite) NSArray *galleries;
@property (readwrite) NSArray *videos;
@property (readwrite) UISegmentedControl *segmentedControl;

@end

@implementation JSNewsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"普法宣传";
        UIImage *normalImage = [UIImage imageNamed:@"News"];
        UIImage *selectedImage = [UIImage imageNamed:@"NewsHighlighted"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"趣闻", @"照片", @"视频"]];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor whiteColor];
    [_segmentedControl addTarget:self action:@selector(segmentedControlChanged) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
    
    [self loadInfo];
    [self getBannerView];
}

- (void)showBannerView {
    if ([_bannerNews count] == 0) {
        return;
    }
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 150;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, height)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(screenWidth * [_bannerNews count], 0);
    for (int i = 0; i < [_bannerNews count]; i++) {
        JSNews *news = _bannerNews[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * screenWidth, 0, screenWidth, height)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView setImageWithURL:[NSURL URLWithString:news.imagePath] placeholderImage:[UIImage imageNamed:@"NewsPlaceholder"]];
        imgView.userInteractionEnabled = YES;
        imgView.tag = i;
        [scrollView addSubview:imgView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerBkgClick:)];
        [imgView addGestureRecognizer:gesture];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * screenWidth, CGRectGetMaxY(imgView.frame) - 30, screenWidth, 30)];
        titleLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = [NSString stringWithFormat:@"\t%@", news.title];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:titleLabel];
    }
    
    [_tableView setTableHeaderView:scrollView];
}

- (void)bannerBkgClick:(UIGestureRecognizer *)gesture {
    UIView *view = [gesture view];
    JSNews *news = _bannerNews[view.tag];
    JSNewsDetailViewController *detailViewController = [JSNewsDetailViewController new];
    detailViewController.news = news;
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)getBannerView {
    [[JSAPIManager shared] getBanner:^(NSArray *multiAttributes, NSError *error, NSString *message) {
        if (!error) {
            NSLog(@"%@", multiAttributes);
            _bannerNews = [JSNews multiWithAttributesArray:multiAttributes];
            [self showBannerView];
        }
    }];
}

- (void)loadInfo {
    [self displayHUD:@"加载中..."];
    if (_segmentedControl.selectedSegmentIndex == 0) {
        [[JSAPIManager shared] newsInPage:@(0) withBlock:^(NSArray *multiAttributes, NSError *error, NSString *message) {
            [self hideHUD:YES];
            if (!error) {
                _multiNews = [JSNews multiWithAttributesArray:multiAttributes];
                [self showBannerView];
                [_tableView reloadData];
            }
        }];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        [[JSAPIManager shared] galleriesInPage:@(0) withBlock:^(NSArray *multiAttributes, NSError *error, NSString *message) {
            [self hideHUD:YES];
            if (!error) {
                _galleries = [JSGallery multiWithAttributesArray:multiAttributes];
                [_tableView setTableHeaderView:nil];
                [_tableView reloadData];
            }
        }];
    } else {
        [[JSAPIManager shared] videosInPage:@(0) withBlock:^(NSArray *multiAttributes, NSError *error, NSString *message) {
            [self hideHUD:YES];
            if (!error) {
                _videos = [JSVideo multiWithAttributesArray:multiAttributes];
                [_tableView setTableHeaderView:nil];
                [_tableView reloadData];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentedControlChanged {
//    _tableView.hidden = _collectionView.hidden = _videosTableView.hidden = YES;
//    if (_segmentedControl.selectedSegmentIndex == 0) {
//        _tableView.hidden = NO;
//    } else if (_segmentedControl.selectedSegmentIndex == 1) {
//        _collectionView.hidden = NO;
//    } else {
//        _tableView.hidden = NO;
//    }
    [self loadInfo];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        return _multiNews.count;
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        return _galleries.count;
    }
    return _videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        static NSString *CellIdentifier = @"UITableViewCell";
        JSNewsTableViewCell *cell = (JSNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JSNewsTableViewCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        }
        JSNews *news = _multiNews[indexPath.row];
        cell.titleLabel.text = news.title;
        NSMutableString *detailsString = [NSMutableString string];
        [detailsString appendString:[news.content substringToIndex:40]];
        [detailsString appendString:@"\n"];
        [detailsString appendString:news.createdDate.description];//hard code
        cell.contentLabel.text = detailsString;
        
        if (news.imagePath.length) {
            [cell.imgView
             setImageWithURL:[NSURL URLWithString:news.imagePath] placeholderImage:[UIImage imageNamed:@"NewsPlaceholder"]];
        }
        return cell;
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        static NSString *CellIdentifier = @"UITableViewCell";
        JSImgTableViewCell *cell = (JSImgTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JSImgTableViewCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        JSGallery *gallery = _galleries[indexPath.row];
        cell.titleLabel.text = gallery.title;
        if ([gallery.photos count] > 0) {
            JSGalleryPhoto *photo = gallery.photos[0];
            if (photo.imagePath.length) {
                [cell.imgView setImageWithURL:[NSURL URLWithString:photo.imagePath] placeholderImage:[UIImage imageNamed:@"NewsPlaceholder"]];
            }
        }
        return cell;
    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        static NSString *CellIdentifier = @"UITableViewCell";
        JSVideoTableViewCell *cell = (JSVideoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JSVideoTableViewCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        JSVideo *video = _videos[indexPath.row];
        cell.titleLabel.text = video.title;
        cell.contentLabel.text = video.content;
        if (video.imagePath.length) {
            [cell.imgView setImageWithURL:[NSURL URLWithString:video.imagePath] placeholderImage:[UIImage imageNamed:@"NewsPlaceholder"]];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        return 100;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_segmentedControl.selectedSegmentIndex == 0) {
        JSNewsDetailViewController *detailViewController = [JSNewsDetailViewController new];
        detailViewController.news = _multiNews[indexPath.row];
        detailViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailViewController animated:YES];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        JSGallery *gallery = _galleries[indexPath.row];
        JSGalleryDetailsViewController *galleryDetailsViewController = [[JSGalleryDetailsViewController alloc] initWithNibName:nil bundle:nil];
        galleryDetailsViewController.gallery = gallery;
        galleryDetailsViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:galleryDetailsViewController animated:YES];

    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        JSVideo *video = _videos[indexPath.row];
        JSWebViewViewController *webViewController = [JSWebViewViewController new];
        webViewController.url = video.streamPath;
        webViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

@end
