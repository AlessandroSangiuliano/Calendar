//
//  AppDelegate.h
//  AppDelegate
//
//  Created by Alessandro Sangiuliano on 26/02/15.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CalendarAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow __unsafe_unretained *window;
	IBOutlet __weak NSMatrix *matrix;
	IBOutlet __weak NSTextField *monthLabel, *yearLabel;
	NSUInteger unitFlags;
	NSDate *today;
	NSCalendar *gregorian;
	NSInteger monthDays;
	NSArray *monthSymbols;
	NSDateComponents  *firstOfThisMonth;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)test:(id)sender;
- (IBAction)changeMonth:(id)sender;
/**
 This method populates the AppDelegate Interface with calculated days
 */
- (void) populateCalendarFromDateComponents:(NSDateComponents*)firstDayDateComponents;
/**
 * This method returns the first date of a moth in form of NSDateComponents calclulated from
 * the date passed as argument
 */
- (NSDateComponents*) firstDayOfTheMonthFromDate:(NSDate *)aDate;
@end
