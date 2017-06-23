//
//  PersonViewController.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "PersonViewController.h"
#import "Person+CoreDataClass.h"

@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSManagedObjectContext *context;
@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *ageArray;
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle=NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self topHeadView];
    [self getPersonData];
    [self getPerson];
}

-(void)getPersonData{

    //加载modeld文件 得到modelURL
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    //获得有实体类型的Model
    NSManagedObjectModel *model  = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // 构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"Person.data"]];
    
    //NSPersistentStoreCoordinator持久化的助理，将对象保存到数据库中
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        //将对象添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    
    NSDictionary *option = @{NSMigratePersistentStoresAutomaticallyOption:@(YES),NSInferMappingModelAutomaticallyOption:@(YES)};
    //NSMigratePersistentStoresAutomaticallyOption设为yes表示支持版本迁移
    //NSInferMappingModelAutomaticallyOption设为yes表示支持版本迁移映射
    
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:option error:&error];
    
    if (store == nil) { // 直接抛异常
    [NSException raise:@"添加数据库错误" format:@"%@", [error localizedDescription]];
    }
    //被管理的对象上下文，设置persistentStoreCoordinator属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    _context = context;
    context.persistentStoreCoordinator = psc;
   
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
    
    //初始化NSManagedObject
    NSManagedObject *person= [Person jk_create:_context];
    //设置Person的简单属性
    [person setValue:@"志明" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:31] forKey:@"age"];
    [person setValue:@(1) forKey:@"id"];
    [person setValue:@"男" forKey:@"sex"];
    
    
    //以字典的形式插入对象
    NSMutableDictionary *dict3 = [[NSMutableDictionary alloc]init];
    dict3[@"name"] = @"春娇";
    dict3[@"age"] = @(24);
    NSManagedObject *person2 = [Person jk_create:dict3 inContext:_context];
    NSLog(@"person2-%@",person2);
    // 利用上下文对象，将数据同步到持久化存储库
    [_context save:nil];

    //设置查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", @"修改后的名字"];
    // 设置排序方式（按照age升序 yes为升序 no为降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    
    //某种查询条件下的对象 取第一个对象
    NSManagedObject *person3 = [Person jk_find:predicate inContext:_context];
    NSLog(@"person3-%@",person3);
    
    //某种查询条件下的对象 按序排列数组
    NSArray *array = [Person jk_all:predicate sortDescriptors:sortArray inContext:_context];
    NSLog(@"array-%@",array);
    //某种查询条件下的数量
    NSInteger managed_count = [Person jk_count:predicate inContext:_context];
    NSLog(@"%ld",(long)managed_count);
    //取表名
    NSString * entityName =  [Person jk_entityName] ;
    NSLog(@"entityName-%@",entityName);
   
    //对象转化为字典
    NSDictionary *dict = [person jk_toDictionary];
    NSLog(@"%@",dict);
    
    //取第一个对象
