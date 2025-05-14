import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selorgweb_main/order/provider/navigationprovider.dart';
import 'package:selorgweb_main/order/widgets/order_card_widget.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final isMobile = 550;
  List<dynamic> ordersList = [
    {
      "productImages": [
        'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/7283fcd62254bda5195b79e098bed8f702500baa?placeholderIfAbsent=true',
      ],
      "date": 'Placed at 21st Jun 2024, 08:50 am',
      "amount": 183.06,
    },
    {
      "productImages": [
        'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/6b7299222796bf71a08a6bcab095d336fb4ecb57?placeholderIfAbsent=true',
        'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/88a4b54152d62b3026b5c1208e25a1a8cbf2afdc?placeholderIfAbsent=true',
        'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/989aa679aa6d380776578e60da43cd3b8e8f1f8f?placeholderIfAbsent=true',
        'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/7a0e89b351f73931d432c45145be2ad4c43cf502?placeholderIfAbsent=true',
        'https://cdn.builder.io/api/v1/image/assets/06096b941d4746ae854b71463e363371/c467a04f4a2b7e9f08ce9dd1c82a4342877b2a6d?placeholderIfAbsent=true',
      ],
      "date": 'Placed at 21st Jun 2024, 08:50 am',
      "amount": 183.06,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ordersList.length > 0
        ? Column(
          children:
              ordersList.map((e) {
                return InkWell(
                  onTap: () {
                    context.read<Navigationprovider>().updatesectionId(4);
                  },
                  child: OrderCardWidget(
                    productImages: e['productImages'],
                    date: e['date'],
                    amount: e['amount'],
                  ),
                );
              }).toList(),
        )
        : Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 317,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/a694dfd8f620ad4f09ccf74f1458e59c6b460984',
                      width: 73,
                      height: 73,
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child: Text(
                            'No orders placed yet. Start exploring and items to your cart !',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Color(0xFF666666),

                              fontSize: 17.1,
                              fontWeight: FontWeight.w500,
                              height:
                                  28.5 /
                                  17.1, // Convert line-height to Flutter's height
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF034703),
                          ),
                          onPressed: () {
                            // Handle browse action
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 17,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF034703),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Browser Now',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,

                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height:
                                    60 /
                                    30, // Convert line-height to Flutter's height
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
  }
}
