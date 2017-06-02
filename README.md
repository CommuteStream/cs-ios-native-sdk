# CommuteStream iOS Native Ads SDK

This SDK allows you to add CommuteStream Native Ads to your app.

These instructions assume you have already followed the instructions at: [https://commutestream.com/sdkinstructions](https://commutestream.com/sdkinstructions).


## Requirements

- iOS 8.0 and up
- Protocol Buffers: [https://developers.google.com/protocol-buffers](https://developers.google.com/protocol-buffers). We recommend using CocoaPods.

## Downloading
Clone the repository or download the appropriate zip file:

**GitHub:**
[https://github.com/CommuteStream/cs-ios-native-sdk](https://github.com/CommuteStream/cs-ios-native-sdk).
   
## Adding the SDK

1. Drag the
`CSNative.framework` file into your Xcode project.


2. In your project's target, under Build Phases > Embed Frameworks, drag
`CSNNative.framework` to the list of embedded frameworks.


3. Import the header files:

	**Objective-C**

	Add `#import <CSNative/CommuteStream.h>` to the top of each ViewController 		that requests ads.
    
    **Swift**
    
    Add `#import <CSNative/CommuteStream.h>` to your projects `Bridging-Header.h` 	  file. 

## Overview
CommuteStream Native Ads were built specifically for transit apps. Our SDK is packed with flexible components that allow publishers to seamlessly display advertising alongside public transit information.

**Available Components**

Components are meant to be used where the publisher sees fit, but should be placed with the understanding that the ad data they display, will be relevant to the transit data surrounding them. The following components are available and listed in order of usage priority:

- Headline - Displays a strong call-to-action or phrase that relates the value of the offer in as few words as possible –e.g., *"Free 12 oz. Coffee"*


- Body - Provides a more detailed description of the offer –e.g., *"With purchase any breakfast item."*


- Logo - Shows the brand of the company being advertised. In most cases, logos are meant to be displayed with other components such as a Headline, Body or Advertiser, but can be placed alone as an embeleshment to a list item for a transit stop or route.


- Advertiser - Shows the name of the advertiser. –e.g., "Starbucks Coffee"

**Action Cards**

The Action Card is shown anytime a Logo, Body, Headline, Advertiser, or any grouping thereof is tapped on. It is the ultimate native ad, floating above the contents of the app, it keeps the user experience and related transit information in context. The action card includes the following components by default:

- Title - Explains the transit context of the ad. For example, if the user tapped on an icon that was placed on a train stop list, it might read *"Near Belmont Red Line Stop."*


- Subtitle - Further explains the transit context with location information such as a specific address, cross streets, or how far away it is to walk.


- Hero Image - A large image that reenforces the advertiser's brand or message.


- Headline, Body, Logo, and Advertiser - the same compenents used by the publisher to entice users to tap and reveal the Action Card.


- Action Buttons - A maximum of three buttons that perform link-based actions specified by the advertiser. –e.g., *"Download App"*, *"Apply Now"*, or *"Learn More"*


- Close Button - An easy way for the user to quickly opt out.

## Placing Ad Components
You can add components to your app either programmatically, or by using the Storyboard feature in XCode:

#### Programmatically
Here is an example of placing components inside a table view cell:

**Objective-C**
```
CSNLogoView *logo = [[CSNLogoView alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
[cell addSubview:logo];

CSNHeadlineView *headline = [[CSNHeadlineView alloc] initWithFrame: CGRectMake(55, 0, 200, 50)];
[cell addSubview:headline];
```
**Swift**
```
let logoView = CSNLogoView.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
cell.contentView.addSubview(logoView)

let headlineView = CSNHeadlineView.init(frame: CGRect(x: 55, y: 12, width: 200, height: 50))
cell.contentView.addSubview(headlineView)
```

#### Using Storyboards
Some developers prefer to layout components using loadable .xib files. Our SDK makes this simple and intuitive.

For more tips and code snippets, visit our [Native Ads Best Practices](http://commutestream.com/native-ads-best-practices) page.

## Requesting Ads
### CSNAdRequest
Once you've placed the components where you want them, you'll need to request a list of native ads to populate them. For this you will create an individual **CSNAdRequest**, packaged with transit information that matches what's showing on the screen.

There are three levels of transit data you can provide with your **CSNAdRequest**. Each level is more specific than the last and uses a special class:

#### CSNTransitAgency (least specific)

**Objective-C**
```
CSNTransitAgency *agency = [[CSNTransitAgency alloc] initWithIDs:@"agency_id"];

[adRequest addAgency:agency];
```
**Swift**
```
let agency = CSNTransitAgency.init(ids:"agency_id")

adRequest.addAgency(agency)
```

#### CSNTransitRoute (more specific)

**Objective-C**
```
CSNTransitRoute *route = [[CSNTransitRoute alloc] initWithIDs:@"agency_id" routeID:@"route_id"];

[adRequest addRoute:route];
```

**Swift**
```
let route = CSNTransitRoute.init(ids:"agency_id", routeID:"route_id")

adRequest.addRoute(route)
```

#### CSNTransitStop (most specific)
**Objective-C**
```
CSNTransitStop *stop = [[CSNTransitStop alloc] initWithIDs:@"agency_id" routeID:@"route_id" stopID:@"stop_id"];

[adRequest addStop:stop];
```

**Swift**
```
let stop = CSNTransitStop.init(ids:"agency_id", routeID: "route_id", stopID: "stop_id")

adRequest.addStop(stop)
```

Each **CSNAdRequest** must be added to a mutable array, which will then be used to fetch ads using the **CSNAdsController** class.

**Objective-C**
```
NSMutableArray *adRequestsArray = [NSMutableArray alloc] init];
[adRequestsArray addObject:adRequest];
```

**Swift**
```
var adRequests = [CSNAdRequest]()
adRequests.append(adRequest)
```

### CSNAdsController
In order to fetch ads with the array of **CSNAdRequest**s, you must call the ``fetchAds`` method on an instance of **CSNAdsController**. This will invoke a callback that returns an **ads** array.

The **ads** array has the same object count as the adRequests array provided in the call. Some indexes have a **CSNAd**, and others have a **nil** value.
You will use this array to display ad content in the components you added to your app design.

**Objective-C**
```
CSNAdsController *adsController = [[CSNAdsController alloc] initWithClient:ad_client adUnit:ad_unit];
[adsController adsController fetchAds:adRequests completed: ^(NSArray <CSNOptionalAd *> *ads) {
	_ads = ads;
    NSLog(@"%ld", [_ads count]);
    [_tableView reloadData];
}];

```

**Swift**
```
var adsController = CSNAdsController.init(client: ad_client, adUnit: ad_unit)
adsController.fetchAds(adRequests, completed: {(ads) in
	self.stopAds = ads
    self.routeStopsListTableView.reloadData()
})

```

## Building Ads
Once you've placed your ad components and retreived ads using the ``fetchAds`` method, you can put it all together by filling the components with ad data using the ``buildView`` method of the **CSNAdsController** class.

The ``buildView`` method accepts three parameters:

- the parent view of the ad components
- the **ad** property of the **CSNOptionalAd** that was returned in the ``fetchAds`` call
- a boolean value for whether or not the parent is clickable (allows for grouping components so they respond to the same tap)

**Objective-C**
```
[adsController buildView:[cell contentView] ad:ad parentTouch:false];
```

**Swift**
```
adController.build(cell.contentView, ad:(ad as CSNOptionalAd).ad, parentTouch: false)
```