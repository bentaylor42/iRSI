//
//  RSINowViewController.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "RSINowViewController.h"

@interface RSINowViewController ()
{
    NSArray *pageListingRSI;
}

@end

@implementation RSINowViewController

// Declaring local variables
bool demographicsDown = NO;
NSInteger pageNumberRSI = 1;
NSTimer *tabUpdate;
NSTimer * updateVT;

// Declares the strings used on this page
NSString * back;
NSString * forward;
NSString * indications;
NSString * drugs;
NSString * equipment;
NSString * team;
NSString * final;
NSString * startRSI;
NSString * moveOn;
NSString * weightDisplayStatement;
NSString * male;
NSString * female;
NSString * adult;
NSString * child;
NSString * displayVT;
NSString * sourceVTestimate;
NSString * sourceVTentered;
NSString * sourceVTIBW;

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
    
    [self updateNavigation];
    
    self.scrollview.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewIndications.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewDrugs.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewEquipment.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewTeam.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewFinal.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewScroll.translatesAutoresizingMaskIntoConstraints = NO;
    
    tabUpdate = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkTabColour) userInfo:nil repeats:YES];
    
    [self checkUpdates];
    
    updateVT = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkUpdates) userInfo:nil repeats:YES];
    
    [self loadVT];
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    back = [dict objectForKey:@"Back"];
    forward = [dict objectForKey:@"Forward"];
    indications = [dict objectForKey:@"Indications"];
    drugs = [dict objectForKey:@"Drugs"];
    equipment = [dict objectForKey:@"Equipment"];
    team = [dict objectForKey:@"Team"];
    final = [dict objectForKey:@"Final"];
    moveOn = [dict objectForKey:@"MoveOn"];
    weightDisplayStatement = [dict objectForKey:@"WeightDisplayStatement"];
    male = [dict objectForKey:@"Male"];
    female = [dict objectForKey:@"Female"];
    adult = [dict objectForKey:@"Adult"];
    child = [dict objectForKey:@"Child"];
    startRSI = [dict objectForKey:@"StartRSI"];
    displayVT = [dict objectForKey:@"VTDisplay"];
    sourceVTestimate = [dict objectForKey:@"VTSourceEstWt"];
    sourceVTentered = [dict objectForKey:@"VTSourceTotalWt"];
    sourceVTIBW = [dict objectForKey:@"VTSourceIBW"];
    
    pageListingRSI = @[back, indications, drugs, equipment, team, final, startRSI];
    
    self.labelMoveOn.text = moveOn;
}

- (void) checkUpdates{
    Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
    if ([[sharedDemographicsOpen demographicsOpen]boolValue] == YES){
        [self loadVT];
    }
    return;
}

- (void) loadVT{
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    Patient *sharedWeight = [Patient sharedWeight];
    
    float weight;
    NSInteger vT6Kg;
    NSInteger vT8Kg;
    
    if ([[sharedIbwKnown ibwKnown]boolValue] == YES){
        self.labelWeightSource.text = sourceVTIBW;
        weight = [[sharedIdealBodyWeight idealBodyWeight] floatValue];
    }
    
    else if ([[sharedWeightKnown weightKnown] boolValue] == YES){
        self.labelWeightSource.text = sourceVTentered;
        weight = [[sharedWeight weight] floatValue];
    }
    
    else if ([[sharedWeightKnown weightKnown] boolValue] == NO){
        self.labelWeightSource.text = sourceVTestimate;
        weight = [[sharedWeight weight]floatValue];
    }
    
    vT6Kg = (weight * 6);
    vT8Kg = (weight * 8);
    
    self.labelDisplayVT.text = [NSString stringWithFormat:displayVT,vT6Kg, vT8Kg];
    
    return;
}

