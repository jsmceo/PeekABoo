//
//  AddUserViewController.h
//  PeekABoo
//
//  Created by John Malloy on 1/30/14.
//  Copyright (c) 2014 Big Red INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AddUserViewController : UIViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
-(User*)createUser;
@end
