    //
//  CalendarController.m
//  TapkuCalendarDemo
//
//  Created by Ben Pearson on 8/01/11.
//  Copyright 2011 Developing in the Dark. All rights reserved.
//

#import "CalendarController.h"

@implementation CalendarController

@synthesize calendar,aSender,bSender;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		calendar = 	[[TKCalendarMonthView alloc] init];
		calendar.delegate = self;
		calendar.dataSource = self;
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height)] autorelease];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.view.backgroundColor = [UIColor clearColor];
    
	calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
	[self.view addSubview:calendar];
	[calendar reload];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate * now = [NSDate date];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString * nowStr = [formatter stringFromDate:now];
    NSString * dStr = [formatter stringFromDate:d];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    if (aSender != nil) {
        if ([dStr compare:nowStr] == NSOrderedDescending || [nowStr compare:dStr] == NSOrderedSame) {
            [aSender.aEndDateButton setTitle:[formatter stringFromDate:d] forState:UIControlStateNormal];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Неверная дата" message:@"Нельзя назначить дату исполнения в прошлом" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [aSender.aEndDateButton setTitle:[formatter stringFromDate:now] forState:UIControlStateNormal];
        }
//        [aSender.aEndDateButton setTitle:[formatter stringFromDate:d] forState:UIControlStateNormal];
    }
    if (bSender != nil) {
        if ([dStr compare:nowStr] == NSOrderedDescending || [nowStr compare:dStr] == NSOrderedSame) {
            [bSender.aEndDateButton setTitle:[formatter stringFromDate:d] forState:UIControlStateNormal];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Неверная дата" message:@"Нельзя назначить дату исполнения в прошлом" delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [bSender.aEndDateButton setTitle:[formatter stringFromDate:now] forState:UIControlStateNormal];
        }
//        [bSender.aEndDateButton setTitle:[formatter stringFromDate:d] forState:UIControlStateNormal];
    }

    long long date = [d timeIntervalSince1970];
    NSLog(@"%lld",date);
    NSString * stringDate = [NSString stringWithFormat:@"%lld000",date];

    if (aSender != nil) {
        [aSender.activity setObject:stringDate forKey:@"x.DUEDATE_DTTM"];
        [aSender.calendarPopover dismissPopoverAnimated:YES];
    }
    if (bSender != nil) {
        [bSender.arraySelectActivity setObject:stringDate forKey:@"x.DUEDATE_DTTM"];
        [bSender.calendarPopover dismissPopoverAnimated:YES];
    }
    [formatter release];
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
    if (aSender != nil) {
        aSender.calendarPopover.popoverContentSize = CGSizeMake(monthView.frame.size.width, monthView.frame.size.height);
    }
    if (bSender != nil) {
        bSender.calendarPopover.popoverContentSize = CGSizeMake(monthView.frame.size.width, monthView.frame.size.height);
    }
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
    
    return nil;
}


#pragma mark -
#pragma mark Rotation

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Disabled rotation for this example
	return NO;
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[calendar release];
    [super dealloc];
}


@end
