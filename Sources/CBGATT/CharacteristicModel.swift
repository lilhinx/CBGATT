//
//  CharacteristicModel.swift
//
//
//  Created by Chris Hinkle on 10/3/20.
//

import Foundation

public protocol CharacteristicModel
{
	static var dataLength:Int{ get }
	init( bytes:[UInt8] )
}

extension CharacteristicModel
{
	public init( characteristicValue:Data )
	{
		var bytes:[UInt8] = Array( repeating:0, count:Self.dataLength );
		( characteristicValue as NSData ).getBytes( &bytes, length:Self.dataLength )
		self.init( bytes:bytes )
	}
	
	public static func empty( )->Self
	{
		return Self.init( bytes:[UInt8].init( repeating:0, count:dataLength ) )
	}
}
