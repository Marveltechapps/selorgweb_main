import 'package:flutter/material.dart';

class CouponPopup extends StatefulWidget {
  const CouponPopup({super.key});

  @override
  State<CouponPopup> createState() => _CouponPopupState();
}

class _CouponPopupState extends State<CouponPopup> {
  bool hasCoupons = true;
  bool isInvalidCode = false;
  List<String> coupons = ["FRS899", "FRS899", "FRS899"];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 500),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Coupon code',
                      filled: true,
                      fillColor: isInvalidCode ? Colors.red[50] : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => setState(() => isInvalidCode = true),
                  child: const Text(
                    'APPLY',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.green),
                ),
              ],
            ),
            if (isInvalidCode)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please enter a valid coupon code',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            if (!hasCoupons)
              const Column(
                children: [
                  Icon(Icons.percent, size: 64, color: Colors.green),
                  SizedBox(height: 8),
                  Text(
                    'No Available Coupons',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              )
            else
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: coupons.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.lightGreen[50],
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    coupons[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[900],
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text('APPLY'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Add Products worth ₹299 to avail this deal',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '+ MORE',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
