//
//  ISRequestResultManipulator.swift
//  ItunesSearch
//
//  Created by Victor C Tavernari on 08/06/15.
//  Copyright (c) 2015 Victor C Tavernari. All rights reserved.
//

import UIKit

internal class ISRequestResultManipulator {
    
    private(set) var result:[ISInfoData]?;
    
    internal init(data:NSData)
    {
        if let jsonResult:NSDictionary = getDictionaryFromJson(data)
        {
            if let results:NSArray = jsonResult["results"] as? NSArray
            {
                result = [];
                
                for resultRaw in results
                {
                    self.result?.append(ISInfoData(rawData: resultRaw as! NSDictionary));
                }
            }
        }
    }
    
    private func getDictionaryFromJson(json:NSData)->NSDictionary?
    {
        return NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary;
    }
   
}
