//
//  DrugsTableViewController.m
//  irsi
//
//  Created by Ben Taylor on 27/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DrugsTableViewController.h"

@interface DrugsTableViewController ()
{
    NSTimer *reloadTable;
    NSTimer *checkChangeDose;
    
    NSMutableArray *drugsArray;
    
    NSMutableArray *inductionAgentsArray;
    NSMutableArray *relaxantsArray;
    NSMutableArray *flushArray;
    NSMutableArray *emergencyDrugsArray;
    NSMutableArray *coInductiveArray;
    NSMutableArray *ongoingSedationArray;
    NSMutableArray *ongoingAnalgesiaArray;
    NSMutableArray *otherDrugsArray;
    
    NSArray *addDrug;
    NSArray *inductionAgent;
    NSArray *muscleRelaxant;
    NSArray *flush;
    NSArray *vasopressor;
    NSArray *antimuscarinic;
    NSArray *ongoingSedation;
    UITextField *_textFieldBeingEdited;
}

@end

@implementation DrugsTableViewController

NSString * addDrugString;
NSString * inductionAgentString;
NSString * muscleRelaxantString;
NSString * flushString;
NSString * emergencyString;
NSString * vasopressorString;
NSString * antiMuscString;
NSString * coinductiveString;
NSString * ongoingSedationString;
NSString * ongoingAnalgesiaString;
NSString * otherDrugString;
NSString * volumeString;
NSString * doseString;
NSString * notPaeds;

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
    
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    addDrugString = [dict objectForKey:@"AddDrug"];
    inductionAgentString = [dict objectForKey:@"InductionAgents"];
    muscleRelaxantString = [dict objectForKey:@"MuscleRelaxants"];
    flushString = [dict objectForKey:@"Flush"];
    emergencyString = [dict objectForKey:@"EmergencyDrugs"];
    vasopressorString = [dict objectForKey:@"Vasopressor"];
    antiMuscString = [dict objectForKey:@"Antimuscarinic"];
    coinductiveString = [dict objectForKey:@"CoInductive"];
    ongoingSedationString = [dict objectForKey:@"OngoingSedation"];
    ongoingAnalgesiaString = [dict objectForKey:@"OngoingAnalgesia"];
    volumeString = [dict objectForKey:@"Volume"];
    doseString = [dict objectForKey:@"Dose"];
    notPaeds = [dict objectForKey:@"NotPaeds"];
    
    addDrug = @[addDrugString,[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:YES],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];
    inductionAgent = @[inductionAgentString,[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:YES],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];
    muscleRelaxant = @[muscleRelaxantString,[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:YES],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];
    flush = @[flushString,[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:YES],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];
    vasopressor = @[vasopressorString,[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:YES],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];
    antimuscarinic = @[antiMuscString,[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:YES],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];
    ongoingSedation = @[ongoingSedationString,[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:YES],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0]];
    
    [self reloadTable];
    self.tableview.allowsMultipleSelectionDuringEditing = NO;
    
    // keeps checking to see if the dose display type has changed
    checkChangeDose = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector (updateChangedDoseDisplay) userInfo:nil repeats:YES];
}

- (void) updateChangedDoseDisplay{
    Interactions *sharedChangedDoseDisplayType = [Interactions sharedChangedDoseDisplayType];
    Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
    if (([[sharedChangedDoseDisplayType changedDoseDisplayType]boolValue] == YES) || ([[sharedDemographicsOpen demographicsOpen]boolValue] == YES)){
        [self reloadTable];
        [sharedChangedDoseDisplayType setChangedDoseDisplayType:[NSNumber numberWithBool:NO]];
    }
}

// Loads the drug labels from the selected nation to the singleton drug label array
- (void) loadDrugLabels
{
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        
        Nationalities *sharedNationality = [Nationalities sharedNationality];
        Nationalities *sharedDrugLabels = [Nationalities sharedDrugLabels];
        Nationalities *sharedNationalityArray = [Nationalities sharedNationalityArray];
        
        if ([defaults objectForKey:@"Nationality"] != nil){[sharedNationality setNationality:[NSNumber numberWithInteger:[defaults integerForKey:@"Nationalities"]]];}
        
        // Find out path of druglabels.plist file
        NSString *path = [[NSBundle mainBundle] pathForResource:@"NationalDrugLabels" ofType:@"plist"];
        
        // Get the string for the country name of the chosen country
        NSString *country = [[sharedNationalityArray nationalityArray] objectAtIndex:[[sharedNationality nationality] integerValue]];
        
        // Load the file content and read the data into an array
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        [sharedDrugLabels setDrugLabels:[dict objectForKey:country]];
    }
    
}

- (void) reloadTable
{
    // resets the arrays to make the table load more cleanly
    drugsArray = nil;
    inductionAgentsArray = nil;
    relaxantsArray = nil;
    flushArray = nil;
    emergencyDrugsArray = nil;
    coInductiveArray = nil;
    ongoingSedationArray = nil;
    ongoingAnalgesiaArray = nil;
    otherDrugsArray = nil;
    
    [self loadDrugLabels];
    [self loadDrugs];
    [self initialiseDrugsArray];
    [self.tableview reloadData];

    Interactions *sharedDrugsSelectorWindowOpen = [Interactions sharedDrugSelectorWindowOpen];
    
    if ([[sharedDrugsSelectorWindowOpen drugSelectorWindowOpen]boolValue] == NO && [reloadTable isValid]){
        [reloadTable invalidate];
        reloadTable = nil;
    }
    
    return;
}

