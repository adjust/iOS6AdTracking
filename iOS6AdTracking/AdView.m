//
//  AdView.m
//  iOS6AdTracking
//
//  Created by Christian Wellenbrock on 09.10.12.
//  Copyright (c) 2012 adeven. All rights reserved.
//

#import "Adview.h"
// In this example we use AFNetworking to make the callback.
#import "AFNetworking.h"
// Used to retrieve the identifier for advertising.
#import <AdSupport/AdSupport.h>

// The most important part of the implementation is the first method which handles a click.
// The rest of the methods illustrate how this pseudo banner view works.
@implementation AdView

// This method gets called when somebody touched the adView. In that case we'll present the
// product view controller and make the callback.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Prepare the product view controller by providing the product ID.
    SKStoreProductViewController *productViewController = [[[SKStoreProductViewController alloc] init] autorelease];
    productViewController.delegate = self;
    NSDictionary *storeParameters = [NSDictionary dictionaryWithObject:self.productId forKey:SKStoreProductParameterITunesItemIdentifier];
    
    // Try to load the product and present the product view controller in case of success.
    [productViewController loadProductWithParameters:storeParameters completionBlock:^(BOOL result, NSError *error) {
        if (!result) {
            NSLog(@"Failed to load product: %@", error);
        } else {
            [self.parentViewController presentViewController:productViewController animated:YES completion:^(void) {
                NSLog(@"Presented product with ID: %@", self.productId);
            }];
        }
    }];
    
    // make the callback
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.callbackUrl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setRedirectResponseBlock:^NSURLRequest *(NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse) {
        NSString *url = request.URL.absoluteString;
        if (redirectResponse == nil) {
            NSLog(@"request to  %@", url);
        } else {
            NSLog(@"redirect to %@", url);
        }
        return request;
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
    [operation start];
}

// SKStoreProductViewControllerDelegate method that dismisses the product view controller
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismissed product view controller.");
    }];
}

// This initialiser sets the parentViewController.
- (id)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController {
    if ((self = [super initWithFrame:frame])) {
        self.parentViewController = viewController;
    }
    return self;
}

- (void)loadAd {
    // This method should load and display an actual ad and set the productId and callback URL.
    // For the purpose of this demonstration we will mock this by setting hardcoded values.
    self.productId = @"315215396";
    self.callbackUrl = @"http://www.example.com/callback";
    self.advertisingId = [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
}

@end
