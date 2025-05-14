import 'package:flutter/material.dart';
import '../constants/text_styles.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 991;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 70 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 68),
          Text('Categories', style: AppTextStyles.heading2),
          const SizedBox(height: 32),
          Wrap(
            spacing: 100,
            runSpacing: 40,
            children: [
              _buildCategoryColumn([
                'Fruits & Vegetables',
                'Groceries',
                'Fresh Fruits',
                'Fresh Veggies',
                'Leafy Herbs & Seasonings',
                'Dry Fruits & Nuts',
              ]),
              _buildCategoryColumn([
                'Dal',
                'Millets',
                'Rice & Cereals',
                'Grains & Pulses',
                'Seeds',
                'Whole spices & Seasoning',
              ]),
              _buildCategoryColumn([
                'Oil',
                'Honey & Spreads',
                'Sugar & Jaggery',
                'Attas & Flours',
                'Masalas & Powders',
              ]),
              _buildCategoryColumn([
                'Ghee',
                'Honey & Spreads',
                'Salts',
                'Beverages',
                'Noodles & Vermicelli',
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryColumn(List<String> items) {
    return SizedBox(
      width: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              item,
              style: AppTextStyles.categoryText,
            ),
          );
        }).toList(),
      ),
    );
  }
}