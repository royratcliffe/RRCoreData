// RRCoreData NSManagedObjectContext+RRCoreData.m
//
// Copyright © 2008-2011, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import "NSManagedObjectContext+RRCoreData.h"

@implementation NSManagedObjectContext(RRCoreData)

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender alertBlock:(NSApplicationTerminateReply (^)(void))alertBlock
{
	NSApplicationTerminateReply reply;
	if ([self commitEditing])
	{
		NSError *error = nil;
		if ([self hasChanges] && ![self save:&error])
		{
			if ([sender ? sender : [NSApplication sharedApplication] presentError:error])
			{
				// error recovery succeeded
				reply = NSTerminateNow;
			}
			else
			{
				reply = (alertBlock ? alertBlock : ^NSApplicationTerminateReply {
					NSAlert *alert = [[NSAlert alloc] init];
					[alert setMessageText:NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Message text for alert")];
					[alert setInformativeText:NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save.", @"Informative text for alert")];
					[alert addButtonWithTitle:NSLocalizedString(@"Quit Anyway", @"Button title for alert (default return)")];
					[alert addButtonWithTitle:NSLocalizedString(@"Cancel", @"Button title for alert (alternate return)")];
					NSInteger response = [alert runModal];
					[alert release];
					
					NSApplicationTerminateReply reply;
					switch (response) {
						case NSAlertDefaultReturn:
							reply = NSTerminateNow;
							break;
						default:
							reply = NSTerminateCancel;
					}
					return reply;
				})();
			}
		}
		else
		{
			// has no changes or saving succeeded, terminate now
			reply = NSTerminateNow;
		}
	}
	else
	{
		// committing edits failed, cancel termination
		reply = NSTerminateCancel;
	}
	return reply;
}

@end
