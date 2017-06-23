//
//  Card+CoreDataProperties.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "Card+CoreDataProperties.h"

@implementation Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Card"];
}

@dynamic no;
@dynamic person;

@end