//    Person *objs =  [_context jk_fetchObjectForEntity:@"Person"];
//    NSLog(@"objs-%@",objs);
//    
//    id objs2 = [_context jk_fetchObjectForEntity:@"Person" predicate:predicate];
//    NSLog(@"objs2-%@",objs2);
//
//    id objs3 = [_context jk_fetchObjectForEntity:@"Person" predicate:predicate sortDescriptors:sortArray];
//    NSLog(@"objs3-%@",objs3);
//    
//    id objs4 = [_context jk_fetchObjectsForEntity:@"Person" predicate:predicate sortDescriptors:sortArray fetchLimit:1];
//    NSLog(@"objs4-%@",objs4);

    [self getPerson];
}
#pragma mark ---删
-(void)deletePerson{
   
    //检索条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",@"修改后的名字"];
    NSPredicate *pre2 = [NSPredicate predicateWithFormat:@"name=%@",@"春娇"];
    NSArray *objs = [_context fetchObjects:@"Person" usingPredicate:pre returningAsFault:YES];
    NSArray *objs2 = [_context fetchObjects:@"Person" usingPredicate:pre2 returningAsFault:YES];
    
    if (objs.count) {
        
    [_context jk_deleteObjects:objs];
    [_context save:nil];
    [self getPerson];

    }else{
        
    if (objs2.count) {
        
    [_context jk_deleteObjects:objs2];
    [_context save:nil];
    [self getPerson];
        
    }else{
    NSLog(@"没有成员了");
    }
        
  }
}
#pragma mark ---改
-(void)changePerson{
    
    //检索条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",@"志明"];
    NSArray *objs = [_context fetchObjects:@"Person" usingPredicate:pre returningAsFault:YES];
    
    if (objs.count) {
        
    for(Person *person in objs) {
    
    //person.name = @"修改后的名字";
    [person setValue:@"修改后的名字" forKey:@"name"];
    [person setValue:@(18) forKey:@"age"];
    }
    [_context save:nil];
    [self getPerson];
        
    }else{
    NSLog(@"没有成员了");
    }
}
#pragma mark ---查
-(void)selectPerson{
    
    //初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", @"修改后的名字"];
    //设置排序（按照age升序 yes为升序 no为降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    
    //NSEntityDescription *desc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    //给查询请求传递条件参数1
    //request =  [request initWithEntity:desc predicate:predicate sortDescriptors:request.sortDescriptors];
    
    //给查询请求传递条件参数2 查询名字为春娇的对象
    //request = [_context jk_fetchRequestForEntityObject:@"Person" usingValue:@"春娇" forKey:@"name" returningAsFault:YES];
    //给查询请求传递条件参数3 设置了查询条件之后的对象（名字为修改后的名字）
   // request = [_context jk_fetchRequestForEntityObject:@"Person" usingPredicate:predicate returningAsFault:YES];

    //给查询请求传递条件参数5   排序：年龄升序查询
    request= [_context jk_fetchRequestForEntityObjects:@"Person" usingPredicate:predicate usingSortDescriptors:sortArray returningAsFault:YES];
    NSArray *objs = [_context executeFetchRequest:request error:nil];
    //遍历数据
    _nameArray = [[NSMutableArray alloc]init];
    _ageArray = [[NSMutableArray alloc]init];
    for (NSManagedObject *obj in objs) {
        
    NSLog(@"name=%@", [obj valueForKey:@"name"]);
    NSLog(@"age=%@", [obj valueForKey:@"age"]);
    [_nameArray addObject:[obj valueForKey:@"name"]];
    [_ageArray addObject:[obj valueForKey:@"age"]];
        
    }
   //查询对象 正常形式
    NSInteger count = [_context countObjects:@"Person"];
    NSLog(@"count-%ld",(long)count);

    NSArray *objectArray1 = [_context fetchObjects:@"Person" returningAsFault:YES];
    NSLog(@"objectArray1-%@",objectArray1);

    NSArray *objectArray2 = [_context fetchObjects:@"Person" usingPredicate:predicate returningAsFault:YES];
    NSLog(@"objectArray2-%@",objectArray2);
    NSArray *objectArray3 = [_context fetchObjects:@"Person" usingSortDescriptors:sortArray returningAsFault:NO];
     NSLog(@"objectArray3-%@",objectArray3);
    
    NSArray *objectArray4 = [_context fetchObjects:@"Person" usingPredicate:predicate usingSortDescriptors:sortArray returningAsFault:YES];
    NSLog(@"objectArray4-%@",objectArray4);
    //查询对象 block形式
    [_context jk_fetchObjectsForEntity:@"Person" callback:^(NSArray *fetchedObjects, NSError *error) {
    NSLog(@"fetchedObjects-%@",fetchedObjects);
    }];
    
    [_context jk_fetchObjectForEntity:@"Person" predicate:predicate callback:^(id fetchedObject, NSError *error) {
    NSLog(@"fetchedObject2-%@",fetchedObject);
        
    }];
    
    [_context jk_fetchObjectForEntity:@"Person" sortDescriptors:sortArray callback:^(id fetchedObject, NSError *error) {
    NSLog(@"fetchedObject3-%@",fetchedObject);
    }];
    [_context jk_fetchObjectForEntity:@"Person" predicate:predicate sortDescriptors:sortArray callback:^(id fetchedObject, NSError *error) {
    NSLog(@"fetchedObject4-%@",fetchedObject);
    }];
    
    [_tableView reloadData];
}
-(void)getPerson{

    //初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置排序（按照age升序 yes为升序 no为降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    //给查询请求传递条件参数5   排序：年龄升序查询
    request= [_context jk_fetchRequestForEntityObjects:@"Person" usingPredicate:nil usingSortDescriptors:sortArray returningAsFault:YES];
    NSArray *objs = [_context executeFetchRequest:request error:nil];
    //遍历数据
    _nameArray = [[NSMutableArray alloc]init];
    _ageArray = [[NSMutableArray alloc]init];
    for (NSManagedObject *obj in objs) {
        
        NSLog(@"name=%@", [obj valueForKey:@"name"]);
        NSLog(@"age=%@", [obj valueForKey:@"age"]);
        NSLog(@"sex=%@", [obj valueForKey:@"sex"]);
        NSLog(@"id=%@", [obj valueForKey:@"id"]);
        [_nameArray addObject:[obj valueForKey:@"name"]];
        [_ageArray addObject:[obj valueForKey:@"age"]];
        
    }
    [_tableView reloadData];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _nameArray.count;

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
    cell.textLabel.text = _nameArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@岁",_ageArray[indexPath.row]];
    
    return cell;
}
//传入上下文，创建一个Card实体对象
//    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
//
//    [card setValue:@"4414241933432" forKey:@"no"];
//    // 设置Person和Card之间的关联关系
//    [person setValue:card forKey:@"card"];


//    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
//    person.name = @"李四";
//    person.age = [NSNumber numberWithInt:26];
//
//    Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:_context];
//    card.no = @"4414245465555";
//    person.card = card;
//    //保存数据
//    [_context save:nil];

@end
