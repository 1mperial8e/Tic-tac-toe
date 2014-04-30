//
//  TTOnlineLobbyViewController.m
//  Tic tac toe
//
//  Created by Stas Volskyi on 30.04.14.
//  Copyright (c) 2014 mobilesoft365. All rights reserved.
//

#import "TTOnlineLobbyViewController.h"
#import "GooglePlus.h"

@interface TTOnlineLobbyViewController () <UIAlertViewDelegate>

- (IBAction)backButton:(id)sender;
@end

@implementation TTOnlineLobbyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![[GPGManager sharedInstance] isSignedIn])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No connection" message:@"For playing online, please sign in via google+" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign in", nil];
        [alert show];
    }
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:{
            [[GPPSignIn sharedInstance] authenticate];
        }
    }
}


@end
