//
//  TableViewCell.h
//  LoginApp
//
//  Created by Sofia Swidarowicz on 21/03/15.
//  Copyright (c) 2015 Sofia Swidarowicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UILabel *superHeroName;
@property (weak, nonatomic) IBOutlet UILabel *superHeroPower;
@property (weak, nonatomic) IBOutlet UILabel *superHeroHome;
@property (weak, nonatomic) IBOutlet UIImageView *superHeroPicture;

@end
