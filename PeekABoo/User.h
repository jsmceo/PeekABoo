//
//  User.h
//  PeekABoo
//
//  Created by John Malloy on 1/30/14.
//  Copyright (c) 2014 Big Red INC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * phonenumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * email;

@end
