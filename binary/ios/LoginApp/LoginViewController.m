//
//  ViewController.m
//  LoginApp
//
//  Created by Sofia Swidarowicz on 15/03/15.
//  Copyright (c) 2015 Sofia Swidarowicz. All rights reserved.
//

#import "LoginViewController.h"
#import "DashboardViewController.h"

@interface LoginViewController ()


@end

static NSString *userValue = @"bdd";
static NSString *passValue = @"1234";
NSString *_titleAlert;
NSString *_messageAlert;
BOOL errorLogin;

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInput.accessibilityIdentifier = @"userInput";
    self.passwordInput.accessibilityIdentifier = @"passwordInput";
    self.buttonLogin.accessibilityIdentifier = @"buttonLogin";
    self.view.accessibilityIdentifier = @"viewLogin";
    errorLogin = NO;
    
    [self.buttonLogin.layer setCornerRadius:8.0f];
    [self.buttonLogin.layer setMasksToBounds:YES];
    [self.buttonLogin.layer setBorderWidth:1.0f];
    [self.buttonLogin.layer setBorderColor:[[UIColor whiteColor] CGColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doLogin:(id)sender {
    
    if (![self verifyLogin]){
        [self showMessageWithTitle:_titleAlert usingMessage:_messageAlert];
        errorLogin = YES;
    }else{
        DashboardViewController *dashBoard = (DashboardViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"dashboardID"];
        [dashBoard setUserValue:userValue];
        //[self presentViewController:dashBoard animated:YES completion:nil];
        [self presentViewControllerWithNavigationBar:dashBoard];

    }
}

-(void)presentViewControllerWithNavigationBar:(id)viewController{
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:viewController];
    
    //now present this navigation controller modally
    [self presentViewController:navigationController
                       animated:YES
                     completion:^{
                         self.userInput.text = @"";
                         self.passwordInput.text = @"";
                     }];
}

-(BOOL)errorLogin{
    [self setAlertMessages:@"error"];
    return NO;
}

-(BOOL)correctLogin{
    return YES;
}

-(BOOL)verifyLogin{
    if ([self.userInput.text isEqualToString:userValue] && ([self.passwordInput.text isEqualToString:passValue]))
        return [self correctLogin];
    else
        return [self errorLogin];
}

-(void)setAlertMessages:(NSString*)typeMessage{

    if ([typeMessage isEqualToString:@"error"]){
        _titleAlert = @"Error in Login";
        _messageAlert = @"Ups! your user or password is wrong. Try again.";
    }
}

-(void)showMessageWithTitle:(NSString*)title usingMessage:(NSString*)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.accessibilityIdentifier = @"ErrorMessage";
    [alert show];
}




@end
