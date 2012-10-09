//
//  ViewController.m
//  iOS6AdTracking
//
//  Created by Christian Wellenbrock on 09.10.12.
//  Copyright (c) 2012 adeven. All rights reserved.
//

#import "ViewController.h"
#import "AdView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Build, initialise and show an adview.
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    AdView *adView = [[[AdView alloc] initWithFrame:frame viewController:self] autorelease];
    [adView loadAd];
    [self.view addSubview:adView];
    
    // Add a label to make the ad view visible.
    UILabel *label = [[[UILabel alloc] initWithFrame:adView.bounds] autorelease];
    label.text = @"Click here!";
    label.font = [UIFont boldSystemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    [adView addSubview:label];
}

@end
