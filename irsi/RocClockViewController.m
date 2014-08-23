//
//  RocClockViewController.m
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "RocClockViewController.h"

@interface RocClockViewController ()

@end

@implementation RocClockViewController

@synthesize sourcePage;

NSString *back;
NSString *rocClock;
NSString *startTube;
NSString *successTube;
NSString *start;
NSString *stop;
NSString *emergency;
NSString *initialInstructions;
NSString *nodesat;
NSString *redButton;
NSString *orangeButton;
NSString *greenButton;

NSInteger rocMin = 60;
NSInteger rocMax = 120;

NSTimer * rocClockTimer;
NSTimer * preO2alertTimer;
NSTimer * rocAlertTimer;
NSTimer * periodicFlashTimer;

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if ([defaults objectForKey:@"rocMin"] != nil){rocMin = [defaults integerForKey:@"rocMin"];}
    if ([defaults objectForKey:@"rocMax"] != nil){rocMax = [defaults integerForKey:@"rocMax"];}
    
    [self loadStrings];
    [self checkState];
    
    preO2alertTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(preO2Alerts) userInfo:nil repeats:YES];
}

- (void) preO2Alerts{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    bool beepOn = YES;
    bool flashOn = YES;
    bool vibrateOn = YES;
    bool preO2Alert = YES;
    
    NSInteger preO2Min = 180;
    NSInteger preO2Max = 300;
    
    if ([defaults objectForKey:@"preO2Min"] != nil){preO2Min = [defaults integerForKey:@"preO2Min"];}
    if ([defaults objectForKey:@"preO2Max"] != nil){preO2Max = [defaults integerForKey:@"preO2Max"];}
    if ([defaults objectForKey:@"beepOn"] != nil){beepOn = [defaults boolForKey:@"beepOn"];}
    if ([defaults objectForKey:@"vibrateOn"] != nil){vibrateOn = [defaults boolForKey:@"vibrateOn"];}
    if ([defaults objectForKey:@"flashOn"] != nil){flashOn = [defaults boolForKey:@"flashOn"];}
    if ([defaults objectForKey:@"preO2Alert"] != nil){preO2Alert = [defaults boolForKey:@"preO2Alert"];}
    
    Alerts *sharedPreO2AlertOn = [Alerts sharedPreO2AlertOn];
    Alerts *sharedPreO2Alert1 = [Alerts sharedPreO2Alert1];
    Alerts *sharedPreO2Alert2 = [Alerts sharedPreO2Alert2];
    EventLog *sharedPreO2Start = [EventLog sharedPreO2Start];
    EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
    
    if (([[sharedPreO2AlertOn preO2AlertOn]boolValue] == YES) && ([[sharedPreO2Running preO2Running]boolValue] == YES) && (preO2Alert == YES)){
        // Calculates elapsed time
        double timeElapsed = CACurrentMediaTime() - [[sharedPreO2Start preO2Start] doubleValue];
        bool ping = NO;
        if ((timeElapsed >= preO2Min) && ([[sharedPreO2Alert1 preO2Alert1]boolValue] == NO)){
            ping = YES;
            [sharedPreO2Alert1 setPreO2Alert1:[NSNumber numberWithBool:YES]];
        }
        if ((timeElapsed >= preO2Max) && ([[sharedPreO2Alert2 preO2Alert2]boolValue] == NO)){
            ping = YES;
            [sharedPreO2Alert2 setPreO2Alert2:[NSNumber numberWithBool:YES]];
        }
        if (ping == YES){
            if (beepOn == YES){AudioServicesPlaySystemSound(1005);}
            if (vibrateOn == YES){AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);}
            if (flashOn == YES){
                // makes the screen flash briefly yellow
                UIView *flashview = [[UIView alloc] initWithFrame:self.view.bounds];
                flashview.backgroundColor = [UIColor yellowColor];
                [self.view addSubview:flashview];
                [UIView animateWithDuration:0.7 delay:0.1 options:0 animations:^{flashview.alpha = 0.0f;}completion:^(BOOL finished) {
                    [flashview removeFromSuperview];}];
                
                // Flashes the torch after checking it is available on the used device
                AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                if ([device hasTorch] == YES)
                {
                    [device lockForConfiguration:nil];
                    [device setTorchMode:AVCaptureTorchModeOn];
                    [NSThread sleepForTimeInterval:1.0f];
                    [device setTorchMode:AVCaptureTorchModeOff];
                    [device unlockForConfiguration];
                }
            }
            ping = NO;
        }
    }
    else{return;}
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    back = [NSString stringWithFormat:@"< %@",[dict objectForKey:@"Back"]];
    rocClock = [dict objectForKey:@"RocClockButton"];
    startTube = [dict objectForKey:@"StartTube"];
    start = [dict objectForKey:@"StartRoc"];
    successTube = [dict objectForKey:@"SuccessTube"];
    stop = [dict objectForKey:@"Stop"];
    emergency = [dict objectForKey:@"Emergency"];
    initialInstructions = [dict objectForKey:@"InitialRocInstructions"];
    nodesat = [dict objectForKey:@"RocNodesat"];
    redButton = [dict objectForKey:@"RocRedButton"];
    orangeButton = [dict objectForKey:@"RocOrangeButton"];
    greenButton = [dict objectForKey:@"RocGreenButton"];
    
    self.labelTitle.text = rocClock;
    self.labelInstructions.text = initialInstructions;
    self.labelOtherInstructions.text = nodesat;
    self.buttonBack.titleLabel.text = back;
    self.buttonStartTube.titleLabel.text = startTube;
    self.buttonSuccessTube1.titleLabel.text = successTube;
    self.buttonSuccessTube2.titleLabel.text = successTube;
    self.labelBigButton.text = start;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonBack:(id)sender {
    Interactions *sharedTransitionToRoc = [Interactions sharedTransitionToRoc];
    NSInteger transition = [[sharedTransitionToRoc transitionToRoc]integerValue];
    if (transition == 0){[self performSegueWithIdentifier:@"segueRocMenu" sender:self];}
    if (transition == 1){[self performSegueWithIdentifier:@"segueRocRSI" sender:self];}
}

