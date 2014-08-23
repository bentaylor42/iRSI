//
//  PreO2ViewController.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "PreO2ViewController.h"


@interface PreO2ViewController ()

@end

@implementation PreO2ViewController

NSInteger preO2Min = 180;
NSInteger preO2Max = 300;
NSTimer *preO2Timer;
NSTimer *flashTimer;
NSTimer *entice;

NSString * startString;
NSString * runningString;
NSString * stopString;

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
    
    self.labelPreO2Time.hidden = YES;
    self.buttonStartPreO2.hidden = NO;
    self.buttonStartPreO2.enabled = YES;
    self.buttonStopPreO2.hidden = YES;
    self.buttonStopPreO2.enabled = NO;
    self.labelTitle.hidden = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if ([defaults objectForKey:@"preO2Min"] != nil){preO2Min = [defaults integerForKey:@"preO2Min"];}
    if ([defaults objectForKey:@"preO2Max"] != nil){preO2Max = [defaults integerForKey:@"preO2Max"];}
    
    [self checkState];
    entice = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(entice) userInfo:nil repeats:YES];
    return;
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    startString = [dict objectForKey:@"StartPreO2"];
    runningString = [dict objectForKey:@"PreO2Time"];
    stopString = [dict objectForKey:@"Stop"];
    
    self.buttonStartPreO2.titleLabel.text = startString;
    self.buttonStopPreO2.titleLabel.text = stopString;
    self.labelTitle.text = runningString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonStartPreO2:(id)sender
{
    self.buttonStartPreO2.hidden = YES;
    self.buttonStartPreO2.enabled = NO;
    self.buttonStopPreO2.enabled = YES;
    self.buttonStopPreO2.hidden = NO;
    self.labelPreO2Time.hidden = NO;
    self.labelTitle.hidden = NO;
    
    EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
    EventLog *sharedPreO2Start = [EventLog sharedPreO2Start];
    Alerts *sharedPreO2AlertOn = [Alerts sharedPreO2AlertOn];
    Alerts *sharedPreO2Alert1 = [Alerts sharedPreO2Alert1];
    Alerts *sharedPreO2Alert2 = [Alerts sharedPreO2Alert2];
    
    [sharedPreO2AlertOn setPreO2AlertOn:[NSNumber numberWithBool:YES]];
    [sharedPreO2Alert1 setPreO2Alert1:[NSNumber numberWithBool:NO]];
    [sharedPreO2Alert2 setPreO2Alert2:[NSNumber numberWithBool:NO]];
    
    [sharedPreO2Start setPreO2Start:[NSNumber numberWithDouble:CACurrentMediaTime()]];
    [sharedPreO2Running setPreO2Running:[NSNumber numberWithBool:YES]];
    
    preO2Timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateElapsedTime) userInfo:nil repeats:YES];
}

- (void) checkState
{
    EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
    bool running = [[sharedPreO2Running preO2Running] boolValue];
    if (running == YES)
    {
        self.buttonStartPreO2.hidden = YES;
        self.buttonStartPreO2.enabled = NO;
        self.buttonStopPreO2.enabled = YES;
        self.buttonStopPreO2.hidden = NO;
        self.labelPreO2Time.hidden = NO;
        self.labelTitle.hidden = NO;
        
        preO2Timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateElapsedTime) userInfo:nil repeats:YES];
    }
    
    return;
}

- (void) updateElapsedTime
{
    EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
    EventLog *sharedPreO2Start = [EventLog sharedPreO2Start];
    EventLog *sharedTotalPreO2 = [EventLog sharedTotalPreO2];
    
    if ([[sharedPreO2Running preO2Running] boolValue] == YES)
    {
        double timeElapsed = CACurrentMediaTime() - [[sharedPreO2Start preO2Start] doubleValue];
        [sharedTotalPreO2 setTotalPreO2:[NSNumber numberWithDouble:timeElapsed]];
        int minutes = (int) (timeElapsed/60);
        int seconds = (int) (timeElapsed - (minutes*60));
        
        self.labelPreO2Time.text = [NSString stringWithFormat:@"%02i : %02i", minutes, seconds];
        [self colourCode];
    }
    else
    {
        [sharedTotalPreO2 setTotalPreO2:[NSNumber numberWithInt:0]];
        [preO2Timer invalidate];
        return;
    }
    
}

- (void) colourCode
{
    // get elapsed time
    EventLog * sharedTotalPreO2 = [EventLog sharedTotalPreO2];
    float secondsElapsedPreO2 = [[sharedTotalPreO2 totalPreO2] floatValue];
    
    // if less than lower interval, red coloured
    if (secondsElapsedPreO2 <preO2Min)
    {
        _imageBorder.image = [UIImage imageNamed:@"RedBackgroundBorderedBlack.png"];
    }
    // if more than upper interval, green coloured
    else if (secondsElapsedPreO2 >= preO2Max)
    {
        _imageBorder.image = [UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"];
    }
    // if between intervals, orange colour
    else
    {
        _imageBorder.image = [UIImage imageNamed:@"OrangeBackgroundBorderedBlack.png"];
    }
}

- (IBAction)buttonStopPreO2:(id)sender
{
    EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
    EventLog *sharedTotalPreO2 = [EventLog sharedTotalPreO2];
    Alerts *sharedPreO2AlertOn = [Alerts sharedPreO2AlertOn];
    
    [sharedPreO2AlertOn setPreO2AlertOn:[NSNumber numberWithBool:NO]];
    
    _imageBorder.image = [UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"];
    self.labelPreO2Time.hidden = YES;
    self.buttonStartPreO2.hidden = NO;
    self.buttonStartPreO2.enabled = YES;
    self.buttonStopPreO2.hidden = YES;
    self.buttonStopPreO2.enabled = NO;
    self.labelTitle.hidden = YES;
    self.labelPreO2Time.text = @"00 : 00";
    
    [sharedPreO2Running setPreO2Running:[NSNumber numberWithBool:NO]];
    [sharedTotalPreO2 setTotalPreO2:[NSNumber numberWithInt:0]];
    
    preO2Timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateElapsedTime) userInfo:nil repeats:YES];
}

- (void) entice
{
    /*
     Develop code to make pre-O2 button flash slowly intermittently in order to prompt people to press it
     */
    
    return;
}

@end
