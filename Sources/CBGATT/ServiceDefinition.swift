//
//  ServiceDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

public protocol ServiceDefinition:RawRepresentable,CaseIterable,CustomStringConvertible
{
    var service:CBUUID{ get }
    var characteristics:Set<CBUUID>{ get }
}

extension ServiceDefinition
{
    public static var allServices:[CBUUID]
    {
        return allCases.map( { $0.service } )
    }
}
