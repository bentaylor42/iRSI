//
//  DrugsViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DrugsViewController.h"

@interface DrugsViewController ()
{
    NSMutableArray *displayNamesArray;
    NSMutableArray *displayLabelArray;
    NSMutableArray *displaySelectedArray;
    NSMutableArray *displayIndexArray;
    NSMutableArray *customLabelDisplayArray;
    NSMutableArray *activeArray;
    NSMutableArray *phemArray;
}

@end

@implementation DrugsViewController

NSInteger doseDisplayType = 0;
NSMutableDictionary *inductionAgents;
NSTimer *drugSelection;
bool selectionLoaded = NO;
NSInteger sectionOpen = 0;

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
NSString * tapToSelect;
NSString * volToGive;
NSString * doseToGive;
NSString * mgKg;

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
    otherDrugString = [dict objectForKey:@"OtherDrugs"];
    tapToSelect = [dict objectForKey:@"TapToSelectAgent"];
    volToGive = [dict objectForKey:@"VolToGive"];
    doseToGive = [dict objectForKey:@"DoseToGive"];
    mgKg = [dict objectForKey:@"mgKg"];
    
    self.labelTapToSelect.text = tapToSelect;
    [self.segmentedDoseDisplayType setTitle:volToGive forSegmentAtIndex:0];
    [self.segmentedDoseDisplayType setTitle:doseToGive forSegmentAtIndex:1];
    [self.segmentedDoseDisplayType setTitle:mgKg forSegmentAtIndex:2];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    DrugLog *sharedDrugDoseDisplayType = [DrugLog sharedDrugDoseDisplayType];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewDrugsTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollSelector.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewSelector.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (selectionLoaded == NO) {
        drugSelection = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(openDrugSelector) userInfo:nil repeats:YES];
    }
    if ([defaults objectForKey:@"drugDisplayTypeSelected"] != nil){doseDisplayType = [defaults integerForKey:@"drugDisplayTypeSelected"];}
    
    if ([sharedDrugDoseDisplayType drugDoseDisplayType] != nil){
        doseDisplayType = [[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue];}
    
    if (([sharedDrugDoseDisplayType drugDoseDisplayType] == nil) && ([defaults objectForKey:@"drugDisplayTypeSelected"] == nil)){
        doseDisplayType = 0;
        [sharedDrugDoseDisplayType setDrugDoseDisplayType:[NSNumber numberWithInteger:2]];
    }

    self.segmentedDoseDisplayType.selectedSegmentIndex = doseDisplayType;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentDoseDisplayType:(id)sender
{
    doseDisplayType = self.segmentedDoseDisplayType.selectedSegmentIndex;
    
    return;
}

- (void) openDrugSelector
{
    Interactions *sharedDrugSelectorWindowOpen = [Interactions sharedDrugSelectorWindowOpen];
    Interactions *sharedDrugSelectionSection = [Interactions sharedDrugSelectionSection];
    selectionLoaded =YES;
    
    if ([[sharedDrugSelectorWindowOpen drugSelectorWindowOpen] boolValue] == YES)
    {
        self.viewDrugSelector.hidden = NO;
        self.viewDrugSelector.alpha = 1;
        
        sectionOpen = [[sharedDrugSelectionSection drugSelectionSection] integerValue];
        [self loadDrugLabels];
        [self populateTable];
        
        // Stops the timer from repeatedly firing and over-riding click events
        [drugSelection invalidate];
        drugSelection = nil;
        
        return;
    }
    
    return;
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
        
        return;
    }
}

