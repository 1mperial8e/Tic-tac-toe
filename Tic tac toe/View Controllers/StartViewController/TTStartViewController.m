//
//  TTViewController.m
//  Tic tac toe
//
//  Created by Stas Volskyi on 30.04.14.
//  Copyright (c) 2014 mobilesoft365. All rights reserved.
//

#import "TTStartViewController.h"
#import "TTGameViewController.h"
#import "TTSettingsViewController.h"

@interface TTStartViewController ()

- (IBAction)leaderboardButton:(id)sender;
- (IBAction)achievementsButton:(id)sender;
- (IBAction)signIn:(id)sender;


@end

@implementation TTStartViewController

static NSString * const kClientID = @"111039763950-dj91993gmav7o5dn26v65ga1lavlt0jg.apps.googleusercontent.com";

- (void)viewDidLoad
{
    [super viewDidLoad];
	GPPSignIn *signIn = [GPPSignIn sharedInstance];
    // You set kClientID in a previous step
    signIn.clientID = kClientID;
    signIn.scopes = [NSArray arrayWithObjects:
                     @"https://www.googleapis.com/auth/games",
                     @"https://www.googleapis.com/auth/appstate",
                     nil];
    signIn.language = [[NSLocale preferredLanguages] objectAtIndex:0];
    signIn.delegate = self;
    signIn.shouldFetchGoogleUserID =YES;
    [signIn trySilentAuthentication];

}

- (void) viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark - UIActions

- (IBAction)leaderboardButton:(id)sender{
    
}
- (IBAction)achievementsButton:(id)sender{
    
}

- (IBAction)signIn:(id)sender {
    if (![[GPGManager sharedInstance] isSignedIn]) {
        [[GPPSignIn sharedInstance] authenticate];
    }
}

#pragma mark - GPPSignIn delegate

-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if (error == nil && auth) {
        NSLog(@"Success signing in to Google! Auth object is %@", auth);
        [self startGoogleGamesSignIn];
    } else {
        NSLog(@"Failed to log into Google!\n\tError=%@\n\tAuthObj=%@",error,auth);
    }
}

-(void)startGoogleGamesSignIn
{
    [[GPGManager sharedInstance] signIn:[GPPSignIn sharedInstance] reauthorizeHandler:^(BOOL requiresKeychainWipe, NSError *error) {
        if (requiresKeychainWipe) {
            [[GPPSignIn sharedInstance] signOut];
        }
        [[GPPSignIn sharedInstance] authenticate];
    }];
}


@end
