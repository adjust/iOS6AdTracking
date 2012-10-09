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
            [self.parentViewController  presentViewController:productViewController animated:YES completion:^(void) {
                NSLog(@"Presented product with ID: %@", self.productId);
            }];
        }
    }];
    
    // Prepare the callback request using the callback URL and the advertising ID.
    NSURL *baseUrl = [NSURL URLWithString:self.callbackUrl];
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:baseUrl];
    NSDictionary *httpParameters = [NSDictionary dictionaryWithObject:self.advertisingId forKey:@"advertising_id"];
    
    // Actually make the callback.
    [httpClient getPath:@"" parameters:httpParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Finished callback: %@", operation.request.URL);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed callback: %@", error);
    }];
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