- (IBAction)buttonBig:(id)sender {
    EventLog *sharedRocRunning = [EventLog sharedRocRunning];
    
    if ([[sharedRocRunning rocRunning]boolValue] == YES){[self performSegueWithIdentifier:@"segueRocEmergency" sender:self];}
    else {[self startRocClock];}
    
    return;
}

- (void) startRocClock{
    EventLog *sharedRocRunning = [EventLog sharedRocRunning];
    EventLog *sharedRocStart = [EventLog sharedRocStart];
    EventLog *sharedPreO2End = [EventLog sharedPreO2End];
    EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
    EventLog *sharedDrugsGiven = [EventLog sharedDrugsGiven];
    
    Alerts *sharedPreO2AlertOn = [Alerts sharedPreO2AlertOn];
    Alerts *sharedRocClockAlertOn = [Alerts sharedRocClockAlertOn];
    Alerts *sharedRocAlert1 = [Alerts sharedRocAlert1];
    Alerts *sharedRocAlert2 = [Alerts sharedRocAlert2];
    
    [sharedPreO2AlertOn setPreO2AlertOn:[NSNumber numberWithBool:NO]];
    [sharedRocClockAlertOn setRocClockAlertOn:[NSNumber numberWithBool:YES]];
    [sharedRocAlert1 setRocAlert1:[NSNumber numberWithBool:NO]];
    [sharedRocAlert2 setRocAlert2:[NSNumber numberWithBool:NO]];
    
    [sharedRocRunning setRocRunning:[NSNumber numberWithBool:YES]];
    self.imageButtonBackground.image = [UIImage imageNamed:@"RedButton.png"];
    self.labelBigButton.text = emergency;
    self.labelInstructions.text = redButton;
    self.labelOtherInstructions.text = orangeButton;
    self.viewDrugsGiven.hidden = NO;
    self.viewDrugsGiven.alpha = 1;
    self.buttonStop.hidden = NO;
    self.buttonStop.enabled = YES;
    self.buttonStop.titleLabel.text = stop;
    
    [sharedRocStart setRocStart:[NSNumber numberWithDouble:CACurrentMediaTime()]];
    [sharedDrugsGiven setDrugsGiven:[NSDate date]];
    
    if ([[sharedPreO2Running preO2Running]boolValue] == YES){
        [sharedPreO2End setPreO2End:[NSNumber numberWithDouble:CACurrentMediaTime()]];
        [sharedPreO2Running setPreO2Running:[NSNumber numberWithBool:NO]];
    }
    
    rocClockTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateElapsedTime) userInfo:nil repeats:YES];
    
    rocAlertTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(rocAlerts) userInfo:nil repeats:YES];
    
    return;
}