- (IBAction)buttonClose:(id)sender{
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedWeight = [Patient sharedWeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    NSString *gender;
    if ([[sharedIsFemale isFemale] boolValue] == YES){gender = female;}
    if ([[sharedIsFemale isFemale] boolValue] == NO){gender = male;}
    NSString *adultAge;
    if ([[sharedIsAdult isAdult] boolValue] == YES){adultAge = adult;}
    if ([[sharedIsAdult isAdult] boolValue] == NO){adultAge = child;}
    
    _labelDisplayWeight.text = [NSString stringWithFormat:weightDisplayStatement, [[sharedWeight weight] intValue], gender, adultAge];
    
    CGRect newFrame = _demographicsDropDown.frame;
    newFrame.origin.y -= 500;
    
    [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
    
    demographicsDown = NO;
    
    Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
    [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:NO]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDropDemographics:(id)sender
{
    CGRect newFrame = _demographicsDropDown.frame;
    newFrame.origin.y += 500;
    
    [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
    demographicsDown = YES;
    
    Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
    [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:YES]];
}

- (IBAction)swipeUp:(id)sender {
    if (demographicsDown == YES)
    {
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedIsFemale = [Patient sharedIsFemale];
        NSString *gender;
        if ([[sharedIsFemale isFemale] boolValue] == YES){gender = female;}
        if ([[sharedIsFemale isFemale] boolValue] == NO){gender = male;}
        NSString *adultAge;
        if ([[sharedIsAdult isAdult] boolValue] == YES){adultAge = adult;}
        if ([[sharedIsAdult isAdult] boolValue] == NO){adultAge = child;}
        
        _labelDisplayWeight.text = [NSString stringWithFormat:weightDisplayStatement, [[sharedWeight weight] intValue], gender, adultAge];
        
        CGRect newFrame = _demographicsDropDown.frame;
        newFrame.origin.y -= 500;
        
        [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
        
        demographicsDown = NO;
        
        Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
        [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:NO]];
    }
    return;
}

- (IBAction)panDemographics:(id)sender {
    if (demographicsDown == NO)
    {
        CGRect newFrame = _demographicsDropDown.frame;
        newFrame.origin.y += 500;
        
        [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
        demographicsDown = YES;
        
        Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
        [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:YES]];
    }
    return;
}

- (void) updateNavigation
{
    NSInteger backNumber = pageNumberRSI -1;
    NSInteger forwardNumber = pageNumberRSI +1;
    NSString *backLabel = [pageListingRSI objectAtIndex:backNumber];
    NSString *forwardLabel = [pageListingRSI objectAtIndex:forwardNumber];
    NSString *now = [pageListingRSI objectAtIndex:pageNumberRSI];
    _labelBack.text = [NSString stringWithFormat:@"< %@", backLabel];
    _labelForward.text = [NSString stringWithFormat:@"%@ >", forwardLabel];
    _labelPageTitle.text = now;
    
    [self updatePage];
    [self updateTabs];
    
    if (pageNumberRSI <5){self.labelMoveOn.text = moveOn;}
    if (pageNumberRSI == 5){self.labelMoveOn.text = startRSI;}
    
    return;
}

- (IBAction)buttonBack:(id)sender {
   
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    
    if (([[sharedNODESATWindowOpen nodesatWindowOpen] boolValue] == NO) && ([[sharedAirwayWindowOpen airwayWindowOpen] boolValue] == NO))
    {
        if (pageNumberRSI == 1){[self performSegueWithIdentifier:@"segueRSItoHome" sender:self];}
        if (pageNumberRSI >1)
        {
            pageNumberRSI --;
            [self updateNavigation];
        }
        if (pageNumberRSI <1){pageNumberRSI = 1; [self updateNavigation];}
    }
    
    if ([[sharedAirwayWindowOpen airwayWindowOpen] boolValue] == YES)
    {
        [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    }
    
    if ([[sharedNODESATWindowOpen nodesatWindowOpen] boolValue] == YES)
    {
        [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    }
    
    return;
}

- (IBAction)buttonForward:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    if (pageNumberRSI == 5){[self performSegueWithIdentifier:@"segueRSItoRoc" sender:self];}
    if (pageNumberRSI <5)
    {
        pageNumberRSI ++;
        [self updateNavigation];
    }
    if (pageNumberRSI >5){pageNumberRSI = 5; [self updateNavigation];}
    
    return;
}
- (IBAction)swipeRight:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    if (pageNumberRSI == 1){[self performSegueWithIdentifier:@"segueRSItoHome" sender:self];}
    if (pageNumberRSI >1)
    {
        pageNumberRSI --;
        [self updateNavigation];
    }
    if (pageNumberRSI <1){pageNumberRSI = 1; [self updateNavigation];}
    
    return;
}

- (IBAction)swipeLeft:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    if (pageNumberRSI == 5){[self performSegueWithIdentifier:@"segueRSItoRoc" sender:self];}
    if (pageNumberRSI <5)
    {
        pageNumberRSI ++;
        [self updateNavigation];
    }
    if (pageNumberRSI >5){pageNumberRSI = 5; [self updateNavigation];}
    
    return;
}

- (void) updatePage
{
    self.viewIndications.hidden = YES;
    self.viewDrugs.hidden = YES;
    self.viewEquipment.hidden = YES;
    self.viewTeam.hidden = YES;
    self.viewFinal.hidden = YES;
    self.viewScroll.hidden = YES;
    
    switch (pageNumberRSI) {
        case 1:
            self.viewIndications.hidden = NO;
            self.viewScroll.hidden = NO;
            break;
            
        case 2:
            self.viewDrugs.hidden = NO;
            break;
            
        case 3:
            self.viewEquipment.hidden = NO;
            self.viewScroll.hidden = NO;
            break;
            
        case 4:
            self.viewTeam.hidden = NO;
            self.viewScroll.hidden = NO;
            break;
            
        case 5:
            self.viewFinal.hidden = NO;
            self.viewScroll.hidden = NO;
            break;
            
        default:
            break;
    }
    
    return;
}
- (IBAction)buttonMoveOn:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    if (pageNumberRSI == 5){[self performSegueWithIdentifier:@"segueRSItoRoc" sender:self];}
    if (pageNumberRSI <5)
    {
        pageNumberRSI ++;
        [self updateNavigation];
    }
    if (pageNumberRSI >5){pageNumberRSI = 5; [self updateNavigation];}
    
    return;
}

- (IBAction)buttonTabIndications:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 1;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabDrugs:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 2;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabEquipment:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 3;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabTeam:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 4;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabFinal:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 5;
    
    [self updateNavigation];
    
    return;
}

