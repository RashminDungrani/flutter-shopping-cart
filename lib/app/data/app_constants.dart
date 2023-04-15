import 'dart:io';

import 'package:flutter/foundation.dart' as foundation;

const kIsWeb = foundation.kIsWeb;

final kIsIOS = kIsWeb ? false : Platform.isIOS;
final kIsAndroid = kIsWeb ? false : Platform.isAndroid;

const kReleaseMode = foundation.kReleaseMode;

// final kIsWindows = kIsWeb ? false : Platform.isWindows;
