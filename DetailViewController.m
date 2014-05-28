//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by tbredemeier on 5/27/14.
//  Copyright (c) 2014 Mobile Makers Academy. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *rsvpCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *hostingGroupLabel;
@property (strong, nonatomic) IBOutlet UIWebView *eventDescriptionWebView;

@end

@implementation DetailViewController
- (IBAction)onEventWebsiteButtonPressed:(id)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.event[@"name"];
    self.rsvpCountLabel.text = [NSString stringWithFormat:@"Yes RSVP Count: %@",self.event[@"yes_rsvp_count"]];
    self.hostingGroupLabel.text = [NSString stringWithFormat:@"Hosted by:\n%@",self.event[@"group"] [@"name"]];
    [self.eventDescriptionWebView loadHTMLString:self.event[@"description"] baseURL:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *nextViewController = segue.destinationViewController;
    nextViewController.url = [NSURL URLWithString:self.event[@"event_url"]];
}

@end
