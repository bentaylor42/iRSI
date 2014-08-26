//
//  DefaultsViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DefaultsViewController.h"

@interface DefaultsViewController (){
    NSMutableArray *displayNamesArray;
    NSMutableArray *displayLabelArray;
    NSMutableArray *displaySelectedArray;
    NSMutableArray *displayIndexArray;
    NSMutableArray *customLabelDisplayArray;
    
    NSArray *defaultInductionAgent;
    NSArray *defaultRelaxant;
    NSArray *defaultVasopressor;
    NSArray *defaultAntimuscarinic;
    NSArray *defaultSedation;
}

@end

@implementation DefaultsViewController

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
    
    [self loadDefaults];
    [self createKeyboardReturnButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Creates a popup window with a return button for the number pad
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
    _textFieldBeepInterval.inputAccessoryView = toolbar;
    _textFieldFlashInterval.inputAccessoryView = toolbar;
    _textFieldPreO2Max.inputAccessoryView = toolbar;
    _textFieldPreO2Min.inputAccessoryView = toolbar;
    _textFieldRocMax.inputAccessoryView = toolbar;
    _textFieldRocMin.inputAccessoryView = toolbar;
    _textFieldVibrateInterval.inputAccessoryView = toolbar;
    
    return;
}

-(void) dismissKeyboard:(id) sender
{
    if ([_textFieldBeepInterval isFirstResponder]){
        [_textFieldBeepInterval resignFirstResponder];
    }
    if ([_textFieldFlashInterval isFirstResponder]){
        [_textFieldFlashInterval resignFirstResponder];
    }
    if ([_textFieldPreO2Max isFirstResponder]){
        [_textFieldPreO2Max resignFirstResponder];
    }
    if ([_textFieldPreO2Min isFirstResponder]){
        [_textFieldPreO2Min resignFirstResponder];
    }
    if ([_textFieldRocMax isFirstResponder]){
        [_textFieldRocMax resignFirstResponder];
    }
    if ([_textFieldRocMin isFirstResponder]){
        [_textFieldRocMin resignFirstResponder];
    }
    if ([_textFieldVibrateInterval isFirstResponder]){
        [_textFieldVibrateInterval resignFirstResponder];
    }

    return;
}

// minimises keyboard on tapping elsewhere on screen
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_textFieldBeepInterval isFirstResponder] && [touch view] != _textFieldBeepInterval) {
        [_textFieldBeepInterval resignFirstResponder];
    }
    if ([_textFieldFlashInterval isFirstResponder] && [touch view] != _textFieldFlashInterval) {
        [_textFieldFlashInterval resignFirstResponder];
    }
    if ([_textFieldPreO2Max isFirstResponder] && [touch view] != _textFieldPreO2Max) {
        [_textFieldPreO2Max resignFirstResponder];
    }
    if ([_textFieldPreO2Min isFirstResponder] && [touch view] != _textFieldPreO2Min) {
        [_textFieldPreO2Min resignFirstResponder];
    }
    if ([_textFieldRocMax isFirstResponder] && [touch view] != _textFieldRocMax) {
        [_textFieldRocMax resignFirstResponder];
    }
    if ([_textFieldRocMin isFirstResponder] && [touch view] != _textFieldRocMin) {
        [_textFieldRocMin resignFirstResponder];
    }
    if ([_textFieldVibrateInterval isFirstResponder] && [touch view] != _textFieldVibrateInterval) {
        [_textFieldVibrateInterval resignFirstResponder];
    }
    
    return;
}

