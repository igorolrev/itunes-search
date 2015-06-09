//
//  ItunesSearchTests.swift
//  ItunesSearchTests
//
//  Created by Victor C Tavernari on 08/06/15.
//  Copyright (c) 2015 Victor C Tavernari. All rights reserved.
//

import UIKit
import XCTest

class ItunesSearchTests: XCTestCase {
    
    func testCallSyncSearch() {
        XCTAssert(ItunesSearch.SearchSync("metallica sad but true").hasResult, "Has result");
        XCTAssertFalse(ItunesSearch.SearchSync("").hasResult, "Has no result");
    }
    
    func testGetArtistName()
    {
        let searchTerm = "metallica sad but true";
        
        let result = ItunesSearch.SearchSync(searchTerm).results;
        let artistName:String = result.first!.get(fromItem: ISItemKey.ARTIST_NAME)!;
        XCTAssertEqual(artistName, "Metallica", "Search OK");
    }
    
    func testGetTrackName()
    {
        let searchTerm = "metallica sad but true";
        
        let result = ItunesSearch.SearchSync(searchTerm).results;
        let artistName:String = result.first!.get(fromItem: ISItemKey.TRACK_NAME)!;
        
        XCTAssertEqual(artistName, "Sad But True", "Search OK");

    }
    
    func testGetCoverURL()
    {
        let searchTerm = "Metallica Sad But True";
        let result = ItunesSearch.SearchSync(searchTerm).results;
        
        result.first?.getCoverURL(ISCoverSize.REGULAR, dpi: ISCoverImageDPI.MEDIUM);
        
        XCTAssert(validateURL(result.first!.getCoverURL(size: 200, dpi: 100)!, size: 200, dpi: 100), "correct cover url");
        XCTAssert(validateURL(result.first!.getCoverURL(size: 400, dpi: 300)!, size: 400, dpi: 300), "correct cover url");
        XCTAssertFalse(validateURL(result.first!.getCoverURL(size: 400, dpi: 300)!, size: 100, dpi: 200), "incorrect url");
    }
    
    private func validateURL(url:String, size:Int, dpi:Int)->Bool
    {
        return url.lowercaseString.rangeOfString("\(size)x\(size)-\(dpi)") != nil
    }
    
}
