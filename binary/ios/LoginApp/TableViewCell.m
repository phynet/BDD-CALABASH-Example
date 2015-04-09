//
//  TableViewCell.m
//  LoginApp
//
//  Created by Sofia Swidarowicz on 21/03/15.
//  Copyright (c) 2015 Sofia Swidarowicz. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    self.superHeroName.accessibilityIdentifier = @"heroName";
    self.superHeroPower.accessibilityIdentifier = @"heroPower";
    self.superHeroPicture.accessibilityIdentifier = @"heroPicture";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
