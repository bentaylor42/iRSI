//
//  PaedsCalcViewController.m
//  irsi
//
//  Created by Ben Taylor on 20/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "PaedsCalcViewController.h"

@interface PaedsCalcViewController (){
    NSString * kg;
    NSString * st;
    NSString * lbs;
    NSString * enterWeight;
    NSString * stones;
    NSString * pounds;
    NSString * adult16;
    NSString * year15;
    NSString * year14;
    NSString * year13;
    NSString * year12;
    NSString * year11;
    NSString * year10;
    NSString * year9;
    NSString * year8;
    NSString * year7;
    NSString * year6;
    NSString * year5;
    NSString * year4;
    NSString * year3;
    NSString * year2;
    NSString * year1;
    NSString * month11;
    NSString * month10;
    NSString * month9;
    NSString * month8;
    NSString * month7;
    NSString * month6;
    NSString * month5;
    NSString * month4;
    NSString * month3;
    NSString * month2;
    NSString * month1;
    NSString * neonate;
    NSString * closeButton;
    NSString * back;
    NSString * cuffed;
    NSString * unCuffed;
    NSString * tubeSizeTitle;
    NSString * ageDisplayButtonBlank;
    NSString * ageDisplayButtonComplete;
    NSString * defibEnergy;
    NSString * paedsCalcTitle;
    NSString * agePickerTitle;
    NSString * tubeLengthOral;
    NSString * tubeLengthNasal;
    NSString * traumaBolus;
    NSString * medicalBolus;
    NSString * volToGive;
    NSString * doseToGive;
    NSString * mgKg;
    NSString * cardiacArrest;
    
    NSArray *_agePickerArray;
    NSArray *_ageWeightArray;
    NSArray *_yearsAgeArray;
    NSArray * labelArray;
    
}
@end

@implementation PaedsCalcViewController

