iOS6AdTracking
==============

This is a small example of a pseudo advertising banner view. It is meant to illustrate how tracking could be handled in combination with the new SKStoreProductViewController in iOS6. The main mechanism is the callback to a callback URL with an advertising ID.

The main files of interest are [AdView.h](https://github.com/adeven/iOS6AdTracking/blob/master/iOS6AdTracking/AdView.h) and [AdView.m](https://github.com/adeven/iOS6AdTracking/blob/master/iOS6AdTracking/AdView.m) which form the sample ad view. The file [ViewController.m](https://github.com/adeven/iOS6AdTracking/blob/master/iOS6AdTracking/ViewController.m) creates and adds such an ad view to the main view controller. If you build and run this project you should see a banner view with the title "Click here!". Clicking this banner will present the new product view controller and makes a callback to the callback URL in the background. Furthermore we send the new identifierForAdvertising to enable tracking of these clicks.
