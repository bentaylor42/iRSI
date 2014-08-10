//
//  MainMenuViewController.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

// ======= Defines the strings for the labels ========
NSString *missionStatement;
NSString *emergencyGuidelines;
NSString *usefulTools;
NSString *rsiNow;
NSString *settings;
NSString *phemMode;
NSString *version;
NSString *copyright2014;
NSString *copyrightAfter2014;
NSString *appTitle;

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
    
    // Hides the navigation controllers
    [self.navigationController setNavigationBarHidden:YES];
    
    [self loadStrings];
    
    [self copyrightVersion];
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    appTitle = [dict objectForKey:@"AppTitle"];
    missionStatement = [dict objectForKey:@"MissionStatement"];
    emergencyGuidelines = [dict objectForKey:@"EmergencyGuidelines"];
    usefulTools = [dict objectForKey:@"UsefulTools"];
    rsiNow = [dict objectForKey:@"RSINow"];
    settings = [dict objectForKey:@"Settings"];
    phemMode = [dict objectForKey:@"PreHospitalMode"];
    version = [dict objectForKey:@"Version"];
    copyright2014 = [dict objectForKey:@"Copyright2014"];
    copyrightAfter2014 = [dict objectForKey:@"CopyrightAfter2014"];
    
    self.labelAppTitle.text = appTitle;
    self.labelMissionStatement.text = missionStatement;
    self.buttonEmergency.titleLabel.text = emergencyGuidelines;
    self.buttonTools.titleLabel.text = usefulTools;
    self.buttonRSI.titleLabel.text = rsiNow;
    self.buttonSettings.titleLabel.text = settings;
    self.labelPHEM.text = phemMode;
}

- (void) viewDidAppear:(BOOL)animated
{
    EventLog *sharedPreHospital = [EventLog sharedPreHospital];
    self.switchPHEM.on = [[sharedPreHospital preHospital] boolValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void) copyrightVersion
{
    NSString *versionNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.labelVersion.text = [NSString stringWithFormat:version,versionNumber];
    
    // Gets the present year, in order to update the copyright strings
    NSDate *now = [NSDate date];
    NSDateFormatter *year = [[NSDateFormatter alloc]init];
    [year setDateFormat:@"yyyy"];
    NSString *output = [year stringFromDate:now];
    
    if ([output isEqualToString:@"2014"])
    {
        self.labelCopyright.text = [NSString stringWithFormat:copyright2014,@"\u00A9"];
    }
    else
    {
        self.labelCopyright.text = [NSString stringWithFormat:copyrightAfter2014,@"\u00A9", output];
    }
}

- (IBAction)switchPHEM:(id)sender
{
    EventLog *sharedPreHospital = [EventLog sharedPreHospital];
    [sharedPreHospital setPreHospital:[NSNumber numberWithBool:self.switchPHEM.on]];
}

@end
