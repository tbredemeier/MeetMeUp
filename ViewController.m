//
//  ViewController.m
//  MeetMeUp
//
//  Created by tbredemeier on 5/27/14.
//  Copyright (c) 2014 Mobile Makers Academy. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSDictionary *data;
@property NSArray *events;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError)
    {
        self.data = [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:&connectionError];
        self.events = self.data[@"results"];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *event = [self.events objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"eventCellID"];

    cell.textLabel.text = event[@"name"];
    cell.detailTextLabel.text = event[@"venue"][@"address_1"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *selectedEvent = [self.events objectAtIndex:selectedPath.row];
    DetailViewController *nextViewController = segue.destinationViewController;
    nextViewController.event = selectedEvent;
}

@end
