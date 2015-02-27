//
//  AppDelegate.h
//  Calendar
//
//  Created by Alex on 28/01/15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	IBOutlet __weak NSMatrix *matrix;
	IBOutlet __weak NSTextField *month, *year;
	NSDateComponents *firstOfThisMonth;
	NSDictionary *months;
	NSCalendar *gregorian;
	NSInteger monthDays;
	NSArray *monthSymbols;
	NSUInteger unitFlags;
	NSDate *today;
}
- (IBAction)test:(id)sender;
- (IBAction)changeMonth:(id)sender;
/**
 This method populates the Calendar Interface with calculated days
 */
- (void) populateCalendarFromDateComponents:(NSDateComponents*)firstDayDateComponents;
/**
 * This method returns the first date of a moth in form of NSDateComponents calclulated from
 * the date passed as argument
 */
- (NSDateComponents*) firstDayOfTheMonthFromDate:(NSDate *)aDate;


@end