NSInteger weightSelected = 0;
NSInteger doseSelectedType = 2;

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
    
    [self loadStrings];
    
    [defaults synchronize];
    
    if ([defaults objectForKey:@"weightTypeDefaultSelected"] != nil){
        self.segmentedWeight.selectedSegmentIndex = [defaults integerForKey:@"weightTypeDefaultSelected"];
        weightSelected = [defaults integerForKey:@"weightTypeDefaultSelected"];}
    
    // Creates the weight corresponding with each age group
    _ageWeightArray = @[@"70",@"52",@"49",@"46",@"43",@"40",@"37",@"34",@"31",@"28",@"25",@"18",@"16",@"14",@"12",@"10",@"9.5",@"9.0",@"8.5",@"8.0",@"7.5",@"7.0",@"6.5",@"6.0",@"5.5",@"5.0",@"4.5",@"3.5"];
    
    // Creates the age in years corresponding with each age group
    _yearsAgeArray = @[@"16",@"15",@"14",@"13",@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"0"];
    
    // Connect data to UIPicker
    self.agePicker.dataSource = self;
    self.agePicker.delegate = self;
    
    // Loads the singleton data to the existing dials
    Patient *sharedAgeArrayIndex = [Patient sharedAgeArrayIndex];
    [self.agePicker selectRow:[[sharedAgeArrayIndex ageArrayIndex]intValue] inComponent:(NSInteger) 0 animated:YES];
    [self displayWeight];
    [self createKeyboardReturnButton];
    [self wetFlag];
    
    DrugLog *sharedDrugDoseDisplayType = [DrugLog sharedDrugDoseDisplayType];
    if ([defaults objectForKey:@"drugDisplayTypeSelected"] != nil){doseSelectedType = [defaults integerForKey:@"drugDisplayTypeSelected"];}
    
    if ([sharedDrugDoseDisplayType drugDoseDisplayType] != nil){
        doseSelectedType = [[sharedDrugDoseDisplayType drugDoseDisplayType]integerValue];}
    
    if (([sharedDrugDoseDisplayType drugDoseDisplayType] == nil) && ([defaults objectForKey:@"drugDisplayTypeSelected"] == nil)){
        doseSelectedType = 2;
        [sharedDrugDoseDisplayType setDrugDoseDisplayType:[NSNumber numberWithInteger:2]];
    }
    
    self.segmentedDoseDisplayType.selectedSegmentIndex = doseSelectedType;
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    kg = [dict objectForKey:@"Kg"];
    st = [dict objectForKey:@"St"];
    lbs = [dict objectForKey:@"Lbs"];
    stones = [dict objectForKey:@"Stones"];
    pounds = [dict objectForKey:@"Pounds"];
    adult16 = [dict objectForKey:@"Adult16"];
    year15 = [dict objectForKey:@"15Year"];
    year14 = [dict objectForKey:@"14Year"];
    year13 = [dict objectForKey:@"13Year"];
    year12 = [dict objectForKey:@"12Year"];
    year11 = [dict objectForKey:@"11Year"];
    year10 = [dict objectForKey:@"10Year"];
    year9 = [dict objectForKey:@"9Year"];
    year8 = [dict objectForKey:@"8Year"];
    year7 = [dict objectForKey:@"7Year"];
    year6 = [dict objectForKey:@"6Year"];
    year5 = [dict objectForKey:@"5Year"];
    year4 = [dict objectForKey:@"4Year"];
    year3 = [dict objectForKey:@"3Year"];
    year2 = [dict objectForKey:@"2Year"];
    year1 = [dict objectForKey:@"1Year12Months"];
    month11 = [dict objectForKey:@"11Months"];
    month10 = [dict objectForKey:@"10Months"];
    month9 = [dict objectForKey:@"9Months"];
    month8 = [dict objectForKey:@"8Months"];
    month7 = [dict objectForKey:@"7Months"];
    month6 = [dict objectForKey:@"6Months"];
    month5 = [dict objectForKey:@"5Months"];
    month4 = [dict objectForKey:@"4Months"];
    month3 = [dict objectForKey:@"3Months"];
    month2 = [dict objectForKey:@"2Months"];
    month1 = [dict objectForKey:@"1Month"];
    neonate = [dict objectForKey:@"Neonate"];
    closeButton = [dict objectForKey:@"Close"];
    enterWeight = [dict objectForKey:@"EnterWeight"];
    ageDisplayButtonBlank = [dict objectForKey:@"ageDisplayButtonBlank"];
    ageDisplayButtonComplete = [dict objectForKey:@"ageDisplayButtonComplete"];
    back = [NSString stringWithFormat:@"< %@",[dict objectForKey:@"Back"]];
    defibEnergy = [dict objectForKey:@"defibEnergy"];
    cuffed = [dict objectForKey:@"CuffedTube"];
    unCuffed = [dict objectForKey:@"UncuffedTube"];
    tubeSizeTitle = [dict objectForKey:@"tubeSizeTitle"];
    paedsCalcTitle = [dict objectForKey:@"PaedsCalc"];
    agePickerTitle = [dict objectForKey:@"agePickerTitle"];
    tubeLengthOral = [dict objectForKey:@"tubeLengthOral"];
    tubeLengthNasal = [dict objectForKey:@"tubeLengthNasal"];
    traumaBolus = [dict objectForKey:@"traumaBolus"];
    medicalBolus = [dict objectForKey:@"medicalBolus"];
    volToGive = [dict objectForKey:@"VolToGive"];
    doseToGive = [dict objectForKey:@"DoseToGive"];
    mgKg = [dict objectForKey:@"mgKg"];
    cardiacArrest = [dict objectForKey:@"cardiacArrest"];
    
    
    // Creates the array for the agePicker
    _agePickerArray = @[adult16, year15, year14, year13, year12, year11, year10, year9, year8, year7, year6, year5, year4, year3, year2, year1, month11, month10, month9, month8, month7, month6, month5, month4, month3, month2, month1, neonate];
    
    self.textFieldKg.placeholder = enterWeight;
    self.textFieldLbs.placeholder = pounds;
    self.textFieldPounds.placeholder = pounds;
    self.textFieldStones.placeholder = stones;
    [self.segmentedWeight setTitle:kg forSegmentAtIndex:0];
    [self.segmentedWeight setTitle:st forSegmentAtIndex:1];
    [self.segmentedWeight setTitle:lbs forSegmentAtIndex:2];
    [self.buttonDisplayAge setTitle:ageDisplayButtonBlank forState:UIControlStateNormal];
    [self.buttonBack setTitle:back forState:UIControlStateNormal];
    [self.buttonClose setTitle:closeButton forState:UIControlStateNormal];
    [self.segmentedCuffed setTitle:cuffed forSegmentAtIndex:0];
    [self.segmentedCuffed setTitle:unCuffed forSegmentAtIndex:1];
    self.labelTitle.text = paedsCalcTitle;
    self.labelETTSize.text = tubeSizeTitle;
    self.labelSelectAge.text = agePickerTitle;
    self.labelOralLength.text = tubeLengthOral;
    self.labelNasalLength.text = tubeLengthNasal;
    [self.segmentedDoseDisplayType setTitle:volToGive forSegmentAtIndex:0];
    [self.segmentedDoseDisplayType setTitle:doseToGive forSegmentAtIndex:1];
    [self.segmentedDoseDisplayType setTitle:mgKg forSegmentAtIndex:2];
    
    [self.buttonDisplayAge.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.buttonDisplayAge.selected = NO;
    [self.buttonBack.titleLabel setTextAlignment:NSTextAlignmentLeft];
    self.buttonBack.selected = NO;
    [self.buttonClose.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.buttonClose.selected = NO;
}

// The number of columns of data
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The Number of rows of data
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _agePickerArray.count;
}

// The data to return for the row and component that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _agePickerArray[row];
}

// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // Gets the weight and stores it in a singleton
    NSString *agePickerOutput = [_ageWeightArray objectAtIndex:row];
    Patient *sharedWeight = [Patient sharedWeight];
    [sharedWeight setWeight:[NSNumber numberWithFloat:[agePickerOutput floatValue]]];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
    
    // Gets the age ands stores it in a singleton
    NSString *ageOutput = [_agePickerArray objectAtIndex:row];
    NSString *yearsOld = [_yearsAgeArray objectAtIndex:row];
    
    int age = [yearsOld intValue];
    
    // Stores the output in a singleton
    Patient *sharedAge = [Patient sharedAge];
    Patient *sharedAgeArrayIndex = [Patient sharedAgeArrayIndex];
    [sharedAge setAge:[NSNumber numberWithInt:age]];
    [sharedAgeArrayIndex setAgeArrayIndex:[NSNumber numberWithInteger:row]];
    
    // Detects if the patient is an adult or not (for certain drug calculations)
    if ([ageOutput isEqualToString: @"Adult (16+)"])
    {
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        [sharedIsAdult setIsAdult:[NSNumber numberWithBool:YES]];
        [self.buttonDisplayAge setTitle:ageDisplayButtonBlank forState:UIControlStateNormal];
        [self.buttonDisplayAge.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.buttonDisplayAge.selected = NO;
    }
    else
    {
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        [sharedIsAdult setIsAdult:[NSNumber numberWithBool:NO]];
        [self.buttonDisplayAge setTitle:[NSString stringWithFormat:ageDisplayButtonComplete, ageOutput] forState:UIControlStateNormal];
        [self.buttonDisplayAge.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.buttonDisplayAge.selected = NO;
    }
    
    [self displayWeight];
    [self wetFlag];
    
    return;
}

-(void) createKeyboardReturnButton
{
    //Creates a custom keypad with a return button
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar.barStyle=UIBarStyleDefault;
    
    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    
    // Add buttons to the toolbar
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    
    // Set the toolbar as accessory view of an UITextField object
    _textFieldKg.inputAccessoryView = toolbar;
    _textFieldLbs.inputAccessoryView = toolbar;
    _textFieldPounds.inputAccessoryView = toolbar;
    _textFieldStones.inputAccessoryView = toolbar;
    
    _textFieldAdrenalineConc.inputAccessoryView = toolbar;
    _textFieldAdrenalineMinijet.inputAccessoryView = toolbar;
    _textFieldAtropineConc.inputAccessoryView = toolbar;
    _textFieldGlucoseConc.inputAccessoryView = toolbar;
    _textFieldLorazepamConc.inputAccessoryView = toolbar;
    _textFieldNasalLength.inputAccessoryView = toolbar;
    _textFieldOralLength.inputAccessoryView = toolbar;
    _textFieldSuxConc.inputAccessoryView = toolbar;
    _textFieldTubeSize.inputAccessoryView = toolbar;
    
    return;
}

-(void) dismissKeyboard:(id) sender
{
    if ([_textFieldKg isFirstResponder]){
        [_textFieldKg resignFirstResponder];
    }
    if ([_textFieldLbs isFirstResponder]){
        [_textFieldLbs resignFirstResponder];
    }
    if ([_textFieldPounds isFirstResponder]){
        [_textFieldPounds resignFirstResponder];
    }
    if ([_textFieldStones isFirstResponder]){
        [_textFieldStones resignFirstResponder];
    }
    
    if ([_textFieldAdrenalineConc isFirstResponder]){
        [_textFieldAdrenalineConc resignFirstResponder];
    }
    if ([_textFieldAdrenalineMinijet isFirstResponder]){
        [_textFieldAdrenalineMinijet resignFirstResponder];
    }
    if ([_textFieldAtropineConc isFirstResponder]){
        [_textFieldAtropineConc resignFirstResponder];
    }
    if ([_textFieldGlucoseConc isFirstResponder]){
        [_textFieldGlucoseConc resignFirstResponder];
    }
    if ([_textFieldLorazepamConc isFirstResponder]){
        [_textFieldLorazepamConc resignFirstResponder];
    }
    if ([_textFieldNasalLength isFirstResponder]){
        [_textFieldNasalLength resignFirstResponder];
    }
    if ([_textFieldOralLength isFirstResponder]){
        [_textFieldOralLength resignFirstResponder];
    }
    if ([_textFieldSuxConc isFirstResponder]){
        [_textFieldSuxConc resignFirstResponder];
    }
    if ([_textFieldTubeSize isFirstResponder]){
        [_textFieldTubeSize resignFirstResponder];
    }
    return;
}

// minimises keyboard on tapping elsewhere on screen
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_textFieldKg isFirstResponder] && [touch view] != _textFieldKg) {
        [_textFieldKg resignFirstResponder];
    }
    if ([_textFieldLbs isFirstResponder] && [touch view] != _textFieldLbs) {
        [_textFieldLbs resignFirstResponder];
    }
    if ([_textFieldPounds isFirstResponder] && [touch view] != _textFieldPounds) {
        [_textFieldPounds resignFirstResponder];
    }
    if ([_textFieldStones isFirstResponder] && [touch view] != _textFieldStones) {
        [_textFieldStones resignFirstResponder];
    }
    
    if ([_textFieldAdrenalineConc isFirstResponder] && [touch view] != _textFieldAdrenalineConc) {
        [_textFieldAdrenalineConc resignFirstResponder];
    }
    if ([_textFieldAdrenalineMinijet isFirstResponder] && [touch view] != _textFieldAdrenalineMinijet) {
        [_textFieldAdrenalineMinijet resignFirstResponder];
    }
    if ([_textFieldAtropineConc isFirstResponder] && [touch view] != _textFieldAtropineConc) {
        [_textFieldAtropineConc resignFirstResponder];
    }
    if ([_textFieldGlucoseConc isFirstResponder] && [touch view] != _textFieldGlucoseConc) {
        [_textFieldGlucoseConc resignFirstResponder];
    }
    if ([_textFieldLorazepamConc isFirstResponder] && [touch view] != _textFieldLorazepamConc) {
        [_textFieldLorazepamConc resignFirstResponder];
    }
    if ([_textFieldNasalLength isFirstResponder] && [touch view] != _textFieldNasalLength) {
        [_textFieldNasalLength resignFirstResponder];
    }
    if ([_textFieldOralLength isFirstResponder] && [touch view] != _textFieldOralLength) {
        [_textFieldOralLength resignFirstResponder];
    }
    if ([_textFieldSuxConc isFirstResponder] && [touch view] != _textFieldSuxConc) {
        [_textFieldSuxConc resignFirstResponder];
    }
    if ([_textFieldTubeSize isFirstResponder] && [touch view] != _textFieldTubeSize) {
        [_textFieldTubeSize resignFirstResponder];
    }
    return;
}

