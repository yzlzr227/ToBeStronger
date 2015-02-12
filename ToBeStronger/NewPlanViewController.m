//
//  NewPlanViewController.m
//  ToBeStronger
//
//  Created by Zhang Boxuan on 14-3-12.
//  Copyright (c) 2014年 Boxuan Zhang. All rights reserved.
//

#import "NewPlanViewController.h"

@interface NewPlanViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_position;
@property (weak, nonatomic) IBOutlet UITextField *tf_content;
@property (weak, nonatomic) IBOutlet UITextField *tf_sets;
@property (weak, nonatomic) IBOutlet UITextField *tf_numPerSet;
@property (weak, nonatomic) IBOutlet UITextField *tf_weight;
@property (weak, nonatomic) IBOutlet UITextField *tf_startDate;
@property (weak, nonatomic) IBOutlet UITextField *tf_frequency;
@property (weak, nonatomic) IBOutlet UITextField *tf_countingMethod;
@property (weak, nonatomic) IBOutlet UITextField *tf_duration;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker_startDate;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView_frequency;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView_countingMethod;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView_position;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolBar_datePicker;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolBar_frequencyPicker;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolBar_countingMethodPicker;
@property (strong, nonatomic) IBOutlet UIToolbar *doneToolBar_positionPicker;

@property (strong, nonatomic) NSString *planDate;
@property (strong, nonatomic) NSArray *frequencyPickerArray;
@property (strong, nonatomic) NSArray *countingMethodPickerArray;
@property (strong, nonatomic) NSArray *positionPickerArray;
@property (strong, nonatomic) NSArray *positionPickerEngArray;


@property (strong, nonatomic) Plan *planToAdd;

@end

@implementation NewPlanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setTextfieldsDelegates];
//    [self createDatePicker];
//    [self createPickerViewForFrequencyInput];
//    [self createPickerViewForCountingMethodInput];
//    [self createPickerViewForPositionInput];
    
    self.planToAdd = [[Plan alloc] init];
    
}

- (void)setTextfieldsDelegates
{
    self.tf_content.delegate = self;
    self.tf_position.delegate = self;
    self.tf_sets.delegate = self;
    self.tf_numPerSet.delegate = self;
    self.tf_frequency.delegate = self;
    self.tf_duration.delegate = self;
    self.tf_countingMethod.delegate = self;
    self.tf_startDate.delegate = self;

    self.tf_weight.delegate = self;
    self.tf_weight.clearsOnBeginEditing = YES;
    
    self.tf_duration.clearsOnBeginEditing = YES;
}

//using UIPickerView to input
- (void)createPickerViewForPositionInput
{
    //Create UIPickerView
    self.pickerView_position = [[UIPickerView alloc] initWithFrame:CGRectMake(100, 250, 200, 100)];
    
    [self.pickerView_position reloadAllComponents];
    [self.view addSubview:self.pickerView_position];
    
    //Internationalization Strings
    NSString *iShoulders = [[NSString alloc] initWithFormat:NSLocalizedString(@"Shoulders", @"Posiiont - Shoulders")];
    NSString *iChest = [[NSString alloc] initWithFormat:NSLocalizedString(@"Chest", @"Posiiont - Chest")];
    NSString *iArms = [[NSString alloc] initWithFormat:NSLocalizedString(@"Arms", @"Posiiont - Arms")];
    NSString *iCore = [[NSString alloc] initWithFormat:NSLocalizedString(@"Core", @"Posiiont - Core")];
    NSString *iLegs = [[NSString alloc] initWithFormat:NSLocalizedString(@"Legs", @"Posiiont - Legs")];
    NSString *iOther = [[NSString alloc] initWithFormat:NSLocalizedString(@"Other", @"Posiiont - Other")];
    
    self.positionPickerEngArray = [NSArray arrayWithObjects:@"Shoulders", @"Chest", @"Arms", @"Core", @"Legs", @"Other", nil];
    self.positionPickerArray = [NSArray arrayWithObjects:iShoulders, iChest, iArms, iCore, iLegs, iOther, nil];
    
    self.tf_position.inputView = self.pickerView_position;
    self.pickerView_position.delegate = self;
    self.pickerView_position.dataSource = self;
    self.pickerView_position.frame = CGRectMake(0, 480, 320, 216);
    
    //create UIToolBar
    self.doneToolBar_positionPicker = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    // add done button
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                           action:@selector(donePositionPicker)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:self
                                                                           action:nil];
    self.doneToolBar_positionPicker.items = [NSArray arrayWithObjects:space, right, nil];
    //Set tf_startDate's inputAccessoryView to doneToolBar
    self.tf_position.inputAccessoryView = self.doneToolBar_positionPicker;
    
}


