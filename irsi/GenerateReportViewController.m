//
//  GenerateReportViewController.m
//  irsi
//
//  Created by Ben Taylor on 17/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "GenerateReportViewController.h"

@interface GenerateReportViewController (){
    NSString * pageTitle;
    NSString * demographicsHeading;
    NSString * back;
    NSString * confirmButton;
    NSString * dateformat;
    
    NSString * adultPatient;
    NSString * paediatricPatient;
    NSString * age;
    NSString * female;
    NSString * male;
    NSString * weight;
    NSString * estWeight;
    NSString * height;
    NSString * ibWeight;
    NSString * kg;
    
    NSString * reportTitle;
    NSString * locationTimings;
    NSString * date;
    NSString * time;
    NSString * preHospital;
    NSString * inHospital;
    NSString * wardDepartment;
    NSString * latitude;
    NSString * longitude;
    NSString * address;
    
    NSString * preparationTitle;
    NSString * challengeResponse;
    NSString * indicated;
    NSString * bestLocation;
    NSString * safeScene;
    NSString * protectedEnvironment;
    NSString * fullAccess;
    NSString * preO2TotalTime;
    NSString * apnoeicOxy;
    NSString * ivIOPatent;
    NSString * airwayOK;
    NSString * airwayNotOK;
    NSString * fullMonitoring;
    NSString * spO2;
    NSString * ecg;
    NSString * bloodPressure;
    NSString * etCO2;
    NSString * otherMonitors;
    NSString * kitCheck;
    NSString * airwayRescue;
    
    NSString * drugsUsed;
    NSString * inductionAgents;
    NSString * relaxants;
    NSString * emergencyDrugs;
    NSString * coInductives;
    NSString * otherDrugs;
    NSString * sedationMaintained;
    NSString * analgesiaMaintained;
    NSString * flushString;
    
    NSString * intubationAttemptHeading;
    NSString * teamBrief;
    NSString * cricoidUsed;
    NSString * cricoidPressureNotUsed;
    NSString * milsUsed;
    NSString * drugTime;
    NSString * intubationStartTime;
    NSString * successfulTubeTime;
    NSString * tubeSize;
    NSString * oral;
    NSString * nasal;
    NSString * cuffed;
    NSString * uncuffed;
    NSString * tubeSecuredAt;
    NSString * capnoTrace;
    NSString * tubeThroughCords;
    NSString * intubationGrade;
    NSString * equalAE;
    NSString * cxrOrdered;
    NSString * secureForTransfer;
    NSString * laryngoscopy;
    NSString * emailTitle;
    NSString * emailMessageBody;
    
    NSString * incidents;
    NSString * comments;
}

@end