- (void) populateTable
{
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
    InductionAgents *sharedIsVasopressor = [InductionAgents sharedIsVasopressor];
    InductionAgents *sharedManualDose = [InductionAgents sharedManualDose];
    InductionAgents *sharedSafePaeds = [InductionAgents sharedSafePaeds];
    InductionAgents *sharedPaedsMin = [InductionAgents sharedPaedsMin];
    InductionAgents *sharedPaedsMax = [InductionAgents sharedPaedsMax];
    InductionAgents *sharedPaedsSingle = [InductionAgents sharedPaedsSingle];
    InductionAgents *sharedPaedsMaxTotal = [InductionAgents sharedPaedsMaxTotal];
    
    Nationalities *sharedDrugLabels = [Nationalities sharedDrugLabels];
    
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
    [sharedIsVasopressor setIsVasopressor:[dict objectForKey:@"IsVasopressor"]];
    //if ([sharedManualDose manualDose] == nil){[sharedManualDose setManualDose:[dict objectForKey:@"ManualDose"]];}
    for (NSInteger t = 0; t < [[sharedInductionName inductionName]count]; t++)
    {
        if ([[sharedManualDose manualDose]count] < t){[[sharedManualDose manualDose] addObject:[NSNumber numberWithInt:0]];}
    }
    [sharedSafePaeds setSafePaeds:[dict objectForKey:@"SafeInPaeds"]];
    [sharedPaedsMin setPaedsMin:[dict objectForKey:@"PaedsMin"]];
    [sharedPaedsMax setPaedsMax:[dict objectForKey:@"PaedsMax"]];
    [sharedPaedsSingle setPaedsSingle:[dict objectForKey:@"PaedsSingleScaledDose"]];
    [sharedPaedsMaxTotal setPaedsMaxTotal:[dict objectForKey:@"PaedsMaxTotal"]];
    activeArray = [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"Active"]];
    phemArray = [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"PHEM"]];
    
    // Loads the arrays of drugs in each class
    DrugLog *sharedInductionDrug = [DrugLog sharedInductionDrug];
    DrugLog *sharedRelaxantsDrug = [DrugLog sharedRelaxantsDrug];
    DrugLog *sharedFlush = [DrugLog sharedFlush];
    DrugLog *sharedEmergencyDrug = [DrugLog sharedEmergencyDrug];
    DrugLog *sharedCoinductiveDrug = [DrugLog sharedCoinductiveDrug];
    DrugLog *sharedOngoingSedationDrug = [DrugLog sharedOngoingSedationDrug];
    DrugLog *sharedOngoingAnalgesiaDrug = [DrugLog sharedOngoingAnalgesiaDrug];
    DrugLog *sharedOtherDrug = [DrugLog sharedOtherDrug];
    
    // Initialises the display array
    displayNamesArray = [[NSMutableArray alloc] init];
    displayLabelArray = [[NSMutableArray alloc] init];
    displaySelectedArray = [[NSMutableArray alloc] init];
    displayIndexArray = [[NSMutableArray alloc] init];
    customLabelDisplayArray = [[NSMutableArray alloc] init];
    
    // Goes through the entire drug database and populates an array
    NSInteger i = 0;
    
    EventLog *sharedPreHospital = [EventLog sharedPreHospital];
    bool phem = [[sharedPreHospital preHospital]boolValue];
    
    
    
    for (i = 0; i < [sharedInductionClass inductionClass].count; i++)
    {
        if ((phem == NO) || ([[phemArray objectAtIndex:i]boolValue] == YES)){
            if ([[activeArray objectAtIndex:i]boolValue] == YES){
                if ([[sharedManualDose manualDose] count] <= i){[[sharedManualDose manualDose] addObject:[NSNumber numberWithInt:0]];}
                
                if ([[[sharedInductionClass inductionClass]objectAtIndex:i]integerValue] == sectionOpen)
                {
                    [displayNamesArray addObject:[[sharedInductionName inductionName] objectAtIndex:i]];
                    NSInteger label = [[[sharedInductionLabelType inductionLabelType] objectAtIndex:i] integerValue];
                    [customLabelDisplayArray addObject:[NSNumber numberWithInteger:label]];
                    [displayLabelArray addObject:[[sharedDrugLabels drugLabels] objectAtIndex:label]];
                    [displayIndexArray addObject:[NSNumber numberWithInteger:i]];
                    
                    // detects if the item has already been selected
                    NSArray *currentClass = [[NSArray alloc] init];
                    
                    switch (sectionOpen) {
                        case 0:
                            currentClass = [sharedInductionDrug inductionDrug];
                            break;
                            
                        case 1:
                            currentClass = [sharedRelaxantsDrug relaxantsDrug];
                            break;
                            
                        case 2:
                            currentClass = [sharedFlush flush];
                            break;
                            
                        case 3:
                            currentClass = [sharedEmergencyDrug emergencyDrug];
                            break;
                            
                        case 4:
                            currentClass = [sharedCoinductiveDrug coInductiveDrug];
                            break;
                            
                        case 5:
                            currentClass = [sharedOngoingSedationDrug ongoingSedationDrug];
                            break;
                            
                        case 6:
                            currentClass = [sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug];
                            break;
                            
                        case 7:
                            currentClass = [sharedOtherDrug otherDrug];
                            break;
                            
                        default:
                            break;
                    }
                    
                    NSMutableArray *listOfDrugs = [[NSMutableArray alloc] init];
                    for (int list=0; list<[currentClass count]; list++){
                        NSArray *array = [[NSArray alloc] init];
                        array = [currentClass objectAtIndex:list];
                        [listOfDrugs addObject:[array objectAtIndex:0]];
                    }
                    
                    if ([listOfDrugs containsObject:[[sharedInductionName inductionName] objectAtIndex:i]]){
                        [displaySelectedArray addObject:[NSNumber numberWithBool:YES]];}
                    else {[displaySelectedArray addObject:[NSNumber numberWithBool:NO]];}
                }
            }
        }
    }
        
    
    [self.tableDrugSelector reloadData];
    return;
}

