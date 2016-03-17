# AppFriendsDemo_Swift
AppFriends widget demo project in swift.
You need to run cocoapod on the project to start. For more detail, please checkout our [guide](http://www.appfriends.me/documents/ios/)

# AppFriends iOS SDK 

## Integration

### Cocoapods 
To integrate AppFriends iOS SDK to your Xcode iOS project, add this line in your `Podfile`

	pod 'AppFriends'
	
To use the SDK, include the header:
	
	#import <HacknocraftiOS/HacknocraftiOS.h> 

### Swift
In your `Podfile` include:

	pod 'AppFriends'
	pod 'FontAwesomeKit', :head

Add `#import <HacknocraftiOS/HacknocraftiOS.h>` to your bridge header.

For details on how to use bridge header and library in swift project, please follow [this guide](http://swiftalicio.us/2014/11/using-cocoapods-from-swift/) 

You can download our [Swift demo](https://github.com/laeroah/AppFriendsDemo_Swift.git) from github.

## Initialization

After logging into your admin panel, and created your application, you can find your `App ID` and `App Secret`. Then use them in the initialization.
	
	 - (void)initializeWithApplicationKey:(NSString *)key 
								   secret:(NSString *)secret 
						    configuration:(NSDictionary *)options

### Build Initialization Options
To initialize the SDK, you can pass in a `NSDictionary` 

Key           | Type          | Description
------------- | ------------- | -------------
kHCUseProduction  | Boolean | Set @YES to use production rather than sendbox
kHCDefaultSocialWidgetPosition  | CGPoint | Specify the position where the widget button will show up on the view. 
kHCDefaultSocialWidgetOpenDirection  | NSInteger | Enum `HCSocialWidgetOpenDirection` This value will dictate the widget open direction. 
kHCDefaultSocialWidgetEnableProfileLink  | Boolean | Set @YES to enable linking between the widget's user profile to the user profile in your app. If your app doesn't have a profile page, you can ignore this value.
kHCDefaultSocialWidgetWidth  | Float | set width of the widget window. Max value is screen width - 20, and min value is 300.

## User Authentication
Before your users can start enjoying AppFriends, they need to have an AppFriends account. Login the user by invoking:

	// find this method in HCSocialWidget
	- (void)loginWithUserInfo:(NSDictionary *)userInfo

The user's AppFriends account will be associated with the user's account in your app. To correctly display the user information, please fill the following information in the *userInfo* dictionary:

Key           | Type          | Description
------------- | ------------- | -------------
kHCUserName   | text          | the username
kHCUserAvatar | text          | the full URL of the user's avatar
kHCUserAppID  | text          | the user's userID in **your own app**.
kHCUserEmail  | text          | the user's email

## Styling

AppFriends UI can be customize to fit the style of your own app. To customize the UI, please use `HCWidget` properties. For example: 

	// Setting the navigation bar icon highlight color to red
	[[HCWidget sharedWidget]setNavBarIconHighlightColor:UIColor.redColor];
	
	
## Show the Widget on your App
After the initialization is finished. You can now show the widget on the views in your App by calling:

	+ (void)showSocialWidgetOnViewController:(UIViewController *)viewController
                          viewControllerPath:(NSString *)path
                           disableScreenshot:(BOOL)disable
                                  completion:(void (^)(void))complete

The *viewController* parameter is the `UIViewController`, which is presenting the widget. We recommand showing the widget in `viewDidAppear` method of your view controller. For detail info on this method, please go to [class document](ios_class/Classes/HCWidget.html#//api/name/showSocialWidgetOnViewController:viewControllerPath:disableScreenshot:completion:).  

## Content Sharing with AppFriends

A great feature with AppFriends is being able to share your app content within your app among your users or to outside the app in places like Facebook, Twitter, Instagram, SMS and so on. To utilize this feature, you need assign a **path** to each of your page (app screen). You can also use additional **parameters** to help your app with navigation. 

### Path and Parameters
A **path** with **parameters** looks like an URL without the host, for example, `/profile?id=23` could be a path that describes the profile page of your user with ID equal to 23.

To set the path and parameter of the current screen, you can call:
		
		[HCWidget setScreenPath:@"/profile?id=23"];
		
		or, when you show the widget button, include the screen path when you present the widget button on your view controller:

		[HCWidget showSocialWidgetOnViewController:self viewControllerPath:@"/profile?id=23" disableScreenshot:NO completion:nil];

### Handling callbacks 
After you set the **path** with **parameters** for your screen, you should then handle callback from our widget to navigate to this screen. For example, when someone shared his profile page to the chat, another user can tap the link below the shared screenshot. Then our widget will trigger the callback here: 

		[HCWidget mapURL:@"/profile" toCallback:^(NSDictionary *params) {
			NSString *userID = params[@"id"];
			// your logic to navigate to the user's profile page with the ID value.
		}];

### Deeplinks
When a user shares screenshot from your app, a deeplink will be generated and shared with the screenshot. If the screenshot is taken from a place you have assign a path and parameters to, the information will also be included in the deeplink. When users clicks on the deeplink and install/open the app, we will trigger the callback with the path and parameters you provided.

To receive deeplink actions, you need insert calls in the correct places in your application delegate:

	+ (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
	and
	+ (BOOL)continueUserActivity:(NSUserActivity *)userActivity

See [class documents](ios_class/index.html) for more detail.

## Public Chat Channels
By default, we create a global public chat channel for all of your users to chat. You can create, edit and remove public chat channels. You can either do it from the AppFriends admin panel or via our [API](server/index.html).

## Private Group Chat
You can create private chat group using the `HCWidget` methods. In each private chat group, you can only include the users that you want to invite, and the chat group will not be visible to others. Users can leave the group if they want to. Please see [class document](ios_class/Classes/HCWidget.html#//api/name/createGroup:lookupKey:withUserIDs:complete:).

## Post User Activities
User activity feed is another powerful feature in AppFriends. User's activities will be posted in their user profile in the widget. We are already posting some activities from the widget by default. You can post activities generated inside your app can also be posted by call activity method inside `HCWidget`. Click [here](server/ios_class/Classes/HCWidget.html#//api/name/createActivityWithLeftImageURL:leftImageCode:title:path:params:complete:) for detail.

Posting activity is a great way to let other users to find out what's going on inside the app. You can also create **trending** activities by using our [server api](server/index.html). Trending activities are events in your app that you believe is hot or want to grab more attention. For example, you can post a trending activity with "There are 500 users watching 'cute cat' video" and a path with parameter which can navigate more users to the video when the activity is clicked.
