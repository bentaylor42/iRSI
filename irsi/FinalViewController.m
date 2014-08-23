//
//  FinalViewController.m
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "FinalViewController.h"

@interface FinalViewController (){
    NSMutableArray * finalArray;
}
@end

@implementation FinalViewController

bool usingCricoid = YES;

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
    
    [self loadCricoid];
    [self populateTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) populateTable {
    EventLog *sharedFinalTicked = [EventLog sharedFinalTicked];
    EventLog *sharedFinalChecklist = [EventLog sharedFinalChecklist];
    EventLog *sharedFinalCricoid = [EventLog sharedFinalCricoid];
    
    finalArray = [[NSMutableArray alloc]init];
    
    // Loads the arrays from the plist files and adds them to NSArrays to allow display in sections
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FinalChecklist" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    [sharedFinalChecklist setFinalChecklist:[dict objectForKey:@"Items"]];
    [sharedFinalCricoid setFinalCricoid:[dict objectForKey:@"Cricoid"]];
    
    for (NSInteger i=0; i < [[sharedFinalChecklist finalChecklist] count]; i++){
        if ([[[sharedFinalCricoid finalCricoid]objectAtIndex:i]boolValue] ==  NO){
            NSMutableArray *array = [[NSMutableArray alloc]init];
            [array addObject:[NSNumber numberWithInteger:i]];
            [array addObject:[[sharedFinalChecklist finalChecklist]objectAtIndex:i]];
            [array addObject:[[sharedFinalTicked finalTicked]objectAtIndex:i]];
            [finalArray addObject:array];
        }
        if (([[[sharedFinalCricoid finalCricoid]objectAtIndex:i]boolValue] ==  YES) && (usingCricoid == YES)){
            NSMutableArray *array = [[NSMutableArray alloc]init];
            [array addObject:[NSNumber numberWithInteger:i]];
            [array addObject:[[sharedFinalChecklist finalChecklist]objectAtIndex:i]];
            [array addObject:[[sharedFinalTicked finalTicked]objectAtIndex:i]];
            [finalArray addObject:array];
        }
        else {[[sharedFinalTicked finalTicked]replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:3]];}
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [finalArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [finalArray objectAtIndex:indexPath.row];
    NSString *cellID = @"ChecklistBasic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [array objectAtIndex:1];
    switch ([[array objectAtIndex:2] integerValue]) {
        case 1:
            // Selected State
            cell.imageView.image = [UIImage imageNamed:@"completeTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
            break;
            
        case 2:
            // Failed/ Unsuccessful State
            cell.imageView.image = [UIImage imageNamed:@"FailedTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
            break;
            
        case 3:
            // Skipped State
            cell.imageView.image = [UIImage imageNamed:@"SkipTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:0.4];
            break;
            
        case 0:
            // Default State
            cell.imageView.image = [UIImage imageNamed:@"blankTickBox.png"];
            cell.backgroundColor = [UIColor clearColor];
            break;
            
        default:
            break;
    }
    return cell;
}

- (void) loadCricoid{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if ([defaults objectForKey:@"cricoidUsed"] != nil){usingCricoid = [defaults boolForKey:@"cricoidUsed"];}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventLog *sharedFinalTicked = [EventLog sharedFinalTicked];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableArray *array = [finalArray objectAtIndex:indexPath.row];
    NSInteger index = [[array objectAtIndex:0]integerValue];
    NSInteger newValue;
    
    switch ([[array objectAtIndex:2] integerValue]) {
        case 0:
            // Selected State
            [[sharedFinalTicked finalTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:1]];
            newValue = 1;
            cell.imageView.image = [UIImage imageNamed:@"completeTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedFinalTicked finalTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:2]];
            newValue = 2;
            cell.imageView.image = [UIImage imageNamed:@"FailedTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
            break;
            
        case 2:
            // Skipped State
            [[sharedFinalTicked finalTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:3]];
            newValue = 3;
            cell.imageView.image = [UIImage imageNamed:@"SkipTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:0.4];
            break;
            
        case 3:
            // Default State
            [[sharedFinalTicked finalTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:0]];
            cell.imageView.image = [UIImage imageNamed:@"blankTickBox.png"];
            cell.backgroundColor = [UIColor clearColor];
            newValue = 0;
            break;
            
        default:
            break;
    }
    
    NSMutableArray *update = [[NSMutableArray alloc] initWithArray:array];
    [update replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:newValue]];
    [finalArray replaceObjectAtIndex:indexPath.row withObject:update];
    
    [self updateTabColour];
    
    return;
}

- (void) updateTabColour
{
    EventLog *sharedFinalComplete = [EventLog sharedFinalComplete];
    
    NSInteger sum = 0;
    
    for (NSInteger i=0; i<[finalArray count]; i++) {
        NSArray *array = [finalArray objectAtIndex:i];
        if ([[array objectAtIndex:2]integerValue] > 0){sum ++;}
    }
    if (sum == 0){[sharedFinalComplete setFinalComplete:[NSNumber numberWithInteger:0]];}
    if ((sum > 0) && (sum < [finalArray count])){[sharedFinalComplete setFinalComplete:[NSNumber numberWithInteger:1]];}
    if (sum == [finalArray count]){[sharedFinalComplete setFinalComplete:[NSNumber numberWithInteger:2]];}
    
    return;
}


@end
