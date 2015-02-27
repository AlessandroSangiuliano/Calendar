//
//  NoterWindowController.h
//  Calendar
//
//  Created by Alex on 03/02/15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

#ifndef Calendar_NoterWindowController_h
#define Calendar_NoterWindowController_h

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NoterWindowController : NSWindowController
{
	IBOutlet NSTextView *descriptionView;
	IBOutlet __weak NSTextField *titleView;
}

- (id) initWithWindowNibName:(NSString *)windowNibName;
- (IBAction)storeEvents:(id)sender;
@end

#endif
