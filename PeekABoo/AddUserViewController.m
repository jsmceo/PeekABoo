//
//  AddUserViewController.m
//  PeekABoo
//
//  Created by John Malloy on 1/30/14.
//  Copyright (c) 2014 Big Red INC. All rights reserved.
//

#import "AddUserViewController.h"

@interface AddUserViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate>
{
    __weak IBOutlet UITextField *nameLabel;
    __weak IBOutlet UITextField *addressLabel;
    __weak IBOutlet UITextField *phoneLabel;
    __weak IBOutlet UITextField *emailLabel;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIBarButtonItem *saveButton;
    
    NSURL* imagePath;
    UIImagePickerController* imagePicker;
}

@end

@implementation AddUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	saveButton.enabled = NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self checkForCompleteForm];
    return YES;
}

-(void)checkForCompleteForm
{
    int formsFilled = 0;
    for (UITextField* textField in self.view.subviews) {
        if([textField isKindOfClass:[UITextField class]])
        {
            if(!([textField.text isEqualToString:@""]))
            {
                formsFilled++;
            }
        }
    }
    
    if (phoneLabel.text.length != 10)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Invalid Phone Number" message:@"Please enter a valid 10-digit phone number with no formatting." delegate:self cancelButtonTitle:@"If you insist." otherButtonTitles:nil];
        
        [alert show];
    }
    
    if (imageView.image != [UIImage imageNamed:@"100x150.gif"]) {
        formsFilled++;
    }
    
    if (formsFilled == 5) {
        saveButton.enabled = YES;
    }else{
        saveButton.enabled = NO;
    }
    
}

-(User*)createUser
{
    User* user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    user.name = nameLabel.text;
    user.address = addressLabel.text;
    user.phonenumber = phoneLabel.text;
    user.email = emailLabel.text;
    user.photo = [imagePath absoluteString];
    
    
    return user;
}

- (IBAction)choosePhotoFromLibrary:(id)sender
{
    imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imagePath = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self checkForCompleteForm];


}

@end
