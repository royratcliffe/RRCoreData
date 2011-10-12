// RRCoreData RRCoreDataStack.m
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

#import "RRCoreDataStack.h"
#import "NSManagedObjectContext+RRCoreData.h"

@implementation RRCoreDataStack

@synthesize context     = _context;
@synthesize coordinator = _coordinator;
@synthesize model       = _model;

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender alertBlock:(NSApplicationTerminateReply (^)(void))alertBlock
{
	NSManagedObjectContext *context = [self context];
	return context ? [context applicationShouldTerminate:sender alertBlock:alertBlock] : NSTerminateNow;
}

- (NSPersistentStoreCoordinator *)coordinatorOrNewWithModel
{
	NSPersistentStoreCoordinator *coordinator;
	if ((coordinator = [self coordinator]) == nil)
	{
		[self setCoordinator:coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self modelOrMergedFromMainBundle]] autorelease]];
	}
	return coordinator;
}

- (NSManagedObjectModel *)modelOrMergedFromMainBundle
{
	NSManagedObjectModel *model;
	if ((model = [self model]) == nil)
	{
		[self setModel:model = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle mainBundle]]]];
	}
	return model;
}

@end
