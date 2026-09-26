import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UOverlay {
  OverlayEntry? _entry;
  final BuildContext context;

  UOverlay(this.context);

  void show({required String message, bool loading = false}) {
    hide();

    final overlay = Overlay.of(context);

    _entry = OverlayEntry(
      builder: (context) => Positioned(
        key: UniqueKey(),
        top: MediaQuery.of(context).size.height * 0.4,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                spacing: 6,
                children: [
                  if (loading)
                    CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_entry!);
  }

  void hide() {
    _entry?.remove();
    _entry = null;
  }

  void showWithTimeout({
    required String message,
    bool loading = false,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(message: message, loading: loading);
    Future.delayed(duration, hide);
  }
}