// Load drugs from the saved plist file and save them to the arrays
- (void) loadDrugs
{
    // Loads shared singletons
    InductionAgents *sharedInductionName = [InductionAgents sharedInductionName];
    InductionAgents *sharedInductionClass = [InductionAgents sharedInductionClass];
    InductionAgents *sharedInductionIsMaxMin = [InductionAgents sharedInductionIsMaxMin];
    InductionAgents *sharedInductionIsSingleAdultDose = [InductionAgents sharedInductionIsSingleAdultDose];
    InductionAgents *sharedInductionMinimumDose = [InductionAgents sharedInductionMinimumDose];
    InductionAgents *sharedInductionMaximumDose = [InductionAgents sharedInductionMaximumDose];
    InductionAgents *sharedInductionSingleScaledDose = [InductionAgents sharedInductionSingleScaledDose];
    InductionAgents *sharedInductionSingleAdultDose = [InductionAgents sharedInductionSingleAdultDose];
    InductionAgents *sharedInductionNormalConc = [InductionAgents sharedInductionNormalConc];
    InductionAgents *sharedInductionUnitType = [InductionAgents sharedInductionUnitType];
    InductionAgents *sharedInductionLabelType = [InductionAgents sharedInductionLabelType];
    InductionAgents *sharedManualDose = [InductionAgents sharedManualDose];
    
    // Find out the path of InductionAgents.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"InductionAgents" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    [sharedInductionName setInductionName:[dict objectForKey:@"DrugName"]];
    [sharedInductionClass setInductionClass:[dict objectForKey:@"Class"]];
    [sharedInductionIsMaxMin setInductionIsMaxMin:[dict objectForKey:@"IsMaxMin"]];
    [sharedInductionIsSingleAdultDose setInductionIsSingleAdultDose:[dict objectForKey:@"IsSingleAdultDose"]];
    [sharedInductionMinimumDose setInductionMinimumDose:[dict objectForKey:@"MinimumDose"]];
    [sharedInductionMaximumDose setInductionMaximumDose:[dict objectForKey:@"MaximumDose"]];
    [sharedInductionSingleScaledDose setInductionSingleScaledDose:[dict objectForKey:@"SingleScaledDose"]];
    [sharedInductionSingleAdultDose setInductionSingleAdultDose:[dict objectForKey:@"SingleAdultDose"]];
    [sharedInductionNormalConc setInductionNormalConc:[dict objectForKey:@"NormalConc"]];
    [sharedInductionUnitType setInductionUnitType:[dict objectForKey:@"UnitType"]];
    [sharedInductionLabelType setInductionLabelType:[dict objectForKey:@"LabelType"]];
    
    for (NSInteger i = 0; i < [[sharedInductionName inductionName] count]; i++)
    {
        if ([[sharedManualDose manualDose] count] <= i){[[sharedManualDose manualDose] addObject:[NSNumber numberWithInt:0]];}
    }
}

