//
//  DASCSuccessViewController.m
//  iRSILastWorkingVersion
//
//  Created by Ben Taylor on 23/06/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DASCSuccessViewController.h"

@interface DASCSuccessViewController ()

@end

@implementation DASCSuccessViewController

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
- (IBAction)button63:(id)sender {
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setSelected:YES];
        [sender setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateSelected];
    }
    return;
}

@end
