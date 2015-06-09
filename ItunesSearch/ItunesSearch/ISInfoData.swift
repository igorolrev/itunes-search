//
//  ISInfoData.swift
//  ItunesSearch
//
//  Created by Victor C Tavernari on 09/06/15.
//  Copyright (c) 2015 Victor C Tavernari. All rights reserved.
//

import UIKit

public enum ISCoverSize:Int
{
    case LARGE = 1500;
    case REGULAR = 700;
    case SMALL = 300
    case TINY = 100;
}

public enum ISCoverImageDPI:Int
{
    case HIGH = 400;
    case MEDIUM = 200;
    case LOW = 75;
}

public class ISInfoData {
   
    private var rawData:NSDictionary;
    
    init(rawData:NSDictionary)
    {
        self.rawData = rawData;
    }

    public func get<T:Any>(#fromItem:ISItemKey)->T?
    {
        if let value: T = rawData[fromItem.rawValue] as? T
        {
            return value;
        }
        
        return nil;
    }
}

public extension ISInfoData
{
    func getCoverURL(size:ISCoverSize, dpi:ISCoverImageDPI)->String?
    {
        return getCoverURL(size: size.rawValue, dpi: dpi.rawValue);
    }
    
    func getCoverURL(size:Int = 100, dpi:Int = 75)->String?
    {
       if let url:String = get(fromItem: ISItemKey.ART_WORK_URL_100)
       {
            let urlToRequest = url.stringByReplacingOccurrencesOfString("100x100", withString: String(size)+"x"+String(size), options: NSStringCompareOptions.LiteralSearch, range: nil).stringByReplacingOccurrencesOfString("-75", withString: "-"+String(dpi), options: NSStringCompareOptions.LiteralSearch, range: nil);
        
            return urlToRequest;
       }
        
        return nil;
    }
}
