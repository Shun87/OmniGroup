// Copyright 2001-2005, 2010 Omni Development, Inc.  All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.

#import "OAShrinkyTextField.h"

#import <Cocoa/Cocoa.h>
#import <OmniBase/rcsid.h>

RCS_ID("$Id$");

@interface OAShrinkyTextField (/*Private*/)
- (void)_resetBounds;
- (CGFloat)_widthOfString;
@end

@implementation OAShrinkyTextField

- (void)setFrame:(NSRect)frameRect;
{
    [super setFrame:frameRect];
    [self _resetBounds];
}

// NSControl subclass

- (void)setStringValue:(NSString *)newString;
{
    [super setStringValue:newString];
    [self _resetBounds];
    [self setNeedsDisplay:YES];
}

- (void)setObjectValue:(id <NSCopying>)newValue;
{
    [super setObjectValue:(id)newValue];
    [self _resetBounds];
    [self setNeedsDisplay:YES];
}

- (void)setFont:(NSFont *)font;
{
    [super setFont:font];
    [self _resetBounds];
    [self setNeedsDisplay:YES];
}

#pragma mark Private

- (void)_resetBounds;
{
    NSRect frame = [self frame];
    CGFloat normalStringWidth = [self _widthOfString] + 8.0f; // Mmm, magic

    if (normalStringWidth > NSWidth(frame))
        [self setBoundsSize:NSMakeSize(normalStringWidth, NSHeight(frame))];
    else
        [self setBoundsSize:frame.size];
}

- (CGFloat)_widthOfString;
{
    return [[self attributedStringValue] size].width;
}

@end