- (void) displayWeight
{
    _textFieldKg.enabled = YES;
    _textFieldLbs.enabled = YES;
    _textFieldPounds.enabled = YES;
    _textFieldStones.enabled = YES;
    
    _textFieldKg.hidden = YES;
    _textFieldLbs.hidden = YES;
    _textFieldPounds.hidden = YES;
    _textFieldStones.hidden = YES;
    
    switch (self.segmentedWeight.selectedSegmentIndex)
    {
        case 0:
            _textFieldKg.hidden = NO;
            break;
            
        case 1:
            _textFieldStones.hidden = NO;
            _textFieldPounds.hidden = NO;
            break;
            
        case 2:
            _textFieldLbs.hidden = NO;
            
        default:
            break;
    }
    
    Patient *sharedWeight = [Patient sharedWeight];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    float weight = [[sharedWeight weight] floatValue];
    float poundWeight = weight * 2.20462;
    int calcStones = (int) (poundWeight/14);
    float calcPounds = poundWeight - (calcStones * 14);
    
    _textFieldKg.text = [NSString stringWithFormat:@"%.1f",weight];
    _textFieldLbs.text = [NSString stringWithFormat:@"%.1f",poundWeight];
    _textFieldPounds.text = [NSString stringWithFormat:@"%.1f", calcPounds];
    _textFieldStones.text = [NSString stringWithFormat:@"%i", calcStones];
    
    if ([[sharedWeightKnown weightKnown]boolValue] == YES)
    {
        if (weightSelected == 0)
        {
            _textFieldKg.hidden = NO;
            
            _textFieldLbs.hidden = YES;
            _textFieldPounds.hidden = YES;
            _textFieldStones.hidden = YES;
            _textFieldLbs.enabled = NO;
            _textFieldPounds.enabled = NO;
            _textFieldStones.enabled = NO;
        }
        if (weightSelected == 1)
        {
            _textFieldStones.hidden = NO;
            _textFieldPounds.hidden = NO;
            
            _textFieldKg.hidden = YES;
            _textFieldLbs.hidden = YES;
            _textFieldKg.enabled = NO;
            _textFieldLbs.enabled = NO;
        }
        if (weightSelected == 2)
        {
            _textFieldLbs.hidden = NO;
            
            _textFieldKg.hidden = YES;
            _textFieldPounds.hidden = YES;
            _textFieldStones.hidden = YES;
            _textFieldKg.enabled = NO;
            _textFieldPounds.enabled = NO;
            _textFieldStones.enabled = NO;
        }
    }
    else if ([[sharedWeightKnown weightKnown]boolValue] == NO)
    {
        _textFieldKg.text = [NSString stringWithFormat:@""];
        _textFieldLbs.text = [NSString stringWithFormat:@""];
        _textFieldPounds.text = [NSString stringWithFormat:@""];
        _textFieldStones.text = [NSString stringWithFormat:@""];
    }
    
    [self wetFlag];
    
    return;
}

float tubeSize;
bool manualTubeSelected;