@implementation GenerateReportViewController

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
    [self addDoneToolBarToKeyboard:_textViewOne];
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    back = [NSString stringWithFormat:@"< %@",[dict objectForKey:@"Back"]];
    pageTitle = [dict objectForKey:@"ConfirmReportReportTitle"];
    demographicsHeading = [dict objectForKey:@"DemographicsHeading"];
    confirmButton = [dict objectForKey:@"GenReportButton"];
    
    adultPatient = [dict objectForKey:@"adultPatient"];
    paediatricPatient = [dict objectForKey:@"paediatricPatient"];
    age = [dict objectForKey:@"age"];
    male = [dict objectForKey:@"Male"];
    female = [dict objectForKey:@"Female"];
    weight = [dict objectForKey:@"weight"];
    estWeight = [dict objectForKey:@"estWeight"];
    height = [dict objectForKey:@"height"];
    ibWeight = [dict objectForKey:@"ibWeight"];
    kg = [dict objectForKey:@"Kg"];
    
    reportTitle = [dict objectForKey:@"ReportTitle"];
    locationTimings = [dict objectForKey:@"LocationTimings"];
    date = [dict objectForKey:@"Date"];
    time = [dict objectForKey:@"Time"];
    preHospital = [dict objectForKey:@"PreHospital"];
    inHospital = [dict objectForKey:@"InHospital"];
    wardDepartment = [dict objectForKey:@"WardDepartment"];
    latitude = [dict objectForKey:@"Latitude"];
    longitude = [dict objectForKey:@"Longitude"];
    address = [dict objectForKey:@"IncidentAddress"];
    dateformat = [dict objectForKey:@"dateformat"];
    
    preparationTitle = [dict objectForKey:@"preparationTitle"];
    challengeResponse = [dict objectForKey:@"challengeResponse"];
    indicated = [dict objectForKey:@"indicated"];
    safeScene = [dict objectForKey:@"safeScene"];
    protectedEnvironment = [dict objectForKey:@"protectedEnvironment"];
    fullAccess = [dict objectForKey:@"fullAccess"];
    preO2TotalTime = [dict objectForKey:@"preO2TotalTime"];
    ivIOPatent = [dict objectForKey:@"ivIOPatent"];
    airwayOK = [dict objectForKey:@"airwayOK"];
    airwayNotOK = [dict objectForKey:@"airwayNotOK"];
    fullMonitoring = [dict objectForKey:@"fullMonitoring"];
    spO2 = [dict objectForKey:@"spO2"];
    ecg = [dict objectForKey:@"ecg"];
    bloodPressure = [dict objectForKey:@"bloodPressure"];
    etCO2 = [dict objectForKey:@"etCO2"];
    otherMonitors = [dict objectForKey:@"otherMonitors"];
    kitCheck = [dict objectForKey:@"kitCheck"];
    airwayRescue = [dict objectForKey:@"airwayRescue"];
    bestLocation = [dict objectForKey:@"bestLocation"];
    apnoeicOxy = [dict objectForKey:@"apnoeicOxy"];
    
    drugsUsed = [dict objectForKey:@"drugsUsed"];
    sedationMaintained = [dict objectForKey:@"sedationMaintained"];
    analgesiaMaintained = [dict objectForKey:@"analgesiaMaintained"];
    inductionAgents = [dict objectForKey:@"InductionAgents"];
    relaxants = [dict objectForKey:@"MuscleRelaxants"];
    emergencyDrugs = [dict objectForKey:@"EmergencyDrugs"];
    coInductives = [dict objectForKey:@"CoInductive"];
    otherDrugs = [dict objectForKey:@"OtherDrugs"];
    flushString = [dict objectForKey:@"Flush"];
    
    intubationAttemptHeading = [dict objectForKey:@"intubationAttemptHeading"];
    teamBrief = [dict objectForKey:@"teamBrief"];
    cricoidUsed = [dict objectForKey:@"cricoidUsed"];
    cricoidPressureNotUsed = [dict objectForKey:@"cricoidPressureNotUsed"];
    milsUsed = [dict objectForKey:@"milsUsed"];
    drugTime = [dict objectForKey:@"drugTime"];
    intubationStartTime = [dict objectForKey:@"intubationStartTime"];
    successfulTubeTime = [dict objectForKey:@"successfulTubeTime"];
    tubeSize = [dict objectForKey:@"tubeSize"];
    oral = [dict objectForKey:@"oral"];
    nasal = [dict objectForKey:@"nasal"];
    cuffed = [dict objectForKey:@"cuffed"];
    uncuffed = [dict objectForKey:@"uncuffed"];
    tubeSecuredAt = [dict objectForKey:@"tubeSecuredAt"];
    capnoTrace = [dict objectForKey:@"capnoTrace"];
    tubeThroughCords = [dict objectForKey:@"tubeThroughCords"];
    intubationGrade = [dict objectForKey:@"intubationGrade"];
    equalAE = [dict objectForKey:@"equalAE"];
    cxrOrdered = [dict objectForKey:@"cxrOrdered"];
    secureForTransfer = [dict objectForKey:@"secureForTransfer"];
    laryngoscopy = [dict objectForKey:@"laryngoscopy"];
    emailTitle = [dict objectForKey:@"emailTitle"];
    emailMessageBody = [dict objectForKey:@"emailMessageBody"];
    
    incidents = [dict objectForKey:@"incidents"];
    comments = [dict objectForKey:@"comments"];
    
    [self.buttonBack setTitle:back forState:UIControlStateNormal];
    [self.buttonFinished setTitle:confirmButton forState:UIControlStateNormal];
    self.labelTitleLabel.text = pageTitle;
    [self.buttonFinished.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self generateReport];
    
    return;
}

//set up a placeholder variable for the textfield user typing

-(void)addDoneToolBarToKeyboard:(UITextView *)textView
{
    UIToolbar* doneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    doneToolbar.barStyle = UIBarStyleDefault;
    doneToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedDismissKeyboard)],
                         nil];
    [doneToolbar sizeToFit];
    textView.inputAccessoryView = doneToolbar;
}

//remember to set your text view delegate
//but if you only have 1 text view in your view controller
//you can simply change currentTextField to the name of your text view
//and ignore this textViewDidBeginEditing delegate method

-(void)doneButtonClickedDismissKeyboard
{
    [_textViewOne resignFirstResponder];
}