//using UIPickerView to input frequency
- (void)createPickerViewForFrequencyInput
{
    self.tf_frequency.delegate = self;
    
    //Create UIPickerView
    self.pickerView_frequency = [[UIPickerView alloc] initWithFrame:CGRectMake(100, 250, 200, 100)];
    
    [self.pickerView_frequency reloadAllComponents];
    [self.view addSubview:self.pickerView_frequency];
    
    //Internationalization Strings
    NSString *iEvery1Day = [NSString stringWithFormat:NSLocalizedString(@"every 1 day", @"every 1 day")];
    NSString *iEvery2Day = [NSString stringWithFormat:NSLocalizedString(@"every 2 day", @"every 2 day")];
    NSString *iEvery3Day = [NSString stringWithFormat:NSLocalizedString(@"every 3 day", @"every 3 day")];
    NSString *iEvery4Day = [NSString stringWithFormat:NSLocalizedString(@"every 4 day", @"every 4 day")];
    NSString *iEvery5Day = [NSString stringWithFormat:NSLocalizedString(@"every 5 day", @"every 5 day")];
    NSString *iEvery6Day = [NSString stringWithFormat:NSLocalizedString(@"every 6 day", @"every 6 day")];
    
//    self.frequencyPickerArray = [NSArray arrayWithObjects:@"every 1 day ", @"every 2 days", @"every 3 days", @"every 4 days", @"every 5 days", @"every 6 days", nil];
    self.frequencyPickerArray = [NSArray arrayWithObjects:iEvery1Day, iEvery2Day, iEvery3Day, iEvery4Day, iEvery5Day, iEvery6Day, nil];
    
    self.tf_frequency.inputView = self.pickerView_frequency;
    self.pickerView_frequency.delegate = self;
    self.pickerView_frequency.dataSource = self;
    self.pickerView_frequency.frame = CGRectMake(0, 480, 320, 216);
    
    //create UIToolBar
    self.doneToolBar_frequencyPicker = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    // add done button
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                           action:@selector(doneFrequencyPicker)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:self
                                                                           action:nil];
    self.doneToolBar_frequencyPicker.items = [NSArray arrayWithObjects:space, right, nil];
    //Set tf_startDate's inputAccessoryView to doneToolBar
    self.tf_frequency.inputAccessoryView = self.doneToolBar_frequencyPicker;

}

//using UIPickerView to input counting Method
- (void)createPickerViewForCountingMethodInput
{
    self.tf_countingMethod.delegate = self;
    
    //Create UIPickerView
    self.pickerView_countingMethod = [[UIPickerView alloc] initWithFrame:CGRectMake(100, 250, 200, 100)];
    
    [self.pickerView_countingMethod reloadAllComponents];
    [self.view addSubview:self.pickerView_countingMethod];
    
    //Internaionalization Strings
    NSString *iAccelorometer = [NSString stringWithFormat:NSLocalizedString(@"Accelorometer", @"Counting Method - Accelorometer")];
    NSString *iTouch = [NSString stringWithFormat:NSLocalizedString(@"Touch", @"Counting Method - Touch")];
    
//    self.countingMethodPickerArray = [NSArray arrayWithObjects:@"Accelorometer", @"Touch", nil];
    self.countingMethodPickerArray = [NSArray arrayWithObjects:iAccelorometer, iTouch, nil];
    
    self.tf_countingMethod.inputView = self.pickerView_countingMethod;
    self.pickerView_countingMethod.delegate = self;
    self.pickerView_countingMethod.dataSource = self;
    self.pickerView_countingMethod.frame = CGRectMake(0, 480, 320, 216);
    
    //create UIToolBar
    self.doneToolBar_countingMethodPicker = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    // add done button
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                           action:@selector(doneCountingMethodPicker)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:self
                                                                           action:nil];
    self.doneToolBar_countingMethodPicker.items = [NSArray arrayWithObjects:space, right, nil];
    //Set tf_startDate's inputAccessoryView to doneToolBar
    self.tf_countingMethod.inputAccessoryView = self.doneToolBar_countingMethodPicker;
    
}

- (void)donePositionPicker
{
    [self.tf_position endEditing:YES];
}

