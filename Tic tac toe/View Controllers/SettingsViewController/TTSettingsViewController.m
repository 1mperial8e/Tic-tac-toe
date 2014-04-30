//
//  TTSettengsViewController.m
//  Tic tac toe
//
//  Created by Stas Volskyi on 30.04.14.
//  Copyright (c) 2014 mobilesoft365. All rights reserved.
//

#import "TTSettingsViewController.h"
#import "TTStartViewController.h"

@interface TTSettingsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *signInOut;

- (IBAction)signInOut:(id)sender;
- (IBAction)back:(id)sender;

@end

@implementation TTSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[GPGManager sharedInstance] isSignedIn]) {
        [self.signInOut setTitle:@"G+ | sign out" forState:UIControlStateNormal];
    }
    else{
        [self.signInOut setTitle:@"G+ | sign in" forState:UIControlStateNormal];
    }
}


- (IBAction)signInOut:(id)sender {
    if ([[GPGManager sharedInstance] isSignedIn]){
        [self.signInOut setTitle:@"G+ | sign in" forState:UIControlStateNormal];
        [[GPGManager sharedInstance] signOut];
    }
    else{
        [[GPPSignIn sharedInstance] authenticate];
        [self.signInOut setTitle:@"G+ | sign out" forState:UIControlStateNormal];
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
