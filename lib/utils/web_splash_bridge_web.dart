import 'dart:js_interop';

@JS('removeNativeSplash')
external void _removeNativeSplash();

@JS('splashAnimationStart')
external JSNumber? get _splashAnimationStart;

void removeNativeSplash() {
  try {
    _removeNativeSplash();
  } catch (_) {}
}

int? nativeSplashAnimationStartMs() {
  try {
    return _splashAnimationStart?.toDartInt;
  } catch (_) {
    return null;
  }
}
