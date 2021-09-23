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

func wifi_info() -> String? {
    let connection = xpc_connection_create_mach_service("com.apple.nehelper", nil, 2)
    xpc_connection_set_event_handler(connection, { _ in })
    xpc_connection_resume(connection)
    let xdict = xpc_dictionary_create(nil, nil, 0)
    xpc_dictionary_set_uint64(xdict, "delegate-class-id", 10)
    xpc_dictionary_set_uint64(xdict, "sdk-version", 1) // may be omitted entirely
    xpc_dictionary_set_string(xdict, "interface-name", "en0")
    let reply = xpc_connection_send_message_with_reply_sync(connection, xdict)
    if let result = xpc_dictionary_get_value(reply, "result-data") {
        let ssid = String(cString: xpc_dictionary_get_string(result, "SSID"))
        let bssid = String(cString: xpc_dictionary_get_string(result, "BSSID"))
        return "SSID: \(ssid)\nBSSID: \(bssid)"
    } else {
        return nil
    }
}
