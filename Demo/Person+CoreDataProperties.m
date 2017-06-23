//
//  Person+CoreDataProperties.m
//  Demo
//
//  Created by Content on 2017/5/8.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic name;
@dynamic age;
@dynamic card;

@end
