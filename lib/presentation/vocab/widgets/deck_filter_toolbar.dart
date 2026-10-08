import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';

enum DeckSortField {
  name,
  cardCount,
  cefr,
  createdAt,
}

extension DeckSortFieldExt on DeckSortField {
  String get label {
    switch (this) {
      case DeckSortField.name:
        return 'Tên';
      case DeckSortField.cardCount:
        return 'Số từ';
      case DeckSortField.cefr:
        return 'Trình độ';
      case DeckSortField.createdAt:
        return 'Mới nhất';
    }
  }

  IconData get icon {
    switch (this) {
      case DeckSortField.name:
        return Icons.sort_by_alpha_rounded;
      case DeckSortField.cardCount:
        return Icons.format_list_numbered_rounded;
      case DeckSortField.cefr:
        return Icons.workspace_premium_rounded;
      case DeckSortField.createdAt:
        return Icons.schedule_rounded;
    }
  }
}

class DeckFilterToolbar extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final DeckSortField sortField;
  final ValueChanged<DeckSortField> onSortFieldChanged;
  final bool isAscending;
  final VoidCallback onToggleDirection;
  final int totalCount;

  const DeckFilterToolbar({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.sortField,
    required this.onSortFieldChanged,
    required this.isAscending,
    required this.onToggleDirection,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(color: colors.border, width: 1.2),
        ),
      ),
      child: Column(
        children: [
          // 1. Ô tìm kiếm trong kho từ
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: colors.surfaceMuted,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border, width: 1),
            ),
            child: TextField(
              onChanged: onSearchChanged,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 13,
                color: colors.textMain,
              ),
              decoration: InputDecoration(
                hintText: 'Tìm theo tên bộ từ, mô tả...',
                hintStyle: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 12,
                  color: colors.textSub.withOpacity(0.7),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: colors.textSub,
                  size: 18,
                ),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close_rounded, size: 16, color: colors.textSub),
                        onPressed: () => onSearchChanged(''),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 2. Thanh tiêu chí sắp xếp & Nút đảo chiều Tăng/Giảm
          Row(
            children: [
              // Tiêu chí sắp xếp
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: DeckSortField.values.map((field) {
                      final isSelected = sortField == field;
                      return GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          onSortFieldChanged(field);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? colors.brandSoft : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? colors.brand : colors.border,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                field.icon,
                                size: 14,
                                color: isSelected ? colors.brand : colors.textSub,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                field.label,
                                style: TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontSize: 11,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                  color: isSelected ? colors.brand : colors.textSub,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Nút Đảo chiều Tăng / Giảm (Sort Direction Toggle)
              Tooltip(
                message: isAscending ? 'Đang sắp xếp: Tăng dần' : 'Đang sắp xếp: Giảm dần',
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onToggleDirection();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: colors.brand.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.brand.withOpacity(0.25), width: 1.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isAscending ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                          size: 15,
                          color: colors.brand,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isAscending ? 'Tăng' : 'Giảm',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: colors.brand,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