// Loads the array of drugs
- (void) initialiseDrugsArray
{
    drugsArray = [[NSMutableArray alloc] init];
    
    inductionAgentsArray = [[NSMutableArray alloc] init];
    relaxantsArray = [[NSMutableArray alloc] init];
    flushArray = [[NSMutableArray alloc] init];
    coInductiveArray = [[NSMutableArray alloc] init];
    emergencyDrugsArray = [[NSMutableArray alloc] init];
    ongoingAnalgesiaArray = [[NSMutableArray alloc] init];
    ongoingSedationArray = [[NSMutableArray alloc] init];
    otherDrugsArray = [[NSMutableArray alloc] init];
    
    DrugLog *sharedInductionDrug = [DrugLog sharedInductionDrug];
    DrugLog *sharedRelaxantsDrug = [DrugLog sharedRelaxantsDrug];
    DrugLog *sharedFlush = [DrugLog sharedFlush];
    DrugLog *sharedEmergencyDrug = [DrugLog sharedEmergencyDrug];
    DrugLog *sharedCoinductiveDrug = [DrugLog sharedCoinductiveDrug];
    DrugLog *sharedOngoingSedationDrug = [DrugLog sharedOngoingSedationDrug];
    DrugLog *sharedOngoingAnalgesiaDrug = [DrugLog sharedOngoingAnalgesiaDrug];
    DrugLog *sharedOtherDrug = [DrugLog sharedOtherDrug];
    DrugLog *sharedAntimuscarinicChosen = [DrugLog sharedAntimuscarinicChosen];
    DrugLog *sharedVasopressorChosen = [DrugLog sharedVasopressorChosen];
    
    EventLog * sharedDrugsComplete = [EventLog sharedDrugsComplete];
    
    NSInteger vasoChosen = [[sharedVasopressorChosen vasopressorChosen] integerValue];
    NSInteger antiMusc = [[sharedAntimuscarinicChosen antimuscarinicChosen] integerValue];
    
    // Checks to see if anything has been added to the arrays for each drug class.  If they are empty, adds filler values, else adds the singleton arrays
    NSInteger drugTabCounter = 0;
    
    if ([sharedInductionDrug inductionDrug].count > 0)
    {
        inductionAgentsArray  = [[NSMutableArray alloc] initWithArray:[sharedInductionDrug inductionDrug]];
        if ([inductionAgentsArray containsObject:addDrug])
        {
            NSInteger index = [inductionAgentsArray indexOfObject:addDrug];
            [inductionAgentsArray removeObjectAtIndex:index];
            [inductionAgentsArray addObject:addDrug];
        }
        else {[inductionAgentsArray addObject:addDrug];}
        
        drugTabCounter++;
    }

    if ([sharedInductionDrug inductionDrug].count == 0)
    {
        inductionAgentsArray = [[NSMutableArray alloc] initWithObjects: inductionAgent, nil];
    }
    
    // If all the selected drugs have been deleted, replaces the remaining add drug label with the placeholder
    if (([inductionAgentsArray count] == 1) && ([inductionAgentsArray containsObject:addDrug])){
        NSInteger index = [inductionAgentsArray indexOfObject:addDrug];
        [inductionAgentsArray replaceObjectAtIndex:index withObject:inductionAgent];
        drugTabCounter --;
    }
    
    if ([sharedRelaxantsDrug relaxantsDrug].count > 0)
    {
        relaxantsArray = [[NSMutableArray alloc] initWithArray:[sharedRelaxantsDrug relaxantsDrug]];
        if ([relaxantsArray containsObject:addDrug])
        {
            NSInteger index = [relaxantsArray indexOfObject:addDrug];
            [relaxantsArray removeObjectAtIndex:index];
            [relaxantsArray addObject:addDrug];
        }
        else {[relaxantsArray addObject:addDrug];}
        
        drugTabCounter++;
    }

    if ([sharedRelaxantsDrug relaxantsDrug].count == 0)
    {
        relaxantsArray = [[NSMutableArray alloc] initWithObjects: muscleRelaxant, nil];
    }
    // If all the selected drugs have been deleted, replaces the remaining add drug label with the placeholder
    if (([relaxantsArray count] == 1) && ([relaxantsArray containsObject:addDrug])){
        NSInteger index = [relaxantsArray indexOfObject:addDrug];
        [relaxantsArray replaceObjectAtIndex:index withObject:muscleRelaxant];
        drugTabCounter --;
    }
    
    if ([sharedFlush flush].count > 0)
    {
        flushArray = [[NSMutableArray alloc] initWithArray:[sharedFlush flush]];
        
        drugTabCounter++;
    }
    if ([sharedFlush flush].count == 0)
    {
        flushArray = [[NSMutableArray alloc] initWithObjects: flush, nil];
    }
    
    // If all the selected drugs have been deleted, replaces the remaining add drug label with the placeholder
    if (([flushArray count] == 1) && ([flushArray containsObject:addDrug])){
        NSInteger index = [flushArray indexOfObject:addDrug];
        [flushArray replaceObjectAtIndex:index withObject:flush];
        drugTabCounter --;
    }
    
    if ([sharedCoinductiveDrug coInductiveDrug].count > 0)
    {
        coInductiveArray = [[NSMutableArray alloc] initWithArray:[sharedCoinductiveDrug coInductiveDrug]];
        if ([coInductiveArray containsObject:addDrug])
        {
            NSInteger index = [coInductiveArray indexOfObject:addDrug];
            [coInductiveArray removeObjectAtIndex:index];
            [coInductiveArray addObject:addDrug];
        }
        else {[coInductiveArray addObject:addDrug];}
    }
    if ([sharedCoinductiveDrug coInductiveDrug].count == 0)
    {
        coInductiveArray = [[NSMutableArray alloc] initWithObjects: addDrug, nil];
    }
    
    if ([sharedOngoingSedationDrug ongoingSedationDrug].count > 0)
    {
        ongoingSedationArray = [[NSMutableArray alloc] initWithArray:[sharedOngoingSedationDrug ongoingSedationDrug]];
        if ([ongoingSedationArray containsObject:addDrug])
        {
            NSInteger index = [ongoingSedationArray indexOfObject:addDrug];
            [ongoingSedationArray removeObjectAtIndex:index];
            [ongoingSedationArray addObject:addDrug];
        }
        else {[ongoingSedationArray addObject:addDrug];}
        
        drugTabCounter++;
    }
    if ([sharedOngoingSedationDrug ongoingSedationDrug].count == 0)
    {
        ongoingSedationArray = [[NSMutableArray alloc] initWithObjects: ongoingSedation, nil];
    }
    
    // If all the selected drugs have been deleted, replaces the remaining add drug label with the placeholder
    if (([ongoingSedationArray count] == 1) && ([ongoingSedationArray containsObject:addDrug])){
        NSInteger index = [ongoingSedationArray indexOfObject:addDrug];
        [ongoingSedationArray replaceObjectAtIndex:index withObject:ongoingSedation];
    }
    
    if ([sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug].count > 0)
    {
        ongoingAnalgesiaArray = [[NSMutableArray alloc] initWithArray:[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug]];
        if ([ongoingAnalgesiaArray containsObject:addDrug])
        {
            NSInteger index = [ongoingAnalgesiaArray indexOfObject:addDrug];
            [ongoingAnalgesiaArray removeObjectAtIndex:index];
            [ongoingAnalgesiaArray addObject:addDrug];
        }
        else {[ongoingAnalgesiaArray addObject:addDrug];}
    }
    if ([sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug].count == 0)
    {
        ongoingAnalgesiaArray = [[NSMutableArray alloc] initWithObjects: addDrug, nil];
    }
    
    if ([sharedOtherDrug otherDrug].count > 0)
    {
        otherDrugsArray = [sharedOtherDrug otherDrug];
        if ([otherDrugsArray containsObject:addDrug])
        {
            NSInteger index = [otherDrugsArray indexOfObject:addDrug];
            [otherDrugsArray removeObjectAtIndex:index];
            [otherDrugsArray addObject:addDrug];
        }
        else {[otherDrugsArray addObject:addDrug];}
    }
    if ([sharedOtherDrug otherDrug].count == 0)
    {
        otherDrugsArray = [[NSMutableArray alloc] initWithObjects: addDrug, nil];
    }
    
    if ((antiMusc == 0) && (vasoChosen == 0)){
        emergencyDrugsArray = [[NSMutableArray alloc] init];
        if ([emergencyDrugsArray containsObject:antimuscarinic])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:antimuscarinic];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:vasopressor])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:vasopressor];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:addDrug])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:addDrug];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        [emergencyDrugsArray addObject:vasopressor];
        [emergencyDrugsArray addObject:antimuscarinic];
    }
    
    else if ((antiMusc == 0) && (vasoChosen != 0)){
        emergencyDrugsArray = [[NSMutableArray alloc] initWithArray:[sharedEmergencyDrug emergencyDrug]];
        if ([emergencyDrugsArray containsObject:antimuscarinic])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:antimuscarinic];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:vasopressor])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:vasopressor];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:addDrug])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:addDrug];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        [emergencyDrugsArray addObject:antimuscarinic];
        drugTabCounter ++;
    }
    
    else if ((antiMusc > 0) && (vasoChosen == 0)){
        emergencyDrugsArray = [[NSMutableArray alloc] initWithArray:[sharedEmergencyDrug emergencyDrug]];
        if ([emergencyDrugsArray containsObject:antimuscarinic])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:antimuscarinic];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:vasopressor])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:vasopressor];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:addDrug])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:addDrug];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        [emergencyDrugsArray insertObject:vasopressor atIndex:0];
        drugTabCounter ++;
    }
    
    else if ((antiMusc >0) && (vasoChosen >0)){
        emergencyDrugsArray = [[NSMutableArray alloc] initWithArray:[sharedEmergencyDrug emergencyDrug]];
        if ([emergencyDrugsArray containsObject:antimuscarinic])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:antimuscarinic];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:vasopressor])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:vasopressor];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        if ([emergencyDrugsArray containsObject:addDrug])
        {
            NSInteger index = [emergencyDrugsArray indexOfObject:addDrug];
            [emergencyDrugsArray removeObjectAtIndex:index];
        }
        [emergencyDrugsArray addObject:addDrug];
        drugTabCounter++;
        drugTabCounter++;
    }
    
    // updates the singleton which syncs the drugs tabs
    if (drugTabCounter == 0) {[sharedDrugsComplete setDrugsComplete:[NSNumber numberWithInteger:0]];}
    if (drugTabCounter == 6) {[sharedDrugsComplete setDrugsComplete:[NSNumber numberWithInteger:2]];}
    else if (drugTabCounter <6 && drugTabCounter >0) {[sharedDrugsComplete setDrugsComplete:[NSNumber numberWithInteger:1]];}
    drugTabCounter = 0;
    
    // packages these arrays into dictionaries for the section headers and then into a master array
    NSDictionary *inductionAgentsArrayDict = [NSDictionary dictionaryWithObject:inductionAgentsArray forKey:@"data"];
    [drugsArray addObject:inductionAgentsArrayDict];
    
    NSDictionary *muscleRelaxantsArrayDict = [NSDictionary dictionaryWithObject:relaxantsArray forKey:@"data"];
    [drugsArray addObject:muscleRelaxantsArrayDict];
    
    NSDictionary *flushArrayDict = [NSDictionary dictionaryWithObject:flushArray forKey:@"data"];
    [drugsArray addObject:flushArrayDict];
    
    NSDictionary *emergencyDrugsArrayDict = [NSDictionary dictionaryWithObject:emergencyDrugsArray forKey:@"data"];
    [drugsArray addObject:emergencyDrugsArrayDict];
    
    NSDictionary *coInductivesArrayDict = [NSDictionary dictionaryWithObject:coInductiveArray forKey:@"data"];
    [drugsArray addObject:coInductivesArrayDict];
    
    NSDictionary *ongoingSedationArrayDict = [NSDictionary dictionaryWithObject:ongoingSedationArray forKey:@"data"];
    [drugsArray addObject:ongoingSedationArrayDict];
    
    NSDictionary *ongoingAnalgesiaArrayDict = [NSDictionary dictionaryWithObject:ongoingAnalgesiaArray forKey:@"data"];
    [drugsArray addObject:ongoingAnalgesiaArrayDict];
    
    NSDictionary *otherDrugsArrayDict = [NSDictionary dictionaryWithObject:otherDrugsArray forKey:@"data"];
    [drugsArray addObject:otherDrugsArrayDict];
    
    [self.tableview reloadData];
    
    return;
}

