//
//  ExampleService.swift
//
//
//  Created by Chris Hinkle on 9/7/24.
//

import Foundation
import CoreBluetooth

struct ExampleService:ServiceDefinition
{
	static let id:CBUUID = CBUUID.init( nsuuid:.init( uuidString:"448DF4C0-95C0-421C-8497-1A6CC5003C45" )! )
	
	struct NestedService:ServiceDefinition
	{
		static let id:CBUUID = CBUUID.init( nsuuid:.init( uuidString:"F7FB956D-7F2B-41E8-AE11-A88CC44F046B" )! )
		
		var includedServices: Array<any ServiceDefinition>
		{
			return [ ]
		}
		
		var characteristics: Array<any CharacteristicDefinition> = [ ]
	}
	
	struct NestedService2:ServiceDefinition
	{
		static let id:CBUUID = CBUUID.init( nsuuid:.init( uuidString:"FB4A7884-4EB9-4ECE-9981-BB8DB4A19757" )! )
		
		var includedServices: Array<any ServiceDefinition>
		{
			return [ ]
		}
		
		var characteristics: Array<any CharacteristicDefinition> = [ ]
	}
	
	var includedServices:Array<any ServiceDefinition>
	{
		return [ NestedService( ), NestedService2( ) ]
	}
	
	struct CoolInt:CharacteristicDefinition
	{
		typealias Value = Int
		static let id:CBUUID = CBUUID.init( nsuuid:.init( uuidString:"C3F93BA9-6A46-4E7C-A86C-2D8E2EF1E49C" )! )
	}
	
	struct CoolFloat:CharacteristicDefinition
	{
		typealias Value = Float
		static let id:CBUUID = CBUUID.init( nsuuid:.init( uuidString:"6C102A3E-A38D-48BC-98D9-923067517EF7" )! )
	}
	
	var characteristics: Array<any CharacteristicDefinition> = [ CoolInt( ), CoolFloat( ) ]
	
	
}
