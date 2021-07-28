#include <stdint.h>

#ifdef __ANDROID__
#define DART_EXPORT __attribute__((visibility("default"))) __attribute__((used))
#elif _WIN32
#define DART_EXPORT __declspec(dllexport)
#endif

#ifdef __cplusplus
extern "C" {
#endif

DART_EXPORT void initialize_print(void (*printCallback)(const char *));

DART_EXPORT int32_t add(int32_t x, int32_t y);

DART_EXPORT char *jsoncpp_example();

DART_EXPORT void native_free(void *ptr);

#ifdef __cplusplus
}
#endif