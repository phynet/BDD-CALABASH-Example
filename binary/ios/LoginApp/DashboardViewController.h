//
//  DashboardViewController.h
//  LoginApp
//
//  Created by Sofia Swidarowicz on 15/03/15.
//  Copyright (c) 2015 Sofia Swidarowicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *userValueProp;
@property(copy,nonatomic) NSString *userValue;


@property(copy,nonatomic) NSArray *superheroName;
@property(copy,nonatomic) NSArray *superPower;
@property(copy, nonatomic) NSArray *superheroImage;
@property(copy, nonatomic) NSArray *superheroHome;

@property (weak, nonatomic) IBOutlet UITableView *tableViewMocked;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;


@end