- (void) loadDefaults
{
    // Synchronises locally saved defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    // Defines variables with default values
    bool phem = NO;
    bool cricoidUsed = YES;
    bool beepOn = YES;
    bool vibrateOn = YES;
    bool flashOn = YES;
    bool preO2Alert = YES;
    bool rocAlert = YES;
    bool periodicAlert = YES;
    NSInteger heightTypeSelected = 0;
    NSInteger weightTypeSelected = 0;
    NSInteger preO2Min = 180;
    NSInteger preO2Max = 300;
    NSInteger rocMin = 60;
    NSInteger rocMax = 120;
    NSInteger drugDisplayTypeSelected = 0;
    NSInteger beepInterval = 30;
    NSInteger vibrateInterval = 30;
    NSInteger flashInterval = 30;
    
    // Loads pre-saved data from NSUserDefaults
    if ([defaults objectForKey:@"PHEM"] != nil){phem = [defaults boolForKey:@"PHEM"];}
    if ([defaults objectForKey:@"heightTypeDefaultSelected"] != nil){heightTypeSelected = [defaults integerForKey:@"heightTypeDefaultSelected"];}
    if ([defaults objectForKey:@"weightTypeDefaultSelected"] != nil){weightTypeSelected = [defaults integerForKey:@"weightTypeDefaultSelected"];}
    if ([defaults objectForKey:@"drugDisplayTypeSelected"] != nil){drugDisplayTypeSelected = [defaults integerForKey:@"drugDisplayTypeSelected"];}
    if ([defaults objectForKey:@"cricoidUsed"] != nil){cricoidUsed = [defaults boolForKey:@"cricoidUsed"];}
    if ([defaults objectForKey:@"preO2Min"] != nil){preO2Min = [defaults integerForKey:@"preO2Min"];}
    if ([defaults objectForKey:@"preO2Max"] != nil){preO2Max = [defaults integerForKey:@"preO2Max"];}
    if ([defaults objectForKey:@"rocMin"] != nil){rocMin = [defaults integerForKey:@"rocMin"];}
    if ([defaults objectForKey:@"rocMax"] != nil){rocMax = [defaults integerForKey:@"rocMax"];}
    
    if ([defaults objectForKey:@"beepOn"] != nil){beepOn = [defaults boolForKey:@"beepOn"];}
    if ([defaults objectForKey:@"vibrateOn"] != nil){vibrateOn = [defaults boolForKey:@"vibrateOn"];}
    if ([defaults objectForKey:@"flashOn"] != nil){flashOn = [defaults boolForKey:@"flashOn"];}
    if ([defaults objectForKey:@"preO2Alert"] != nil){preO2Alert = [defaults boolForKey:@"preO2Alert"];}
    if ([defaults objectForKey:@"rocAlert"] != nil){rocAlert = [defaults boolForKey:@"rocAlert"];}
    if ([defaults objectForKey:@"periodicAlert"] != nil){periodicAlert = [defaults boolForKey:@"periodicAlert"];}
    
    if ([defaults objectForKey:@"beepInterval"] != nil){beepInterval = [defaults integerForKey:@"beepInterval"];}
    if ([defaults objectForKey:@"vibrateInterval"] != nil){vibrateInterval = [defaults integerForKey:@"vibrateInterval"];}
    if ([defaults objectForKey:@"flashInterval"] != nil){flashInterval = [defaults integerForKey:@"flashInterval"];}
    
    if ([defaults objectForKey:@"inductionAgent"] != nil){defaultInductionAgent = [defaults arrayForKey:@"inductionAgent"];}
    if ([defaults objectForKey:@"Relaxant"] != nil){defaultRelaxant = [defaults arrayForKey:@"Relaxant"];}
    if ([defaults objectForKey:@"Vasopressor"] != nil){defaultVasopressor = [defaults arrayForKey:@"Vasopressor"];}
    if ([defaults objectForKey:@"Antimuscarininic"] != nil){defaultAntimuscarinic = [defaults arrayForKey:@"Antimuscarininic"];}
    if ([defaults arrayForKey:@"Sedation"] != nil){defaultSedation = [defaults arrayForKey:@"Sedation"];}
    
    // Defines the variables to singletons - if there is a pre-saved default, then saves it.  Else uses the pre-defined defaults
    EventLog *sharedPreHospital = [EventLog sharedPreHospital];
    
    [sharedPreHospital setPreHospital:[NSNumber numberWithBool:phem]];
    
    // Sets the controls in the desired setting
    self.switchPHEM.on = phem;
    self.switchCricoid.on = cricoidUsed;
    self.segmentedHeight.selectedSegmentIndex = heightTypeSelected;
    self.segmentedWeight.selectedSegmentIndex = weightTypeSelected;
    self.segmentedDrugDoseDisplayType.selectedSegmentIndex = drugDisplayTypeSelected;
    self.textFieldPreO2Min.placeholder = [NSString stringWithFormat:@"%li", ((long)preO2Min/60)];
    self.textFieldPreO2Max.placeholder = [NSString stringWithFormat:@"%li", ((long)preO2Max/60)];
    self.textFieldRocMin.placeholder = [NSString stringWithFormat:@"%li", (long)rocMin];
    self.textFieldRocMax.placeholder = [NSString stringWithFormat:@"%li", (long)rocMax];
    self.switchBeepOn.on = beepOn;
    self.switchFlashOn.on = flashOn;
    self.switchVibrateOn.on = vibrateOn;
    self.switchPreO2Alert.on = preO2Alert;
    self.switchRocAlert.on = rocAlert;
    self.switch30SAlert.on = periodicAlert;
    self.textFieldBeepInterval.placeholder = [NSString stringWithFormat:@"%li", (long)beepInterval];
    self.textFieldFlashInterval.placeholder = [NSString stringWithFormat:@"%li", (long)flashInterval];
    self.textFieldVibrateInterval.placeholder = [NSString stringWithFormat:@"%li", (long)vibrateInterval];
    
    [self loadDrugs];
}

