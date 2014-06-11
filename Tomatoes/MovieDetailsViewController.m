//
//  MovieDetailsViewController.m
//  Tomatoes
//
//  Created by Stella Su on 6/5/14.
//  Copyright (c) 2014 Stella Su. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UIScrollView *movieScroll;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;
@property (weak, nonatomic) IBOutlet UIView *movieDetailView;

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
      }
    return self;
}


// This method is called right before the view animates in.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURL *posterURL = [NSURL
                        URLWithString: [self.movie
                                        valueForKeyPath:@"posters.original"]];
    
    [self.moviePoster setImageWithURL:posterURL];
    
    self.title = self.movie[@"title"];
    self.movieSynopsisLabel.text = self.movie[@"synopsis"];
    self.movieTitleLabel.text = self.movie[@"title"];
    
    [self.movieSynopsisLabel sizeToFit];
    CGRect newBackgroundViewFrame = self.movieDetailView.frame;

    newBackgroundViewFrame.size.height = self.movieSynopsisLabel.frame.origin.y + self.movieSynopsisLabel.frame.size.height + 200;
    self.movieDetailView.frame = newBackgroundViewFrame;

    [self.movieScroll setContentSize:CGSizeMake(self.movieScroll.frame.size.width, self.movieDetailView.frame.origin.y + self.movieDetailView.frame.size.height - 180)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
