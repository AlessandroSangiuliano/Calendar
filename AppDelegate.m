//
//  CalendarAppDelegate.m
//  Calendar
//
//  Created by Alessandro Sangiuliano on 26/02/15.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@interface CalendarAppDelegate (Private)
- (void) setMonthDaysMonthAndYearFromComponents:(NSDateComponents*)components;
- (void) disableAllButtons;
- (void) setButtonColorFromCell:(NSButtonCell*)aCell;
- (NSButtonCell *) cellFromDate:(NSDate *)aDate;
@end

@implementation CalendarAppDelegate


@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	[monthLabel setFont:[NSFont systemFontOfSize:15]];
	[yearLabel setFont:[NSFont systemFontOfSize:15]];
	
	/* Set the background color */
	
	self.window.backgroundColor = [NSColor whiteColor];
	
	/* Calendar view population */
	
	unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSWeekdayOrdinalCalendarUnit;
	today = [NSDate date];
	gregorian = [NSCalendar currentCalendar];
	NSDateComponents *components = [gregorian components:unitFlags fromDate:today];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	monthSymbols = [formatter monthSymbols];
	[self disableAllButtons];	
	[self setMonthDaysMonthAndYearFromComponents:components];
	
	firstOfThisMonth = [self firstDayOfTheMonthFromDate:today];
	[self populateCalendarFromDateComponents:firstOfThisMonth];
	
	/* get the cell that indicates today and set the text to red, to bold and to 16 the font size */
	
	NSButtonCell* retrievedCell = [self cellFromDate:today];
	[self setButtonColorFromCell:retrievedCell];
	//[retrievedCell setImage:[NSImage imageNamed:@"NSBluetoothTemplate"]];
	
}

- (void) setMonthDaysMonthAndYearFromComponents:(NSDateComponents*)components
{
	[monthLabel setStringValue:[monthSymbols objectAtIndex:[components month] - 1]];
	[yearLabel setStringValue:[NSString stringWithFormat:@"%ld", [components year]]];
	
	NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[gregorian dateFromComponents:components]]; 
	monthDays = range.length;
	NSLog(@"Numbers of Days %ld", monthDays);
}


- (void) populateCalendarFromDateComponents:(NSDateComponents *)firstDayDateComponents
{
	NSInteger weekDay = [firstDayDateComponents weekday];
	NSLog(@"The weekday %ld", weekDay);
	NSButtonCell *button;
	NSInteger rowIndex = 0, columIndex = 0;
	NSInteger dayNumber = 0;
	
	switch (weekDay)
	{
		case 1:
			columIndex = 6;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:@"1"];
			[button setEnabled:YES];
			rowIndex++;
			columIndex = 0;
			dayNumber++;
			break;
		case 2:
			columIndex = 0;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:@"1"];
			[button setEnabled:YES];
			break;
		case 3:
			columIndex = 1;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:@"1"];
			[button setEnabled:YES];
			break;
		case 4:
			columIndex = 2;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:@"1"];
			[button setEnabled:YES];
			break;
		case 5:
			columIndex = 3;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:@"1"];
			NSLog(@"Giovdì zignò");
			break;
		case 6:
			columIndex = 4;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:@"1"];
			[button setEnabled:YES];
			break;
		case 7:
			columIndex = 5;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:@"1"];
			[button setEnabled:YES];
			break;
		default:
			break;
	}
	
	for (;  rowIndex<=5; rowIndex++)
	{
		NSLog(@"Che problema hai righe");
		for (; columIndex<=6 && dayNumber < monthDays; columIndex++)
		{
			NSLog(@"Che problema hai?");
			dayNumber += 1;
			button = [matrix cellAtRow:rowIndex column:columIndex];
			[button setTitle:[NSString stringWithFormat:@"%ld",dayNumber]];
			[button setEnabled:YES];
		}
		columIndex = 0;
	}
}

- (NSDateComponents*) firstDayOfTheMonthFromDate:(NSDate *)aDate
{
	NSUInteger unitsFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit;
	/*remember to check if gregorian == nil */
	
	NSDateComponents *firstDay = [gregorian components:unitsFlags fromDate: aDate];
	[firstDay setDay:1]; //Meh! this setDay seems to do -1 on OS X. Look Better
	/*[firstDay setMonth:1];
	 monthDays = 31;*/
	NSDate *date = [gregorian dateFromComponents:firstDay];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"EEEE"];
	NSArray *weekdaySymbols = [formatter weekdaySymbols];
	NSString *dayName = [formatter stringFromDate:date];
	NSString *tmpName;
	
	for (NSInteger i = 0; i < weekdaySymbols.count; i++)
	{
		tmpName = [weekdaySymbols objectAtIndex:i];
		if ([tmpName isEqualToString:dayName])
			[firstDay setWeekday:i]; //It was i+1 on OS X, on gnustep I have a different behavior.
	}
	NSLog(@"Day name %@\nday symbols %@\nweekday %ld\nmonth %ld", dayName, [formatter weekdaySymbols], [firstDay weekday], [firstDay month]);
	return firstDay;
	
}

