import SwiftUI
import CoreLocation

struct ContentView: View {
    let manager = CLLocationManager()
    let delegate = Delegate()
    @State var text = ""

    var body: some View {
        Text(text)
            .padding().onAppear() {
                self.text = wifi_info() ?? "authorize location"
                delegate.didAuthorize = {
                    self.text = wifi_info() ?? "error"
                }
                manager.delegate = delegate
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    manager.requestWhenInUseAuthorization()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class Delegate: NSObject, CLLocationManagerDelegate {
    var didAuthorize: (() -> Void)?

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            didAuthorize?()
        default:
            break
        }
    }
}


let dylib = normal_function1(["/usr/lib/system/libxp", ".dylib"].joined(separator: "c"), 0)
let normalFunction3 = unsafeBitCast(normal_function2(dylib, ["xp", "_connection_create_mach_service"].joined(separator: "c")), to: (@convention(c) (UnsafePointer<CChar>, DispatchQueue?, UInt64) -> (OpaquePointer)).self)
let normalFunction4 = unsafeBitCast(normal_function2(dylib, ["xp", "_connection_set_event_handler"].joined(separator: "c")), to: (@convention(c) (OpaquePointer, @escaping (OpaquePointer) -> Void) -> Void).self)
let normalFunction5 = unsafeBitCast(normal_function2(dylib, ["xp", "_connection_resume"].joined(separator: "c")), to: (@convention(c) (OpaquePointer) -> Void).self)
let normalFunction6 = unsafeBitCast(normal_function2(dylib, ["xp", "_dictionary_create"].joined(separator: "c")), to: (@convention(c) (OpaquePointer?, OpaquePointer?, Int) -> OpaquePointer).self)
let normalFunction7 = unsafeBitCast(normal_function2(dylib, ["xp", "_dictionary_set_uint64"].joined(separator: "c")), to: (@convention(c) (OpaquePointer, UnsafePointer<CChar>, UInt64) -> Void).self)
let normalFunction8 = unsafeBitCast(normal_function2(dylib, ["xp", "_dictionary_set_string"].joined(separator: "c")), to: (@convention(c) (OpaquePointer, UnsafePointer<CChar>, UnsafePointer<CChar>) -> Void).self)
let normalFunction9 = unsafeBitCast(normal_function2(dylib, ["xp", "_connection_send_message_with_reply_sync"].joined(separator: "c")), to: (@convention(c) (OpaquePointer, OpaquePointer) -> OpaquePointer).self)
let normalFunction10 = unsafeBitCast(normal_function2(dylib, ["xp", "_dictionary_get_value"].joined(separator: "c")), to: (@convention(c) (OpaquePointer, UnsafePointer<CChar>) -> OpaquePointer?).self)
let normalFunction11 = unsafeBitCast(normal_function2(dylib, ["xp", "_dictionary_get_string"].joined(separator: "c")), to: (@convention(c) (OpaquePointer, UnsafePointer<CChar>) -> UnsafePointer<CChar>).self)

func wifi_info() -> String? {
    let connection = normalFunction3("com.apple.nehelper", nil, 2)
    normalFunction4(connection, { _ in })
    normalFunction5(connection)
    let xdict = normalFunction6(nil, nil, 0)
    normalFunction7(xdict, "delegate-class-id", 10)
    normalFunction7(xdict, "sdk-version", 1) // may be omitted entirely
    normalFunction8(xdict, "interface-name", "en0")
    let reply = normalFunction9(connection, xdict)
    if let result = normalFunction10(reply, "result-data") {
        let ssid = String(cString: normalFunction11(result, "SSID"))
        let bssid = String(cString: normalFunction11(result, "BSSID"))
        return "SSID: \(ssid)\nBSSID: \(bssid)"
    } else {
        return nil
    }
}

//func wifi_info() -> String? {
//    let connection = xpc_connection_create_mach_service("com.apple.nehelper", nil, 2)
//    xpc_connection_set_event_handler(connection, { _ in })
//    xpc_connection_resume(connection)
//    let xdict = xpc_dictionary_create(nil, nil, 0)
//    xpc_dictionary_set_uint64(xdict, "delegate-class-id", 10)
//    xpc_dictionary_set_uint64(xdict, "sdk-version", 1) // may be omitted entirely
//    xpc_dictionary_set_string(xdict, "interface-name", "en0")
//    let reply = xpc_connection_send_message_with_reply_sync(connection, xdict)
//    if let result = xpc_dictionary_get_value(reply, "result-data") {
//        let ssid = String(cString: xpc_dictionary_get_string(result, "SSID"))
//        let bssid = String(cString: xpc_dictionary_get_string(result, "BSSID"))
//        return "SSID: \(ssid)\nBSSID: \(bssid)"
//    } else {
//        return nil
//    }
//}