// Creates a tableview with one section
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Calculates the number of rows to display based on the count of the display array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [displayNamesArray count];
}

// Defines the section title based on which section is selected on the main table
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (sectionOpen) {
        case 0:
            return inductionAgentString;
            break;
            
        case 1:
            return muscleRelaxantString;
            break;
            
        case 2:
            return flushString;
            break;
            
        case 3:
            return emergencyString;
            break;
            
        case 4:
            return coinductiveString;
            break;
            
        case 5:
            return ongoingSedationString;
            break;
            
        case 6:
            return ongoingAnalgesiaString;
            break;
            
        case 7:
            return otherDrugString;
            break;
            
        default:
            return @"";
            break;
    }
}

// defines the cells
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drugDisplayCheck"];
    
    // Defines the labels by tag number
    UILabel *drugName = (UILabel *) [cell viewWithTag:100];
    UIImageView *drugLabel = (UIImageView *)[cell viewWithTag:103];
    UIImageView *tick = (UIImageView *)[cell viewWithTag:1];
    NSInteger label;
    
    drugName.text = [displayNamesArray objectAtIndex:indexPath.row];
    [drugLabel setImage:[UIImage imageNamed:[displayLabelArray objectAtIndex:indexPath.row]]];
    label = [[customLabelDisplayArray objectAtIndex:indexPath.row]integerValue];
    drugName.font = [UIFont systemFontOfSize:12];
    drugName.textColor = [UIColor blackColor];
    
    // Adjusts font for volatile agents, to make them show up more clearly
    if ((label > 10) && (label < 16)){
        drugName.font = [UIFont boldSystemFontOfSize:12];
        switch (label) {
            case 11:
                drugName.textColor = [UIColor whiteColor];
                break;
                
            case 12:
                drugName.textColor = [UIColor blackColor];
                break;
                
            case 13:
                drugName.textColor = [UIColor whiteColor];
                break;
                
            case 14:
                drugName.textColor = [UIColor blackColor];
                break;
                
            case 15:
                drugName.textColor = [UIColor blackColor];
                break;
                
            default:
                break;
        }
    }
    
    // Changes text colour for sux and adrenaline labels
    if ([[displayLabelArray objectAtIndex:indexPath.row]  isEqualToString: @"Sux.png"]){
        drugName.font = [UIFont boldSystemFontOfSize:12];
        drugName.textColor = [UIColor redColor];
    }
    
    if ([[displayLabelArray objectAtIndex:indexPath.row] isEqualToString: @"adrenaline.png"]){
        drugName.font = [UIFont boldSystemFontOfSize:12];
        drugName.textColor = [UIColor colorWithRed:216.0f/255.0f green:10.0f/255.0f blue:216.0f/255.0f alpha:1.0];
    }
    
    // places a checkmark next to selected items
    if ([[displaySelectedArray objectAtIndex:indexPath.row] boolValue] == YES){
        [tick setImage:[UIImage imageNamed:@"completeTickBox.png"]];
        cell.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
    }
    if ([[displaySelectedArray objectAtIndex:indexPath.row] boolValue] == NO){
        cell.accessoryType = UITableViewCellAccessoryNone;
        [tick setImage:[UIImage imageNamed:@"blankTickBox.png"]];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath

// - (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    // Loads singletons
    DrugLog *sharedInductionDrug = [DrugLog sharedInductionDrug];
    DrugLog *sharedRelaxantsDrug = [DrugLog sharedRelaxantsDrug];
    DrugLog *sharedFlush = [DrugLog sharedFlush];
    DrugLog *sharedEmergencyDrug = [DrugLog sharedEmergencyDrug];
    DrugLog *sharedCoinductiveDrug = [DrugLog sharedCoinductiveDrug];
    DrugLog *sharedOngoingSedationDrug = [DrugLog sharedOngoingSedationDrug];
    DrugLog *sharedOngoingAnalgesiaDrug = [DrugLog sharedOngoingAnalgesiaDrug];
    DrugLog *sharedOtherDrug = [DrugLog sharedOtherDrug];
    DrugLog *sharedSectionSelected = [DrugLog sharedSectionSelected];
    DrugLog *sharedVasopressorChosen = [DrugLog sharedVasopressorChosen];
    DrugLog *sharedAntimuscarinicChosen = [DrugLog sharedAntimuscarinicChosen];
    
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
    InductionAgents *sharedIsVasopressor = [InductionAgents sharedIsVasopressor];
    InductionAgents *sharedManualDose = [InductionAgents sharedManualDose];
    InductionAgents *sharedSafePaeds = [InductionAgents sharedSafePaeds];
    InductionAgents *sharedPaedsMin = [InductionAgents sharedPaedsMin];
    InductionAgents *sharedPaedsMax = [InductionAgents sharedPaedsMax];
    InductionAgents *sharedPaedsSingle = [InductionAgents sharedPaedsSingle];
    InductionAgents *sharedPaedsMaxTotal = [InductionAgents sharedPaedsMaxTotal];
    
    // updates singleton with currently selected row
    [sharedSectionSelected setSectionSelected:[NSNumber numberWithInteger:sectionOpen]];
    
    // If row is not yet selected, adds it to the database
    NSInteger selectedIndex = [[displayIndexArray objectAtIndex:indexPath.row]integerValue];
    
    // Creates and populates an array with the selected drug
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:[[sharedInductionName inductionName] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionClass inductionClass] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionIsMaxMin inductionIsMaxMin] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionIsSingleAdultDose inductionIsSingleAdultDose] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionMinimumDose inductionMinimumDose] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionMaximumDose inductionMaximumDose] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionSingleScaledDose inductionSingleScaledDose] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionSingleAdultDose inductionSingleAdultDose] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionNormalConc inductionNormalConc] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionUnitType inductionUnitType] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedInductionLabelType inductionLabelType] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedIsVasopressor isVasopressor] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedManualDose manualDose] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedSafePaeds safePaeds] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedPaedsMin paedsMin] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedPaedsMax paedsMax] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedPaedsSingle paedsSingle] objectAtIndex:selectedIndex]];
    [array addObject:[[sharedPaedsMaxTotal paedsMaxTotal] objectAtIndex:selectedIndex]];
    
    // Adds the created array to the singleton array
    if ([[displaySelectedArray objectAtIndex:indexPath.row] boolValue] == NO)
    {
        [displaySelectedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        
        switch (sectionOpen) {
            case 0:
                [[sharedInductionDrug inductionDrug] addObject:array];
                break;
                
            case 1:
                [[sharedRelaxantsDrug relaxantsDrug] addObject:array];
                break;
                
            case 2:
                [[sharedFlush flush] addObject:array];
                break;
                
            case 3:
                [[sharedEmergencyDrug emergencyDrug] addObject:array];
                break;
                
            case 4:
                [[sharedCoinductiveDrug coInductiveDrug] addObject:array];
                break;
                
            case 5:
                [[sharedOngoingSedationDrug ongoingSedationDrug] addObject:array];
                break;
                
            case 6:
                [[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug] addObject:array];
                break;
                
            case 7:
                [[sharedOtherDrug otherDrug] addObject:array];
                break;
                
            default:
                break;
        }
        
        NSInteger total = 0;
        switch ([[array objectAtIndex:11]integerValue]) {
            case 0:
                break;
                
            case 1:
                total = [[sharedVasopressorChosen vasopressorChosen] integerValue];
                total ++;
                [sharedVasopressorChosen setVasopressorChosen:[NSNumber numberWithInteger:total]];
                total = 0;
                break;
                
            case 2:
                total = [[sharedAntimuscarinicChosen antimuscarinicChosen] integerValue];
                total ++;
                [sharedAntimuscarinicChosen setAntimuscarinicChosen:[NSNumber numberWithInteger:total]];
                total = 0;
                break;
                
            default:
                break;
        }        
    }
    
    else if ([[displaySelectedArray objectAtIndex:indexPath.row] boolValue] == YES)
    {
        [displaySelectedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        NSMutableArray *seekAndDestroy = [[NSMutableArray alloc] init];
        NSUInteger index;
        
        switch (sectionOpen) {
            case 0:
                for (int q=0; q<[[sharedInductionDrug inductionDrug] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedInductionDrug inductionDrug] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedInductionDrug inductionDrug]removeObjectAtIndex:index];}
                
                break;
                
            case 1:
                for (int q=0; q<[[sharedRelaxantsDrug relaxantsDrug] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedRelaxantsDrug relaxantsDrug] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedRelaxantsDrug relaxantsDrug]removeObjectAtIndex:index];}
                
                break;
                
            case 2:
                for (int q=0; q<[[sharedFlush flush] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedFlush flush] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedFlush flush]removeObjectAtIndex:index];}
                
                break;
                
            case 3:
                for (int q=0; q<[[sharedEmergencyDrug emergencyDrug] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedEmergencyDrug emergencyDrug] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedEmergencyDrug emergencyDrug]removeObjectAtIndex:index];}
                
                break;
                
            case 4:
                for (int q=0; q<[[sharedCoinductiveDrug coInductiveDrug] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedCoinductiveDrug coInductiveDrug] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedCoinductiveDrug coInductiveDrug]removeObjectAtIndex:index];}
                
                break;
                
            case 5:
                for (int q=0; q<[[sharedOngoingSedationDrug ongoingSedationDrug] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedOngoingSedationDrug ongoingSedationDrug] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedOngoingSedationDrug ongoingSedationDrug]removeObjectAtIndex:index];}
                
                break;
                
            case 6:
                for (int q=0; q<[[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedOngoingAnalgesiaDrug ongoingAnalgesiaDrug]removeObjectAtIndex:index];}
                
                break;
                
            case 7:
                for (int q=0; q<[[sharedOtherDrug otherDrug] count]; q++){
                    NSArray *array = [[NSArray alloc] init];
                    array = [[sharedOtherDrug otherDrug] objectAtIndex:q];
                    [seekAndDestroy addObject: [array objectAtIndex:0]];
                }
                NSUInteger index = [seekAndDestroy indexOfObject:[displayNamesArray objectAtIndex:indexPath.row]];
                if (index == NSNotFound){NSLog(@"missing item from array...!");}
                else {[[sharedOtherDrug otherDrug]removeObjectAtIndex:index];}
                
                break;
                
            default:
                break;
        }
        
        NSInteger total = 0;
        switch ([[array objectAtIndex:11]integerValue]) {
            case 0:
                break;
                
            case 1:
                total = [[sharedVasopressorChosen vasopressorChosen] integerValue];
                total --;
                [sharedVasopressorChosen setVasopressorChosen:[NSNumber numberWithInteger:total]];
                total = 0;
                break;
                
            case 2:
                total = [[sharedAntimuscarinicChosen antimuscarinicChosen] integerValue];
                total --;
                [sharedAntimuscarinicChosen setAntimuscarinicChosen:[NSNumber numberWithInteger:total]];
                total = 0;
                break;
                
            default:
                break;
        }
    }
    
    // reloads the table array
    [self openDrugSelector];
    
    return;
}