- (void)doneFrequencyPicker
{
    [self.tf_frequency endEditing:YES];
}

- (void)doneCountingMethodPicker
{
    [self.tf_countingMethod endEditing:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == self.pickerView_frequency)
    {
        return [self.frequencyPickerArray count];
    }else if (pickerView == self.pickerView_countingMethod)
    {
        return [self.countingMethodPickerArray count];
    }else if (pickerView == self.pickerView_position)
    {
        return [self.positionPickerArray count];
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == self.pickerView_frequency)
    {
        return [self.frequencyPickerArray objectAtIndex:row];
    }else if(pickerView == self.pickerView_countingMethod)
    {
        return [self.countingMethodPickerArray objectAtIndex:row];
    }else if(pickerView == self.pickerView_position)
    {
        return [self.positionPickerArray objectAtIndex:row];
    }
    
    return @"error";
}



//using UIDatePicker to input start date
- (void)createDatePicker
{
    self.tf_startDate.delegate = self;
    
    //Create UIDatePicker
    self.datePicker_startDate = [[UIDatePicker alloc] init];
    self.datePicker_startDate.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    self.datePicker_startDate.datePickerMode = UIDatePickerModeDate;
    
    //Set tv_startDate's inputview to UIDatePicker
    self.tf_startDate.inputView = self.datePicker_startDate;
    
    //create UIToolBar
    self.doneToolBar_datePicker = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    // add done button
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                           action:@selector(doneDatePicker)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:self
                                                                           action:nil];
    self.doneToolBar_datePicker.items = [NSArray arrayWithObjects:space, right, nil];
    //Set tf_startDate's inputAccessoryView to doneToolBar
    self.tf_startDate.inputAccessoryView = self.doneToolBar_datePicker;
}

- (void)doneDatePicker
{
    if ([self.view endEditing:NO]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
//        self.tf_startDate.text = [NSString stringWithFormat:@"Start Date\t\t\t\t\t\t%@",[formatter stringFromDate:self.datePicker_startDate.date]];
        self.tf_startDate.text = [NSString stringWithFormat:NSLocalizedString(@"StartDateHint", @"Start Date Hint"), [formatter stringFromDate:self.datePicker_startDate.date]];
        self.planToAdd.startDate = [NSString stringWithString:[formatter stringFromDate:self.datePicker_startDate.date]];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.tf_weight)
    {
        NSString *tmp = [NSString stringWithString:self.tf_weight.text];
//        self.tf_weight.text = [NSString stringWithFormat:@"Weight\t\t\t\t\t\t\t\t    %@ lb", tmp];
        self.tf_weight.text = [NSString stringWithFormat:NSLocalizedString(@"WeightHint", @"Weight Hint"), tmp];
        self.planToAdd.weight = [tmp integerValue];
    }else if(textField == self.tf_frequency)
    {
        NSInteger row = [self.pickerView_frequency selectedRowInComponent:0];
//        self.tf_frequency.text = [NSString stringWithFormat:@"Freq.\t\t\t\t\t\t    %@", [self.frequencyPickerArray objectAtIndex:row]];
        self.tf_frequency.text = [NSString stringWithFormat:NSLocalizedString(@"FrequencyHint", @"Frequency Hint"), [self.frequencyPickerArray objectAtIndex:row]];
        self.planToAdd.frequency = row + 1;
    }else if(textField == self.tf_countingMethod)
    {
        NSInteger row = [self.pickerView_countingMethod selectedRowInComponent:0];
        self.tf_countingMethod.text = [self.countingMethodPickerArray objectAtIndex:row];
//        self.planToAdd.countingMethod = [self.countingMethodPickerArray objectAtIndex:row];
        if(row == 0)
            self.planToAdd.countingMethod = @"Accelorometer";
        else
            self.planToAdd.countingMethod = @"Touch";
    }else if(textField == self.tf_position)
    {
        NSInteger row = [self.pickerView_position selectedRowInComponent:0];
        self.tf_position.text = [self.positionPickerArray objectAtIndex:row];
        self.planToAdd.position = [self.positionPickerEngArray objectAtIndex:row];
    }else if(textField == self.tf_content)
    {
        self.planToAdd.name = self.tf_content.text;
    }else if(textField == self.tf_sets)
    {
        self.planToAdd.sets = [self.tf_sets.text integerValue];
    }else if(textField == self.tf_numPerSet)
    {
        self.planToAdd.numberPerSet = [self.tf_numPerSet.text integerValue];
    }else if(textField == self.tf_duration)
    {
        self.planToAdd.duration = [self.tf_duration.text integerValue];
//        self.tf_duration.text = [NSString stringWithFormat:@"Duration:\t\t\t\t\t\t  %ld week(s)", self.planToAdd.duration];
        self.tf_duration.text = [NSString stringWithFormat:NSLocalizedString(@"DurationHint", @"Duration Hint"), self.planToAdd.duration];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.tf_position)
    {
        [self createPickerViewForPositionInput];
    }else if(textField == self.tf_startDate)
    {
        [self createDatePicker];
    }else if(textField == self.tf_frequency)
    {
        [self createPickerViewForFrequencyInput];
    }else if(textField == self.tf_countingMethod)
    {
        [self createPickerViewForCountingMethodInput];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.tf_weight)
    {
        [self.tf_weight resignFirstResponder];
    }
    
    if([self.tf_position isFirstResponder])
    {
        [self.tf_content becomeFirstResponder];
    }else if([self.tf_content isFirstResponder])
    {
        [self.tf_sets becomeFirstResponder];
    }else if([self.tf_sets isFirstResponder])
    {
        [self.tf_numPerSet becomeFirstResponder];
    }else if([self.tf_numPerSet isFirstResponder])
    {
        [self.tf_weight becomeFirstResponder];
    }else if([self.tf_duration isFirstResponder])
    {
        [self.tf_duration resignFirstResponder];
    }
    
    return YES;
}


