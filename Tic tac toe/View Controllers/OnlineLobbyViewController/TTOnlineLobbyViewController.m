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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![[GPGManager sharedInstance] isSignedIn])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No connection" message:@"For playing online, please sign in via google+" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign in", nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
