import XCTest
import CoreBluetooth
@testable import CBGATT


enum FakeServices:String,ServiceDefinition
{
    case fake = "613E4B12-C744-420A-93AF-AC6E3CDFEE76"
    
    var characteristics: Set<CBUUID>
    {
        return [ ]
    }
    
    public var description:String
    {
        switch self
        {
        case .fake:
            return "Fake Service"
        }
    }
}

enum FakeCharacteristics:String,CharacteristicDefinition
{
    case fake = "4FF50274-038D-43BA-B833-B45111D3C009"
    
    public var description:String
    {
        switch self
        {
        case .fake:
            return "Fake Service"
        }
    }
    
    func model( with data:Data )->CharacteristicModel
    {
        fatalError( )
    }
    
    var shouldRead:Bool
    {
        return true
    }
    
    var shouldNotify:Bool
    {
        return true
    }
}


final class CBGATTTests:XCTestCase
{
    func testExample( )
    {
        
       
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
