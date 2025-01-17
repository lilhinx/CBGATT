//
//  GATTReadConfiguration.swift
//  CBGATT
//
//  Created by Chris Hinkle on 1/16/25.
//

import Foundation


open class GATTReadConfiguration
{
    public init( )
    {
        
    }
    
    open func shouldRead( _ characteristic:any CharacteristicDefinition )->Bool
    {
        fatalError( )
    }
    
    open func shouldNotify( _ characteristic:any CharacteristicDefinition )->Bool
    {
        fatalError( )
    }
}
