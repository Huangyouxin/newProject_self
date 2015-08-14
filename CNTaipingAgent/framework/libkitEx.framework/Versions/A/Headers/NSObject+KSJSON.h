//
//  KSJSON.h
//  KSJSON
//
//  Created by Karl Stenerud on 10/29/11.
//  Copyright (c) 2011 Karl Stenerud. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <Foundation/Foundation.h>

/**
 * Serializes objects to JSON strings, and deserializes JSON strings into
 * objects.
 */
@interface NSObject (KSJSON)

/** Serialize an object into a JSON string.
 * Returns nil on error and prints out diagnostic messages.
 *
 * @param object The object to serialize. Must be an array or dictionary.
 *
 * @param error Placeholder for any errors. Ignored if nil.
 *
 * @return The JSON serialized string or nil if an error occurred.
 */
+ (NSString*) JSONEncoder:(id) object error:(NSError**) error;

/** Deserialize a JSON string into an object hierarchy.
 * Returns nil on error and prints out diagnostic messages.
 *
 * @param jsonString the JSON encoded string.
 *
 * @param error Placeholder for any errors. Ignored if nil.
 *
 * @return the resulting object hierarchy or nil if an error occurred.
 */
+ (id) JSONDecoder:(NSString*) jsonString error:(NSError**) error;

@end

@interface NSDictionary (KSJSON)
/** Serialize an object into a JSON string.
 *
 * @return The JSON serialized string or nil if an error occurred.
 */
- (NSString*) JSONEncoder;
@end

@interface NSArray (KSJSON)
/** Serialize an object into a JSON string.
 *
 * @return The JSON serialized string or nil if an error occurred.
 */
- (NSString*) JSONEncoder;
@end

@interface NSData (KSJSON)
/** Deserialize a JSON string into an object hierarchy.
 *
 * @return the resulting object hierarchy or nil if an error occurred.
 */
- (id) JSONDecoder;
@end

@interface NSString (KSJSON)
/** Deserialize a JSON string into an object hierarchy.
 *
 * @return the resulting object hierarchy or nil if an error occurred.
 */
- (id) JSONDecoder;
@end
