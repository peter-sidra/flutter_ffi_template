#include <stdint.h>

#define DART_EXPORT __attribute__((visibility("default"))) __attribute__((used))

#ifdef __cplusplus
extern "C" {
#endif

DART_EXPORT void initialize_print(void (*printCallback)(const char *));

DART_EXPORT int32_t add(int32_t x, int32_t y);

DART_EXPORT char *jsoncpp_example();

#ifdef __cplusplus
}
#endif