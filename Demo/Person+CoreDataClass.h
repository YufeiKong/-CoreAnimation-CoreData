//
//  Person+CoreDataClass.h
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSManagedObject
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) Card *card;
@end

NS_ASSUME_NONNULL_END

#import "Person+CoreDataProperties.h"
