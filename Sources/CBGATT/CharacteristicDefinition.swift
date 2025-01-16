//
//  CharacteristicDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

public protocol CharacteristicDefinition
{
	static var id:CBUUID{ get }
    associatedtype Value:Decodable
}




