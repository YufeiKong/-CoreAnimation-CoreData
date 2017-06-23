//
//  PersonViewController2.m
//  Demo
//
//  Created by Content on 2017/5/10.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "PersonViewController2.h"
#import "Person+CoreDataClass.h"
#import "CoreDataManager.h"

@interface PersonViewController2 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSManagedObjectContext *context;
@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *ageArray;
@property(nonatomic,strong)CoreDataManager *coreManager;
@property(nonatomic,strong)NSMutableArray *addArray;
@property(nonatomic,strong)NSMutableArray *resultArray;
@end

@implementation PersonViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle=NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self topHeadView];
    _resultArray = [[NSMutableArray alloc]init];
    _coreManager = [[CoreDataManager alloc]init];
 
    [self selectPerson];
}
-(void)topHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor darkGrayColor];
    [headView addSubview:line];
    _tableView.tableHeaderView = headView;
    
    NSArray *cate =@[@"增",@"删",@"改",@"查"];
    for (int i=0; i<cate.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30+i*90, 25, 50, 40);
        [btn setTitle:cate[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor lightGrayColor];
        btn.tag=i;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(button_click:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btn];
    }
}
-(void)button_click:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            [self addPerson];
            break;
        case 1:
            [self deletePerson];
            break;
        case 2:
            [self changePerson];
            break;
        case 3:
            [self selectPerson];
            break;
        default:
            break;
    }
}
#pragma mark ---增
-(void)addPerson{
   
    _addArray = [[NSMutableArray alloc]init];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"name"] = @"春娇";
    dict[@"age"] = @(24);
    
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc]init];
    dict2[@"name"] = @"志明";
    dict2[@"age"] = @(31);
    
    [_addArray addObject:dict];
    [_addArray addObject:dict2];
    [_coreManager insertCoreData:_addArray];
    [self selectPerson];
}
#pragma mark ---删
-(void)deletePerson{
    
    [_coreManager deleteData:@"修改后的名字"];
    [self selectPerson];
    
}
#pragma mark ---改
-(void)changePerson{
  
    [_coreManager updateData:@"志明" withNewName:@"修改后的名字"];
    [self selectPerson];

}
#pragma mark ---查
-(void)selectPerson{
    
   _resultArray =  [_coreManager selectData];
    NSLog(@"%@",_resultArray);
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _resultArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"personCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    Person *person = _resultArray[indexPath.row];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@岁",[person valueForKey:@"age"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    Person *person = _resultArray[indexPath.row];
//    
//    [_coreManager updateData:person.name withNewName:@"修改后的名字"];
//    [self selectPerson];
//    
    
}

@end
