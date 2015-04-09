//
//  DetailViewController.m
//  LoginApp
//
//  Created by Sofia Swidarowicz on 21/03/15.
//  Copyright (c) 2015 Sofia Swidarowicz. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Detail %@", self.detailModal);
    
    self.superHeroName.text = self.detailModal[0];
    self.superHeroName.accessibilityIdentifier = @"HeroNameDetail";
    
    self.superHeroPower.text = self.detailModal[1];
    self.superHeroPower.accessibilityIdentifier = @"HeroPowerDetail";
    
    self.superHeroPicture.image = [UIImage imageNamed:self.detailModal[2]];
    self.superHeroPicture.accessibilityIdentifier = @"HeroPictureDetail";
    
    self.superHeroHome.text = self.detailModal[3];
    self.superHeroHome.accessibilityIdentifier = @"HeroHomeDetail";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
