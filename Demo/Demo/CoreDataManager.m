//
//  CoreDataManager.m
//  Demo
//
//  Created by Content on 2017/5/10.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Person.data"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
- (NSURL *)applicationDocumentsDirectory{

   return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
//增
- (void)insertCoreData:(NSMutableArray*)dataArray{

    NSManagedObjectContext *context = [self managedObjectContext];
    for (Person*info in dataArray) {
        NSManagedObject *person = [Person jk_create:context];
        [person setValue:[info valueForKey:@"name"] forKey:@"name"];
        [person setValue:[info valueForKey:@"age"] forKey:@"age"];
        [context save:nil];
    }
}
//删
- (void)deleteData:(NSString *)personName{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",personName];
    NSPredicate *pre2 = [NSPredicate predicateWithFormat:@"name=%@",@"春娇"];
    NSArray *objs = [context fetchObjects:@"Person" usingPredicate:pre returningAsFault:YES];
    NSArray *objs2 = [context fetchObjects:@"Person" usingPredicate:pre2 returningAsFault:YES];
    
    if (objs.count) {
        
    [context jk_deleteObjects:objs];
    [context save:nil];
        
    }else{
        
    if (objs2.count) {
        
    [context jk_deleteObjects:objs2];
    [context save:nil];
        
    }else{
        
    NSLog(@"没有成员了");
    }
  }
    
}
//改
- (void)updateData:(NSString*)oldName withNewName:(NSString*)name{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",oldName];
    NSArray *objs = [context fetchObjects:@"Person" usingPredicate:predicate returningAsFault:YES];
    if (objs.count) {
        
    for (Person *info in objs) {
        info.name = name;
    }
    [context save:nil];
        
    }else{
        
     NSLog(@"没有成员了");
    }
}
//查
- (NSMutableArray*)selectData{

    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //设置排序（按照age升序 yes为升序 no为降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    fetchRequest= [context jk_fetchRequestForEntityObjects:coreData_TableName usingPredicate:nil usingSortDescriptors:sortArray returningAsFault:YES];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (Person *info in fetchedObjects) {
        NSLog(@"name:%@", info.name);
        NSLog(@"age:%@", [info valueForKey:@"age"]);
        [resultArray addObject:info];
    }
    return resultArray;
    
}
@end
