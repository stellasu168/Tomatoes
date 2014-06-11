//
//  MoviesViewController.h
//  Tomatoes
//
//  Created by Stella Su on 6/5/14.
//  Copyright (c) 2014 Stella Su. All rights reserved.
//  This should call MovieMasterViewController.

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "MBProgressHUD.h"


@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property UIRefreshControl *refreshControl;

-(void)refreshTableView:(UIRefreshControl *)refresh;

@end