//make keyboard disappear
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tf_weight resignFirstResponder];
    [self.tf_position resignFirstResponder];
    [self.tf_content resignFirstResponder];
    [self.tf_sets resignFirstResponder];
    [self.tf_numPerSet resignFirstResponder];
    [self.tf_startDate resignFirstResponder];
    [self.tf_frequency resignFirstResponder];
    [self.tf_countingMethod resignFirstResponder];
    [self.tf_duration resignFirstResponder];
}


- (IBAction)clickDoneButtonToAddPlan:(UIBarButtonItem*)sender
{
    [self.tf_content endEditing:YES];
    [self.tf_position endEditing:YES];
    [self.tf_sets endEditing:YES];
    [self.tf_numPerSet endEditing:YES];
    [self.tf_weight endEditing:YES];
    [self.tf_startDate endEditing:YES];
    [self.tf_frequency endEditing:YES];
    [self.tf_countingMethod endEditing:YES];
    
    NSLog(@"addPlan.name=%@\n", self.planToAdd.name);
    NSLog(@"addPlan.position=%@\n", self.planToAdd.position);
    NSLog(@"addPlan.sets=%ld\n", (long)self.planToAdd.sets);
    NSLog(@"addPlan.numPerSet=%ld\n", (long)self.planToAdd.numberPerSet);
    NSLog(@"addPlan.weight=%ld\n", (long)self.planToAdd.weight);
    NSLog(@"addPlan.startDate=%@\n", self.planToAdd.startDate);
    NSLog(@"addPlan.frequency=%ld\n", (long)self.planToAdd.frequency);
    NSLog(@"addPlan.countingMethod=%@\n", self.planToAdd.countingMethod);
    
    
    //input Checking
    if(!self.planToAdd.name || !self.planToAdd.position || !self.planToAdd.startDate || !self.planToAdd.duration || !self.planToAdd.frequency || !self.planToAdd.countingMethod || !self.planToAdd.numberPerSet)
    {
        //Show alert View
        NSString *alertMsg = [NSString stringWithFormat:NSLocalizedString(@"InfoIncomplete", @"Information incomplete hint")];
        NSString *alertBtnStr = [NSString stringWithFormat:NSLocalizedString(@"Back", @"Back")];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertMsg delegate:self cancelButtonTitle:alertBtnStr otherButtonTitles:nil];
        [alertView show];
    }else
    {
        if(self.planToAdd.numberPerSet > 99)
        {
            //Show alert View
            NSString *alertMsg = [NSString stringWithFormat:NSLocalizedString(@"NumberTooLarge", @"Number Too Large")];
            NSString *alertBtnStr = [NSString stringWithFormat:NSLocalizedString(@"Back", @"Back")];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertMsg delegate:self cancelButtonTitle:alertBtnStr otherButtonTitles:nil];

            [alertView show];
        }else
        {
            [self.planToAdd generatePlan];
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
        
    }
    
    
//    [self.planToAdd generatePlan];
//    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}





















@end
