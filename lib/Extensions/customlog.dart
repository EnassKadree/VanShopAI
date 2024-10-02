import 'dart:developer';

void logWarning(String? text) => log('\x1B[35m$text\x1B[0m');

void logError(String? text) => log('\x1B[31m$text\x1B[0m');

void logInfo(String? text) => log('\x1B[37m$text\x1B[0m');

void logSuccess(String? text) => log('\x1B[32m$text\x1B[0m');