- (void) updateTabs
{
    self.buttonTabDrugs.selected = NO;
    self.buttonTabEquipmet.selected = NO;
    self.buttonTabFinal.selected = NO;
    self.buttonTabIndications.selected = NO;
    self.buttonTabTeam.selected = NO;
    
    self.buttonTabDrugs.highlighted = NO;
    self.buttonTabEquipmet.highlighted = NO;
    self.buttonTabFinal.highlighted = NO;
    self.buttonTabIndications.highlighted = NO;
    self.buttonTabTeam.highlighted = NO;
    
    switch (pageNumberRSI) {
        case 1:
            self.buttonTabIndications.selected = YES;
            break;
            
        case 2:
            self.buttonTabDrugs.selected = YES;
            break;
            
        case 3:
            self.buttonTabEquipmet.selected = YES;
            break;
            
        case 4:
            self.buttonTabTeam.selected = YES;
            break;
            
        case 5:
            self.buttonTabFinal.selected = YES;
            break;
            
        default:
            break;
    }
    
    [self checkTabColour];
    
    return;
}

- (void) checkTabColour
{
    EventLog *sharedIndicationComplete = [EventLog sharedIndicationComplete];
    EventLog *sharedDrugsComplete = [EventLog sharedDrugsComplete];
    EventLog *sharedEquipComplete = [EventLog sharedEquipComplete];
    EventLog *sharedTeamComplete = [EventLog sharedTeamComplete];
    EventLog *sharedFinalComplete = [EventLog sharedFinalComplete];
    
    switch ([[sharedIndicationComplete indicationComplete] integerValue]) {
        case 0:
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"redIndicationsTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"redIndicationsTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"amberIndicationsTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"amberIndicationsTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"greenIndicationsTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"greenIndicationsTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedDrugsComplete drugsComplete] integerValue]) {
        case 0:
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"redDrugTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"redDrugTabSelected.png"] forState:UIControlStateSelected];

            break;
            
        case 1:
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"amberDrugTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"amberDrugTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"greenDrugTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"greenDrugTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedEquipComplete equipComplete] integerValue]) {
        case 0:
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"redEquipmentTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"redEquipmentTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"amberEquipmentTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"amberEquipmentTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"greenEquipmentTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"greenEquipmentTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedTeamComplete teamComplete] integerValue]) {
        case 0:
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"redTeamTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"redTeamTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"amberTeamTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"amberTeamTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"greenTeamTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"greenTeamTabSelected"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedFinalComplete finalComplete] integerValue]) {
        case 0:
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"redFinalTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"redFinalTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"amberFinalTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"amberFinalTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"greenFinalTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"greenFinalTabSelected"] forState:UIControlStateSelected];
            break;
        default:
            break;
    }
    return;
}

@end
