//
//  MasterViewController.m
//  PeekABoo
//
//  Created by John Malloy on 1/30/14.
//  Copyright (c) 2014 Big Red INC. All rights reserved.
//

#import "MasterViewController.h"
#import "AddUserViewController.h"
#import "DetailViewController.h"
#import "ImageCollectionCell.h"
#import "User.h"

@interface MasterViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView* userCollectionView;
}


@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"peekaboo"];
    [self.fetchedResultsController performFetch:nil];
    self.fetchedResultsController.delegate = self;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserCellID" forIndexPath:indexPath];
    User* user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageWithContentsOfFile:user.photo];
    
    return cell;
    
}

//-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
//{
//    switch (type) {
//        case NSFetchedResultsChangeInsert:
//        {
//            [userCollectionView insertItemsAtIndexPaths:@[newIndexPath]];
//            break;
//        }
//        case NSFetchedResultsChangeUpdate:
//        {
//            [userCollectionView reloadItemsAtIndexPaths:@[newIndexPath]];
//            break;
//        }
//        default:
//            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddUserSegue"])
    {
        AddUserViewController* auvc = segue.destinationViewController;
        auvc.managedObjectContext = self.managedObjectContext;
        //[self presentViewController:auvc animated:YES completion:nil];
    }
    
    
    
    //if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        [[segue destinationViewController] setDetailItem:object];
//    }
}

-(IBAction)unwindFromAddingUser:(UIStoryboardSegue*)segue
{
    AddUserViewController* auvc = segue.sourceViewController;
    User* user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    user = [auvc createUser];
    [self.managedObjectContext save:nil];
    

}


@end