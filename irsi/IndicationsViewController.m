//
//  IndicationsViewController.m
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "IndicationsViewController.h"

@interface IndicationsViewController ()
{
    NSTimer *closeWindows;
    NSMutableArray *fullArray;
    NSMutableArray *indicationsArray;
    NSMutableArray *indexValue;
    NSArray *subview;
}
@end

@implementation IndicationsViewController

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
    
    [self populateTable];
    
    return;
}

- (void) populateTable{
    EventLog *sharedIndicationChecklist = [EventLog sharedIndicationChecklist];
    EventLog *sharedIndicationTicked = [EventLog sharedIndicationTicked];
    EventLog *sharedIndicationPHEM = [EventLog sharedIndicationPHEM];
    
    // Loads the arrays from the plist files and adds them to NSArrays to allow display in sections
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Indications" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    [sharedIndicationChecklist setIndicationChecklist:[dict objectForKey:@"Items"]];
    [sharedIndicationPHEM setIndicationPHEM:[dict objectForKey:@"PHEM"]];
    subview = [[NSArray alloc]initWithArray:[dict objectForKey:@"Subview"]];
    
    indicationsArray = [[NSMutableArray alloc] init];
    fullArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < [[sharedIndicationChecklist indicationChecklist] count]; i ++){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        [array addObject:[NSNumber numberWithInteger:i]];
        [array addObject:[[sharedIndicationChecklist indicationChecklist]objectAtIndex:i]];
        [array addObject:[[sharedIndicationPHEM indicationPHEM]objectAtIndex:i]];
        [array addObject:[subview objectAtIndex:i]];
        [array addObject:[[sharedIndicationTicked indicationTicked]objectAtIndex:i]];
        
        [fullArray addObject:array];
    }
    
    for (NSInteger p = 0; p < [fullArray count]; p ++){
        EventLog *sharedPreHospital = [EventLog sharedPreHospital];
        bool phem = [[sharedPreHospital preHospital]boolValue];
        
        NSArray * phemArray = [[NSArray alloc] initWithArray:[fullArray objectAtIndex:p]];
        
        if (phem == YES){
            if ([[phemArray objectAtIndex:2]integerValue] <2){
                [indicationsArray addObject:phemArray];
            }
        }
        
        if (phem == NO){
            if ([[phemArray objectAtIndex:2]integerValue] != 1){
                [indicationsArray addObject:phemArray];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [indicationsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [indicationsArray objectAtIndex:indexPath.row];
    
    NSString *cellID = @"ChecklistBasic";
    
    if ([[array objectAtIndex:3]integerValue]>0){cellID = @"ChecklistMoreDetail";}
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [array objectAtIndex:1];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventLog *sharedIndicationTicked = [EventLog sharedIndicationTicked];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableArray *array = [indicationsArray objectAtIndex:indexPath.row];
    NSInteger index = [[array objectAtIndex:0]integerValue];
    NSInteger newValue;
    
    switch ([[array objectAtIndex:4] integerValue]) {
        case 0:
            // Selected State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:1]];
            newValue = 1;
            cell.imageView.image = [UIImage imageNamed:@"completeTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:2]];
            newValue = 2;
            cell.imageView.image = [UIImage imageNamed:@"FailedTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
            break;
            
        case 2:
            // Skipped State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:3]];
            newValue = 3;
            cell.imageView.image = [UIImage imageNamed:@"SkipTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:0.4];
            break;
            
        case 3:
            // Default State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:0]];
            cell.imageView.image = [UIImage imageNamed:@"blankTickBox.png"];
            cell.backgroundColor = [UIColor clearColor];
            newValue = 0;
            break;
            
        default:
            break;
    }
    
    NSMutableArray *update = [[NSMutableArray alloc] initWithArray:array];
    [update replaceObjectAtIndex:4 withObject:[NSNumber numberWithInteger:newValue]];
    [indicationsArray replaceObjectAtIndex:indexPath.row withObject:update];
    
    //[self populateTable];
    
    [self updateTabColour];
    
    return;
}

- (void) updateTabColour
{
    EventLog *sharedIndicationComplete = [EventLog sharedIndicationComplete];
    
    NSInteger sum = 0;
    
    for (NSInteger i=0; i<[indicationsArray count]; i++) {
        NSArray *array = [indicationsArray objectAtIndex:i];
        if ([[array objectAtIndex:4]integerValue] > 0){sum ++;}
    }
    if (sum == 0){[sharedIndicationComplete setIndicationComplete:[NSNumber numberWithInteger:0]];}
    if ((sum > 0) && (sum < [indicationsArray count])){[sharedIndicationComplete setIndicationComplete:[NSNumber numberWithInteger:1]];}
    if (sum == [indicationsArray count]){[sharedIndicationComplete setIndicationComplete:[NSNumber numberWithInteger:2]];}
    
    return;
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [indicationsArray objectAtIndex:indexPath.row];
    
    if ([[array objectAtIndex: 3]integerValue] == 1)
    {
        Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
        [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:YES]];
        
        [UIView animateWithDuration:1.5 animations:^(void){
            _viewAirway.hidden = NO;
            _viewAirway.alpha = 1;
            
            [self.view bringSubviewToFront:_viewAirway];
            
        }];
        
        closeWindows = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(closeAirway) userInfo:nil repeats:YES];
        
        return;
    }
    if ([[array objectAtIndex: 3]integerValue] == 2)
    {
        Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
        [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:YES]];
        
        [UIView animateWithDuration:1.5 animations:^(void){
            
            _viewNODESAT.hidden = NO;
            _viewNODESAT.alpha = 1;
            
            [self.view bringSubviewToFront:_viewNODESAT];
            
        }];
        
        closeWindows = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(closeNODESAT) userInfo:nil repeats:YES];
        return;
    }

    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeAirway
{
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    if ([[sharedAirwayWindowOpen airwayWindowOpen] boolValue] == NO)
    {
        [UIView animateWithDuration:1.5 animations:^(void){
            _viewAirway.hidden = YES;
            _viewAirway.alpha = 0;
        }];
        
        [closeWindows invalidate];
    }
    
    return;
}


- (void) closeNODESAT
{
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    
    if ([[sharedNODESATWindowOpen nodesatWindowOpen] boolValue] == NO)
    {
        
        [UIView animateWithDuration:1.5 animations:^(void){
            _viewNODESAT.hidden = YES;
            _viewNODESAT.alpha = 0;
        }];
        
        [closeWindows invalidate];
    }
    
    return;
}

@end
