//
//  MoviesViewController.m
//  Tomatoes
//
//  Created by Stella Su on 6/5/14.
//  Copyright (c) 2014 Stella Su. All rights reserved.
//

#import "MoviesViewController.h"

@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UILabel *networkStatusLabel;

// Array of movies
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        return self;
    }
    return nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.title = @"Movies";
    
}

- (void)showLoading
{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        self.hud.labelText = @"Loading";
            
}
         
-(void)hideLoading
{
    [self.hud hide:YES];
}

// After the view is created successfully from the nib, this method is called.
// This is a good place to configure your view, add gesture recognizers, add dynamics, etc.
- (void)viewDidLoad
{
    [super viewDidLoad];

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull to Refresh"];
    
    // Configure Refresh Control
    [refreshControl addTarget:self
                       action:@selector(refreshTableView:)
            forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    // Rotten Tomatoes's API
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    [self showLoading];
    
    // Make a network call
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         [self hideLoading];
         if (connectionError)
         {
             dispatch_async(dispatch_get_main_queue(), ^(void)
             {
                 self.networkStatusLabel.hidden = NO;
             });

         }
         else
         {
             id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             self.movies = object[@"movies"];
             // Keep render each row
             [self.tableView reloadData];
         }
    }];

    
    self.tableView.rowHeight = 125;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Look for the movies
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];

}

-(void)refreshTableView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    // End refreshing
    [refresh endRefreshing];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

// Tell me how many rows of movies
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Give me a movie cell
    MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
   
    NSDictionary *movie = self.movies[indexPath.row];
  
    // movie[@"title"] --? "title" is the key in the dictionary.
    movieCell.titleLabel.text = movie[@"title"];
    movieCell.synopsisLabel.text = movie[@"synopsis"];
    
    NSURL *posterUrl = [NSURL URLWithString:[movie valueForKeyPath:@"posters.detailed"]];
    [movieCell.posterView setImageWithURL:posterUrl];
    
    // If you want to add Movie Casts
    // NSArray *cast = movie[@"abridged_cast"];
    // for (NSDictionary ...
    
    return movieCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *myMovie = self.movies[indexPath.row];
    
    // Navigate to other screen
    MovieDetailsViewController *mdvc = [[MovieDetailsViewController alloc] init];
    mdvc.movie = myMovie;
    
    // Configure the subview here. Push a view controller
    mdvc.movie =
        self.movies[indexPath.row];
    [self.navigationController pushViewController:mdvc
                                         animated:YES];

}

@end
