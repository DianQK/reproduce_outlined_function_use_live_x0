// https://github.com/facebook/react-native/blob/v0.66.1/Libraries/Image/RCTImageUtils.m

#import <UIKit/UIKit.h>
#import <tgmath.h>
#import <ImageIO/ImageIO.h>

CGImageSourceRef MYCGImageSourceCreateWithData(NSData* data, int v);
CGSize RCTTargetSize(CGSize sourceSize, CGFloat sourceScale, CGSize destSize, CGFloat destScale);
CGSize RCTSizeInPixels(CGSize pointSize, CGFloat scale);

void RCTDecodeImageWithData(NSData *data, CGSize destSize, CGFloat destScale)
{
  CGImageSourceRef sourceRef = MYCGImageSourceCreateWithData(data, 0);

  // Get original image size
  CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(sourceRef, 0, NULL);

  NSNumber *width = @1;
  NSNumber *height = @1;
  CGSize sourceSize = {width.doubleValue, 0};

  // Calculate target size
  CGSize targetSize = RCTTargetSize(sourceSize, 1, destSize, destScale);
  CGSize targetPixelSize = RCTSizeInPixels(targetSize, destScale);
  CGFloat maxPixelSize = fmax(fmin(sourceSize.width, 1), fmin(1, 1));

  NSDictionary<NSString *, NSNumber *> *options = @{
    (id)@"": @YES,
    (id)@"": @YES,
    (id)@"": @YES,
    (id)@"": @(maxPixelSize),
  };
}

NSData* RCTGetImageMetadata2(NSData *data)
{
  CGImageSourceRef sourceRef = MYCGImageSourceCreateWithData(data, 0);
  CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(sourceRef, 1, NULL);
  return NULL;
}

NSData* RCTGetImageMetadata3(NSData *data)
{
  CGImageSourceRef sourceRef = MYCGImageSourceCreateWithData(data, 0);
  CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(sourceRef, 2, NULL);
  return NULL;
}
