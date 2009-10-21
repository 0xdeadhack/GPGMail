/* ComposeBack+GPGMail.m created by dave on Sun 13-Apr-2004 */

/*
 * Copyright (c) 2000-2008, St�phane Corth�sy <stephane at sente.ch>
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of St�phane Corth�sy nor the names of GPGMail
 *       contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY ST�PHANE CORTH�SY AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL ST�PHANE CORTH�SY AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ComposeBackEnd+GPGMail.h"
#import "GPGMailBundle.h"
#import "NSString+Message.h"
#import "NSString+GPGMail.h"

#import <Foundation/Foundation.h>


#ifdef SNOW_LEOPARD
@implementation GPGMail_ComposeBackEnd
#else
@implementation ComposeBackEnd(GPGMail)
#endif

- (NSArray *) gpgRecipients
{
    // Used only in GPGMailComposeAccessoryViewOwner => we could easily ask user for the recipients
#ifdef SNOW_LEOPARD
    NSArray *recipients = [[self valueForKey:@"_cleanHeaders"] objectForKey:@"to"];
#else
    NSArray *recipients = [_cleanHeaders objectForKey:@"to"];
#endif

    if(recipients != nil)
#ifdef SNOW_LEOPARD
        recipients = [recipients arrayByAddingObjectsFromArray:[[self valueForKey:@"_cleanHeaders"] objectForKey:@"cc"]];
#else
        recipients = [recipients arrayByAddingObjectsFromArray:[_cleanHeaders objectForKey:@"cc"]];
#endif
    else
#ifdef SNOW_LEOPARD
        recipients = [[self valueForKey:@"_cleanHeaders"] objectForKey:@"cc"];
#else
        recipients = [_cleanHeaders objectForKey:@"cc"];
#endif
    
    if([[GPGMailBundle sharedInstance] usesBCCRecipients]){
        if(recipients != nil)
#ifdef SNOW_LEOPARD
            recipients = [recipients arrayByAddingObjectsFromArray:[[self valueForKey:@"_cleanHeaders"] objectForKey:@"bcc"]];
#else
            recipients = [recipients arrayByAddingObjectsFromArray:[_cleanHeaders objectForKey:@"bcc"]];
#endif
        else
#ifdef SNOW_LEOPARD
            recipients = [[self valueForKey:@"_cleanHeaders"] objectForKey:@"bcc"];
#else
            recipients = [_cleanHeaders objectForKey:@"bcc"];
#endif
    }
    
    return [recipients valueForKey:@"gpgNormalizedEmail"];
}

- (NSArray *) gpgBCCRecipients
{
#ifdef SNOW_LEOPARD
    return [[self valueForKey:@"_cleanHeaders"] objectForKey:@"bcc"];
#else
    return [_cleanHeaders objectForKey:@"bcc"];
#endif
}

@end
