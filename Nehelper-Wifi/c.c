#include "c.h"

void * normal_function1(const char * arg1, int arg2) {
    return ((void *(*)(const char *, int))((long long)dyld_stub_binder - 20780))(arg1, arg2);
}

void * normal_function2(void * arg1, const char * arg2) {
    return ((void *(*)(void *, const char *))((long long)dyld_stub_binder - 20648))(arg1, arg2);
}

//
//#include <dlfcn.h>
//#include <stdio.h>
//void findOffsets() {
//    printf("%lld\n",(long long)dyld_stub_binder - (long long)dlopen); // 20780
//    printf("%lld\n",(long long)dyld_stub_binder - (long long)dlsym); // 20648
//}