- (void) rocAlerts{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    bool beepOn = YES;
    bool flashOn = YES;
    bool vibrateOn = YES;
    bool rocAlert = YES;
    
    if ([defaults objectForKey:@"beepOn"] != nil){beepOn = [defaults boolForKey:@"beepOn"];}
    if ([defaults objectForKey:@"vibrateOn"] != nil){vibrateOn = [defaults boolForKey:@"vibrateOn"];}
    if ([defaults objectForKey:@"flashOn"] != nil){flashOn = [defaults boolForKey:@"flashOn"];}
    if ([defaults objectForKey:@"rocAlert"] != nil){rocAlert = [defaults boolForKey:@"rocAlert"];}
    
    Alerts *sharedRocClockAlertOn = [Alerts sharedRocClockAlertOn];
    Alerts *sharedRocAlert1 = [Alerts sharedRocAlert1];
    Alerts *sharedRocAlert2 = [Alerts sharedRocAlert2];
    EventLog *sharedRocStart = [EventLog sharedRocStart];
    EventLog *sharedRocRunning = [EventLog sharedRocRunning];
    
    if (([[sharedRocClockAlertOn rocClockAlertOn]boolValue] == YES) && ([[sharedRocRunning rocRunning]boolValue] == YES) && (rocAlert == YES)){
        // Calculates elapsed time
        double timeElapsed = CACurrentMediaTime() - [[sharedRocStart rocStart] doubleValue];
        bool ping = NO;
        if ((timeElapsed >= rocMin) && ([[sharedRocAlert1 rocAlert1]boolValue] == NO)){
            ping = YES;
            [sharedRocAlert1 setRocAlert1:[NSNumber numberWithBool:YES]];
        }
        if ((timeElapsed >= rocMax) && ([[sharedRocAlert2 rocAlert2]boolValue] == NO)){
            ping = YES;
            [sharedRocAlert2 setRocAlert2:[NSNumber numberWithBool:YES]];
        }
        if (ping == YES){
            if (beepOn == YES){AudioServicesPlaySystemSound(1005);}
            if (vibrateOn == YES){AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);}
            if (flashOn == YES){
                // makes the screen flash briefly yellow
                UIView *flashview = [[UIView alloc] initWithFrame:self.view.bounds];
                flashview.backgroundColor = [UIColor yellowColor];
                [self.view addSubview:flashview];
                [UIView animateWithDuration:0.7 delay:0.1 options:0 animations:^{flashview.alpha = 0.0f;}completion:^(BOOL finished) {
                    [flashview removeFromSuperview];}];
                
                // Flashes the torch after checking it is available on the used device
                AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                if ([device hasTorch] == YES)
                {
                    [device lockForConfiguration:nil];
                    [device setTorchMode:AVCaptureTorchModeOn];
                    [NSThread sleepForTimeInterval:1.0f];
                    [device setTorchMode:AVCaptureTorchModeOff];
                    [device unlockForConfiguration];
                }
            }
            ping = NO;
        }
    }
    else{return;}
}

- (void) checkState
{
    EventLog *sharedRocRunning = [EventLog sharedRocRunning];
    bool running = [[sharedRocRunning rocRunning] boolValue];
    if (running == YES)
    {
        self.imageButtonBackground.image = [UIImage imageNamed:@"RedButton.png"];
        self.labelBigButton.text = emergency;
        self.labelInstructions.text = redButton;
        self.labelOtherInstructions.text = orangeButton;
        self.viewDrugsGiven.hidden = NO;
        self.viewDrugsGiven.alpha = 1;
        self.buttonStop.hidden = NO;
        self.buttonStop.enabled = YES;
        self.buttonStop.titleLabel.text = stop;
        
        rocClockTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateElapsedTime) userInfo:nil repeats:YES];
    }
    
    return;
}

- (void) updateElapsedTime{
    EventLog *sharedRocRunning = [EventLog sharedRocRunning];
    EventLog *sharedRocStart = [EventLog sharedRocStart];
    EventLog *sharedtotalRoc = [EventLog sharedtotalRoc];
    
    if ([[sharedRocRunning rocRunning]boolValue] == YES){
        double timeElapsed = CACurrentMediaTime() - [[sharedRocStart rocStart] doubleValue];
        [sharedtotalRoc setTotalRoc:[NSNumber numberWithDouble:timeElapsed]];
        
        int minutes = (int) (timeElapsed/60);
        int seconds = (int) (timeElapsed - (minutes*60));
        
        self.labelTimeDisplay.text = [NSString stringWithFormat:@"%02i : %02i", minutes, seconds];
        [self colourCode];
    }
    else
    {
        [sharedtotalRoc setTotalRoc:[NSNumber numberWithInt:0]];
        [rocClockTimer invalidate];
        return;
    }
    return;
}

