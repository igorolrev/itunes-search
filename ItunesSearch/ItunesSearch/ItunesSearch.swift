//
//  ItunesSearch.swift
//  ItunesSearch
//
//  Created by Victor C Tavernari on 08/06/15.
//  Copyright (c) 2015 Victor C Tavernari. All rights reserved.
//

import UIKit

public class ItunesSearch {
   
    let ITUNES_URL_SEARCH_BY_TERM = "https://itunes.apple.com/search?term=";

    public var hasResult:Bool {
        get {
            return results.count > 0
        }
    }
    
    private(set) public var results:[ISInfoData] = [];
    
    public class func SearchSync(term:String)->ItunesSearch
    {
        return ItunesSearch(term: term, async: false);
    }
    
    private init(term:String, async:Bool)
    {
        if let encodedTerm = getValueEncodedToSearch(term)
        {
            let url = ITUNES_URL_SEARCH_BY_TERM+encodedTerm;
            requestToItunes(url);
        }
    }
    
    private func getValueEncodedToSearch(term:String)->String?
    {
        return term.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet());
    }

    private func requestToItunes(urlToSearch:String)
    {
        if let url = NSURL(string: urlToSearch)
        {
            if let data = NSData(contentsOfURL: url)
            {
                if let resultProcessed = ISRequestResultManipulator(data: data).result
                {
                    results = resultProcessed;
                }
                
            }
        }
    }
    
}
