// RRCoreData NSManagedObjectContext+RRCoreData.h
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

#import <Foundation/Foundation.h>

@interface NSManagedObjectContext(RRCoreData)

/*!
 * @brief Answers what to reply when an application delegate receives an
 * "application should terminate" notification, basing the reply on the
 * condition of the managed-object context.
 *
 * @param sender The application about to terminate, or @c nil to indicate the
 * shared application instance.
 *
 * @param alertBlock Describes what to do if context changes @c cannot commit,
 * or specifies @c NULL if the user should decide. You can use this argument to
 * customise user interaction.
 *
 * @result Says what should happen when the application requests
 * termination. Can it terminate now or should the application cancel
 * termination?
 *
 * @details You typically call this method after the user selects the
 * application's Quit menu item. If the managed-object context includes
 * uncommitted changes, the method first tries to commit the changes.
 */
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender alertBlock:(NSApplicationTerminateReply (^)(void))alertBlock;

@end
