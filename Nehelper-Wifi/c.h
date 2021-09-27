#ifndef c_h
#define c_h

#define NO_UND(func) extern void func(void) asm(#func);
NO_UND(dyld_stub_binder);

void * normal_function1(const char * arg1, int arg2); // dlopen
void * normal_function2(void * arg1, const char * arg2); // dlsym
//void findOffsets();

#endif /* c_h */
