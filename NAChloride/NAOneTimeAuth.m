//
//  NAOneTimeAuth.m
//  NAChloride
//
//  Created by Gabriel on 9/24/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import "NAOneTimeAuth.h"

#import "NAInterface.h"

#import <libsodium/sodium.h>

@implementation NAOneTimeAuth

- (NSData *)auth:(NSData *)data key:(NSData *)key error:(NSError **)error {
  NAChlorideInit();
  
  if (!key || [key length] != NAOneTimeAuthKeySize) {
    if (error) *error = [NSError errorWithDomain:@"NAChloride" code:NAErrorCodeInvalidKey userInfo:@{NSLocalizedDescriptionKey: @"Invalid key"}];
    return nil;
  }

  NSMutableData *outData = [NSMutableData dataWithLength:NAOneTimeAuthSize];
  
  crypto_onetimeauth([outData mutableBytes], [data bytes], [data length], [key bytes]);
  return outData;
}

- (BOOL)verify:(NSData *)auth data:(NSData *)data key:(NSData *)key error:(NSError **)error {
  NAChlorideInit();

  if (!key || [key length] != NAOneTimeAuthKeySize) {
    if (error) *error = [NSError errorWithDomain:@"NAChloride" code:NAErrorCodeInvalidKey userInfo:@{NSLocalizedDescriptionKey: @"Invalid key"}];
    return NO;
  }

  if (!auth || [auth length] != NAOneTimeAuthSize) {
    if (error) *error = [NSError errorWithDomain:@"NAChloride" code:NAErrorCodeInvalidData userInfo:@{NSLocalizedDescriptionKey: @"Invalid data"}];
    return NO;
  }

  if (crypto_onetimeauth_verify([auth bytes], [data bytes], [data length], [key bytes]) != 0) {
    if (error) *error = [NSError errorWithDomain:@"NAChloride" code:NAErrorCodeVerificationFailed userInfo:@{NSLocalizedDescriptionKey: @"Verification failed"}];
    return NO; // Message forged!
  }
  return YES;
}

@end
