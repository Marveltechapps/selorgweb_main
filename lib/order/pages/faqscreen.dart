import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 822),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQ',
              style: AppStyles.titleStyle,
              semanticsLabel: 'Frequently Asked Questions',
            ),
            const SizedBox(height: 20),
            const FAQItem(
              question: 'What is Selorg?',
              answer:
                  'Selorg is a premium organic grocery delivery service, committed to bringing you the freshest, 100% organic produce and daily essentials right to your doorstep.',
            ),
            const FAQItem(
              question: 'How does Selorg work?',
              answer:
                  'Download the Selorg app, sign up, explore a wide range of organic products, add them to your cart, and place your order. Our delivery partner will ensure your organic goodies arrive fresh and fast.',
            ),
            const FAQItem(
              question: 'Why are Organic products expensive than normal?',
              answer:
                  'Organic products are grown by a small section of farmers due to low yield and the 3-4 years needed to prepare soil. Limited supply raises costs. As awareness of health benefits grows, more farmers will produce organic goods, reducing prices. Ultimately, organic prices should align with market expectations for both consumers and farmers.',
            ),
            const FAQItem(
              question: 'Are your farms Organic certified?',
              answer:
                  'Most of our products come from Certified Farms, but we also source from small organic farmers. We regularly visit farms to monitor quality and consult with retailers before partnering with new sources. We appreciate your support in guiding smaller farmers to obtain certification.',
            ),
            const FAQItem(
              question: 'What is the delivery fee?',
              answer:
                  'Delivery is free for orders above 299rs. For smaller orders, a delivery fees will applies.',
            ),
            const FAQItem(
              question: 'Can I schedule my delivery?',
              answer:
                  'Currently, we don\'t offer delivery scheduling. Orders are delivered as quickly as possible after confirmation.',
            ),
            const FAQItem(
              question: 'What if an item I ordered is out of stock?',
              answer:
                  'In rare cases when an item is unavailable, we\'ll notify you immediately and offer alternatives or issue a quick refund.',
            ),
            const FAQItem(
              question: 'How do I pay for my order?',
              answer:
                  'We accept multiple payment options, including credit/debit cards, UPI, digital wallets, and cash on delivery.',
            ),
            const FAQItem(
              question: 'Can I modify my order after placing it?',
              answer:
                  'Order modifications and cancellations are not available at the moment. Please double-check your cart before placing your order.',
            ),
            const FAQItem(
              question: 'What if I receive a wrong or damaged item?',
              answer:
                  'If you receive an incorrect or damaged product, please report it through the Support@sodakku.com and we’ll replace it or issue a refund.',
            ),
            const FAQItem(
              question: 'How can I track my order?',
              answer:
                  'Once your order is confirmed, you can track its real-time status through the app until it reaches your doorstep.',
            ),
            const FAQItem(
              question: 'How do I return an item?',
              answer:
                  'Currently, we don\'t offer a return option. Please check your order carefully before confirming your purchase.',
            ),
            const FAQItem(
              question: 'Is my personal information secure?',
              answer:
                  'Absolutely. We prioritize your privacy and use advanced security measures to protect your data.',
            ),
            const FAQItem(
              question: 'How can I provide feedback?',
              answer:
                  'We love hearing from you! Rate your experience through the app or drop us a message in the feedback section.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: AppStyles.questionStyle,
            semanticsLabel: question,
          ),
          const SizedBox(height: 5),
          Text(answer, style: AppStyles.answerStyle, semanticsLabel: answer),
        ],
      ),
    );
  }
}

class AppStyles {
  static const Color textPrimaryColor = Color(0xFF444444);
  static const Color textSecondaryColor = Color(0xFF777777);

  static TextStyle titleStyle = GoogleFonts.poppins(
    // fontFamily: 'Poppins',
    fontSize: 33,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    height: 1.0,
  );

  static TextStyle questionStyle = GoogleFonts.poppins(
    // fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    height: 2.0,
  );

  static TextStyle answerStyle = GoogleFonts.poppins(
    // fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
    height: 1.44, // 23px line height / 16px font size
  );
}