- (void) wetFlag{
    // ===== W =====
    Patient *sharedWeight = [Patient sharedWeight];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    float weight = [[sharedWeight weight]floatValue];
    bool weightKnown = [[sharedWeightKnown weightKnown]boolValue];
    
    // ===== E =====
    NSInteger defibDose = 4*weight;
    if (weightKnown == YES){self.labelDefibEnergy.text = [NSString stringWithFormat:defibEnergy, [NSString stringWithFormat:@"\t\t%li J", (long)defibDose]];}
    else {self.labelDefibEnergy.text = [NSString stringWithFormat:defibEnergy, @"\t\t4 J/Kg"];}
    
    // ===== T =====
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedAge = [Patient sharedAge];
    Patient *sharedIsCuffedTube = [Patient sharedIsCuffedTube];
    Patient *sharedTubeSize = [Patient sharedTubeSize];
    
    if ([[sharedIsAdult isAdult]boolValue] == NO){
        self.labelTubeLarger.hidden = NO;
        self.labelTubeSmaller.hidden = NO;
        [self.segmentedCuffed setEnabled:YES forSegmentAtIndex:1];
        float rawTubeSize = (([[sharedAge age]floatValue]/4) + 4);
        if ([[sharedIsCuffedTube isCuffedTube]boolValue] == YES){rawTubeSize = (rawTubeSize - 1);}
        if ((rawTubeSize - (int) rawTubeSize) == 0.25){rawTubeSize = (int) rawTubeSize;}
        if ((rawTubeSize - (int) rawTubeSize) == 0.75){rawTubeSize = ((int) rawTubeSize) +0.5;}
        self.textFieldTubeSize.placeholder = [NSString stringWithFormat:@"%.1f", rawTubeSize];
        if ([[sharedTubeSize tubeSize]floatValue] >0){
            rawTubeSize = [[sharedTubeSize tubeSize] floatValue];
            self.textFieldTubeSize.text = [NSString stringWithFormat:@"%.1f", rawTubeSize];
        }
        self.labelTubeSmaller.text = [NSString stringWithFormat:@"%.1f", (rawTubeSize - 0.5)];
        self.labelTubeLarger.text = [NSString stringWithFormat:@"%.1f", (rawTubeSize + 0.5)];
    }
    else{
        self.labelTubeSmaller.hidden = YES;
        self.labelTubeLarger.hidden = YES;
        self.segmentedCuffed.selectedSegmentIndex = 0;
        [sharedIsCuffedTube setIsCuffedTube:[NSNumber numberWithBool:YES]];
        [self.segmentedCuffed setEnabled:NO forSegmentAtIndex:1];
        if ([[sharedTubeSize tubeSize]floatValue] >0){
            self.textFieldTubeSize.text = [NSString stringWithFormat:@"%.1f", [[sharedTubeSize tubeSize] floatValue]];
        }
        else {self.textFieldTubeSize.placeholder = @"";}
    }
    
    if ([[sharedIsAdult isAdult] boolValue] == NO){
        float oralPaedsLength = ([[sharedAge age] integerValue]/2) + 12;
        float nasalPaedsLength = ([[sharedAge age] integerValue]/2) + 15;
        
        self.textFieldOralLength.placeholder = [NSString stringWithFormat:@"%.1f", oralPaedsLength];
        self.textFieldNasalLength.placeholder = [NSString stringWithFormat:@"%.1f", nasalPaedsLength];
    }
    
    // ===== F =====
    if ([[sharedWeightKnown weightKnown] boolValue] == NO){
        self.labelTraumaBolus.text = [NSString stringWithFormat:traumaBolus, @"\t\t10 ml/Kg"];
        self.labelMedicalBolus.text = [NSString stringWithFormat:medicalBolus, @"\t20 ml/Kg"];
    }
    else{
        self.labelTraumaBolus.text = [NSString stringWithFormat:traumaBolus, [NSString stringWithFormat:@"\t\t%i ml",([[sharedWeight weight]intValue] * 10)]];
        self.labelMedicalBolus.text = [NSString stringWithFormat:medicalBolus, [NSString stringWithFormat:@"\t%i ml",([[sharedWeight weight]intValue] * 20)]];
    }
    
    // ===== L =====
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    InductionAgents *sharedInductionIsMaxMin = [InductionAgents sharedInductionIsMaxMin];
    Nationalities *sharedDrugLabels = [Nationalities sharedDrugLabels];
    Nationalities *sharedNationalityArray = [Nationalities sharedNationalityArray];
    InductionAgents *sharedInductionName = [InductionAgents sharedInductionName];
    InductionAgents *sharedInductionNormalConc = [InductionAgents sharedInductionNormalConc];
    InductionAgents *sharedInductionUnitType = [InductionAgents sharedInductionUnitType];
    InductionAgents *sharedPaedsMin = [InductionAgents sharedPaedsMin];
    InductionAgents *sharedPaedsMax = [InductionAgents sharedPaedsMax];
    InductionAgents *sharedPaedsSingle = [InductionAgents sharedPaedsSingle];
    InductionAgents *sharedPaedsMaxTotal = [InductionAgents sharedPaedsMaxTotal];
    
    NSInteger doseType = doseSelectedType;
    if ([[sharedWeightKnown weightKnown]boolValue] == NO){
        doseType = 2;
    }
    
    
    if ([defaults objectForKey:@"Nationality"] != nil){[sharedNationality setNationality:[NSNumber numberWithInteger:[defaults integerForKey:@"Nationalities"]]];}
    
    // Find out path of druglabels.plist file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NationalDrugLabels" ofType:@"plist"];
    
    // Get the string for the country name of the chosen country
    NSString *country = [[sharedNationalityArray nationalityArray] objectAtIndex:[[sharedNationality nationality] integerValue]];
    
    // Load the file content and read the data into an array
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    [sharedDrugLabels setDrugLabels:[dict objectForKey:country]];

    // Find out the path of InductionAgents.plist
    path = [[NSBundle mainBundle] pathForResource:@"InductionAgents" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    [sharedInductionName setInductionName:[dict objectForKey:@"DrugName"]];
    [sharedInductionIsMaxMin setInductionIsMaxMin:[dict objectForKey:@"IsMaxMin"]];
    [sharedInductionNormalConc setInductionNormalConc:[dict objectForKey:@"NormalConc"]];
    [sharedInductionUnitType setInductionUnitType:[dict objectForKey:@"UnitType"]];
    [sharedPaedsSingle setPaedsSingle:[dict objectForKey:@"PaedsSingleScaledDose"]];
    [sharedPaedsMaxTotal setPaedsMaxTotal:[dict objectForKey:@"PaedsMaxTotal"]];
    [sharedPaedsMin setPaedsMin:[dict objectForKey:@"PaedsMin"]];
    [sharedPaedsMax setPaedsMax:[dict objectForKey:@"PaedsMax"]];
    float minDose;
    float maxDose;
    float minVol;
    float maxVol;
    float minMgKg;
    float maxMgKg;
    
    NSInteger thisDrug = 37;
    
    [self.imageLorazepam setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:1]]];
    minMgKg = [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
    maxMgKg = [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    self.titleLorazepam.text = [[sharedInductionName inductionName] objectAtIndex:thisDrug];
    self.textFieldLorazepamConc.text = [NSString stringWithFormat:@"%.0f",lorazConc];
    if ([[[sharedInductionIsMaxMin inductionIsMaxMin]objectAtIndex:thisDrug]boolValue] == NO){
        minDose = weight * [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
        maxDose = minDose;
    }
    else{
        minDose = weight * [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
        maxDose = weight * [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    }
    if (minDose > [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue]){
        minDose = [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue];
    }
    if (maxDose > [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue]) {
        maxDose = [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue];
    }
    switch (doseType) {
        case 0:
            minVol = (minDose / lorazConc);
            maxVol = (maxVol / lorazConc);
            self.doseLabelLorazepam.text = [NSString stringWithFormat:@"%.1f mls", minVol];
            self.labelMgLorazepam.text = @"mg/ml";
            self.labelMgLorazepam.hidden = NO;
            self.textFieldLorazepamConc.hidden = NO;
            break;
            
        case 1:
            self.doseLabelLorazepam.text = [NSString stringWithFormat:@"%.1f mg", minDose];
            self.labelMgLorazepam.hidden = YES;
            self.textFieldLorazepamConc.hidden = YES;
            break;
            
        case 2:
            self.doseLabelLorazepam.text = @"100 mcg/Kg";
            self.labelMgLorazepam.hidden = YES;
            self.textFieldLorazepamConc.hidden = YES;
            break;
            
        default:
            break;
    }
    
    // ===== A =====
    
    thisDrug = 14;
    
    [self.imageAdrenaline setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:8]]];
    minMgKg = [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
    maxMgKg = [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    self.titleAdrenaline.text = [[sharedInductionName inductionName] objectAtIndex:thisDrug];
    self.textFieldAdrenalineConc.text = [NSString stringWithFormat:@"%.0f \u00B5g/ml",adrenalineConc];
    
    minDose = 10 * [[sharedWeight weight]floatValue];
    maxDose = minDose;
    
    switch (doseType) {
        case 0:
            minVol = (minDose / adrenalineConc);
            maxVol = (maxVol / adrenalineConc);
            self.doseLabelAdrenaline.text = [NSString stringWithFormat:@"(%@)\n%.1f mls",cardiacArrest, minVol];
            int minijetDiluation = 1000000/adrenalineConc;
            self.textFieldAdrenalineMinijet.text = [NSString stringWithFormat:@"(1:%i)",minijetDiluation];
            self.textFieldAdrenalineMinijet.hidden = NO;
            self.textFieldAdrenalineConc.hidden = NO;
            break;
            
        case 1:
            self.doseLabelAdrenaline.text = [NSString stringWithFormat:@"(%@)\n%.1f mcg", cardiacArrest, minDose];
            self.textFieldAdrenalineMinijet.hidden = YES;
            self.textFieldAdrenalineConc.hidden = YES;
            break;
            
        case 2:
            self.doseLabelAdrenaline.text = [NSString stringWithFormat:@"(%@)\n10 mcg/Kg",cardiacArrest];
            self.textFieldAdrenalineMinijet.hidden = YES;
            self.textFieldAdrenalineConc.hidden = YES;
            break;
            
        default:
            break;
    }
    
    // ===== G =====
    
    thisDrug = 38;
    
    [self.imageGlucose setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:0]]];
    minMgKg = [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
    maxMgKg = [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    self.titleGlucose.text = [[sharedInductionName inductionName] objectAtIndex:thisDrug];
    self.textFieldGlucoseConc.text = [NSString stringWithFormat:@"%.0f %%",(glucoseConc/10)];
    if ([[[sharedInductionIsMaxMin inductionIsMaxMin]objectAtIndex:thisDrug]boolValue] == NO){
        minDose = weight * [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
        maxDose = minDose;
    }
    else{
        minDose = weight * [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
        maxDose = weight * [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    }
    if (minDose > [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue]){
        minDose = [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue];
    }
    if (maxDose > [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue]) {
        maxDose = [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue];
    }
    switch (doseType) {
        case 0:
            minVol = (minDose / glucoseConc);
            maxVol = (maxVol / glucoseConc);
            self.doseLabelGlucose.text = [NSString stringWithFormat:@"%.0f mls", minVol];
            self.textFieldGlucoseConc.hidden = NO;
            self.textFieldGlucoseConc.enabled = YES;
            break;
            
        case 1:
            self.doseLabelGlucose.text = [NSString stringWithFormat:@"%.0f mg", minDose];
            self.textFieldGlucoseConc.text = @"10%";
            self.textFieldGlucoseConc.enabled = NO;
            break;
            
        case 2:
            self.doseLabelGlucose.text = @"2 mls/Kg";
            self.textFieldGlucoseConc.text = @"10%";
            self.textFieldGlucoseConc.enabled = NO;
            break;
            
        default:
            break;
    }
    
    thisDrug = 11;
    
    [self.imageSux setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:3]]];
    minMgKg = [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
    maxMgKg = [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    self.titleSux.text = [[sharedInductionName inductionName] objectAtIndex:thisDrug];
    self.textFieldSuxConc.text = [NSString stringWithFormat:@"%.0f",suxConc];
    
    minDose = weight;
    maxDose = weight * 2;
    
    switch (doseType) {
        case 0:
            minVol = (minDose / suxConc);
            maxVol = (maxDose / suxConc);
            self.doseLabelSux.text = [NSString stringWithFormat:@"%.1f - %.1f mls", minVol, maxVol];
            self.labelMgSux.text = @"mg/ml";
            self.labelMgSux.hidden = NO;
            self.textFieldSuxConc.hidden = NO;
            break;
            
        case 1:
            self.doseLabelSux.text = [NSString stringWithFormat:@"%.1f - %.1f mg", minDose, maxDose];
            self.labelMgSux.hidden = YES;
            self.textFieldSuxConc.hidden = YES;
            break;
            
        case 2:
            self.doseLabelSux.text = @"1 - 2 mg/Kg";
            self.labelMgSux.hidden = YES;
            self.textFieldSuxConc.hidden = YES;
            break;
            
        default:
            break;
    }
    
    thisDrug = 19;
    
    [self.imageAtropine setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:9]]];
    minMgKg = [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
    maxMgKg = [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    self.titleAtropine.text = [[sharedInductionName inductionName] objectAtIndex:thisDrug];
    self.textFieldAtropineConc.text = [NSString stringWithFormat:@"%.0f",atropineConc];
    if ([[[sharedInductionIsMaxMin inductionIsMaxMin]objectAtIndex:thisDrug]boolValue] == NO){
        minDose = weight * [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
        maxDose = minDose;
    }
    else{
        minDose = weight * [[[sharedPaedsMin paedsMin]objectAtIndex:thisDrug]floatValue];
        maxDose = weight * [[[sharedPaedsMax paedsMax]objectAtIndex:thisDrug]floatValue];
    }
    if (minDose > [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue]){
        minDose = [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue];
    }
    if (maxDose > [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue]) {
        maxDose = [[[sharedPaedsMaxTotal paedsMaxTotal]objectAtIndex:thisDrug]floatValue];
    }
    switch (doseType) {
        case 0:
            minVol = (minDose / atropineConc);
            maxVol = (maxVol / atropineConc);
            self.doseLabelAtropine.text = [NSString stringWithFormat:@"%.1f mls", minVol];
            
            self.labelMgAtropine.text = @"mcg/ml";
            self.labelMgAtropine.hidden = NO;
            self.textFieldAtropineConc.hidden = NO;
            break;
            
        case 1:
            self.doseLabelAtropine.text = [NSString stringWithFormat:@"%.1f mcg", minDose];
            
            self.labelMgAtropine.hidden = YES;
            self.textFieldAtropineConc.hidden = YES;
            break;
            
        case 2:
            self.doseLabelAtropine.text = @"20 mcg/Kg";
            self.labelMgAtropine.hidden = YES;
            self.textFieldAtropineConc.hidden = YES;
            break;
            
        default:
            break;
    }
    
    
    
    
    if ([[[sharedDrugLabels drugLabels]objectAtIndex:3] isEqualToString: @"Sux.png"]){
        self.titleSux.font = [UIFont boldSystemFontOfSize:16];
        self.titleSux.textColor = [UIColor redColor];
    }
    
    if ([[[sharedDrugLabels drugLabels]objectAtIndex:8] isEqualToString: @"adrenaline.png"]){
        self.titleAdrenaline.font = [UIFont boldSystemFontOfSize:16];
        self.titleAdrenaline.textColor = [UIColor colorWithRed:216.0f/255.0f green:10.0f/255.0f blue:216.0f/255.0f alpha:1.0];
    }
}

float lorazConc = 4;
float glucoseConc = 100;
float adrenalineConc = 100;
float suxConc = 50;
float atropineConc = 600;

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
- (IBAction)segmentedWeight:(id)sender {
    switch (self.segmentedWeight.selectedSegmentIndex)
    {
        case 0:
            weightSelected = 0;
            break;
            
        case 1:
            weightSelected = 1;
            break;
            
        case 2:
            weightSelected = 2;
            
        default:
            break;
            
    }
    [self displayWeight];
    [self wetFlag];
    
    return;
}

- (IBAction)textFieldKgs:(id)sender {
    if ([[_textFieldKg text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        
        [sharedWeight setWeight:[NSNumber numberWithFloat:[_textFieldKg.text floatValue]]];
        [self displayWeight];
        [self wetFlag];
    }
    return;
}

- (IBAction)textFieldLbs:(id)sender {
    if ([[_textFieldLbs text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        
        [sharedWeight setWeight:[NSNumber numberWithFloat:(0.453592 * [_textFieldLbs.text floatValue])]];
        [self displayWeight];
        [self wetFlag];
    }
    return;
}

- (IBAction)textFieldStone:(id)sender {
    if ([[_textFieldStones text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        float subPoundWeight;
        float stoneWeight;
        if ([[_textFieldPounds text] length] != 0)
        {
            subPoundWeight = [_textFieldPounds.text floatValue];
        }
        if ([[_textFieldStones text] length] != 0)
        {
            stoneWeight = [_textFieldStones.text floatValue];
        }
        float poundWeight = (14 * stoneWeight) + subPoundWeight;
        [sharedWeight setWeight:[NSNumber numberWithFloat:((0.453592 * poundWeight) + 0.01)]];
        [self displayWeight];
        [self wetFlag];
    }
    return;
}

- (IBAction)textFieldPounds:(id)sender {
    if ([[_textFieldPounds text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        float subPoundWeight;
        float stoneWeight;
        if ([[_textFieldPounds text] length] != 0)
        {
            subPoundWeight = [_textFieldPounds.text floatValue];
        }
        if ([[_textFieldStones text] length] != 0)
        {
            stoneWeight = [_textFieldStones.text floatValue];
        }
        float poundWeight = (14 * stoneWeight) + subPoundWeight;
        [sharedWeight setWeight:[NSNumber numberWithFloat:((0.453592 * poundWeight)+ 0.01)]];
        [self displayWeight];
        [self wetFlag];
    }
    
    return;
}

- (IBAction)buttonClose:(id)sender {
    CGRect newFrame = _viewPopDown.frame;
    newFrame.origin.y -= 500;
    
    [UIView animateWithDuration:1.0 animations:^{_viewPopDown.frame = newFrame;}];
    
    [self displayWeight];
    [self wetFlag];
    
    [self.buttonClose.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.buttonClose.selected = NO;
}

- (IBAction)buttonDisplayAge:(id)sender {
    CGRect newFrame = _viewPopDown.frame;
    newFrame.origin.y += 500;
    
    [UIView animateWithDuration:1.0 animations:^{_viewPopDown.frame = newFrame;}];
    
    [self.view bringSubviewToFront:_viewPopDown];
    
    [self.buttonDisplayAge.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.buttonDisplayAge.selected = NO;
}

- (IBAction)segmentedCuffed:(id)sender {
    Patient *sharedIsCuffedTube = [Patient sharedIsCuffedTube];
    switch (self.segmentedCuffed.selectedSegmentIndex) {
        case 0:
            [sharedIsCuffedTube setIsCuffedTube:[NSNumber numberWithBool:YES]];
            break;
            
        case 1:
            [sharedIsCuffedTube setIsCuffedTube:[NSNumber numberWithBool:NO]];
            break;
            
        default:
            break;
    }
    
    [self wetFlag];
}

- (IBAction)textFieldTubeSize:(id)sender {
    Patient *sharedTubeSize = [Patient sharedTubeSize];
    [sharedTubeSize setTubeSize:[NSNumber numberWithFloat:[self.textFieldTubeSize.text floatValue]]];
    [self wetFlag];
}

float oralTubeLength;
- (IBAction)textFieldOralLength:(id)sender {
    if ([[_textFieldOralLength text] length] != 0)
    {
        oralTubeLength = [_textFieldOralLength.text floatValue];
        self.textFieldNasalLength.text = @"";
        self.textFieldOralLength.text = [NSString stringWithFormat:@"%.1f", oralTubeLength];
        Patient *sharedTubeLength = [Patient sharedTubeLength];
        Patient *sharedIsNasalTube = [Patient sharedIsNasalTube];
        [sharedIsNasalTube setIsNasalTube:[NSNumber numberWithBool:NO]];
        [sharedTubeLength setTubeLength:[NSNumber numberWithFloat:oralTubeLength]];
    }
    [self wetFlag];
    return;
}

float nasalTubeLength;
- (IBAction)textFieldNasalLength:(id)sender {
    if ([[_textFieldNasalLength text] length] != 0)
    {
        nasalTubeLength = [_textFieldNasalLength.text floatValue];
        self.textFieldOralLength.text = @"";
        self.textFieldNasalLength.text = [NSString stringWithFormat:@"%.1f", nasalTubeLength];
        Patient *sharedTubeLength = [Patient sharedTubeLength];
        Patient *sharedIsNasalTube = [Patient sharedIsNasalTube];
        [sharedIsNasalTube setIsNasalTube:[NSNumber numberWithBool:YES]];
        [sharedTubeLength setTubeLength:[NSNumber numberWithFloat:nasalTubeLength]];
    }
    [self wetFlag];
    return;
}

- (IBAction)segmentedDoseDisplayType:(id)sender {
    doseSelectedType = self.segmentedDoseDisplayType.selectedSegmentIndex;
    
    [self wetFlag];
    
    return;
}

- (IBAction)textFieldLorazepamConc:(id)sender {
    if ([[_textFieldLorazepamConc text]length] != 0){
        lorazConc = [self.textFieldLorazepamConc.text floatValue];
        [self wetFlag];
    }
}

- (IBAction)textFieldAdrenalineMinijetConc:(id)sender {
    if ([[_textFieldAdrenalineConc text]length] != 0){
        adrenalineConc = (1000000/[self.textFieldAdrenalineConc.text floatValue]);
        [self wetFlag];
    }
}

- (IBAction)textFieldAdrenalineConc:(id)sender {
    if ([[_textFieldAdrenalineConc text]length] != 0){
        adrenalineConc = [self.textFieldAdrenalineConc.text floatValue];
        [self wetFlag];
    }
}

- (IBAction)textFieldGlucoseConc:(id)sender {
    if ([[_textFieldGlucoseConc text]length] != 0){
        glucoseConc = [self.textFieldGlucoseConc.text floatValue];
        [self wetFlag];
    }
}

- (IBAction)textFieldAtropineConc:(id)sender {
    if ([[_textFieldAtropineConc text]length] != 0){
        atropineConc = [self.textFieldAtropineConc.text floatValue];
        [self wetFlag];
    }
}

- (IBAction)textFieldSuxConc:(id)sender {
    if ([[_textFieldSuxConc text]length] != 0){
        suxConc = [self.textFieldSuxConc.text floatValue];
        [self wetFlag];
    }
}


@end
