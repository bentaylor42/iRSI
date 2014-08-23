//
//  MainMenuViewController.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController (){
    NSTimer *resetTimer;
}

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
    
    resetTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(resetSingletons) userInfo:nil repeats:YES];
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
    
    if ([segue.identifier isEqualToString:@"segueMainEmergency"]){
        Interactions *sharedTransitionToEmergency = [Interactions sharedTransitionToEmergency];
        [sharedTransitionToEmergency setTransitionToEmergency:[NSNumber numberWithInt:0]];
    }
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

- (void) resetSingletons{
    Interactions *sharedResetAll = [Interactions sharedResetAll];
    if ([[sharedResetAll resetAll]boolValue] == YES){
        
        // ===== Resets all singleton variables =====
        Patient *sharedAge = [Patient sharedAge];
        Patient *sharedAgeArrayIndex = [Patient sharedAgeArrayIndex];
        Patient *sharedHeight = [Patient sharedHeight];
        Patient *sharedIbwKnown = [Patient sharedIbwKnown];
        Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        Patient *sharedIsFemale = [Patient sharedIsFemale];
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        Patient *sharedTubeSize = [Patient sharedTubeSize];
        Patient *sharedIsCuffedTube = [Patient sharedIsCuffedTube];
        Patient *sharedIsNasalTube = [Patient sharedIsNasalTube];
        Patient *sharedTubeLength = [Patient sharedTubeLength];
        
        [sharedAge setAge:[[NSNumber alloc] init]];
        [sharedAgeArrayIndex setAgeArrayIndex:[[NSNumber alloc] initWithInt:0]];
        [sharedHeight setHeight:[[NSNumber alloc] init]];
        [sharedIbwKnown setIbwKnown:[[NSNumber alloc] initWithBool:NO]];
        [sharedIdealBodyWeight setIdealBodyWeight:[[NSNumber alloc] init]];
        [sharedIsAdult setIsAdult:[[NSNumber alloc] initWithBool:YES]];
        [sharedIsFemale setIsFemale:[[NSNumber alloc] initWithBool:NO]];
        [sharedWeight setWeight:[[NSNumber alloc] initWithFloat:70.0]];
        [sharedWeightKnown setWeightKnown:[[NSNumber alloc] initWithBool:NO]];
        [sharedIsCuffedTube setIsCuffedTube:[[NSNumber alloc] initWithBool:YES]];
        [sharedTubeSize setTubeSize:[[NSNumber alloc]init]];
        [sharedTubeLength setTubeLength:[[NSNumber alloc]init]];
        [sharedIsNasalTube setIsNasalTube:[[NSNumber alloc] initWithBool:NO]];
        
        EventLog *sharedConfirmationChecklist = [EventLog sharedConfirmationChecklist];
        EventLog *sharedConfirmationPHEM = [EventLog sharedConfirmationPHEM];
        EventLog *sharedConfirmationTicked = [EventLog sharedConfirmationTicked];
        EventLog *sharedDrugsComplete = [EventLog sharedDrugsComplete];
        EventLog *sharedEquipComplete = [EventLog sharedEquipComplete];
        EventLog *sharedEquipmentTicked = [EventLog sharedEquipmentTicked];
        EventLog *sharedFinalChecklist = [EventLog sharedFinalChecklist];
        EventLog *sharedFinalComplete = [EventLog sharedFinalComplete];
        EventLog *sharedFinalCricoid = [EventLog sharedFinalCricoid];
        EventLog *sharedFinalTicked = [EventLog sharedFinalTicked];
        EventLog *sharedIndicationChecklist = [EventLog sharedIndicationChecklist];
        EventLog *sharedIndicationComplete = [EventLog sharedIndicationComplete];
        EventLog *sharedIndicationPHEM = [EventLog sharedIndicationPHEM];
        EventLog *sharedIndicationTicked = [EventLog sharedIndicationTicked];
        EventLog *sharedIntubationAttemptRunning = [EventLog sharedIntubationAttemptRunning];
        EventLog *sharedIntubationAttemptStart = [EventLog sharedIntubationAttemptStart];
        EventLog *sharedPreHospital = [EventLog sharedPreHospital];
        EventLog *sharedPreO2End  = [EventLog sharedPreO2End];
        EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
        EventLog *sharedPreO2Start = [EventLog sharedPreO2Start];
        EventLog *sharedRocEnd = [EventLog sharedRocEnd];
        EventLog *sharedRocRunning = [EventLog sharedRocRunning];
        EventLog *sharedRocStart = [EventLog sharedRocStart];
        EventLog *sharedTeamComplete = [EventLog sharedTeamComplete];
        EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
        EventLog *sharedTotalPreO2 = [EventLog sharedTotalPreO2];
        EventLog *sharedtotalRoc = [EventLog sharedtotalRoc];
        EventLog *sharedLatRSI = [EventLog sharedLatRSI];
        EventLog *sharedLongRSI = [EventLog sharedLongRSI];
        EventLog *sharedCLGrade = [EventLog sharedCLGrade];
        EventLog *sharedSuccessfulIntubationTime = [EventLog sharedSuccessfulTubeTime];
        EventLog *sharedJobAddress = [EventLog sharedJobAddress];
        EventLog *sharedGPSFix = [EventLog sharedGPSFix];
        EventLog *sharedIntubationSuccessful = [EventLog sharedIntubationSuccessful];
        EventLog *sharedIntubationStarted = [EventLog sharedIntubationStarted];
        EventLog *sharedDrugsGiven = [EventLog sharedDrugsGiven];
        
        [sharedDrugsGiven setDrugsGiven:[[NSDate alloc] init]];
        [sharedIntubationStarted setIntubationStarted:[[NSDate alloc] init]];
        [sharedIntubationSuccessful setIntubationSuccessful:[[NSDate alloc] init]];
        [sharedGPSFix setGpsFix:[[NSNumber alloc] initWithBool:NO]];
        [sharedJobAddress setJobAddress:[[NSString alloc]init]];
        [sharedtotalRoc setTotalRoc:[[NSNumber alloc] init]];
        [sharedTotalPreO2 setTotalPreO2:[[NSNumber alloc] init]];
        [sharedTeamTicked setTeamTicked:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]];
        [sharedTeamComplete setTeamComplete:[[NSNumber alloc] initWithBool:NO]];
        [sharedRocStart setRocStart:[[NSNumber alloc] init]];
        [sharedRocRunning setRocRunning:[[NSNumber alloc] initWithBool:NO]];
        [sharedRocEnd setRocEnd:[[NSNumber alloc] init]];
        [sharedPreO2Start setPreO2Start:[[NSNumber alloc] init]];
        [sharedPreO2Running setPreO2Running:[[NSNumber alloc] initWithBool:NO]];
        [sharedPreO2End setPreO2End:[[NSNumber alloc] init]];
        [sharedPreHospital setPreHospital:[[NSNumber alloc] initWithBool:NO]];
        [sharedIntubationAttemptStart setIntubationAttemptStart:[[NSNumber alloc] init]];
        [sharedIntubationAttemptRunning setIntubationAttemptRunning:[[NSNumber alloc] initWithBool:NO]];
        [sharedIndicationTicked setIndicationTicked:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0],nil]];
        [sharedIndicationPHEM setIndicationPHEM:[[NSArray alloc] init]];
        [sharedIndicationComplete setIndicationComplete:[[NSNumber alloc] initWithInteger:0]];
        [sharedIndicationChecklist setIndicationChecklist:[[NSArray alloc] init]];
        [sharedFinalTicked setFinalTicked:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]];
        [sharedFinalCricoid setFinalCricoid:[[NSArray alloc] init]];
        [sharedFinalComplete setFinalComplete:[[NSNumber alloc] initWithInteger:0]];
        [sharedFinalChecklist setFinalChecklist:[[NSMutableArray alloc]init]];
        [sharedEquipmentTicked setEquipmentTicked:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil]];
        [sharedEquipComplete setEquipComplete:[[NSNumber alloc] initWithInteger:0]];
        [sharedDrugsComplete setDrugsComplete:[[NSNumber alloc] initWithInteger:0]];
        [sharedConfirmationTicked setConfirmationTicked:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil]];
        [sharedConfirmationPHEM setConfirmationPHEM:[[NSMutableArray alloc]init]];
        [sharedConfirmationChecklist setConfirmationChecklist:[[NSMutableArray alloc]init]];
        [sharedLongRSI setLongRSI:[[NSNumber alloc] init]];
        [sharedLatRSI setLatRSI:[[NSNumber alloc] init]];
        [sharedCLGrade setClGrade:[[NSString alloc]init]];
        [sharedSuccessfulIntubationTime setSuccessfulTubeTime:[[NSNumber alloc]init]];
        
        Alerts *sharedIntubationAlertOn = [Alerts sharedIntubationAlertOn];
        Alerts *sharedIntubationStartTime = [Alerts sharedIntubationStartTime];
        Alerts *sharedIntubationTimerRunning = [Alerts sharedIntubationTimerRunning];
        Alerts *sharedIntubationTotalTime = [Alerts sharedIntubationTotalTime];
        Alerts *sharedPreO2Alert1 = [Alerts sharedPreO2Alert1];
        Alerts *sharedPreO2Alert2 = [Alerts sharedPreO2Alert2];
        Alerts *sharedPreO2AlertOn = [Alerts sharedPreO2AlertOn];
        Alerts *sharedRocAlert1 = [Alerts sharedRocAlert1];
        Alerts *sharedRocAlert2 = [Alerts sharedRocAlert2];
        Alerts *sharedRocClockAlertOn = [Alerts sharedRocClockAlertOn];
        
        [sharedIntubationAlertOn setIntubationAlertOn:[[NSNumber alloc] initWithBool:NO]];
        [sharedIntubationStartTime setIntubationStartTime:[[NSNumber alloc] init]];
        [sharedIntubationTimerRunning setIntubationTimerRunning:[[NSNumber alloc] initWithBool:NO]];
        [sharedIntubationTotalTime setIntubationTotalTime:[[NSNumber alloc] init]];
        [sharedPreO2Alert1 setPreO2Alert1:[[NSNumber alloc] initWithBool:NO]];
        [sharedPreO2Alert2 setPreO2Alert2:[[NSNumber alloc] initWithBool:NO]];
        [sharedPreO2AlertOn setPreO2AlertOn:[[NSNumber alloc] initWithBool:NO]];
        [sharedRocAlert1 setRocAlert1:[[NSNumber alloc] initWithBool:NO]];
        [sharedRocAlert2 setRocAlert2:[[NSNumber alloc] initWithBool:NO]];
        [sharedRocClockAlertOn setRocClockAlertOn:[[NSNumber alloc] initWithBool:NO]];
        
        DrugLog *sharedInductionDrug = [DrugLog sharedInductionDrug];
        DrugLog *sharedRelaxantsDrug = [DrugLog sharedRelaxantsDrug];
        DrugLog *sharedFlush = [DrugLog sharedFlush];
        DrugLog *sharedEmergencyDrug = [DrugLog sharedEmergencyDrug];
        DrugLog *sharedCoinductiveDrug = [DrugLog sharedCoinductiveDrug];
        DrugLog *sharedOngoingSedationDrug = [DrugLog sharedOngoingSedationDrug];
        DrugLog *sharedOngoingAnalgesiaDrug = [DrugLog sharedOngoingAnalgesiaDrug];
        DrugLog *sharedOtherDrug = [DrugLog sharedOtherDrug];
        DrugLog *sharedVasopressorChosen = [DrugLog sharedVasopressorChosen];
        DrugLog *sharedAntimuscarinicChosen = [DrugLog sharedAntimuscarinicChosen];
        DrugLog *sharedDrugDoseDisplayType = [DrugLog sharedDrugDoseDisplayType];
        
        [sharedInductionDrug setInductionDrug:[[NSMutableArray alloc] init]];
        [sharedRelaxantsDrug setRelaxantsDrug:[[NSMutableArray alloc] init]];
        [sharedFlush setFlush:[[NSMutableArray alloc] init]];
        [sharedEmergencyDrug setEmergencyDrug:[[NSMutableArray alloc] init]];
        [sharedCoinductiveDrug setCoInductiveDrug:[[NSMutableArray alloc] init]];
        [sharedOngoingSedationDrug setOngoingSedationDrug:[[NSMutableArray alloc] init]];
        [sharedOngoingAnalgesiaDrug setOngoingAnalgesiaDrug:[[NSMutableArray alloc] init]];
        [sharedOtherDrug setOtherDrug:[[NSMutableArray alloc] init]];
        [sharedVasopressorChosen setVasopressorChosen:[[NSNumber alloc] initWithInteger:0]];
        [sharedAntimuscarinicChosen setAntimuscarinicChosen:[[NSNumber alloc] initWithInteger:0]];
        [sharedDrugDoseDisplayType setDrugDoseDisplayType:[[NSNumber alloc] init]];
        
        Interactions *sharedResetAll = [Interactions sharedResetAll];
        Interactions *sharedTriggerReport = [Interactions sharedTriggerReport];
        
        [sharedResetAll setResetAll:[NSNumber numberWithBool:NO]];
        [sharedTriggerReport setTriggerReport:[NSNumber numberWithBool:NO]];
        
        
        // ===== refreshes the view =====
        [self loadStrings];
        [self copyrightVersion];
    }
}

@end
