//
//  iRSISettingsFeedbackViewController.m
//  iRSILastWorkingVersion
//
//  Created by Ben Taylor on 15/06/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "iRSISettingsFeedbackViewController.h"

@interface iRSISettingsFeedbackViewController ()

@end

@implementation iRSISettingsFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)facebookLink:(id)sender {
    
    // Facebook Link Button
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/iRSIApp"]];
}

- (IBAction)twitterLink:(id)sender {
    
    // Twitter Link Button
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/iRSIApp"]];
    
}

- (IBAction)googlePlusLink:(id)sender {
    
    // Google + Link Button
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/u/1/b/100931254322285698179/100931254322285698179/posts/p/pub"]];
}
- (IBAction)emailLink:(id)sender {
    
    // Opens the mail app and sends email
    
    // Checks the device can send mail
    if ([MFMailComposeViewController canSendMail]) {
        
    
        // Sets the default title and email address
        NSString *emailTitle = @"iRSI App Feedback";
        NSArray *toRecipents = [NSArray arrayWithObject:@"irsiapplication@gmail.com"];
    
        // Opens a message window and writes the default subject and email address on the screen
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setToRecipients:toRecipents];
    
        // Presents mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    else
    {
        UIAlertView *noMailAppAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Your device doesn't seem to have a properly configured mail app"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noMailAppAlert show];
    
    }
    
}

- (IBAction)buttonWebsiteLink:(id)sender
{
    // Website link button
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.rsiready.com"]];
}

// Allows the programme to handle the response of the user to cancelling, saving, sending or failure to send the message
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            NSLog(@"Mail not sent");
            break;
    }
    
    //Closes the mail interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)buttonRate:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itubes.apple.com/app/idid894362128"]];
}

@end
