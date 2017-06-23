//
//  Card+CoreDataProperties.h
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "Card+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *no;
@property (nullable, nonatomic, retain) Person *person;

@end

NS_ASSUME_NONNULL_END