- (void) loadDrugs{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    [self loadDrugLabels];
    Nationalities *sharedDrugLabels = [Nationalities sharedDrugLabels];
    
    if ([defaults objectForKey:@"inductionAgent"] != nil){
        self.labelIA.text = [defaultInductionAgent objectAtIndex:0];
        [self.buttonIA setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:[[defaultInductionAgent objectAtIndex:10]intValue]]] forState:UIControlStateNormal];
    }
    if ([defaults objectForKey:@"inductionAgent"] == nil){
        self.labelIA.text = @"No Default";
        [self.buttonIA setImage:[UIImage imageNamed:@"BlankAgent.png"] forState:UIControlStateNormal];
    }
    
    if ([defaults objectForKey:@"Relaxant"] != nil){
        self.labelRelaxant.text = [defaultRelaxant objectAtIndex:0];
        [self.buttonRelaxant setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:[[defaultRelaxant objectAtIndex:10]intValue]]] forState:UIControlStateNormal];
    }
    if ([defaults objectForKey:@"Relaxant"] == nil){
        self.labelRelaxant.text = @"No Default";
        [self.buttonRelaxant setImage:[UIImage imageNamed:@"BlankAgent.png"] forState:UIControlStateNormal];
    }
    
    if ([defaults objectForKey:@"Vasopressor"] != nil){
        self.labelVasopressor.text = [defaultVasopressor objectAtIndex:0];
        [self.buttonVasopressor setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:[[defaultVasopressor objectAtIndex:10]intValue]]] forState:UIControlStateNormal];
    }
    if ([defaults objectForKey:@"Vasopressor"] == nil){
        self.labelVasopressor.text = @"No Default";
        [self.buttonVasopressor setImage:[UIImage imageNamed:@"BlankAgent.png"] forState:UIControlStateNormal];
    }
    
    if ([defaults objectForKey:@"Antimuscarininic"] != nil){
        self.labelAntimuscarininc.text = [defaultAntimuscarinic objectAtIndex:0];
        [self.buttonAntimuscarininic setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:[[defaultAntimuscarinic objectAtIndex:10]intValue]]] forState:UIControlStateNormal];
    }
    if ([defaults objectForKey:@"Antimuscarininic"] == nil){
        self.labelAntimuscarininc.text = @"No Default";
        [self.buttonAntimuscarininic setImage:[UIImage imageNamed:@"BlankAgent.png"] forState:UIControlStateNormal];
    }
    
    if ([defaults objectForKey:@"Sedation"] != nil){
        self.labelOnogingSedation.text = [defaultSedation objectAtIndex:0];
        [self.buttonOngoingSed setImage:[UIImage imageNamed:[[sharedDrugLabels drugLabels]objectAtIndex:[[defaultSedation objectAtIndex:10]intValue]]] forState:UIControlStateNormal];
    }
    if ([defaults objectForKey:@"Sedation"] == nil){
        self.labelOnogingSedation.text = @"No Default";
        [self.buttonOngoingSed setImage:[UIImage imageNamed:@"BlankAgent.png"] forState:UIControlStateNormal];
    }
    
    // Changes text colour for sux and adrenaline labels
    self.labelRelaxant.font = [UIFont systemFontOfSize:12];
    self.labelRelaxant.textColor = [UIColor blackColor];
    self.labelVasopressor.font = [UIFont systemFontOfSize:12];
    self.labelVasopressor.textColor = [UIColor blackColor];
    
    if ([[[sharedDrugLabels drugLabels]objectAtIndex:[[defaultRelaxant objectAtIndex:10]intValue]] isEqualToString: @"Sux.png"]){
        self.labelRelaxant.font = [UIFont boldSystemFontOfSize:12];
        self.labelRelaxant.textColor = [UIColor redColor];
    }
    
    if ([[[sharedDrugLabels drugLabels]objectAtIndex:[[defaultVasopressor objectAtIndex:10]intValue]] isEqualToString: @"adrenaline.png"]){
        self.labelVasopressor.font = [UIFont boldSystemFontOfSize:12];
        self.labelVasopressor.textColor = [UIColor colorWithRed:216.0f/255.0f green:10.0f/255.0f blue:216.0f/255.0f alpha:1.0];
    }
}

