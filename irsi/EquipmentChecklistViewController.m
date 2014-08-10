//
//  EquipmentChecklistViewController.m
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "EquipmentChecklistViewController.h"

@interface EquipmentChecklistViewController (){
    NSMutableArray * equipmentArray;
}

@end

@implementation EquipmentChecklistViewController

// Defines custom strings
NSString * sectionMonitoring;
NSString * sectionBasic;
NSString * sectionRescue;

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
    
    [self populateTable];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewEquipment.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    sectionMonitoring = [dict objectForKey:@"EquipmentMonitoring"];
    sectionBasic = [dict objectForKey:@"EquipmentBasic"];
    sectionRescue = [dict objectForKey:@"EquipmentRescue"];
    
    return;
}

- (void) populateTable{
    equipmentArray = [[NSMutableArray alloc] init];
    
    EventLog *sharedEquipmentTicked = [EventLog sharedEquipmentTicked];
    
    // Loads the arrays from the plist files and adds them to NSArrays to allow display in sections
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Equipment" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSArray *monitoring = [[NSArray alloc] initWithArray:[dict objectForKey:@"Monitoring"]];
    NSArray *basicAirway = [[NSArray alloc] initWithArray:[dict objectForKey:@"BasicAirway"]];
    NSArray *airwayRescue = [[NSArray alloc] initWithArray:[dict objectForKey:@"AirwayRescue"]];
    
    NSDictionary *monitoringDict = [NSDictionary dictionaryWithObject:monitoring forKey:@"data"];
    NSDictionary *basicDict = [NSDictionary dictionaryWithObject:basicAirway forKey:@"data"];
    NSDictionary *rescueDict = [NSDictionary dictionaryWithObject:airwayRescue forKey:@"data"];
    
    [equipmentArray addObject:monitoringDict];
    [equipmentArray addObject:basicDict];
    [equipmentArray addObject:rescueDict];
    
    NSInteger itemsCount = ([monitoring count] + [basicAirway count] + [airwayRescue count]);
    
    // Populates the ticked array if it is blank
    for (NSInteger i = 0; i < itemsCount; i++){
        if ([[sharedEquipmentTicked equipmentTicked] count] < i){
            [[sharedEquipmentTicked equipmentTicked] addObject:[NSNumber numberWithInteger:0]];
        }
    }
    
    return;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [equipmentArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dictionary = [equipmentArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
}

// Defines the section titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return sectionMonitoring;
            break;
            
        case 1:
            return sectionBasic;
            break;
            
        case 2:
            return sectionRescue;
            break;
            
        default:
            return @"";
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventLog *sharedEquipmentTicked = [EventLog sharedEquipmentTicked];
    NSDictionary *dict = [equipmentArray objectAtIndex:indexPath.section];
    NSArray *array = [dict objectForKey:@"data"];
    NSString *cellID = @"ChecklistBasic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    /*
    NSInteger indexSelected;
    NSInteger section0;
    NSInteger section1;
    
    dict = [equipmentArray objectAtIndex:0];
    array = [dict objectForKey:@"data"];
    section0 = [array count];
    
    dict = [equipmentArray objectAtIndex:0];
    array = [dict objectForKey:@"data"];
    section1 = [array count];
    
    switch (indexPath.section) {
        case 0:
            indexSelected = indexPath.row;
            break;
            
        case 1:
            indexSelected = (section0 + indexPath.row);
            break;
            
        case 2:
            indexSelected = (section1 + indexPath.row);
            break;
            
        default:
            break;
    }
    
    switch ([[[sharedEquipmentTicked equipmentTicked]objectAtIndex:indexSelected]integerValue]) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"blankTickBox.png"];
            cell.backgroundColor = [UIColor clearColor];
            break;
            
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"completeTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
            break;
            
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"FailedTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
            break;
            
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"SkipTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:0.4];
            break;
            
        default:
            break;
    }
    */
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventLog *sharedEquipmentTicked = [EventLog sharedEquipmentTicked];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger indexSelected;
    NSInteger section0;
    NSInteger section1;
    
    NSDictionary *dictionary = [equipmentArray objectAtIndex:0];
    NSArray *array = [dictionary objectForKey:@"data"];
    section0 = [array count];
    
    NSDictionary *dic = [equipmentArray objectAtIndex:1];
    NSArray *ar = [dic objectForKey:@"data"];
    section1 = [ar count];

    switch (indexPath.section) {
        case 0:
            indexSelected = indexPath.row;
            break;
            
        case 1:
            indexSelected = (section0 + indexPath.row);
            break;
            
        case 2:
            indexSelected = (section0 + section1 + indexPath.row);
            break;
            
        default:
            break;
    }
    
    if ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:indexSelected] integerValue] == 1)
        
        // Failed/ Unsuccessful State
    {
        [[sharedEquipmentTicked equipmentTicked] replaceObjectAtIndex:indexSelected withObject:@2];
        cell.imageView.image = [UIImage imageNamed:@"FailedTickBox.png"];
        cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
    }
    else if ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:indexSelected] integerValue] == 0)
        
        // Selected State
    {
        [[sharedEquipmentTicked equipmentTicked] replaceObjectAtIndex:indexSelected withObject:@1];
        cell.imageView.image = [UIImage imageNamed:@"completeTickBox.png"];
        cell.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
    }
    else if ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:indexSelected] integerValue] == 2)
        
        // Skipped State
    {
        [[sharedEquipmentTicked equipmentTicked] replaceObjectAtIndex:indexSelected withObject:@3];
        cell.imageView.image = [UIImage imageNamed:@"SkipTickBox.png"];
        cell.backgroundColor = [UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:0.4];
    }
    else if ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:indexSelected] integerValue] == 3)
        
        // Default State
    {
        [[sharedEquipmentTicked equipmentTicked] replaceObjectAtIndex:indexSelected withObject:@0];
        cell.imageView.image = [UIImage imageNamed:@"blankTickBox.png"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [self updateTabColour];
    
    //[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    return;
}

- (void) updateTabColour
{
    EventLog *sharedEquipmentTicked = [EventLog sharedEquipmentTicked];
    EventLog *sharedEquipComplete = [EventLog sharedEquipComplete];
    NSInteger sum = 0;
    NSInteger i = 0;
    NSInteger count = [[sharedEquipmentTicked equipmentTicked] count];
    
    for (i=0; i<count; i++) {
        if ([[[sharedEquipmentTicked equipmentTicked] objectAtIndex:i]integerValue] > 0){sum ++;}
    }
    if (sum == 0){[sharedEquipComplete setEquipComplete:[NSNumber numberWithInt:0]];}
    if ((sum > 0) && (sum < count)){[sharedEquipComplete setEquipComplete:[NSNumber numberWithInt:1]];}
    if (sum == count){[sharedEquipComplete setEquipComplete:[NSNumber numberWithInt:2]];}
    
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
