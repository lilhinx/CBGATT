//
//  CharacteristicDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

public protocol CharacteristicDefinition:CaseIterable,CustomStringConvertible
{
    var characteristic:CBUUID{ get }
    func model( with data:Data )->CharacteristicModel
}