- (void) generateReport{
    // creates a mutableattributed string to contain the text for the whole document
    NSMutableAttributedString * wholeDocument = [[NSMutableAttributedString alloc] init];
    
    // ===== adds the title =====
    NSMutableParagraphStyle *alignCentre = [[NSMutableParagraphStyle alloc] init];
    alignCentre.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString * titleNSAS = [[NSMutableAttributedString alloc] initWithString:reportTitle];
    [titleNSAS addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] range:NSMakeRange(0, titleNSAS.length)];
    [titleNSAS addAttribute:NSParagraphStyleAttributeName value:alignCentre range:NSMakeRange(0, titleNSAS.length)];
    [wholeDocument appendAttributedString:titleNSAS];
    
    // adds demographics disclaimer
    NSMutableAttributedString *demographics = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n\n\n\n%@\n\n\n\n\n",demographicsHeading]];
    [demographics addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:10] range:NSMakeRange(0, demographics.length)];
    [demographics addAttribute:NSParagraphStyleAttributeName value:alignCentre range:NSMakeRange(0, demographics.length)];
    [wholeDocument appendAttributedString:demographics];
    
    // Displays key patient demographics
    NSString * stringGenerator = [[NSString alloc]init];
    NSMutableString * createString = [[NSMutableString alloc]init];
    NSMutableParagraphStyle *alignLeft = [[NSMutableParagraphStyle alloc] init];
    alignCentre.alignment = NSTextAlignmentLeft;
    
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    Patient *sharedAge = [Patient sharedAge];
    Patient *sharedHeight = [Patient sharedHeight];
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    Patient *sharedWeight = [Patient sharedWeight];
    
    if ([[sharedIsFemale isFemale]boolValue] == YES){[createString appendString:female];}
    if ([[sharedIsFemale isFemale]boolValue] == NO){[createString appendString:male];}
    [createString appendString:@" "];
    if ([[sharedIsAdult isAdult]boolValue] == YES){[createString appendString:adultPatient];
        [createString appendString:@"\n"];}
    if ([[sharedIsAdult isAdult]boolValue] == NO){[createString appendString:paediatricPatient];
        [createString appendString:[NSString stringWithFormat:@"\n%@ %i \n", age, [[sharedAge age]intValue]]];
    }
    if ([[sharedWeightKnown weightKnown]boolValue] == YES){
        [createString appendString:[NSString stringWithFormat:@"%@ %i%@\n", weight, [[sharedWeight weight]intValue], kg]];}
    if ([[sharedWeightKnown weightKnown]boolValue] == NO){
        [createString appendString:[NSString stringWithFormat:@"%@ %i%@\n", estWeight, [[sharedWeight weight]intValue], kg]];}
    if (([[sharedIbwKnown ibwKnown]boolValue] == YES) && ([[sharedIsAdult isAdult]boolValue] == YES)){
        [createString appendString:[NSString stringWithFormat:@"%@ %icm \n%@ %i%@\n", height, [[sharedHeight height]intValue], ibWeight, [[sharedIdealBodyWeight idealBodyWeight]intValue], kg]];}
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n", createString];
    NSMutableAttributedString * addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    
    // ===== adds the first subheading title =====
    NSMutableAttributedString * loctimeNSAS = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \n",locationTimings]];
    [loctimeNSAS addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] range:NSMakeRange(0, loctimeNSAS.length)];
    [loctimeNSAS addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, loctimeNSAS.length)];
    [loctimeNSAS addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, loctimeNSAS.length)];
    [wholeDocument appendAttributedString:loctimeNSAS];
    
    // adds the date and time
    NSDate *now = [NSDate date];
    NSDateFormatter *today = [[NSDateFormatter alloc]init];
    NSDateFormatter *timeNow = [[NSDateFormatter alloc] init];
    [today setDateFormat:dateformat];
    [timeNow setDateFormat:@"HH:mm zzzz"];
    [timeNow setTimeZone:[NSTimeZone localTimeZone]];
    NSString * todayDate = [NSString stringWithFormat:@"%@ %@\n%@ %@ \n \n", date, [today stringFromDate:now], time, [timeNow stringFromDate:now]];
    addText = [[NSMutableAttributedString alloc] initWithString:todayDate];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // adds the location of the RSI
    EventLog *sharedPreHospital = [EventLog sharedPreHospital];
    NSString * location;
    if ([[sharedPreHospital preHospital]boolValue] == NO){
        location = [NSString stringWithFormat:@"%@ %@ \n", inHospital, wardDepartment];
    }
    
    EventLog *sharedLatRSI = [EventLog sharedLatRSI];
    EventLog *sharedLongRSI = [EventLog sharedLongRSI];
    EventLog *sharedJobAddress = [EventLog sharedJobAddress];
    EventLog *sharedGPSFix = [EventLog sharedGPSFix];
    
    if ([[sharedPreHospital preHospital]boolValue] == YES){
        if ([[sharedGPSFix gpsFix]boolValue] == YES){
            location = [NSString stringWithFormat:@"%@ \n\t%@ %@ \n\t%@ %@ \n%@ \n", preHospital, latitude, [[sharedLatRSI latRSI]stringValue], longitude, [[sharedLongRSI longRSI]stringValue], [sharedJobAddress jobAddress]];
        }
        else{location = [NSString stringWithFormat:@"%@ \n",preHospital];}
    }
    
    addText = [[NSMutableAttributedString alloc] initWithString:location];
    
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // ===== adds preparation heading =====
    addText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@ \n",preparationTitle]];
    
    [addText addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // adds intro to preparation checklist
    stringGenerator = [[NSString alloc]init];
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n", challengeResponse];
    
    addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // confirms if the RSI indicated, and here/ now
    stringGenerator = [[NSString alloc]init];
    
    createString = [[NSMutableString alloc]init];
    EventLog *sharedIndicationTicked = [EventLog sharedIndicationTicked];
    if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:2]integerValue] == 1){
        [createString appendString:indicated];
    }
    if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:3]integerValue] == 1){
        [createString appendString:bestLocation];
    }
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n \n", createString];
    
    addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // protected from envir/ safe scene/ 360 access
    if ([[sharedPreHospital preHospital]boolValue] == YES){
        stringGenerator = [[NSString alloc]init];
        
        createString = [[NSMutableString alloc]init];
        
        EventLog *sharedIndicationTicked = [EventLog sharedIndicationTicked];
        if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:0]integerValue] == 1){
            [createString appendString:safeScene];
            [createString appendString:@" "];
            if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:1]integerValue] != 1){[createString appendString:@"\n"];}
        }
        if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:1]integerValue] == 1){
            [createString appendString:protectedEnvironment];
            [createString appendString:@"\n"];
        }
        if ([[[sharedIndicationTicked indicationTicked] objectAtIndex:5]integerValue] == 1){
            [createString appendString:fullAccess];
        }
        
        stringGenerator = [NSString stringWithFormat:@"%@ \n \n", createString];
                           
        addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
                           
        [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
        [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
        [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
        [wholeDocument appendAttributedString:addText];
    }
    
    // PreO2 duration
    stringGenerator = [[NSString alloc]init];
    createString = [[NSMutableString alloc]init];
    
    EventLog *sharedTotalPreO2 = [EventLog sharedTotalPreO2];
    NSInteger preO2Time = [[sharedTotalPreO2 totalPreO2]integerValue];
    if ((preO2TotalTime > 0) && ([[[sharedIndicationTicked indicationTicked]objectAtIndex:7]integerValue] == 1)){
        int minutes = (int) (preO2Time/60);
        int seconds = (int) (preO2Time - (minutes*60));
        NSString * timePreO2String = [NSString stringWithFormat:preO2TotalTime, minutes, seconds];
        [createString appendString:timePreO2String];
        [createString appendString:@"\n"];
        if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:8]integerValue] == 1){
            [createString appendString:apnoeicOxy];
            [createString appendString:@"\n"];
        }
    }
    if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:9]integerValue] == 1){
        [createString appendString:ivIOPatent];
        [createString appendString: @"\n"];
    }
    if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:6]integerValue] == 1){
        [createString appendString:airwayOK];
        [createString appendString: @"\n"];
    }
    if ([[[sharedIndicationTicked indicationTicked]objectAtIndex:6]integerValue] == 2){
        [createString appendString:airwayNotOK];
        [createString appendString: @"\n"];
    }
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n \n", createString];
    addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // monitoring
    stringGenerator = [[NSString alloc]init];
    createString = [[NSMutableString alloc]init];
    EventLog *sharedEquipmentTicked = [EventLog sharedEquipmentTicked];
    if (([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:0]integerValue] == 1) || ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:1]integerValue] == 1) || ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:2]integerValue] == 1) || ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:3]integerValue] == 1) || ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:4]integerValue] == 1)){
        [createString appendString:fullMonitoring];
    }
    if ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:0]integerValue] == 1){
        [createString appendString:@" "];
        [createString appendString:spO2];}
    if ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:1]integerValue] == 1){
        [createString appendString:@", "];
        [createString appendString:ecg];}
    if ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:2]integerValue] == 1){
        [createString appendString:@", "];
        [createString appendString:bloodPressure];}
    if ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:3]integerValue] == 1){
        [createString appendString:@", "];
        [createString appendString:etCO2];}
    if ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:4]integerValue] == 1){
        [createString appendString:@", "];
        [createString appendString:otherMonitors];}
    if (([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:5]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:6]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:7]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:8]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:9]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:10]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:11]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:12]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:13]integerValue] == 1)){
        [createString appendString:@"\n"];
        [createString appendString:kitCheck];
    }
    if (([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:14]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:15]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:16]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:17]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:18]integerValue] == 1) &&
        ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:19]integerValue] == 1)){
        [createString appendString:@"\n"];
        [createString appendString:airwayRescue];
    }
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n", createString];
    
    addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // ===== Drugs section =====
    addText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@ \n",drugsUsed]];
    [addText addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // Drugs Section Text
    stringGenerator = [[NSString alloc]init];
    createString = [[NSMutableString alloc]init];
    
    DrugLog *sharedInductionDrug = [DrugLog sharedInductionDrug];
    DrugLog *sharedRelaxantsDrug = [DrugLog sharedRelaxantsDrug];
    DrugLog *sharedEmergencyDrug = [DrugLog sharedEmergencyDrug];
    DrugLog *sharedCoinductiveDrug = [DrugLog sharedCoinductiveDrug];
    DrugLog *sharedOtherDrug = [DrugLog sharedOtherDrug];
    DrugLog *sharedOngoingSedationDrug = [DrugLog sharedOngoingSedationDrug];
    DrugLog *sharedOngoingAnalgesiaDrug = [DrugLog sharedOngoingAnalgesiaDrug];
    DrugLog *sharedDrugDoseDisplayType = [DrugLog sharedDrugDoseDisplayType];
    DrugLog *sharedFlush = [DrugLog sharedFlush];
    
    NSString * stringZero = @"mg";
    NSString * stringOne = @"micrograms";
    NSString * stringTwo = @"mg";
    NSString * stringThree = @"mls";
    NSString * stringFour = @"micrograms/ min";
    NSString * stringFive = @"micrograms/ min";
    NSString * stringSix = @"micrograms/ kg/ min";
    NSString * stringSevenAdult = @"grams";
    NSString * stringSevenChild = @"mg";
    
    NSString * stringZero2 = @"mg/ kg";
    NSString * stringOne2 = @"micrograms/ kg";
    NSString * stringTwo2 = @"mg/ kg";
    NSString * stringThree2 = @"mls";
    NSString * stringFour2 = @"micrograms/ min";
    NSString * stringFive2 = @"micrograms/ min";
    NSString * stringSix2 = @"micrograms/ kg/ min";
    NSString * stringSeven2 = @"mg/kg";
    
    NSArray * drugsArray;
    
    float dose = 0;
    bool display2 = NO;
    if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] != 2){display2 = NO;}
    if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2){display2 = YES;}
    
    // Induction Agents
    if ([[sharedInductionDrug inductionDrug] count] != 0){
        [createString appendString:inductionAgents];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedInductionDrug inductionDrug] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedInductionDrug inductionDrug] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            if ([[drugsArray objectAtIndex:12]floatValue] != 0){
                [createString appendString:@": "];
                dose = [[drugsArray objectAtIndex:12]floatValue];
                switch ([[drugsArray objectAtIndex:11]integerValue]) {
                    case 0:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringZero2];}
                        if (display2 == NO){[createString appendString:stringZero];}
                        break;
                        
                    case 1:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringOne2];}
                        if (display2 == NO){[createString appendString:stringOne];}
                        break;
                        
                    case 2:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringTwo2];}
                        if (display2 == NO){[createString appendString:stringTwo];}
                        break;
                        
                    case 3:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringThree2];}
                        if (display2 == NO){[createString appendString:stringThree];}
                        break;
                        
                    case 4:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFour2];}
                        if (display2 == NO){[createString appendString:stringFour];}
                        break;
                        
                    case 5:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFive2];}
                        if (display2 == NO){[createString appendString:stringFive];}
                        break;
                        
                    case 6:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringSix2];}
                        if (display2 == NO){[createString appendString:stringSix];}
                        break;
                        
                    case 7:
                        if (dose <1000){
                            if (dose == (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                            }
                            if (dose != (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                            }
                            if (display2 == YES){[createString appendString:stringSeven2];}
                            if (display2 == NO){[createString appendString:stringSevenChild];}
                        }
                        else{
                            dose = dose/1000;
                            [createString appendString:[NSString stringWithFormat:@"%.1f %@",dose, stringSevenAdult]];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            [createString appendString:@"\n"];
        }
        [createString appendString:@"\n"];
    }
    
    // Relaxants
    if ([[sharedRelaxantsDrug relaxantsDrug] count] != 0){
        [createString appendString:relaxants];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedRelaxantsDrug relaxantsDrug] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedRelaxantsDrug relaxantsDrug] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            if ([[drugsArray objectAtIndex:12]floatValue] != 0){
                [createString appendString:@": "];
                dose = [[drugsArray objectAtIndex:12]floatValue];
                switch ([[drugsArray objectAtIndex:11]integerValue]) {
                    case 0:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringZero2];}
                        if (display2 == NO){[createString appendString:stringZero];}
                        break;
                        
                    case 1:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringOne2];}
                        if (display2 == NO){[createString appendString:stringOne];}
                        break;
                        
                    case 2:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringTwo2];}
                        if (display2 == NO){[createString appendString:stringTwo];}
                        break;
                        
                    case 3:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringThree2];}
                        if (display2 == NO){[createString appendString:stringThree];}
                        break;
                        
                    case 4:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFour2];}
                        if (display2 == NO){[createString appendString:stringFour];}
                        break;
                        
                    case 5:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFive2];}
                        if (display2 == NO){[createString appendString:stringFive];}
                        break;
                        
                    case 6:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringSix2];}
                        if (display2 == NO){[createString appendString:stringSix];}
                        break;
                        
                    case 7:
                        if (dose <1000){
                            if (dose == (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                            }
                            if (dose != (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                            }
                            if (display2 == YES){[createString appendString:stringSeven2];}
                            if (display2 == NO){[createString appendString:stringSevenChild];}
                        }
                        else{
                            dose = dose/1000;
                            [createString appendString:[NSString stringWithFormat:@"%.1f %@",dose, stringSevenAdult]];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            [createString appendString:@"\n"];
        }
        [createString appendString:@"\n"];
    }
    
    // EmergencyDrugs
    if ([[sharedEmergencyDrug emergencyDrug] count] != 0){
        [createString appendString:emergencyDrugs];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedEmergencyDrug emergencyDrug] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedEmergencyDrug emergencyDrug] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            if ([[drugsArray objectAtIndex:12]floatValue] != 0){
                [createString appendString:@": "];
                dose = [[drugsArray objectAtIndex:12]floatValue];
                switch ([[drugsArray objectAtIndex:11]integerValue]) {
                    case 0:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringZero2];}
                        if (display2 == NO){[createString appendString:stringZero];}
                        break;
                        
                    case 1:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringOne2];}
                        if (display2 == NO){[createString appendString:stringOne];}
                        break;
                        
                    case 2:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringTwo2];}
                        if (display2 == NO){[createString appendString:stringTwo];}
                        break;
                        
                    case 3:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringThree2];}
                        if (display2 == NO){[createString appendString:stringThree];}
                        break;
                        
                    case 4:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFour2];}
                        if (display2 == NO){[createString appendString:stringFour];}
                        break;
                        
                    case 5:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFive2];}
                        if (display2 == NO){[createString appendString:stringFive];}
                        break;
                        
                    case 6:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringSix2];}
                        if (display2 == NO){[createString appendString:stringSix];}
                        break;
                        
                    case 7:
                        if (dose <1000){
                            if (dose == (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                            }
                            if (dose != (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                            }
                            if (display2 == YES){[createString appendString:stringSeven2];}
                            if (display2 == NO){[createString appendString:stringSevenChild];}
                        }
                        else{
                            dose = dose/1000;
                            [createString appendString:[NSString stringWithFormat:@"%.1f %@",dose, stringSevenAdult]];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            [createString appendString:@"\n"];
        }
        [createString appendString:@"\n"];
    }
    
    // Co-Inductives
    if ([[sharedCoinductiveDrug coInductiveDrug] count] != 0){
        [createString appendString:coInductives];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedCoinductiveDrug coInductiveDrug] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedCoinductiveDrug coInductiveDrug] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            if ([[drugsArray objectAtIndex:12]floatValue] != 0){
                [createString appendString:@": "];
                dose = [[drugsArray objectAtIndex:12]floatValue];
                switch ([[drugsArray objectAtIndex:11]integerValue]) {
                    case 0:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringZero2];}
                        if (display2 == NO){[createString appendString:stringZero];}
                        break;
                        
                    case 1:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringOne2];}
                        if (display2 == NO){[createString appendString:stringOne];}
                        break;
                        
                    case 2:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringTwo2];}
                        if (display2 == NO){[createString appendString:stringTwo];}
                        break;
                        
                    case 3:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringThree2];}
                        if (display2 == NO){[createString appendString:stringThree];}
                        break;
                        
                    case 4:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFour2];}
                        if (display2 == NO){[createString appendString:stringFour];}
                        break;
                        
                    case 5:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFive2];}
                        if (display2 == NO){[createString appendString:stringFive];}
                        break;
                        
                    case 6:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringSix2];}
                        if (display2 == NO){[createString appendString:stringSix];}
                        break;
                        
                    case 7:
                        if (dose <1000){
                            if (dose == (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                            }
                            if (dose != (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                            }
                            if (display2 == YES){[createString appendString:stringSeven2];}
                            if (display2 == NO){[createString appendString:stringSevenChild];}
                        }
                        else{
                            dose = dose/1000;
                            [createString appendString:[NSString stringWithFormat:@"%.1f %@",dose, stringSevenAdult]];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            [createString appendString:@"\n"];
        }
        [createString appendString:@"\n"];
    }
    
    // Other Drugs
    if ([[sharedOtherDrug otherDrug] count] != 0){
        [createString appendString:otherDrugs];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedOtherDrug otherDrug] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedOtherDrug otherDrug] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            if ([[drugsArray objectAtIndex:12]floatValue] != 0){
                [createString appendString:@": "];
                dose = [[drugsArray objectAtIndex:12]floatValue];
                switch ([[drugsArray objectAtIndex:11]integerValue]) {
                    case 0:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringZero2];}
                        if (display2 == NO){[createString appendString:stringZero];}
                        break;
                        
                    case 1:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringOne2];}
                        if (display2 == NO){[createString appendString:stringOne];}
                        break;
                        
                    case 2:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringTwo2];}
                        if (display2 == NO){[createString appendString:stringTwo];}
                        break;
                        
                    case 3:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringThree2];}
                        if (display2 == NO){[createString appendString:stringThree];}
                        break;
                        
                    case 4:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFour2];}
                        if (display2 == NO){[createString appendString:stringFour];}
                        break;
                        
                    case 5:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFive2];}
                        if (display2 == NO){[createString appendString:stringFive];}
                        break;
                        
                    case 6:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringSix2];}
                        if (display2 == NO){[createString appendString:stringSix];}
                        break;
                        
                    case 7:
                        if (dose <1000){
                            if (dose == (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                            }
                            if (dose != (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                            }
                            if (display2 == YES){[createString appendString:stringSeven2];}
                            if (display2 == NO){[createString appendString:stringSevenChild];}
                        }
                        else{
                            dose = dose/1000;
                            [createString appendString:[NSString stringWithFormat:@"%.1f %@",dose, stringSevenAdult]];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            [createString appendString:@"\n"];
        }
        [createString appendString:@"\n"];
    }
    
    // OngoingSedation
    if ([[sharedOngoingSedationDrug ongoingSedationDrug] count] != 0){
        [createString appendString:sedationMaintained];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedOngoingSedationDrug ongoingSedationDrug] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedOngoingSedationDrug ongoingSedationDrug] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            if ([[drugsArray objectAtIndex:12]floatValue] > 0){
                [createString appendString:@": "];
                dose = [[drugsArray objectAtIndex:12]floatValue];
                switch ([[drugsArray objectAtIndex:11]integerValue]) {
                    case 0:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringZero2];}
                        if (display2 == NO){[createString appendString:stringZero];}
                        break;
                        
                    case 1:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringOne2];}
                        if (display2 == NO){[createString appendString:stringOne];}
                        break;
                        
                    case 2:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringTwo2];}
                        if (display2 == NO){[createString appendString:stringTwo];}
                        break;
                        
                    case 3:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringThree2];}
                        if (display2 == NO){[createString appendString:stringThree];}
                        break;
                        
                    case 4:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFour2];}
                        if (display2 == NO){[createString appendString:stringFour];}
                        break;
                        
                    case 5:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFive2];}
                        if (display2 == NO){[createString appendString:stringFive];}
                        break;
                        
                    case 6:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringSix2];}
                        if (display2 == NO){[createString appendString:stringSix];}
                        break;
                        
                    case 7:
                        if (dose <1000){
                            if (dose == (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                            }
                            if (dose != (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                            }
                            if (display2 == YES){[createString appendString:stringSeven2];}
                            if (display2 == NO){[createString appendString:stringSevenChild];}
                        }
                        else{
                            dose = dose/1000;
                            [createString appendString:[NSString stringWithFormat:@"%.1f %@",dose, stringSevenAdult]];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            [createString appendString:@"\n"];
        }
        [createString appendString:@"\n"];
    }
    
    // OngoingAnalgesia
    if ([[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug] count] != 0){
        [createString appendString:analgesiaMaintained];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            if ([[drugsArray objectAtIndex:12]floatValue] != 0){
                [createString appendString:@": "];
                dose = [[drugsArray objectAtIndex:12]floatValue];
                switch ([[drugsArray objectAtIndex:11]integerValue]) {
                    case 0:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringZero2];}
                        if (display2 == NO){[createString appendString:stringZero];}
                        break;
                        
                    case 1:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringOne2];}
                        if (display2 == NO){[createString appendString:stringOne];}
                        break;
                        
                    case 2:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringTwo2];}
                        if (display2 == NO){[createString appendString:stringTwo];}
                        break;
                        
                    case 3:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringThree2];}
                        if (display2 == NO){[createString appendString:stringThree];}
                        break;
                        
                    case 4:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFour2];}
                        if (display2 == NO){[createString appendString:stringFour];}
                        break;
                        
                    case 5:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringFive2];}
                        if (display2 == NO){[createString appendString:stringFive];}
                        break;
                        
                    case 6:
                        if (dose == (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                        }
                        if (dose != (int) dose){
                            [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                        }
                        if (display2 == YES){[createString appendString:stringSix2];}
                        if (display2 == NO){[createString appendString:stringSix];}
                        break;
                        
                    case 7:
                        if (dose <1000){
                            if (dose == (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%i ",(int) dose]];
                            }
                            if (dose != (int) dose){
                                [createString appendString:[NSString stringWithFormat:@"%.2f ",dose]];
                            }
                            if (display2 == YES){[createString appendString:stringSeven2];}
                            if (display2 == NO){[createString appendString:stringSevenChild];}
                        }
                        else{
                            dose = dose/1000;
                            [createString appendString:[NSString stringWithFormat:@"%.1f %@",dose, stringSevenAdult]];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            [createString appendString:@"\n"];
        }
        [createString appendString:@"\n"];
    }
    
    // Flush
    if ([[sharedFlush flush] count] != 0){
        [createString appendString:flushString];
        [createString appendString:@":\n"];
        for (NSInteger i = 0; i < [[sharedFlush flush] count]; i ++){
            drugsArray = [[NSArray alloc] initWithArray:[[sharedFlush flush] objectAtIndex:i]];
            [createString appendString:@"\t\u2022 "];
            [createString appendString:[drugsArray objectAtIndex:0]];
            [createString appendString:@"10 - 20 mls \n"];
        }
    }
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n", createString];
    addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // Intubation Attempt Section
    addText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@ \n",intubationAttemptHeading]];
    
    [addText addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // Intubation attempt
    stringGenerator = [[NSString alloc]init];
    createString = [[NSMutableString alloc]init];
    
    EventLog *sharedTeamComplete = [EventLog sharedTeamComplete];
    EventLog *sharedTeamTicked = [EventLog sharedTeamTicked];
    EventLog *sharedFinalTicked = [EventLog sharedFinalTicked];
    EventLog *sharedIntubationSuccessful = [EventLog sharedIntubationSuccessful];
    EventLog *sharedIntubationStarted = [EventLog sharedIntubationStarted];
    EventLog *sharedDrugsGiven = [EventLog sharedDrugsGiven];
    EventLog *sharedConfirmationTicked = [EventLog sharedConfirmationTicked];
    EventLog *sharedCLGrade = [EventLog sharedCLGrade];
    Patient *sharedTubeSize = [Patient sharedTubeSize];
    Patient *sharedTubeLength = [Patient sharedTubeLength];
    Patient *sharedIsNasal = [Patient sharedIsNasalTube];
    Patient *sharedCuffed = [Patient sharedIsCuffedTube];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    bool usingCricoid = YES;
    if ([defaults objectForKey:@"cricoidUsed"] != nil){usingCricoid = [defaults boolForKey:@"cricoidUsed"];}
    
    if ([[sharedTeamComplete teamComplete]integerValue] != 0){
        [createString appendString:teamBrief];
        [createString appendString:@"\n"];
    }
    if (([[[sharedTeamTicked teamTicked]objectAtIndex:3]integerValue] == 1) && ([[[sharedFinalTicked finalTicked]objectAtIndex:5]integerValue] == 1)){
        [createString appendString:cricoidUsed];
        [createString appendString:@"\n"];
    }
    if (([[[sharedTeamTicked teamTicked]objectAtIndex:3]integerValue] != 1) || ([[[sharedFinalTicked finalTicked]objectAtIndex:5]integerValue] != 1) || (usingCricoid == NO)){
        [createString appendString:cricoidPressureNotUsed];
        [createString appendString:@"\n"];
    }
    if ([[[sharedTeamTicked teamTicked]objectAtIndex:2]integerValue] == 1){
        [createString appendString:milsUsed];
        [createString appendString:@"\n"];
    }
    [createString appendString:@"\n"];
    
    NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setTimeZone:[NSTimeZone localTimeZone]];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    NSString *timeDrugs = [timeFormat stringFromDate:[sharedDrugsGiven drugsGiven]];
    NSString *timeTubeStart = [timeFormat stringFromDate:[sharedIntubationStarted intubationStarted]];
    NSString *timeTubeSucceed = [timeFormat stringFromDate:[sharedIntubationSuccessful intubationSuccessful]];
    
    [createString appendString:[NSString stringWithFormat:@"%@ %@ \n", drugTime, timeDrugs]];
    [createString appendString:[NSString stringWithFormat:@"%@ %@ \n", intubationStartTime, timeTubeStart]];
    [createString appendString:[NSString stringWithFormat:@"%@ %@ \n", successfulTubeTime, timeTubeSucceed]];
    [createString appendString:@"\n"];
    
    if ([[sharedTubeSize tubeSize]floatValue] != 0){
        [createString appendString:[NSString stringWithFormat:@"%@ %.1f ",tubeSize, [[sharedTubeSize tubeSize]floatValue]]];
        if ([[sharedCuffed isCuffedTube]boolValue] == YES){[createString appendString:cuffed];}
        else{[createString appendString:uncuffed];}
        if ([[sharedIsNasal isNasalTube]boolValue] == YES){[createString appendString:nasal];}
        else {[createString appendString:oral];}
        [createString appendString:@"\n"];
        }
    if ([[sharedTubeLength tubeLength]floatValue] != 0){
        [createString appendString:tubeSecuredAt];
        [createString appendString:[NSString stringWithFormat:@" %.1f cm \n", [[sharedTubeLength tubeLength]floatValue]]];
    }
    
    [createString appendString:@"\n"];
    
    if ([[[sharedConfirmationTicked confirmationTicked]objectAtIndex:0]integerValue] == 1){
        [createString appendString:capnoTrace];
        [createString appendString:@"\n"];
    }
    if ([[[sharedConfirmationTicked confirmationTicked]objectAtIndex:1]integerValue] == 1){
        [createString appendString:tubeThroughCords];
        [createString appendString:@"\n"];
    }

    if ([[sharedCLGrade clGrade] length] != 0){
        [createString appendString:intubationGrade];
        [createString appendString:[NSString stringWithFormat:@" %@ %@ \n", [sharedCLGrade clGrade], laryngoscopy]];}
    
    if ([[[sharedConfirmationTicked confirmationTicked]objectAtIndex:2]integerValue] == 1){
        [createString appendString:equalAE];
        [createString appendString:@"\n"];
    }
    if ([[[sharedConfirmationTicked confirmationTicked]objectAtIndex:3]integerValue] == 1){
        [createString appendString:cxrOrdered];
        [createString appendString:@"\n"];
    }
    if ([[[sharedConfirmationTicked confirmationTicked]objectAtIndex:4]integerValue] == 1){
        [createString appendString:secureForTransfer];
        [createString appendString:@"\n"];
    }
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n", createString];
    addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // incidents section title
    // ===== NOTE two extra line breaks added until content is installed =====
    addText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@ \n  \n\n",incidents]];
    
    [addText addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // comments section title
    addText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@ \n",comments]];
    
    [addText addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    /*
    // ===== template section code =====
    
    // section title
    addText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@ \n",locationTimings]];
    
    [addText addAttribute:NSFontAttributeName value:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    
    // ===== template line code =====
    
    // line title
    stringGenerator = [[NSString alloc]init];
    createString = [[NSMutableString alloc]init];
    
            // add conditionality statements
    
    stringGenerator = [NSString stringWithFormat:@"%@ \n", createString];
    addText = [[NSMutableAttributedString alloc] initWithString:stringGenerator];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, addText.length)];
    [addText addAttribute:NSParagraphStyleAttributeName value:alignLeft range:NSMakeRange(0, addText.length)];
    [wholeDocument appendAttributedString:addText];
    */
    
    // displays the string in the textfield
    self.textViewOne.attributedText = wholeDocument;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_textViewOne isFirstResponder] && [touch view] != _textViewOne){
        [_textViewOne resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonFinished:(id)sender {}

- (void) showEmail:(NSData*)data {
    NSDate *rightNow = [NSDate date];
    NSDateFormatter *formatEmailTitle = [[NSDateFormatter alloc] init];
    [formatEmailTitle setDateFormat:@"d MMM y',' HH:mm"];
    NSString * emailTitleTimeStamp = [formatEmailTitle stringFromDate:rightNow];
    NSString * emailSubject = [NSString stringWithFormat:@"%@ %@", emailTitle, emailTitleTimeStamp];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailSubject];
    [mc setMessageBody:emailMessageBody isHTML:YES];
    // Determine the file name and extension
    
    NSString *mimeType = @"application/rtf";
    
    [mc addAttachmentData:data mimeType:mimeType fileName:filename];
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

NSString *filename;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueReportHome"]){
        
        // creates a .RTF document and saves it to disc
        
        NSAttributedString * document = self.textViewOne.attributedText;
        NSDate *rightNow = [NSDate date];
        NSDateFormatter *formatFileName = [[NSDateFormatter alloc]init];
        [formatFileName setDateFormat:@"dMMMy'_'HHmm_ss_SS"];
        NSData *data = [document dataFromRange:(NSRange){0, [document length]} documentAttributes:@{NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType} error:NULL];
        NSString * dateStamp = [formatFileName stringFromDate:rightNow];
        filename = [NSString stringWithFormat:@"i_rsi_intubation_report_%@.rtf",dateStamp];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, filename];
        [data writeToFile:filePath atomically:YES];
        
        NSLog(@"Filepath: %@",filePath);
        
        // adds the document to an email
        //[self showEmail:nameOfFile];
        [self showEmail:data];
        
        // triggers reset of all data
        Interactions * sharedTriggerReport = [Interactions sharedTriggerReport];
        [sharedTriggerReport setTriggerReport:[NSNumber numberWithBool:NO]];
        Interactions *sharedResetAll = [Interactions sharedResetAll];
        [sharedResetAll setResetAll:[NSNumber numberWithBool:YES]];
    }
}

@end