- (IBAction)switchPHEM:(id)sender
{
    bool switchSetting = self.switchPHEM.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"PHEM"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)segmentedHeightTypeSelected:(id)sender
{
    NSInteger selectedSegment = self.segmentedHeight.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: selectedSegment forKey:@"heightTypeDefaultSelected"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)segmentedWeightTypeSelected:(id)sender
{
    NSInteger selectedSegment = self.segmentedWeight.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: selectedSegment forKey:@"weightTypeDefaultSelected"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)segmentedDrugDoseDisplayType:(id)sender
{
    NSInteger selectedSegment = self.segmentedDrugDoseDisplayType.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: selectedSegment forKey:@"drugDisplayTypeSelected"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)switchCricoid:(id)sender{
    bool switchSetting = self.switchCricoid.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"cricoidUsed"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)textFieldPreO2Min:(id)sender{
    {
        float textfield = ([[self textFieldPreO2Min].text floatValue]*60);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"preO2Min"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldPreO2Max:(id)sender{
    {
        float textfield = ([[self textFieldPreO2Max].text floatValue]*60);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"preO2Max"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldRocMin:(id)sender{
    {
        float textfield = [[self textFieldRocMin].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"rocMin"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldRocMax:(id)sender{
    {
        float textfield = [[self textFieldRocMax].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"rocMax"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)switchBeepOn :(id)sender{
    bool switchSetting = self.switchBeepOn.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"beepOn"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchVibrateOn:(id)sender{
    bool switchSetting = self.switchVibrateOn.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"vibrateOn"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchFlashOn:(id)sender{
    bool switchSetting = self.switchFlashOn.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"flashOn"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchPreO2Alert:(id)sender{
    bool switchSetting = self.switchPreO2Alert.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"preO2Alert"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchRocAlert:(id)sender{
    bool switchSetting = self.switchRocAlert.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"rocAlert"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switch30sAlert:(id)sender{
    bool switchSetting = self.switch30SAlert.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"periodicAlert"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)textFieldBeepInterval:(id)sender{
    {
        float textfield = [[self textFieldBeepInterval].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"beepInterval"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldFlashInterval:(id)sender{
    {
        float textfield = [[self textFieldFlashInterval].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"flashInterval"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldVibrateInterval:(id)sender{
    {
        float textfield = [[self textFieldVibrateInterval].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"vibrateInterval"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

NSInteger openSection = 0;
bool vasopressor = NO;
bool antimuscarininic = NO;

- (IBAction)buttonIA:(id)sender {
    self.viewDrugChoice.hidden = NO;
    self.viewDrugChoice.alpha = 1;
    openSection = 0;
    [self loadDrugLabels];
    [self populateTable];
}
- (IBAction)buttonRelaxant:(id)sender {
    self.viewDrugChoice.hidden = NO;
    self.viewDrugChoice.alpha = 1;
    openSection = 1;
    [self loadDrugLabels];
    [self populateTable];
}
- (IBAction)buttonVasopressor:(id)sender {
    self.viewDrugChoice.hidden = NO;
    self.viewDrugChoice.alpha = 1;
    openSection = 3;
    vasopressor = YES;
    [self loadDrugLabels];
    [self populateTable];
}
- (IBAction)buttonAntimuscarininic:(id)sender {
    self.viewDrugChoice.hidden = NO;
    self.viewDrugChoice.alpha = 1;
    openSection = 3;
    antimuscarininic = YES;
    [self loadDrugLabels];
    [self populateTable];
}
- (IBAction)buttonOngoingSedation:(id)sender {
    self.viewDrugChoice.hidden = NO;
    self.viewDrugChoice.alpha = 1;
    openSection = 5;
    [self loadDrugLabels];
    [self populateTable];
}

- (IBAction)buttonClose:(id)sender {
    self.viewDrugChoice.hidden = YES;
    self.viewDrugChoice.alpha = 0;
    vasopressor = NO;
    antimuscarininic = NO;
}

- (void) loadDrugLabels
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
    
    // Initialises the display array
    displayNamesArray = [[NSMutableArray alloc] init];
    displayLabelArray = [[NSMutableArray alloc] init];
    displayIndexArray = [[NSMutableArray alloc] init];
    customLabelDisplayArray = [[NSMutableArray alloc] init];
    
    // Goes through the entire drug database and populates an array
    NSInteger i = 0;
    for (i = 0; i < [sharedInductionClass inductionClass].count; i++)
    {
                if ([[sharedManualDose manualDose] count] <= i){[[sharedManualDose manualDose] addObject:[NSNumber numberWithInt:0]];}
                
                if (([[[sharedInductionClass inductionClass]objectAtIndex:i]integerValue] == openSection) && ((openSection != 3) || ((vasopressor == YES) && ([[[sharedIsVasopressor isVasopressor]objectAtIndex:i]intValue] == 1)) || ((antimuscarininic == YES) && ([[[sharedIsVasopressor isVasopressor]objectAtIndex:i]intValue] == 2))))
                {
                    [displayNamesArray addObject:[[sharedInductionName inductionName] objectAtIndex:i]];
                    NSInteger label = [[[sharedInductionLabelType inductionLabelType] objectAtIndex:i] integerValue];
                    [customLabelDisplayArray addObject:[NSNumber numberWithInteger:label]];
                    [displayLabelArray addObject:[[sharedDrugLabels drugLabels] objectAtIndex:label]];
                    [displayIndexArray addObject:[NSNumber numberWithInteger:i]];
                }
    }
    if ([displayNamesArray containsObject:@"No Default"]){
        NSInteger index = [displayNamesArray indexOfObject:@"No Default"];
        [displayNamesArray removeObjectAtIndex:index];
        [displayIndexArray removeObjectAtIndex:index];
    }
    [displayNamesArray addObject:@"No Default"];
    [displayIndexArray addObject:[NSNumber numberWithInteger:1000]];
    
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
    if ([[displayNamesArray objectAtIndex:indexPath.row] isEqualToString:@"No Default"]){
        [drugLabel setImage:[UIImage imageNamed:@"BlankAgent.png"]];
        label = 0;
        drugName.font = [UIFont systemFontOfSize:12];
        drugName.textColor = [UIColor blackColor];
    }
    else{
        [drugLabel setImage:[UIImage imageNamed:[displayLabelArray objectAtIndex:indexPath.row]]];
        label = [[customLabelDisplayArray objectAtIndex:indexPath.row]integerValue];
        drugName.font = [UIFont systemFontOfSize:12];
        drugName.textColor = [UIColor blackColor];
        
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
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath

// - (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Loads singletons
    
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
    
    // If row is not yet selected, adds it to the database
    NSInteger selectedIndex = [[displayIndexArray objectAtIndex:indexPath.row]integerValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (selectedIndex != 1000) {
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
    
    
        switch (openSection) {
            case 0:
                [defaults setObject:array forKey:@"inductionAgent"];
                defaultInductionAgent = array;
                break;
                
            case 1:
                [defaults setObject:array forKey:@"Relaxant"];
                defaultRelaxant = array;
                break;

            case 3:
                if ([[array objectAtIndex:11]intValue] == 1){[defaults setObject:array forKey:@"Vasopressor"];
                    defaultVasopressor = array;}
                if ([[array objectAtIndex:11]intValue] == 2){[defaults setObject:array forKey:@"Antimuscarininic"];
                    defaultAntimuscarinic = array;}
                break;
                
            case 5:
                [defaults setObject:array forKey:@"Sedation"];
                defaultSedation = array;
                break;
                
                
            default:
                break;
        }
    }
    
    else {
        switch (openSection) {
            case 0:
                [defaults removeObjectForKey:@"inductionAgent"];
                break;
                
            case 1:
                [defaults removeObjectForKey:@"Relaxant"];
                break;
                
            case 3:
                if (vasopressor == YES){[defaults removeObjectForKey:@"Vasopressor"];}
                if (antimuscarininic == YES){[defaults removeObjectForKey:@"Antimuscarininic"];}
                break;
                
            case 5:
                [defaults removeObjectForKey:@"Sedation"];
                break;
                
                
            default:
                break;
        }
    }
    
    [defaults synchronize];
    [self loadDrugs];
    
    self.viewDrugChoice.hidden = YES;
    self.viewDrugChoice.alpha = 0;
    vasopressor = NO;
    antimuscarininic = NO;
    
    return;
}

@end
