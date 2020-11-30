//
//  CharacteristicDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

public protocol CharacteristicDefinition:RawRepresentable,CaseIterable,CustomStringConvertible where RawValue == String
{
    associatedtype RawValue = String
    var characteristic:CBUUID{ get }
    func model( with data:Data )->CharacteristicModel
    var shouldRead:Bool{ get }
    var shouldNotify:Bool{ get }
}


extension CharacteristicDefinition
{
    public static var allCharacteristics:[CBUUID]
    {
        return allCases.map( { $0.characteristic } )
    }
    
    public var characteristic:CBUUID
    {
        return CBUUID.init( string:rawValue )
    }
}
