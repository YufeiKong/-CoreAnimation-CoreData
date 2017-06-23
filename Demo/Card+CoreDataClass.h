//
//  Card+CoreDataClass.h
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSManagedObject
@property (nonatomic, retain) NSString * no;
@property (nonatomic, retain) Person *person;
@end

NS_ASSUME_NONNULL_END

#import "Card+CoreDataProperties.h"
