//
//

#import <Foundation/Foundation.h>


//GUI STUFF
#define kTileSetWidth 16
#define kTileSetHeight 8

#define kTileWidth 26
#define kTileHeight 26

#define kTileMarginRight 0
#define kTileMarginBottom 0

#define kTileBackName @"tileBack.png"
#define kTileFrontName @"tileFront.png"

#define kMatchAudioFilename @"match.caf"
#define kWinAudioFilename @"win.caf"

#define kWinTextFilename @"winText.png"
#define kNewGameTextFilename @"newgame.png" 



//AUDIO STUFF
#define kGlobalBPM 120

#define kSample0 @"kick.caf"  //kick
#define kSample1 @"hhHit.caf" //hat closed hit
#define kSample2 @"snare.caf" //snare hit 1

//convert filetypes by: afconvert -d LEI16 -f 'caff' 32695__altemark__hh2.wav hhHit.caf