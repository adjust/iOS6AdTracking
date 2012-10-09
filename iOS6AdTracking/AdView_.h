#import <UIKit/UIKit.h>
// We need store kit to use the product view controller.
#import <StoreKit/StoreKit.h>

// This is a minimal example of a pseudo advertising banner view.
// It is meant to illustrate how tracking could be handled in
// combination with the new product view controller in iOS6. The main
// mechanism is the callback to a callback URL with an advertising ID.
@interface AdView : UIView <SKStoreProductViewControllerDelegate>

// The view controller that presents the product view controller.
@property (nonatomic, retain) UIViewController *parentViewController;
// The product ID needed for the product view controller. This might be an app ID.
@property (nonatomic, copy) NSString *productId;

// The URL that gets called when the product view controller is presented.
// This could be used for tracking and possibly for affiliate programs.
@property (nonatomic, copy) NSString *callbackUrl;
// To enable tracking we send the identifierForAdvertising as a callback parameter.
@property (nonatomic, copy) NSString *advertisingId;

// This initializer sets the parentViewController.
- (id)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController;
// This method loads an ad and populates the corresponding productId and callbackUrl.
- (void)loadAd;

@end
