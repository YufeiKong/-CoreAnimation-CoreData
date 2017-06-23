//
//  CoreDataController.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "CoreDataController.h"
#import "PersonViewController.h"
#import "PersonViewController2.h"

@interface CoreDataController ()

@end

@implementation CoreDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title = @"CoreData";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"CoreData";
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //PersonViewController2 *person = [[PersonViewController2 alloc]init];
    PersonViewController *person = [[PersonViewController alloc]init];
    [self.navigationController pushViewController:person animated:YES];
}
@end
