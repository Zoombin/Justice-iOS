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

@interface JSNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (readwrite) UITableView *tableView;
@property (readwrite) NSArray *multiNews;
@property (readwrite) NSArray *galleries;
@property (readwrite) NSArray *videos;

@end

@implementation JSNewsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = @"普法宣传";
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
	
	[self displayHUD:@"加载中..."];
//	[[JSAPIManager shared] newsInPage:@(0) withBlock:^(NSArray *multiAttributes, NSError *error, NSString *message) {
//		[self hideHUD:YES];
//		if (!error) {
//			_multiNews = [JSNews multiWithAttributesArray:multiAttributes];
//			[_tableView reloadData];
//		}
//	}];
	
	
//	[[JSAPIManager shared] galleriesInPage:@(0) withBlock:^(NSArray *multiAttributes, NSError *error, NSString *message) {
//		[self hideHUD:YES];
//		if (!error) {
//			_galleries = [JSGallery multiWithAttributesArray:multiAttributes];
//			[_tableView reloadData];
//		}
//	}];
	
	
	[[JSAPIManager shared] videosInPage:@(0) withBlock:^(NSArray *multiAttributes, NSError *error, NSString *message) {
		[self hideHUD:YES];
		if (!error) {
			_videos = [JSVideo multiWithAttributesArray:multiAttributes];
			[_tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[UITableViewCell identifier]];
	}
//	JSNews *news = _multiNews[indexPath.row];
//	cell.textLabel.text = news.title;
//	NSMutableString *detailsString = [NSMutableString string];
//	[detailsString appendString:[news.content substringToIndex:40]];
//	[detailsString appendString:@"\n"];
//	[detailsString appendString:@"2015-07-10"];//hard code
//	cell.detailTextLabel.text = detailsString;
//	cell.detailTextLabel.numberOfLines = 0;
//	
//	if (news.imagePath.length) {
//		[cell.imageView setImageWithURL:[NSURL URLWithString:news.imagePath] placeholderImage:[UIImage imageNamed:@"NewsPlaceholder"]];
//	}
	
	
//	JSGallery *gallery = _galleries[indexPath.row];
//	cell.textLabel.text = gallery.title;
	
	
	JSVideo *video = _videos[indexPath.row];
	cell.textLabel.text = video.title;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//	JSGallery *gallery = _galleries[indexPath.row];
//	JSGalleryDetailsViewController *galleryDetailsViewController = [[JSGalleryDetailsViewController alloc] initWithNibName:nil bundle:nil];
//	galleryDetailsViewController.gallery = gallery;
//	[self.navigationController pushViewController:galleryDetailsViewController animated:YES];
}

@end
