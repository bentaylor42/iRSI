//
//  guidePreO2ViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "guidePreO2ViewController.h"

@interface guidePreO2ViewController ()

@end

// Declares local strings
NSString * title;
NSString * para1;
NSString * para2;
NSString * para3;
NSString * closeWindow;

@implementation guidePreO2ViewController

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
    
    [self loadStrings];
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    title = [dict objectForKey:@"GuidePreO2Title"];
    para1 = [dict objectForKey:@"GuidePreO2Para1"];
    para2 = [dict objectForKey:@"GuidePreO2Para2"];
    para3 = [dict objectForKey:@"GuidePreO2Para3"];
    closeWindow = [dict objectForKey:@"Close"];
    
    self.labelTitle.text = title;
    self.labelPara1.text = para1;
    self.labelPara2.text = para2;
    self.labelPara3.text = para3;
    self.buttonClose1.titleLabel.text = closeWindow;
    self.buttonClose2.titleLabel.text = closeWindow;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClose:(id)sender {
    
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedNODESATWindowOpen setNodesatWindowOpen :[NSNumber numberWithBool:NO]];
}

- (IBAction)buttonResusMe:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://resus.me/preoxygenation-and-prevention-of-desaturation/"]];
}

- (IBAction)buttonEMCrit:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://emcrit.org/preoxygenation/"]];
}

@end
