//
//  TeamViewController.m
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "TeamViewController.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

NSInteger tickCount = 0;
bool cricoidIsUsed = YES;

NSString * teamIntro;
NSString * teamExplain;
NSString * airwayAssistant;
NSString * intubatorFirst;
NSString * intubatorSecond;
NSString * cSpine;
NSString * cricoid;
NSString * drugAdmin;
NSString * teamLeader;
NSString * scribe;

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
    [self ensureProperlyLoaded];
    [self loadCricoid];
}

- (void) loadCricoid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    if ([defaults objectForKey:@"cricoidUsed"] != nil){cricoidIsUsed = [defaults boolForKey:@"cricoidUsed"];}
    if (cricoidIsUsed == NO){
        [[sharedTeamTicked teamTicked] replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:3]];
        self.buttonCricoid.hidden = YES;
    }
    else{self.buttonCricoid.hidden = NO;}
}

- (void) ensureProperlyLoaded{
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:0]integerValue]) {
        case 1:
            // Selected State
            [self.buttonODP setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonODP setSelected:NO];
            [self.buttonODP setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonODP setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonODP setSelected:NO];
            [self.buttonODP setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonODP setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonODP setSelected:NO];
            [self.buttonODP setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonODP setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonODP setSelected:NO];
            [self.buttonODP setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:1]integerValue]) {
        case 1:
            // Selected State
            [self.buttonAnaes1 setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonAnaes1 setSelected:NO];
            [self.buttonAnaes1 setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonAnaes1 setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonAnaes1 setSelected:NO];
            [self.buttonAnaes1 setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonAnaes1 setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonAnaes1 setSelected:NO];
            [self.buttonAnaes1 setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonAnaes1 setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonAnaes1 setSelected:NO];
            [self.buttonAnaes1 setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:2]integerValue]) {
            
        case 1:
            // Selected State
            [self.buttonCSpine setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonCSpine setSelected:NO];
            [self.buttonCSpine setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonCSpine setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonCSpine setSelected:NO];
            [self.buttonCSpine setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonCSpine setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonCSpine setSelected:NO];
            [self.buttonCSpine setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonCSpine setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonCSpine setSelected:NO];
            [self.buttonCSpine setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:3]integerValue]) {
            
        case 1:
            // Selected State
            [self.buttonCricoid setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonCricoid setSelected:NO];
            [self.buttonCricoid setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonCricoid setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonCricoid setSelected:NO];
            [self.buttonCricoid setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonCricoid setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonCricoid setSelected:NO];
            [self.buttonCricoid setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonCricoid setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonCricoid setSelected:NO];
            [self.buttonCricoid setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:4]integerValue]) {
            
        case 1:
            // Selected State
            [self.buttonDrugs setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonDrugs setSelected:NO];
            [self.buttonDrugs setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonDrugs setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonDrugs setSelected:NO];
            [self.buttonDrugs setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonDrugs setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonDrugs setSelected:NO];
            [self.buttonDrugs setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonDrugs setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonDrugs setSelected:NO];
            [self.buttonDrugs setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:5]integerValue]) {
            
        case 1:
            // Selected State
            [self.buttonTeamLeader setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonTeamLeader setSelected:NO];
            [self.buttonTeamLeader setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonTeamLeader setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonTeamLeader setSelected:NO];
            [self.buttonTeamLeader setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonTeamLeader setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonTeamLeader setSelected:NO];
            [self.buttonTeamLeader setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonTeamLeader setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonTeamLeader setSelected:NO];
            [self.buttonTeamLeader setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:6]integerValue]) {
            
        case 1:
            // Selected State
            [self.buttonAnaes2 setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonAnaes2 setSelected:NO];
            [self.buttonAnaes2 setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonAnaes2 setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonAnaes2 setSelected:NO];
            [self.buttonAnaes2 setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonAnaes2 setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonAnaes2 setSelected:NO];
            [self.buttonAnaes2 setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonAnaes2 setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonAnaes2 setSelected:NO];
            [self.buttonAnaes2 setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    
    switch ([[[sharedTeamTicked teamTicked]objectAtIndex:7]integerValue]) {
            
        case 1:
            // Selected State
            [self.buttonScribe setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonScribe setSelected:NO];
            [self.buttonScribe setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            [self.buttonScribe setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonScribe setSelected:NO];
            [self.buttonScribe setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Skipped State
            [self.buttonScribe setBackgroundImage:nil forState:UIControlStateNormal];
            [self.buttonScribe setSelected:NO];
            [self.buttonScribe setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 4:
            // Default State
            [self.buttonScribe setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [self.buttonScribe setSelected:NO];
            [self.buttonScribe setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    teamIntro = [dict objectForKey:@"TeamIntro"];
    teamExplain = [dict objectForKey:@"TeamExplain"];
    airwayAssistant = [dict objectForKey:@"AirwayAssistant"];
    intubatorFirst = [dict objectForKey:@"IntubatorFirst"];
    intubatorSecond = [dict objectForKey:@"IntubatorSecond"];
    cSpine = [dict objectForKey:@"CSpine"];
    cricoid = [dict objectForKey:@"Cricoid"];
    drugAdmin = [dict objectForKey:@"DrugAdministrator"];
    teamLeader = [dict objectForKey:@"TeamLeader"];
    scribe = [dict objectForKey:@"Scribe"];
    
    // loads the display elements with the custom strings
    self.labelTitle.text = teamIntro;
    self.labelExplanation.text = teamExplain;
    self.buttonODP.titleLabel.text = airwayAssistant;
    self.buttonAnaes1.titleLabel.text = intubatorFirst;
    self.buttonAnaes2.titleLabel.text = intubatorSecond;
    self.buttonCricoid.titleLabel.text = cricoid;
    self.buttonCSpine.titleLabel.text = cSpine;
    self.buttonDrugs.titleLabel.text = drugAdmin;
    self.buttonScribe.titleLabel.text = scribe;
    self.buttonTeamLeader.titleLabel.text = teamLeader;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonODP:(id)sender {
    
    NSInteger buttonTapped = 0;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (IBAction)buttonAnaes1:(id)sender {
    NSInteger buttonTapped = 1;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (IBAction)buttonCSpine:(id)sender {
    NSInteger buttonTapped = 2;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (IBAction)buttonCricoid:(id)sender {
    NSInteger buttonTapped = 3;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (IBAction)buttonDrugs:(id)sender {
    NSInteger buttonTapped = 4;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (IBAction)buttonTeamLeader:(id)sender {
    NSInteger buttonTapped = 5;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (IBAction)buttonSecondIntubator:(id)sender {
    NSInteger buttonTapped = 6;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (IBAction)buttonScribe:(id)sender {
    NSInteger buttonTapped = 7;
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    NSInteger selectedStatus = [[[sharedTeamTicked teamTicked]objectAtIndex:buttonTapped]integerValue];
    
    switch (selectedStatus) {
        case 0:
            // Selected State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:1]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0]];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:2]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0]];
            break;
            
        case 2:
            // Skipped State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:3]];
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:1.0]];
            break;
            
        case 3:
            // Default State
            [[sharedTeamTicked teamTicked]replaceObjectAtIndex:buttonTapped withObject:[NSNumber numberWithInteger:0]];
            [sender setBackgroundImage:[UIImage imageNamed:@"Plain Border"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            [sender setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
            break;
    }
    
    [self updateTabColour];
}

- (void) updateTabColour{
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    EventLog *sharedTeamComplete = [EventLog sharedTeamComplete];
    NSInteger sum = 0;
    NSInteger total = [[sharedTeamTicked teamTicked] count];
    
    for (NSInteger counter = 0; counter < total; counter ++){
        if ([[[sharedTeamTicked teamTicked]objectAtIndex:counter]integerValue] > 0){sum ++;}
    }
    
    if (cricoidIsUsed == NO){
        sum --;
        total --;
    }
    
    if (sum == 0){[sharedTeamComplete setTeamComplete:[NSNumber numberWithInteger:0]];}
    else if (sum < total){[sharedTeamComplete setTeamComplete:[NSNumber numberWithInteger:1]];}
    else {[sharedTeamComplete setTeamComplete:[NSNumber numberWithInteger:2]];}
}

// ===== Code to add functionality in the future for explaining each role and adding named individuals to each slot =====

- (IBAction)pressODP:(id)sender {
    NSLog(@"Airway Assistant - Long Touch");
}

- (IBAction)pressAnaes:(id)sender {
    NSLog(@"1st Intubator - Long Touch");
}

- (IBAction)pressCricoid:(id)sender {
    NSLog(@"Cricoid - Long Touch");
}

- (IBAction)pressCSpine:(id)sender {
    NSLog(@"C-Spine - Long Touch");
}

- (IBAction)pressDrugs:(id)sender {
    NSLog(@"Drugs - Long Touch");
}

- (IBAction)pressTeamLeader:(id)sender {
    NSLog(@"Team Leader - Long Touch");
}

- (IBAction)pressScribe:(id)sender {
    NSLog(@"Scribe - Long Touch");
}

- (IBAction)pressSecondIntubator:(id)sender {
    NSLog(@"Second Intubator - Long Touch");
}

@end
