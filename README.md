KDBencoding
===========

A simple Objective-C decoder for the Bencoding format used in the BitTorrent protocol
http://en.wikipedia.org/wiki/Bencode

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
