//
//  NoterWindowController.m
//  Calendar
//
//  Created by Alex on 03/02/15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

#import "NoterWindowController.h"

@interface NoterWindowController ()
@property (weak) IBOutlet NSWindow *window;
@end


@implementation NoterWindowController

- (IBAction)storeEvents:(id)sender
{
	NSString *content = [descriptionView string];
	NSLog(@"A fissa %@", content);
}
@end