- (NSButtonCell *) cellFromDate:(NSDate *)aDate
{
	NSInteger day = [[gregorian components:NSDayCalendarUnit fromDate:aDate] day];
	NSInteger rowIndex, columIndex, retrievedDay;
	NSButtonCell *button;
	
	for (rowIndex = 0; rowIndex <=5; rowIndex++)
	{
		for (columIndex = 0; columIndex <= 6; columIndex++)
		{
			button = [matrix cellAtRow:rowIndex column:columIndex];
			retrievedDay = [[button title] integerValue];
			
			if (retrievedDay == day)
			{
				return button;
			}
		}
		columIndex = 0;
	}
	
	return button; //it could be nil; check out of this method.
}

- (IBAction)changeMonth:(id)sender
{
	if ([[sender alternateTitle] isEqualToString:@"previous"])
	{
		[self disableAllButtons];
		[firstOfThisMonth setMonth:[firstOfThisMonth month] - 1];
		firstOfThisMonth = [self firstDayOfTheMonthFromDate:[gregorian dateFromComponents:firstOfThisMonth]];
		[self setMonthDaysMonthAndYearFromComponents:firstOfThisMonth];
		[self populateCalendarFromDateComponents:firstOfThisMonth];
		
	}
	else if([[sender alternateTitle] isEqualToString:@"thisDate"])
	{
		[self disableAllButtons];
		firstOfThisMonth = [gregorian components:unitFlags fromDate:[NSDate date]];
		firstOfThisMonth = [self firstDayOfTheMonthFromDate:[gregorian dateFromComponents:firstOfThisMonth]];
		
		[self setMonthDaysMonthAndYearFromComponents:firstOfThisMonth];
		[self populateCalendarFromDateComponents:firstOfThisMonth];
		[self setButtonColorFromCell:[self cellFromDate:today]];
	}
	else
	{
		[self disableAllButtons];
		[firstOfThisMonth setMonth:[firstOfThisMonth month] + 1];
		firstOfThisMonth = [self firstDayOfTheMonthFromDate:[gregorian dateFromComponents:firstOfThisMonth]];
		[self setMonthDaysMonthAndYearFromComponents:firstOfThisMonth];
		[self populateCalendarFromDateComponents:firstOfThisMonth];
		
	}
	
}

- (void) disableAllButtons
{
	NSArray *allCells = [matrix cells];
	NSButtonCell *button;
	NSLog(@"Non vengo chiamato!");
	for (NSInteger i = 0; i < allCells.count; i++)
	{
		NSLog(@"Esisto!");
		button = [allCells objectAtIndex:i];
		[button setBordered:NO];
		[button setEnabled:NO];
		[button setTitle:@""];
	}
}

- (void) setButtonColorFromCell:(NSButtonCell*)aCell
{
	NSMutableAttributedString *todayNoticed = [[NSMutableAttributedString alloc] initWithAttributedString:[aCell attributedTitle]];
	[todayNoticed addAttribute:NSForegroundColorAttributeName value:[NSColor redColor] range:NSMakeRange(0, todayNoticed.length)];
	[todayNoticed addAttribute:NSFontAttributeName value:[NSFont boldSystemFontOfSize:16] range:NSMakeRange(0, todayNoticed.length)];
	[aCell setAttributedTitle:todayNoticed];
	
}

-(IBAction)test:(id)sender
{
	//NSInteger selCell = [sender selectedRow];
	//NSLog(@"test %@", [[sender cellAtRow:[sender selectedRow] column:[sender selectedColumn]] title]);
	NSButtonCell *cio = [sender cellAtRow:[sender selectedRow] column:[sender selectedColumn]];
	cio.backgroundColor = [NSColor colorWithCalibratedRed: 0.21 green: 0.703 blue: 0.574 alpha: 1]; // when ab event is present to a day, change the color to notice the event
	//NoterWindowController *aiss = [[NoterWindowController alloc] initWithWindowNibName:@"Noter"];
	//[aiss loadWindow];
	//[[aiss window] makeKeyAndOrderFront:self];
	//[cio setImage:[NSImage imageNamed:@"NSStatusAvailable"]];
	[cio setAttributedTitle:[cio attributedTitle]];
}

@end
