//
//  ServiceDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

protocol ServiceDefinition:CaseIterable,CustomStringConvertible
{
    var service:CBUUID{ get }
    var characteristics:Set<CBUUID>{ get }
}

extension ServiceDefinition
{
    static var allServices:[CBUUID]
    {
        return allCases.map( { $0.service } )
    }
}
