//
//  TTAppDelegate.m
//  Tic tac toe
//
//  Created by Stas Volskyi on 30.04.14.
//  Copyright (c) 2014 mobilesoft365. All rights reserved.
//

#import "TTAppDelegate.h"
#import "Manager/MPManager.h"
#import <GooglePlus/GooglePlus.h>

@implementation TTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //implemented GPG
    [GPGManager sharedInstance].realTimeRoomDelegate = [MPManager sharedInstance];
    
    //register notification
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)];
    NSDictionary *remoteNotification =
    [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (remoteNotification) {
        if ([[GPGManager sharedInstance] tryHandleRemoteNotification:remoteNotification]) {
            NSLog(@"Handling notification %@ after sign-in is complete", remoteNotification);
            // Looks like we got a Google Play match invite! No other action is requied. Our
            // invite delegate will receive a didReceiveRealTimeInviteForRoon just as soon
            // as sign-in is finished.
        } else {
            // You probably want to do other notification checking here.
        }
    }
    return YES;

}
							
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Got deviceToken from APNS! %@", deviceToken);
    [[GPGManager sharedInstance] registerDeviceToken:deviceToken forEnvironment:GPGPushNotificationEnvironmentSandbox];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Received remote notification! %@", userInfo);
    
    if ([[GPGManager sharedInstance] tryHandleRemoteNotification:userInfo]) {
        UIViewController *lastCont = [(UINavigationController *)self.window.rootViewController viewControllers].lastObject;
        if ([lastCont isKindOfClass:NSClassFromString(@"ATStartViewController")]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incoming invite!" message:@"Do you want start game?" delegate:lastCont cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            [alert show];
        }
    } else {
        // Call other methods that might want to handle this
        // remote notification
    }
}

@end
