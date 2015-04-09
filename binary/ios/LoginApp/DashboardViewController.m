//
//  DashboardViewController.m
//  LoginApp
//
//  Created by Sofia Swidarowicz on 15/03/15.
//  Copyright (c) 2015 Sofia Swidarowicz. All rights reserved.
//

#import "DashboardViewController.h"
#import "TableViewCell.h"
#import "DetailViewController.h"
#import "LoginViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.accessibilityIdentifier = @"viewDashboard";

    self.userValueProp.text = self.userValue;

    
    self.superheroName = @[@"Superman",@"Aquaman",@"Batman",
                            @"BatGirl", @"Wonder Woman", @"Deadpool",
                            @"Iron Man", @"Blackwidow", @"Hawk Eye",
                            @"Hulk",@"Captain America",@"Elektra",@"Thor"];
    
    self.superPower = @[@"Fuerza, Vuelo", @"Telepático", @"Destreza física e inteligencia",
                        @"Inteligencia", @"Fuerza e inteligencia", @"Curación rápida",
                        @"Emanación de energía", @"Curación rápida y fuerza", @"Fuerza y resistencia",
                        @"Fuerza ilimitada",@"Inteligencia y fuereza",@"Reflejos, velocidad, resistencia",@"Fuerza"];
    
    self.superheroImage = @[@"superman.png",@"aquaman.png",@"batman.png",
                            @"batGirl.png", @"wonder_woman.png", @"deadpool.png",
                            @"ironman.png", @"blackwidow.png", @"hawkeye.png",
                            @"hulk.png",@"captain_america.png",@"elektra.png",@"thor.png"];
    
    self.superheroHome =@[@"DC",@"DC",@"DC",
                          @"DC", @"DC", @"Marvel",
                          @"Marverl", @"Marvel", @"Marvel",
                          @"Marvel",@"Marvel",@"Marvel",@"Marvel"];
    
}
- (IBAction)closeView:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.superheroName count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil){
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.superHeroName.text = self.superheroName[indexPath.row];
    cell.superHeroPower.text = self.superPower[indexPath.row];
    cell.superHeroPicture.image = [UIImage imageNamed:self.superheroImage[indexPath.row]];
    cell.superHeroHome.text = self.superheroHome[indexPath.row];
    cell.superHeroHome.accessibilityIdentifier = @"HeroHomeCell";
    cell.superHeroName.accessibilityIdentifier = @"HeroNameCell";
    cell.superHeroPicture.accessibilityIdentifier = @"HeroPictureCell";
    cell.superHeroPower.accessibilityIdentifier = @"HeroPowerCell";
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"detailID"]){
        DetailViewController *detailViewController = (DetailViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableViewMocked indexPathForSelectedRow];
        NSLog(@"%@", self.tableViewMocked);
        
        [detailViewController setDetailModal:@[self.superheroName[indexPath.row], self.superPower[indexPath.row], self.superheroImage[indexPath.row], self.superheroHome[indexPath.row]]];
                    }
}

@end
