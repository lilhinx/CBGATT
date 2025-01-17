//
//  Device.swift
//  CBGATT
//
//  Created by Chris Hinkle on 1/16/25.
//

import Foundation
import CoreBluetooth
import os.log
import Combine


open class Device<Decoder:TopLevelDecoder>:NSObject,CBPeripheralDelegate
{
    private let log:OSLog = .init( subsystem:"CBGATT", category:"Device" )
    
  
    public let peripheral:CBPeripheral
    public let serviceDefinitions:[ServiceDefinition]
    public let readConfiguration:GATTReadConfiguration
    let decoder:Decoder
    public init( peripheral:CBPeripheral, serviceDefinitions:[ServiceDefinition], readConfiguration:GATTReadConfiguration, decoder:Decoder )
    {
        self.peripheral = peripheral
        self.serviceDefinitions = serviceDefinitions
        self.readConfiguration = readConfiguration
        self.decoder = decoder
        super.init( )
        peripheral.delegate = self
    }
    
    let isConnectedSubject:CurrentValueSubject<Bool,Never> = .init( false )
    
    public var isConnected:AnyPublisher<Bool,Never>
    {
        return isConnectedSubject.eraseToAnyPublisher( )
    }
    
    typealias CharacteristicSubject = CurrentValueSubject<(any Decodable)?,Never>
    private var characteristcsSubjects:[CBUUID:CharacteristicSubject] = [ : ]
    
    private func subject( for characteristic:CBUUID )->CharacteristicSubject
    {
        if !characteristcsSubjects.keys.contains( characteristic )
        {
            characteristcsSubjects[ characteristic ] = .init( nil )
        }
        return characteristcsSubjects[ characteristic ]!
    }
    
    public func publisher( for characteristic:CBUUID )->AnyPublisher<(any Decodable)?,Never>
    {
        return subject( for:characteristic ).eraseToAnyPublisher( )
    }
    
    func discover( )
    {
        peripheral.discoverServices( serviceDefinitions.allServices )
    }

    public func peripheral( _ peripheral:CBPeripheral, didDiscoverServices error:Error? )
    {
        guard let discoveredServices = peripheral.services else
        {
            return
        }
        
        for service in discoveredServices
        {
            guard let definition = serviceDefinitions.first( where:{ $0.id == service.uuid } ) else
            {
                continue
            }
            peripheral.discoverCharacteristics( definition.characteristicIdentifiers, for:service )
        }
    }
    
    public func peripheral( _ peripheral:CBPeripheral, didDiscoverCharacteristicsFor service:CBService, error:Error? )
    {
        guard let characteristics = service.characteristics else
        {
            return
        }
        
        for characteristic in characteristics
        {
            guard let serviceDefinition = serviceDefinitions.first( where:{ $0.id == service.uuid } ) else
            {
                continue
            }
            
            guard let definition = serviceDefinition.characteristics.first( where: { $0.id == characteristic.uuid } ) else
            {
                continue
            }
            
            if readConfiguration.shouldNotify( definition )
            {
                peripheral.setNotifyValue( true, for:characteristic )
            }
            else if readConfiguration.shouldRead( definition )
            {
                peripheral.readValue( for:characteristic )
            }
        }
    }
    
    public func peripheral( _ peripheral:CBPeripheral, didUpdateNotificationStateFor characteristic:CBCharacteristic, error:Error? )
    {
        if let error = error
        {
            os_log( "peripheral update notification state error: %{public}@", log:log, type:.error, error.localizedDescription )
            return
        }
        
        guard let definition = serviceDefinitions.flatMap( { $0.characteristics } ).first( where:{ $0.id == characteristic.uuid } ) else
        {
            os_log( "peripheral update notification state for unknown characteristic: %{public}@", log:log, type:.error, characteristic.uuid )
            return
        }
        
        if characteristic.isNotifying
        {
            os_log( "characteristic is notifying: %{public}@", log:log, type:.default, definition.description )
        }
        else
        {
            os_log( "characteristic is not notifying: %{public}@", log:log, type:.default, definition.description )
        }
    }
    
    public func peripheral( _ peripheral:CBPeripheral, didUpdateValueFor characteristic:CBCharacteristic, error:Error? )
    {
        if let error = error
        {
            os_log( "peripheral update notification State error: %{public}@", log:log, type:.error, error.localizedDescription )
            return
        }
        
        guard let definition = serviceDefinitions.flatMap( { $0.characteristics } ).first( where:{ $0.id == characteristic.uuid } ) else
        {
            os_log( "peripheral update value for unknown characteristic: %{public}@", log:log, type:.error, characteristic.uuid )
            return
        }
        
        let valueSubject:CharacteristicSubject = subject( for:characteristic.uuid )
        
        if let data = characteristic.value
        {
            do
            {
                valueSubject.value = try decoder.decode( definition.getValueType( ), from:data as! Decoder.Input )
            }
            catch
            {
                os_log( "peripheral update value decode error: %{public}@", log:log, type:.error, error.localizedDescription )
                valueSubject.value = nil
            }
        }
        else
        {
            valueSubject.value = nil
        }
    }
}