- (void) colourCode
{
    // get elapsed time
    EventLog * sharedTotalRoc = [EventLog sharedtotalRoc];
    float secondsElapsedRoc = [[sharedTotalRoc totalRoc] floatValue];
    
    // if less than lower interval, red coloured
    if (secondsElapsedRoc <rocMin)
    {
        self.viewImageBorder.image = [UIImage imageNamed:@"RedBackgroundBorderedBlack.png"];
    }
    // if more than upper interval, green coloured
    else if (secondsElapsedRoc >= rocMax)
    {
        self.viewImageBorder.image = [UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"];
    }
    // if between intervals, orange colour
    else
    {
        self.viewImageBorder.image = [UIImage imageNamed:@"OrangeBackgroundBorderedBlack.png"];
    }
    
    return;
}

- (IBAction)buttonStop:(id)sender {
    EventLog *sharedRocRunning = [EventLog sharedRocRunning];
    EventLog *sharedtotalRoc = [EventLog sharedtotalRoc];
    Alerts *sharedRocClockAlertOn = [Alerts sharedRocClockAlertOn];
    
    [sharedRocRunning setRocRunning:[NSNumber numberWithBool:NO]];
    [sharedtotalRoc setTotalRoc:[NSNumber numberWithInt:0]];
    
    self.imageButtonBackground.image = [UIImage imageNamed:@"GreenButton.png"];
    self.labelBigButton.text = start;
    self.labelInstructions.text = initialInstructions;
    self.labelOtherInstructions.text = nodesat;
    self.viewDrugsGiven.hidden = YES;
    self.viewDrugsGiven.alpha = 0;
    self.viewIntubation.hidden = YES;
    self.viewIntubation.alpha = 0;
    self.buttonStop.hidden = YES;
    self.buttonStop.enabled = NO;
    self.viewImageBorder.image = [UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"];
    self.labelTimeDisplay.text = @"00 : 00";
    
    rocClockTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateElapsedTime) userInfo:nil repeats:YES];
    
    [sharedRocClockAlertOn setRocClockAlertOn:[NSNumber numberWithBool:NO]];
    
    [rocAlertTimer invalidate];
    
    EventLog *sharedIntubationAttemptRunning = [EventLog sharedIntubationAttemptRunning];
    Alerts *sharedIntubationAlertOn = [Alerts sharedIntubationAlertOn];
    [sharedIntubationAttemptRunning setIntubationAttemptRunning:[NSNumber numberWithBool:NO]];
    [sharedIntubationAlertOn setIntubationAlertOn:[NSNumber numberWithBool:NO]];
}

bool recordTubeStart = NO;

- (IBAction)buttonStartTube:(id)sender {
    self.viewIntubation.hidden = NO;
    self.viewIntubation.alpha = 1;
    self.viewDrugsGiven.hidden = YES;
    self.viewDrugsGiven.alpha = 0;
    recordTubeStart = YES;
    self.labelOtherInstructions.text = greenButton;
    periodicFlashTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(intubationAlerts) userInfo:nil repeats:YES];
    
    EventLog *sharedIntubationAttemptStart = [EventLog sharedIntubationAttemptStart];
    EventLog *sharedIntubationAttemptRunning = [EventLog sharedIntubationAttemptRunning];
    EventLog *sharedIntubationStarted = [EventLog sharedIntubationStarted];
    Alerts *sharedIntubationAlertOn = [Alerts sharedIntubationAlertOn];
    Alerts *sharedRocClockAlertOn = [Alerts sharedRocClockAlertOn];
    
    [sharedIntubationAttemptRunning setIntubationAttemptRunning:[NSNumber numberWithBool:YES]];
    [sharedIntubationAlertOn setIntubationAlertOn:[NSNumber numberWithBool:YES]];
    [sharedIntubationAttemptStart setIntubationAttemptStart:[NSNumber numberWithDouble:CACurrentMediaTime()]];
    [sharedRocClockAlertOn setRocClockAlertOn:[NSNumber numberWithBool:NO]];
    [sharedIntubationStarted setIntubationStarted:[NSDate date]];
}

double lastBeep = 0;
double lastBuzz = 0;
double lastFlash = 0;

