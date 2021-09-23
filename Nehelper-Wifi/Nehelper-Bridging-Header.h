@import Foundation;

typedef void * xpc_object_t;
typedef void * xpc_connection_t;
typedef void (^xpc_handler_t)(xpc_object_t object);

xpc_connection_t xpc_connection_create_mach_service(const char *name, dispatch_queue_t targetq, uint64_t flags);
void xpc_connection_set_event_handler(xpc_connection_t connection, xpc_handler_t handler);
void xpc_connection_resume(xpc_connection_t connection);
xpc_object_t xpc_dictionary_create(const char *const  _Nonnull *keys, xpc_object_t  _Nullable const *values, size_t count);
void xpc_dictionary_set_string(xpc_object_t xdict, const char *key, const char *string);
xpc_object_t xpc_connection_send_message_with_reply_sync(xpc_connection_t connection, xpc_object_t message);
const char * xpc_dictionary_get_string(xpc_object_t xdict, const char *key);
void xpc_dictionary_set_uint64(xpc_object_t xdict, const char *key, uint64_t value);
xpc_object_t xpc_dictionary_get_value(xpc_object_t xdict, const char *key);
char * xpc_copy_description(xpc_object_t object);