// The number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [drugsArray count];
}

// The number of rows per section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dictionary = [drugsArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
}

// Defines the section titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return inductionAgentString;
    if (section == 1)
        return muscleRelaxantString;
    if (section == 2)
        return flushString;
    if (section == 3)
        return emergencyString;
    if (section == 4)
        return coinductiveString;
    if (section == 5)
        return ongoingSedationString;
    if (section == 6)
        return ongoingAnalgesiaString;
    if (section == 7)
        return otherDrugString;
    
    return @"";
}

// ===== Defines the cells ===============

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Gathers the data from the drug display array and prepares it for loading into the cell
    NSDictionary *dictionary = [drugsArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    NSString *drugNameValue;
    NSString *concLabelValue;
    UIImage *drugLabelValue;
    float concentration = 1;
    NSString *doseTextFieldValue;
    NSInteger drugLabelInt;
    NSString *drugLabelString;
    NSString *alternateLabel;
    NSString *doseLabel;
    NSString *calcDoseString;
    
    float weight = 70.0;
    bool isAdult = YES;
    
    bool isMaxMin = YES;
    bool isSingleAdultDose = NO;
    float minimumDose = 0;
    float maximumDose = 0;
    float singleScaledDose = 0;
    float singleAdultDose = 0;
    
    float manualDose = 0;
    
    float minDose = 0;
    float maxDose = 0;

    NSString *calculatedMls;
    NSString *calculatedMg;
    NSString *enteredMg;
    NSString *enteredMls;
    
    bool isPercent = NO;
    bool isInfusion = NO;
    
    bool blank = NO;
    
    bool safePaeds = NO;
    float paedsMin = 0;
    float paedsMax = 0;
    float paedsSingle = 0;
    float paedsMaxTotal = 0;
    
    bool manualDoseSelected = NO;
    
    DrugLog *sharedDrugDoseDisplayType = [DrugLog sharedDrugDoseDisplayType];
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedWeight = [Patient sharedWeight];
    
    isAdult = [[sharedIsAdult isAdult]boolValue];
    weight = [[sharedWeight weight]floatValue];
    if (weight >= 10){weight = (int) weight;};
    
    // if the item at indexpath.row is a filler item, sets the label as the string
    if ([[[array objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:addDrugString]  || [[[array objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:inductionAgentString] || [[[array objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:muscleRelaxantString] || [[[array objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:flushString] || [[[array objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:vasopressorString] || [[[array objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:antiMuscString] || [[[array objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:ongoingSedationString])
    {
        drugNameValue = [[array objectAtIndex:indexPath.row] objectAtIndex:0];
        concLabelValue = @"mg/ml";
        drugLabelValue = [UIImage imageNamed:@"BlankAgent.png"];
        concentration = 1;
        doseTextFieldValue = nil;
        blank = YES;
    }
    
    // If there is an array item at indexpath.row, loads this into the label
    else
    {
        Nationalities *sharedDrugLabels = [Nationalities sharedDrugLabels];
        
        drugNameValue = [[array objectAtIndex:indexPath.row] objectAtIndex:0];
        isMaxMin = [[[array objectAtIndex:indexPath.row] objectAtIndex:2]boolValue];
        isSingleAdultDose = [[[array objectAtIndex:indexPath.row] objectAtIndex:3]boolValue];
        minimumDose = [[[array objectAtIndex:indexPath.row] objectAtIndex:4]floatValue];
        maximumDose = [[[array objectAtIndex:indexPath.row] objectAtIndex:5]floatValue];
        singleScaledDose = [[[array objectAtIndex:indexPath.row] objectAtIndex:6]floatValue];
        singleAdultDose = [[[array objectAtIndex:indexPath.row] objectAtIndex:7]floatValue];
        concentration = [[[array objectAtIndex:indexPath.row] objectAtIndex:8]floatValue];
        
        switch ([[[array objectAtIndex:indexPath.row] objectAtIndex:9]integerValue]) {
            case 0:
                concLabelValue = @"mg/ml";
                alternateLabel = @"mg";
                doseLabel = @"mg/kg";
                break;
                
            case 1:
                concLabelValue = @"micrograms/ml";
                alternateLabel = @"micrograms";
                doseLabel = @"micrograms/kg";
                break;
                
            case 2:
                concLabelValue = @"%";
                alternateLabel = @"mg";
                doseLabel = @"mg/kg";
                isPercent = YES;
                break;
                
            case 3:
                concLabelValue =@"";
                alternateLabel = @"mls";
                doseLabel = @"mls";
                break;
                
            case 4:
                concLabelValue =@"mg/ml";
                alternateLabel =@"mcg/min";
                doseLabel = @"mcg/kg/min";
                isInfusion = YES;
                break;
                
            case 5:
                concLabelValue =@"micrograms/ml";
                alternateLabel = @"mcg/min";
                doseLabel = @"mcg/kg/min";
                isInfusion = YES;
                break;
                
            case 6:
                concLabelValue = @"%";
                alternateLabel = @"mcg/min";
                doseLabel = @"mcg/kg/min";
                isInfusion = YES;
                isPercent = YES;
                break;
                
            case 7:
                if (isAdult == YES){
                    concLabelValue = @"mg/ml";
                    alternateLabel = @"grams";
                    doseLabel = @"grams";
                }
                else {
                    concLabelValue = @"mg/ml";
                    alternateLabel = @"mg";
                    doseLabel = @"mg/kg";
                }
                break;
                
                default:
                break;
        }
        
        drugLabelInt = [[[array objectAtIndex:indexPath.row] objectAtIndex:10]integerValue];
        drugLabelValue = [UIImage imageNamed:[[sharedDrugLabels drugLabels] objectAtIndex:drugLabelInt]];
        
        drugLabelString = [[sharedDrugLabels drugLabels] objectAtIndex:drugLabelInt];
        manualDose = [[[array objectAtIndex:indexPath.row] objectAtIndex:12]floatValue];
        safePaeds = [[[array objectAtIndex:indexPath.row] objectAtIndex:13]boolValue];
        paedsMin = [[[array objectAtIndex:indexPath.row] objectAtIndex:14]floatValue];
        paedsMax = [[[array objectAtIndex:indexPath.row] objectAtIndex:15]floatValue];
        paedsSingle = [[[array objectAtIndex:indexPath.row] objectAtIndex:16]floatValue];
        paedsMaxTotal = [[[array objectAtIndex:indexPath.row] objectAtIndex:17]floatValue];
    }
    
    NSString *cellIdentifier = @"displayDrug";
    if ([drugNameValue isEqualToString:addDrugString]){cellIdentifier = @"addNewDrug";};
    
    // Inactivates the blank textfields for the blank, filler screen to make it easier to click on them
    if ([drugNameValue isEqualToString:inductionAgentString] || [drugNameValue isEqualToString:muscleRelaxantString] || [drugNameValue isEqualToString:flushString] || [drugNameValue isEqualToString:vasopressorString] || [drugNameValue isEqualToString:antiMuscString] || [drugNameValue isEqualToString:ongoingSedationString])
    {
        cellIdentifier = @"blankDrug";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // defines the labels by tag number
    UILabel *drugName = (UILabel *)[cell viewWithTag:100];
    UILabel *concLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *labelMlsMgs = (UILabel *)[cell viewWithTag:102];
    UIImageView *drugLabel = (UIImageView *)[cell viewWithTag:103];
    UITextField *concTextField = (UITextField *)[cell viewWithTag:104];
    UITextField *doseTextField = (UITextField *)[cell viewWithTag:105];
    
    // Writes the array files to the cell
    drugName.text = drugNameValue;
    concLabel.text = concLabelValue;
    [drugLabel setImage:drugLabelValue];
    doseTextField.text = doseTextFieldValue;
    
    drugName.textColor = [UIColor blackColor];
    drugName.font = [UIFont systemFontOfSize:12];
    if (blank == YES){concTextField.text = @"";}
    
    // Calculates the dose for weight
    if (isAdult == YES){
        if (isSingleAdultDose == YES){
            // Displays doses > 1000mg as grams
            doseLabel = @"mg";
            minDose = singleAdultDose;
            maxDose = minDose;
            if (singleAdultDose<1){calcDoseString = [NSString stringWithFormat:@"%.1f", singleAdultDose];}
            else {calcDoseString = [NSString stringWithFormat:@"%i", (int) singleAdultDose];}
            if ([[[array objectAtIndex:indexPath.row] objectAtIndex:9]integerValue] == 1){doseLabel = @"micrograms";}
            if (([[[array objectAtIndex:indexPath.row] objectAtIndex:9]integerValue] == 7) && ([[sharedDrugDoseDisplayType drugDoseDisplayType] integerValue] != 0) && (singleAdultDose > 999)){
                minDose = singleAdultDose/1000;
                maxDose = minDose;
                doseLabel = @"grams";
                if (minDose<1){calcDoseString = [NSString stringWithFormat:@"%.1f", minDose];}
                else {calcDoseString = [NSString stringWithFormat:@"%i", (int) minDose];}}
        }
        else if (isMaxMin == NO){
            minDose = (singleScaledDose * weight);
            maxDose = minDose;
            if (singleScaledDose<1){calcDoseString = [NSString stringWithFormat:@"%.1f", singleScaledDose];}
            else {calcDoseString = [NSString stringWithFormat:@"%i", (int) singleScaledDose];}
            if (singleScaledDose<0.1){calcDoseString = [NSString stringWithFormat:@"%.2f", singleScaledDose];}
            if (singleScaledDose<0.01){calcDoseString = [NSString stringWithFormat:@"%.1f", singleScaledDose];}
        }
        else{
            minDose = (minimumDose *weight);
            maxDose = (maximumDose *weight);
            if ((minimumDose != (int)minimumDose) || (maximumDose != (int) maximumDose)){calcDoseString = [NSString stringWithFormat:@"%.1f - %.1f", minimumDose, maximumDose];}
            else {calcDoseString = [NSString stringWithFormat:@"%i - %i", (int) minimumDose, (int) maximumDose];}
            if (minimumDose < 0.1){calcDoseString = [NSString stringWithFormat:@"%.2f - %.2f", minimumDose, maximumDose];}
            if (minimumDose < 0.01){calcDoseString = [NSString stringWithFormat:@"%.3f - %.3f", minimumDose, maximumDose];}
        }
    }
    
    if (isAdult == NO) {
        if (isMaxMin == NO){
            minDose = (paedsSingle * weight);
            maxDose = minDose;
            if (paedsSingle <1){calcDoseString = [NSString stringWithFormat:@"%.1f", paedsSingle];}
            else {calcDoseString = [NSString stringWithFormat:@"%i", (int) paedsSingle];}
            if (paedsSingle < 0.1){calcDoseString = [NSString stringWithFormat:@"%.2f", paedsSingle];}
            if (paedsSingle < 0.01){calcDoseString = [NSString stringWithFormat:@"%.3f", paedsSingle];}
        }
        if (isMaxMin == YES){
            minDose = (paedsMin *weight);
            maxDose = (paedsMax *weight);
            if ((paedsMin != (int)paedsMin) || (paedsMax != (int) paedsMax)){calcDoseString = [NSString stringWithFormat:@"%.1f - %.1f", paedsMin, paedsMax];}
            else {calcDoseString = [NSString stringWithFormat:@"%i - %i", (int) paedsMin, (int) paedsMax];}
            if (paedsMin < 0.1){calcDoseString = [NSString stringWithFormat:@"%.2f - %.2f", paedsMin, paedsMax];}
            if (paedsMin < 0.01){calcDoseString = [NSString stringWithFormat:@"%.3f - %.3f", paedsMin, paedsMax];}
            
        }
        if (paedsMaxTotal > 0){
            if (minDose > paedsMaxTotal){minDose = paedsMaxTotal;}
            if (maxDose > paedsMaxTotal){maxDose = paedsMaxTotal;}
        }
    }
    
    if (minDose == maxDose){
        if (minDose <5){calculatedMg = [NSString stringWithFormat:@"%.1f", minDose];}
        else {calculatedMg = [NSString stringWithFormat:@"%i", (int) minDose];}
        float volume = (minDose/concentration);
        if (isInfusion == YES){
            volume = (volume *60);
            if ((isPercent == YES) || ([[[array objectAtIndex:indexPath.row] objectAtIndex:9]integerValue] == 4)){
                volume = (volume/1000);
            }
        }
        if (volume <5){calculatedMls = [NSString stringWithFormat:@"%.1f", volume];}
        else {calculatedMls = [NSString stringWithFormat:@"%i", (int) volume];}
    }
    
    if (minDose != maxDose){
        if (minDose <5){calculatedMg = [NSString stringWithFormat:@"%.1f - %.1f", minDose, maxDose];}
        else {calculatedMg = [NSString stringWithFormat:@"%i - %i", (int) minDose, (int) maxDose];}
        float minVolume = (minDose/concentration);
        float maxVolume = (maxDose/concentration);
        if (isInfusion == YES){
            minVolume = (minVolume *60);
            maxVolume = (maxVolume *60);
            if ((isPercent == YES) || ([[[array objectAtIndex:indexPath.row] objectAtIndex:9]integerValue] == 4)){
                minVolume = (minVolume/1000);
                maxVolume = (maxVolume/1000);
            }
        }
        if (minVolume <5){calculatedMls = [NSString stringWithFormat:@"%.1f - %.1f", minVolume, maxVolume];}
        else {calculatedMls = [NSString stringWithFormat:@"%i - %i", (int) minVolume, (int) maxVolume];}
    }
    
    // if there is an entered manual dose, fills it into the dose display text field
    if (manualDose>0){
        manualDoseSelected = YES;
        // Displays doses > 1000mg as grams
        if (([[[array objectAtIndex:indexPath.row] objectAtIndex:9]integerValue] == 7) && (isAdult == YES) && ([[sharedDrugDoseDisplayType drugDoseDisplayType] integerValue] != 0) && (manualDose > 999)){
            manualDose = manualDose/1000;}
        if (manualDose <5){enteredMg = [NSString stringWithFormat:@"%.1f",manualDose];}
        else {enteredMg = [NSString stringWithFormat:@"%i",(int) manualDose];}
        float volume = (manualDose/concentration);
        if (volume <5) {enteredMls = [NSString stringWithFormat:@"%.1f",volume];}
        else {enteredMls = [NSString stringWithFormat:@"%i",(int) volume];}
    }
    
    // Displays the concentration in the text field
    if (isPercent == YES){concentration = (concentration/10);}
    if (concentration >1){concTextField.text = [NSString stringWithFormat:@"%li",(long)concentration];}
    else {concTextField.text = [NSString stringWithFormat:@"%.1f",concentration];}
    if (blank == YES){concTextField.text = @"";}
    
    // Amends the display to alternate if the user chooses absolute dose or calculated volume
    if ([[sharedDrugDoseDisplayType drugDoseDisplayType] integerValue] == 0){
        labelMlsMgs.text = @"mls";
        concTextField.hidden = NO;
        concTextField.enabled = YES;
        doseTextField.text = enteredMls;
        doseTextField.placeholder = calculatedMls;
        if (manualDose==0){doseTextField.text = @"";}
        if (minDose == 0){doseTextField.placeholder = volumeString;}
        if (isInfusion == YES){labelMlsMgs.text = @"ml/hr";}
    }
    if ([[sharedDrugDoseDisplayType drugDoseDisplayType] integerValue] == 1){
        labelMlsMgs.text = alternateLabel;
        concTextField.hidden = YES;
        concTextField.enabled = NO;
        doseTextField.text = enteredMg;
        doseTextField.placeholder = calculatedMg;
        if (manualDose==0){doseTextField.text = @"";}
        if (minDose == 0){doseTextField.placeholder = doseString;}
    }
    if ([[sharedDrugDoseDisplayType drugDoseDisplayType] integerValue] == 2){
        labelMlsMgs.text = doseLabel;
        concTextField.hidden = YES;
        concTextField.enabled = NO;
        doseTextField.text = enteredMg;
        doseTextField.placeholder = calcDoseString;
        if (manualDose==0){doseTextField.text = @"";}
        if (minDose == 0){doseTextField.placeholder = doseString;}
        if (manualDoseSelected == YES){labelMlsMgs.text = alternateLabel;}
    }
    
    // Hides placeholder for drugs not indicated in children, if patient is a child
    if ((isAdult == NO) && (safePaeds == NO) && (blank == NO)){
        doseTextField.placeholder = notPaeds;
    }
    
    // Hides the conc label for flushes
    if (indexPath.section == 2){
        concTextField.hidden = YES;
        concTextField.enabled = NO;
        labelMlsMgs.text = @"mls";
        doseTextField.text = @"10 - 20";
        doseTextField.userInteractionEnabled = NO;
    }
    
    // Hides conc label etc for volatile agents
    if ((drugLabelInt > 10) && (drugLabelInt < 16)){
        concTextField.hidden = YES;
        concTextField.enabled = YES;
        labelMlsMgs.text = @"MAC";
        concLabel.hidden = YES;
        drugName.font = [UIFont boldSystemFontOfSize:12];
        switch (drugLabelInt) {
            case 11:
                drugName.textColor = [UIColor whiteColor];
                doseTextField.placeholder = @"0.8 - 1.4";
                break;
                
            case 12:
                drugName.textColor = [UIColor blackColor];
                doseTextField.placeholder = @"0.8 - 1.4";
                break;
                
            case 13:
                drugName.textColor = [UIColor whiteColor];
                doseTextField.placeholder = @"0.8 - 1.4";
                break;
                
            case 14:
                drugName.textColor = [UIColor blackColor];
                doseTextField.placeholder = @"0.8 - 1.4";
                break;
                
            case 15:
                drugName.textColor = [UIColor blackColor];
                doseTextField.placeholder = @"0.8 - 1.4";
                break;
                
            default:
                break;
        }
    }
    
    // Changes text colour for sux and adrenaline labels
    if ([drugLabelString isEqualToString: @"Sux.png"]){
        drugName.font = [UIFont boldSystemFontOfSize:12];
        drugName.textColor = [UIColor redColor];
    }
    
    if ([drugLabelString isEqualToString: @"adrenaline.png"]){
        drugName.font = [UIFont boldSystemFontOfSize:12];
        drugName.textColor = [UIColor colorWithRed:216.0f/255.0f green:10.0f/255.0f blue:216.0f/255.0f alpha:1.0];
    }
    
    [concTextField addTarget:self action:@selector(onEditConc:) forControlEvents:UIControlEventEditingDidEnd];
    [doseTextField addTarget:self action:@selector(onEditDose:) forControlEvents:UIControlEventEditingDidEnd];
    
    //Creates a custom keypad with a return button
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar.barStyle=UIBarStyleDefault;
    
    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
    
    // Add buttons to the toolbar
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    
    // Set the toolbar as accessory view of an UITextField object
    concTextField.inputAccessoryView = toolbar;
    doseTextField.inputAccessoryView = toolbar;
    
    concTextField.delegate = self;
    doseTextField.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// Gets the selected cell from the table
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Interactions *sharedDrugsSelectionSection = [Interactions sharedDrugSelectionSection];
    Interactions *sharedDrugsSelectorWindowOpen = [Interactions sharedDrugSelectorWindowOpen];
    
    InductionAgents *sharedInductionName = [InductionAgents sharedInductionName];
    InductionAgents *sharedInductionClass = [InductionAgents sharedInductionClass];
    InductionAgents *sharedInductionIsMaxMin = [InductionAgents sharedInductionIsMaxMin];
    InductionAgents *sharedInductionIsSingleAdultDose = [InductionAgents sharedInductionIsSingleAdultDose];
    InductionAgents *sharedInductionMinimumDose = [InductionAgents sharedInductionMinimumDose];
    InductionAgents *sharedInductionMaximumDose = [InductionAgents sharedInductionMaximumDose];
    InductionAgents *sharedInductionSingleScaledDose = [InductionAgents sharedInductionSingleScaledDose];
    InductionAgents *sharedInductionSingleAdultDose = [InductionAgents sharedInductionSingleAdultDose];
    InductionAgents *sharedInductionNormalConc = [InductionAgents sharedInductionNormalConc];
    InductionAgents *sharedInductionUnitType = [InductionAgents sharedInductionUnitType];
    InductionAgents *sharedInductionLabelType = [InductionAgents sharedInductionLabelType];
    
    DrugLog *sharedFlush = [DrugLog sharedFlush];
    
    if (indexPath.section != 2){
        [sharedDrugsSelectionSection setDrugSelectionSection:[NSNumber numberWithInteger:indexPath.section]];
        [sharedDrugsSelectorWindowOpen setDrugSelectorWindowOpen:[NSNumber numberWithBool:YES]];
    }
    
    if (indexPath.section == 2){
        NSMutableArray *saline = [[NSMutableArray alloc] init];
        
        [saline addObject:[[sharedInductionName inductionName] objectAtIndex:5]];
        [saline addObject:[[sharedInductionClass inductionClass] objectAtIndex:5]];
        [saline addObject:[[sharedInductionIsMaxMin inductionIsMaxMin] objectAtIndex:5]];
        [saline addObject:[[sharedInductionIsSingleAdultDose inductionIsSingleAdultDose] objectAtIndex:5]];
        [saline addObject:[[sharedInductionMinimumDose inductionMinimumDose] objectAtIndex:5]];
        [saline addObject:[[sharedInductionMaximumDose inductionMaximumDose] objectAtIndex:5]];
        [saline addObject:[[sharedInductionSingleScaledDose inductionSingleScaledDose] objectAtIndex:5]];
        [saline addObject:[[sharedInductionSingleAdultDose inductionSingleAdultDose] objectAtIndex:5]];
        [saline addObject:[[sharedInductionNormalConc inductionNormalConc] objectAtIndex:5]];
        [saline addObject:[[sharedInductionUnitType inductionUnitType] objectAtIndex:5]];
        [saline addObject:[[sharedInductionLabelType inductionLabelType] objectAtIndex:5]];
        [saline addObject:[NSNumber numberWithBool:NO]];
        [saline addObject:[NSNumber numberWithInteger:0]];
        [saline addObject:[NSNumber numberWithBool:YES]];
        [saline addObject:[NSNumber numberWithInteger:0]];
        [saline addObject:[NSNumber numberWithInteger:0]];
        [saline addObject:[NSNumber numberWithInteger:0]];
        [saline addObject:[NSNumber numberWithInteger:0]];
        
        if ([[sharedFlush flush] count] == 0){
            [[sharedFlush flush] addObject:saline];}
        
        [self reloadTable];
    }
    
    if ([[sharedDrugsSelectorWindowOpen drugSelectorWindowOpen]boolValue] == YES){
        reloadTable = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(reloadTable) userInfo:nil repeats:YES];
    }
    
    if (_textFieldBeingEdited)
    {
        [_textFieldBeingEdited resignFirstResponder];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
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
        
        NSArray *array;
        
        if ([[sharedEmergencyDrug emergencyDrug]count] >0){
            array = [[sharedEmergencyDrug emergencyDrug]objectAtIndex:indexPath.row];
            NSInteger total = 0;
            
            
            if ((indexPath.section == 3) && ([[array objectAtIndex:11]integerValue] == 1)){
                total = [[sharedVasopressorChosen vasopressorChosen] integerValue];
                total --;
                [sharedVasopressorChosen setVasopressorChosen:[NSNumber numberWithInteger:total]];
                total = 0;
            }
            
            if ((indexPath.section == 3) && ([[array objectAtIndex:11]integerValue] == 2)){
                total = [[sharedAntimuscarinicChosen antimuscarinicChosen] integerValue];
                total --;
                [sharedAntimuscarinicChosen setAntimuscarinicChosen:[NSNumber numberWithInteger:total]];
                total = 0;
            }
        }
        
        Interactions *sharedDeleteDrugSection = [Interactions sharedDeleteDrugSection];
        Interactions *sharedDeleteDrugRow = [Interactions sharedDeleteDrugRow];
        [sharedDeleteDrugRow setDeleteDrugRow:[NSNumber numberWithInteger:indexPath.row]];
        [sharedDeleteDrugSection setDeleteDrugSection:[NSNumber numberWithInteger:indexPath.section]];
        
        switch (indexPath.section) {
            case 0:
                if ([[sharedInductionDrug inductionDrug] count] >0){
                    [[sharedInductionDrug inductionDrug] removeObjectAtIndex:indexPath.row];}
                break;
                
            case 1:
                [[sharedRelaxantsDrug relaxantsDrug] removeObjectAtIndex:indexPath.row];
                break;
                
            case 2:
                [[sharedFlush flush] removeObjectAtIndex:indexPath.row];
                break;
                
            case 3:
                [[sharedEmergencyDrug emergencyDrug] removeObjectAtIndex:indexPath.row];
                break;
                
            case 4:
                [[sharedCoinductiveDrug coInductiveDrug] removeObjectAtIndex:indexPath.row];
                break;
                
            case 5:
                [[sharedOngoingSedationDrug ongoingSedationDrug] removeObjectAtIndex:indexPath.row];
                break;
                
            case 6:
                [[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug] removeObjectAtIndex:indexPath.row];
                break;
                
            case 7:
                [[sharedOtherDrug otherDrug] removeObjectAtIndex:indexPath.row];
                break;
                
            default:
                break;
        }
        
        //[self reloadTable];
        
        [self.tableview beginUpdates];
        if ([self.tableview numberOfRowsInSection:indexPath.section] > 2){[self.tableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];}
        
        [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableview endUpdates];
        
        [self reloadTable];
    }
    return;
}



- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void) onMore: (id) sender
{
    NSInteger section = [sender tag] / 10000;
    NSInteger row = [sender tag] % 10000;
    
    NSLog(@"%li, %li",(long)section, (long)row);
    
    return;
}

- (void) onEditConc: (id) sender
{
    NSInteger section;
    NSInteger row;
    UITextField *tf = (UITextField*)sender;
    float enteredConc = ([tf.text floatValue]);
    NSArray *selectedCell = [[NSArray alloc] init];
    
    CGPoint tfPosition = [sender convertPoint:CGPointZero toView:self.tableview];
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:tfPosition];
    if (indexPath != nil){
        section = indexPath.section;
        row = indexPath.row;
        
        NSDictionary *dictionary = [drugsArray objectAtIndex:section];
        NSMutableArray *array = [dictionary objectForKey:@"data"];
        selectedCell = [array objectAtIndex:row];
        NSString *drugName = [selectedCell objectAtIndex:0];
        
        // Find out the path of InductionAgents.plist
        NSString *path = [[NSBundle mainBundle] pathForResource:@"InductionAgents" ofType:@"plist"];
        
        // Load the file content and read the data into arrays
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSMutableArray *defaultValues = [dict objectForKey:@"NormalConc"];
        
        // Goes through the entire list of drugs and finds the one matching in section and name to allow restoration of default values
        InductionAgents *sharedInductionName = [InductionAgents sharedInductionName];
        InductionAgents *sharedInductionClass = [InductionAgents sharedInductionClass];
        
        for (int i = 0; i < [[sharedInductionName inductionName] count]; i++){
            if (([[[sharedInductionClass inductionClass]objectAtIndex:i]integerValue] == section) && ([[[sharedInductionName inductionName]objectAtIndex:i] isEqualToString:drugName])){
                if (enteredConc == 0){
                    enteredConc = [[defaultValues objectAtIndex:i]floatValue];
                }
                if ([[selectedCell objectAtIndex:9] integerValue] == 2){enteredConc = enteredConc *10;}
            }
        }
        
        // finds the array at the index and alters the concentration
        NSMutableArray *change = [[NSMutableArray alloc]init];
        
        switch (section) {
            case 0:
                change = [inductionAgentsArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [inductionAgentsArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 1:
                change = [relaxantsArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [relaxantsArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 2:
                change = [flushArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [flushArray replaceObjectAtIndex:row withObject:change];
                break;
                
                
            case 3:
                change = [emergencyDrugsArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [emergencyDrugsArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 4:
                change = [coInductiveArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [coInductiveArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 5:
                change = [ongoingSedationArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [ongoingSedationArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 6:
                change = [ongoingAnalgesiaArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [ongoingAnalgesiaArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 7:
                change = [otherDrugsArray objectAtIndex:row];
                [change replaceObjectAtIndex:8 withObject:[NSNumber numberWithFloat: enteredConc]];
                [otherDrugsArray replaceObjectAtIndex:row withObject:change];
                break;
                
            default:
                break;
        }
        
        [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self reloadTable];
    }
    
    return;
}

- (void) onEditDose: (id) sender
{
    NSInteger section;
    NSInteger row;
    UITextField *tf = (UITextField*)sender;
    float enteredDose = ([tf.text floatValue]);
    NSArray *selectedCell = [[NSArray alloc] init];
    float concentration;
    NSInteger infusionType;
    
    CGPoint tfPosition = [sender convertPoint:CGPointZero toView:self.tableview];
    NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:tfPosition];
    if (indexPath != nil){
        //NSIndexPath* indexPath = [self.tableview indexPathForCell:sender];
        section = indexPath.section;
        row = indexPath.row;
        
        NSDictionary *dictionary = [drugsArray objectAtIndex:section];
        NSMutableArray *array = [dictionary objectForKey:@"data"];
        selectedCell = [array objectAtIndex:row];
        NSString *drugName = [selectedCell objectAtIndex:0];
        
        // Goes through the entire list of drugs and finds the one matching in section and name to allow restoration of default values
        InductionAgents *sharedInductionName = [InductionAgents sharedInductionName];
        InductionAgents *sharedInductionClass = [InductionAgents sharedInductionClass];
        InductionAgents *sharedManualDose = [InductionAgents sharedManualDose];
        DrugLog *sharedDrugDoseDisplayType = [DrugLog sharedDrugDoseDisplayType];
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        Patient *sharedWeight = [Patient sharedWeight];
        
        // gets the present drug concentration
        NSMutableArray *change = [[NSMutableArray alloc]init];
        
        switch (section) {
            case 0:
                change = [inductionAgentsArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if ([[sharedIsAdult isAdult]boolValue] == YES){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [inductionAgentsArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 1:
                change = [relaxantsArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if ([[sharedIsAdult isAdult]boolValue] == YES){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [relaxantsArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 2:
                change = [flushArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if ([[sharedIsAdult isAdult]boolValue] == YES){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [flushArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 3:
                change = [emergencyDrugsArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if ([[sharedIsAdult isAdult]boolValue] == YES){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [emergencyDrugsArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 4:
                change = [coInductiveArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if ([[sharedIsAdult isAdult]boolValue] == YES){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [coInductiveArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 5:
                change = [ongoingSedationArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if ([[sharedIsAdult isAdult]boolValue] == YES){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [ongoingSedationArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 6:
                change = [ongoingAnalgesiaArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if ([[sharedIsAdult isAdult]boolValue] == YES){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [ongoingAnalgesiaArray replaceObjectAtIndex:row withObject:change];
                break;
                
            case 7:
                change = [otherDrugsArray objectAtIndex:row];
                concentration = [[change objectAtIndex:8]floatValue];
                infusionType = [[change objectAtIndex:9]integerValue];
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 0) {
                    enteredDose = (enteredDose * concentration);
                }
                if ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] == 2) {
                    if (([[change objectAtIndex:3]boolValue] == NO) || ([[sharedIsAdult isAdult]boolValue] == NO)){
                        enteredDose = (enteredDose * [[sharedWeight weight]floatValue]);}}
                switch (infusionType) {
                    case 4:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 5:
                        enteredDose = (enteredDose /60);
                        break;
                        
                    case 6:
                        enteredDose = ((enteredDose *1000)/60);
                        break;
                        
                    case 7:
                        if (([[sharedIsAdult isAdult]boolValue] && ([[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue] > 0) == YES)){enteredDose = (enteredDose *1000);}
                        break;
                        
                    default:
                        break;
                }
                [change replaceObjectAtIndex:12 withObject:[NSNumber numberWithFloat: enteredDose]];
                [otherDrugsArray replaceObjectAtIndex:row withObject:change];
                break;
        }
        
        for (int i = 0; i < [[sharedInductionName inductionName] count]; i++){
            if (([[[sharedInductionClass inductionClass]objectAtIndex:i]integerValue] == section) && ([[[sharedInductionName inductionName]objectAtIndex:i] isEqualToString:drugName])){
                NSLog(@"%@, %.1f", [[sharedInductionName inductionName]objectAtIndex:i], enteredDose);
                if (enteredDose > 0){
                    [[sharedManualDose manualDose]replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:enteredDose]];
                    NSLog(@"%.1f", [[[sharedManualDose manualDose]objectAtIndex:i]floatValue]);
                }
            }
        }
        
        
        [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self reloadTable];
    }
    
    return;
}

// ================= Code to use delegate methods to dismiss keyboard=======

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    _textFieldBeingEdited = textField;
    return;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    _textFieldBeingEdited = nil;
    return;
}

- (void) dismissKeyboard
{
    if ([_textFieldBeingEdited isFirstResponder])
    {
        [_textFieldBeingEdited resignFirstResponder];
    }
    return;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_textFieldBeingEdited isFirstResponder] && [touch view] != _textFieldBeingEdited) {
        [_textFieldBeingEdited resignFirstResponder];
    }
    return;
}

// ==== Add methods to update tab colour, and activate the delete and more buttons

@end
