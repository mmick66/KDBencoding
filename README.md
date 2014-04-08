KDBencoding
===========

Decoder for the Bencoding format used in the BitTorrent protocol

```objective-c
NSData* data = [NSData dataWithContentsOfFile:torrentFilePath];
if(!data) {
  // handle file not loaded error
}
KDBencodingParser* parser = [KDBencodingParser parserWithData:data];
if(!parser) {
  // handle parse error
}
NSLog(@"%@", parser.rootObject);
```
