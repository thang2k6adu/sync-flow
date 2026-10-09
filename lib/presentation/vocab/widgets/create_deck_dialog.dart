import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';
import 'package:pp191225/shared/widgets/feedback/overlay.dart';

class CreateDeckDialog extends ConsumerStatefulWidget {
  const CreateDeckDialog({super.key});

  @override
  ConsumerState<CreateDeckDialog> createState() => _CreateDeckDialogState();
}

class _CreateDeckDialogState extends ConsumerState<CreateDeckDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCefr = 'B1';
  String _selectedCategory = 'IELTS';
  bool _isLoading = false;

  final List<String> cefrLevels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
  final List<String> categories = ['IELTS', 'TOEIC', 'Giao tiếp', 'Công việc', 'Học thuật'];

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final overlay = UOverlay(context);
    try {
      final controller = ref.read(deckListControllerProvider.notifier);
      await controller.createDeck(
        name: _nameController.text.trim(),
        description: _descController.text.trim().isNotEmpty
            ? _descController.text.trim()
            : null,
        category: _selectedCategory,
        cefrLevel: _selectedCefr,
      );

      if (mounted) {
        Navigator.of(context).pop();
        overlay.showWithTimeout(message: 'Tạo bộ từ vựng thành công');
      }
    } catch (e) {
      if (mounted) {
        overlay.showWithTimeout(message: 'Lỗi: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: ChunkyColors.border, width: 2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Tạo bộ từ vựng mới',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: ChunkyColors.textMain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Tên bộ từ *',
                    hintText: 'VD: IELTS Oxford 3000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.border, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.border, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.brand, width: 2),
                    ),
                    prefixIcon: const Icon(Icons.style_rounded, color: ChunkyColors.brand),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Vui lòng nhập tên bộ từ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _descController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Mô tả',
                    hintText: 'Mô tả ngắn gọn về bộ từ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.border, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.border, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.brand, width: 2),
                    ),
                    prefixIcon: const Icon(Icons.description_rounded, color: ChunkyColors.textSub),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cấp độ CEFR:',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ChunkyColors.textSub),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: cefrLevels.map((lvl) {
                    final isSelected = _selectedCefr == lvl;
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => setState(() => _selectedCefr = lvl),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? ChunkyColors.brandSoft : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? ChunkyColors.brand : ChunkyColors.border,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          lvl,
                          style: TextStyle(
                            color: isSelected ? ChunkyColors.brand : ChunkyColors.textMain,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Chủ đề',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.border, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.border, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ChunkyColors.brand, width: 2),
                    ),
                    prefixIcon: const Icon(Icons.category_rounded, color: ChunkyColors.brand),
                  ),
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                ),
                const SizedBox(height: 24),
                ChunkyButton(
                  label: _isLoading ? 'Đang tạo...' : 'Tạo bộ từ',
                  onPressed: _isLoading ? null : _submit,
                ),
                const SizedBox(height: 8),
                ChunkyButton.outlined(
                  label: 'Huỷ bỏ',
                  textColor: ChunkyColors.textSub,
                  onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