- (IBAction)buttonClose:(id)sender {
    Interactions *sharedDrugSelectorWindowOpen = [Interactions sharedDrugSelectorWindowOpen];
    [sharedDrugSelectorWindowOpen setDrugSelectorWindowOpen:[NSNumber numberWithBool:NO]];
    
    self.viewDrugSelector.hidden = YES;
    self.viewDrugSelector.alpha = 0;
    selectionLoaded = NO;
    
    drugSelection = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(openDrugSelector) userInfo:nil repeats:YES];
    
    [self.scrollSelector setContentOffset:CGPointZero animated:YES];
    
    return;
}

- (IBAction)segmentedMlMg:(id)sender {
    DrugLog *sharedDrugDoseDisplayType = [DrugLog sharedDrugDoseDisplayType];
    Interactions *sharedChangeDoseDisplayType = [Interactions sharedChangedDoseDisplayType];
    
    doseDisplayType = self.segmentedDoseDisplayType.selectedSegmentIndex;
    [sharedDrugDoseDisplayType setDrugDoseDisplayType:[NSNumber numberWithInteger:doseDisplayType]];
    
    // Updates a bool singleton to ensure that the table updates
    [sharedChangeDoseDisplayType setChangedDoseDisplayType:[NSNumber numberWithBool:YES]];
}

@end
