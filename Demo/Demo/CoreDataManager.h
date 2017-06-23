//
//  CoreDataManager.h
//  Demo
//
//  Created by Content on 2017/5/10.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;//被管理的对象上下文
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;//获得有实体类型的Model
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;//持久化的助理，将对象保存到数据库中

// 构建SQLite数据库文件的路径
- (NSURL *)applicationDocumentsDirectory;
//增
- (void)insertCoreData:(NSMutableArray*)dataArray;
//删
- (void)deleteData:(NSString *)personName;
//改
- (void)updateData:(NSString*)oldName withNewName:(NSString*)name;
//查
- (NSMutableArray*)selectData;
@end
