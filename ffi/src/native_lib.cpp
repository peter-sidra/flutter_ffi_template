#include "native_lib.h"
#include <functional>
#include <iostream>

#include "json/json.h"

std::function<void(const char *)> dart_print = nullptr;

void initialize_print(void (*printCallback)(const char *)) {
	dart_print = printCallback;
	dart_print("C library initialized");
}

int32_t add(int32_t x, int32_t y) {
	return x + y;
}

char *jsoncpp_example() {
	Json::Value root;
	Json::Value data;
	root["action"] = "run";
	data["number"] = 1;
	root["data"] = data;

	Json::StreamWriterBuilder builder;
	const std::string json_string = Json::writeString(builder, root);
	dart_print(json_string.c_str());

	auto len = json_string.length() + 1;
	char *ret = (char *)malloc(len * sizeof(char));
	strncpy(ret, json_string.c_str(), len);

	return ret;
}

void native_free(void *ptr) {
	free(ptr);
}