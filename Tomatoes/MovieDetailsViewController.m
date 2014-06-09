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
    
    // [self.movieScroll addSubview:self.movieSynopsisLabel];
    self.movieScroll.contentSize = CGSizeMake(0, 680);
    //
    [self.movieScroll setContentOffset:CGPointMake(self.movieScroll.contentOffset.y, 0) animated:YES];
    
    //[self.movieScroll addSubview:self.movieDetailView];
    
    NSURL *posterURL = [NSURL
                        URLWithString: [self.movie
                                        valueForKeyPath:@"posters.original"]];
    
    [self.moviePoster setImageWithURL:posterURL];
    self.title = self.movie[@"title"];
    self.movieSynopsisLabel.text = self.movie[@"synopsis"];
    self.movieTitleLabel.text = self.movie[@"title"];
  
}

// Set up your properties here
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // Do any additional setup after loading the view from its nib.
//
//    NSURL *posterURL = [NSURL
//                        URLWithString: [self.movie
//                        valueForKeyPath:@"posters.original"]];
//
//    [self.moviePoster setImageWithURL:posterURL];
//    self.movieSynopsisLabel.text = self.movie[@"synopsis"];
//                                          
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
