import 'package:flutter/material.dart';

  /// Static helper method to easily show this bottom sheet and get the selected value
  /// 
  /// Example:
  /// ```dart
  /// final selected = await BottomSheetPicker.show<String>(
  ///   context,
  ///   title: "Select Gender",
  ///   options: [
  ///     BottomSheetOption(label: "Male", value: "male"),
  ///     BottomSheetOption(label: "Female", value: "female"),
  ///   ],
  /// );
  /// print(selected); // "male" or "female"
  /// ```

typedef BottomSheetOptionTap<T> = void Function(T value);

class BottomSheetPicker<T> extends StatelessWidget {
  final String title;
  final List<BottomSheetOption<T>> options;

  const BottomSheetPicker({
    super.key,
    required this.title,
    required this.options,
  });

  static Future<T?> show<T>(BuildContext context, {required String title, required List<BottomSheetOption<T>> options}) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheetPicker<T>(
          title: title,
          options: options,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                const Divider(height: 1),
                ...options.map((o) => Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(o.value);
                          },
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            child: Text(
                              o.label,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: o.highlight ? FontWeight.w600 : FontWeight.normal,
                                color: o.highlight ? Colors.black : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                    )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: ListTile(
              title: const Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
        ],
      ),
    );
  }
}

class BottomSheetOption<T> {
  final String label;
  final T value;
  final bool highlight;

  BottomSheetOption({
    required this.label,
    required this.value,
    this.highlight = false,
  });
}