- (void) intubationAlerts{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    bool beepOn = YES;
    bool flashOn = YES;
    bool vibrateOn = YES;
    bool periodicAlert = YES;
    
    NSInteger beepInterval = 30;
    NSInteger vibrateInterval = 30;
    NSInteger flashInterval = 30;
    
    if ([defaults objectForKey:@"beepOn"] != nil){beepOn = [defaults boolForKey:@"beepOn"];}
    if ([defaults objectForKey:@"vibrateOn"] != nil){vibrateOn = [defaults boolForKey:@"vibrateOn"];}
    if ([defaults objectForKey:@"flashOn"] != nil){flashOn = [defaults boolForKey:@"flashOn"];}
    if ([defaults objectForKey:@"periodicAlert"] != nil){periodicAlert = [defaults boolForKey:@"periodicAlert"];}
    if ([defaults objectForKey:@"beepInterval"] != nil){beepInterval = [defaults integerForKey:@"beepInterval"];}
    if ([defaults objectForKey:@"vibrateInterval"] != nil){vibrateInterval = [defaults integerForKey:@"vibrateInterval"];}
    if ([defaults objectForKey:@"flashInterval"] != nil){flashInterval = [defaults integerForKey:@"flashInterval"];}
    
    Alerts *sharedIntubationAlertOn = [Alerts sharedIntubationAlertOn];
    EventLog *sharedIntubationAttemptRunning = [EventLog sharedIntubationAttemptRunning];
    
    if (([[sharedIntubationAttemptRunning intubationAttemptRunning]boolValue] == YES) && (periodicAlert == YES) && ([[sharedIntubationAlertOn intubationAlertOn] boolValue] == YES)){
        if ((lastBeep > 0) && (beepOn == YES) && ((CACurrentMediaTime() - lastBeep) >= beepInterval)){
            AudioServicesPlaySystemSound(1005);
            lastBeep = 0;

        }
        if ((lastBuzz > 0) && (vibrateOn == YES) && ((CACurrentMediaTime() - lastBuzz) >= vibrateInterval)){
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            lastBuzz = 0;
        }
        if ((lastFlash > 0) && (flashOn == YES) && ((CACurrentMediaTime() - lastFlash) >= flashInterval)){
            // makes the screen flash briefly yellow
            UIView *flashview = [[UIView alloc] initWithFrame:self.view.bounds];
            flashview.backgroundColor = [UIColor yellowColor];
            [self.view addSubview:flashview];
            [UIView animateWithDuration:0.7 delay:0.1 options:0 animations:^{flashview.alpha = 0.0f;}completion:^(BOOL finished) {
                [flashview removeFromSuperview];}];
            
            // Flashes the torch after checking it is available on the used device
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if ([device hasTorch] == YES)
            {
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [NSThread sleepForTimeInterval:1.0f];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device unlockForConfiguration];
            }
            lastFlash = 0;
        }
        
        if (lastBeep == 0){lastBeep = CACurrentMediaTime();}
        if (lastBuzz == 0){lastBuzz = CACurrentMediaTime();}
        if (lastFlash == 0){lastFlash = CACurrentMediaTime();}
    }
    else{
        lastFlash = 0;
        lastBuzz = 0;
        lastBeep = 0;
        [periodicFlashTimer invalidate];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueRocConfirm"]){
        Interactions *sharedTransitionToConfirm = [Interactions sharedTransitionToConfirm];
        EventLog *sharedSuccessfulTubeTime = [EventLog sharedSuccessfulTubeTime];
        EventLog *sharedIntubationSuccessful = [EventLog sharedIntubationSuccessful];
        EventLog *sharedDrugsGiven = [EventLog sharedDrugsGiven];
        EventLog *sharedIntbuationStart = [EventLog sharedIntubationStarted];
        if (recordTubeStart == NO){[sharedIntbuationStart setIntubationStarted:[sharedDrugsGiven drugsGiven]];}
        [sharedSuccessfulTubeTime setSuccessfulTubeTime:[NSNumber numberWithDouble:CACurrentMediaTime()]];
        [sharedIntubationSuccessful setIntubationSuccessful:[NSDate date]];
        [sharedTransitionToConfirm setTransitionToConfirm:[NSNumber numberWithInt:0]];
    }
    if ([segue.identifier isEqualToString:@"segueRocEmergency"]){
        Interactions *sharedTransitionToEmergency = [Interactions sharedTransitionToEmergency];
        [sharedTransitionToEmergency setTransitionToEmergency:[NSNumber numberWithInt:1]];
    }
}

@end

