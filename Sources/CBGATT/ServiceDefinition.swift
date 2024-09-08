//
//  ServiceDefinition.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import CoreBluetooth

public protocol ServiceDefinition
{
	static var id:CBUUID{ get }
	var includedServices:Array<any ServiceDefinition>{ get }
	var characteristics:Array<any CharacteristicDefinition>{ get }
}
