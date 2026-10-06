import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_detail_controller.dart';

class CreateCardScreen extends ConsumerStatefulWidget {
  final Deck deck;

  const CreateCardScreen({super.key, required this.deck});

  @override
  ConsumerState<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends ConsumerState<CreateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _termController = TextEditingController();
  final _phoneticController = TextEditingController();
  final _posController = TextEditingController(text: 'adj');
  final _meaningViController = TextEditingController();
  final _defEnController = TextEditingController();
  final _exampleEnController = TextEditingController();
  final _exampleViController = TextEditingController();

  // Exercise fields
  final _targetSentenceController = TextEditingController();
  final _sentenceViController = TextEditingController();
  final _distractorsController = TextEditingController();

  String _selectedCefr = 'B2';
  bool _isLoading = false;

  final List<String> cefrLevels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  @override
  void dispose() {
    _termController.dispose();
    _phoneticController.dispose();
    _posController.dispose();
    _meaningViController.dispose();
    _defEnController.dispose();
    _exampleEnController.dispose();
    _exampleViController.dispose();
    _targetSentenceController.dispose();
    _sentenceViController.dispose();
    _distractorsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final meanings = [
        {
          'order': 1,
          'pos': _posController.text.trim().isNotEmpty
              ? _posController.text.trim()
              : null,
          'meaning_vi': _meaningViController.text.trim(),
          'definition_en': _defEnController.text.trim().isNotEmpty
              ? _defEnController.text.trim()
              : null,
          'example_en': _exampleEnController.text.trim().isNotEmpty
              ? _exampleEnController.text.trim()
              : null,
          'example_vi': _exampleViController.text.trim().isNotEmpty
              ? _exampleViController.text.trim()
              : null,
        }
      ];

      List<Map<String, dynamic>>? exercises;
      if (_targetSentenceController.text.trim().isNotEmpty) {
        final sentence = _targetSentenceController.text.trim();
        final tokens = sentence.split(RegExp(r'\s+'));
        final distractors = _distractorsController.text.trim().isNotEmpty
            ? _distractorsController.text
                .trim()
                .split(',')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList()
            : <String>[];

        exercises = [
          {
            'exerciseType': 'fill_blank',
            'targetSentence': sentence,
            'vietnameseTranslation': _sentenceViController.text.trim().isNotEmpty
                ? _sentenceViController.text.trim()
                : null,
            'tokens': tokens,
            'distractorTokens': distractors,
            'meaningHint': _meaningViController.text.trim(),
          }
        ];
      }

      final controller =
          ref.read(deckCardsControllerProvider(widget.deck.id).notifier);
      await controller.createCard(
        term: _termController.text.trim(),
        phonetic: _phoneticController.text.trim().isNotEmpty
            ? _phoneticController.text.trim()
            : null,
        cefrLevel: _selectedCefr,
        meanings: meanings,
        exercises: exercises,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã thêm thẻ từ vựng mới thành công!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thêm thẻ thất bại: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm từ vào "${widget.deck.name}"'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Thông tin cơ bản
              _buildSectionHeader('1. Thông tin từ vựng'),
              const SizedBox(height: 12),
              TextFormField(
                controller: _termController,
                decoration: const InputDecoration(
                  labelText: 'Từ vựng (Term) *',
                  hintText: 'VD: resilient',
                  prefixIcon: Icon(Icons.spellcheck),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Vui lòng nhập từ vựng';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _phoneticController,
                      decoration: const InputDecoration(
                        labelText: 'Phiên âm IPA',
                        hintText: 'VD: /rɪˈzɪl.jənt/',
                        prefixIcon: Icon(Icons.record_voice_over_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _posController,
                      decoration: const InputDecoration(
                        labelText: 'Từ loại (pos)',
                        hintText: 'adj, noun...',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Cấp độ CEFR:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                children: cefrLevels.map((lvl) {
                  final isSelected = _selectedCefr == lvl;
                  return ChoiceChip(
                    label: Text(lvl),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.neutral900,
                    ),
                    onSelected: (val) {
                      if (val) setState(() => _selectedCefr = lvl);
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
              // Định nghĩa & Nghĩa tiếng Việt
              _buildSectionHeader('2. Nghĩa & Ví dụ minh hoạ'),
              const SizedBox(height: 12),
              TextFormField(
                controller: _meaningViController,
                decoration: const InputDecoration(
                  labelText: 'Nghĩa tiếng Việt *',
                  hintText: 'VD: kiên cường, mau phục hồi',
                  prefixIcon: Icon(Icons.translate),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Vui lòng nhập nghĩa tiếng Việt';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _defEnController,
                decoration: const InputDecoration(
                  labelText: 'Định nghĩa tiếng Anh (tùy chọn)',
                  hintText: 'VD: able to quickly return to a previous good condition',
                  prefixIcon: Icon(Icons.menu_book),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _exampleEnController,
                decoration: const InputDecoration(
                  labelText: 'Câu ví dụ tiếng Anh',
                  hintText: 'VD: She is a resilient woman who overcomes difficulties.',
                  prefixIcon: Icon(Icons.format_quote),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _exampleViController,
                decoration: const InputDecoration(
                  labelText: 'Dịch câu ví dụ',
                  hintText: 'VD: Cô ấy là một phụ nữ kiên cường vượt qua khó khăn.',
                  prefixIcon: Icon(Icons.subtitles_outlined),
                ),
              ),

              const SizedBox(height: 24),
              // Bài tập ngữ cảnh (SRS Exercise)
              _buildSectionHeader('3. Bài tập ngữ cảnh câu (Tùy chọn)'),
              const SizedBox(height: 6),
              const Text(
                'Tạo bài tập sắp xếp câu để ôn tập SRS thông minh hơn.',
                style: TextStyle(fontSize: 12, color: AppColors.neutral500),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _targetSentenceController,
                decoration: const InputDecoration(
                  labelText: 'Câu đích đầy đủ (Target sentence)',
                  hintText: 'VD: She remains resilient despite challenges',
                  prefixIcon: Icon(Icons.task_alt),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sentenceViController,
                decoration: const InputDecoration(
                  labelText: 'Bản dịch tiếng Việt của câu',
                  hintText: 'VD: Cô ấy vẫn kiên cường bất chấp thử thách',
                  prefixIcon: Icon(Icons.translate_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _distractorsController,
                decoration: const InputDecoration(
                  labelText: 'Từ gây nhiễu (phân tách bởi dấu phẩy)',
                  hintText: 'VD: weak, fragile, fragilely',
                  prefixIcon: Icon(Icons.shuffle),
                ),
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Lưu Thẻ Từ Vựng',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}
