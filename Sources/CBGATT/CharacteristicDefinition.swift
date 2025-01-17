//
//  CharacteristicDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

public protocol CharacteristicDefinition:CustomStringConvertible
{
	static var id:CBUUID{ get }
    associatedtype Value:Decodable
}

extension CharacteristicDefinition
{
    public var id:CBUUID
    {
        return Self.id
    }
    
    func getValueType( ) ->Value.Type
    {
        return Value.self
    }
}
