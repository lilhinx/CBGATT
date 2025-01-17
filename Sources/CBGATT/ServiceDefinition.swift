//
//  ServiceDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

public protocol ServiceDefinition:CustomStringConvertible
{
	static var id:CBUUID{ get }
	var includedServices:Array<any ServiceDefinition>{ get }
	var characteristics:Array<any CharacteristicDefinition>{ get }
}

extension ServiceDefinition
{
    public var id:CBUUID
    {
        return Self.id
    }
    
    var allServices:[CBUUID]
    {
        var all = [ id ]
        all.append( contentsOf:includedServices.map( { $0.id } ) )
        return all
    }
    
    var characteristicIdentifiers:[CBUUID]
    {
        return characteristics.map( { $0.id } )
    }
}

extension [ServiceDefinition]
{
    var allServices:[CBUUID]
    {
        flatMap( { $0.allServices } )
    }
}
