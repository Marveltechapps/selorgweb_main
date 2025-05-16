import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selorgweb_main/order/screens/order_status.dart';

class AddressItem {
  final String title;
  final String subtitle;

  AddressItem({required this.title, required this.subtitle});
}

final List<AddressItem> addressList = [
  AddressItem(title: "Adyar", subtitle: "Adyar, Chennai, Tamil Nadu, India"),
  AddressItem(
    title: "Adyar bus depot",
    subtitle:
        "Adyar Bus Depot, Lattice Bridge Road, Shastri Nagar, Adyar, Chennai, Tamil Nadu, India",
  ),
  AddressItem(
    title: "Adyar Cancer Institute",
    subtitle: "Guindy National Park, Adyar, Chennai, Tamil Nadu, India",
  ),
  AddressItem(title: "Adyar", subtitle: "Adyar, Karnataka, India"),
  AddressItem(
    title: "Adyar Ananda Bhavan – A2B",
    subtitle: "A2B, Commercial Road, Adyar, Chennai",
  ),
  AddressItem(
    title: "Adyar Ananda Bhavan – A2B",
    subtitle: "A2B, Commercial Road, Adyar, Chennai",
  ),
  AddressItem(
    title: "Adyar Ananda Bhavan – A2B",
    subtitle: "A2B, Commercial Road, Adyar, Chennai",
  ),
];

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});
  @override
  Widget build(BuildContext context) {
    bool isaddressadded = true;
    final isMobile = MediaQuery.of(context).size.width < 500;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 35,
        vertical: 18,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x40666666),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child:
          isaddressadded
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: isMobile ? 150 : 220,
                        child: Text(
                          'Other - 13, 8/22,Dr Muthu  Lakshmi Rd, Djdskjskdnamn amnsamns',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF666666),
                            fontSize: 15,
                          ),

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        spacing: isMobile ? 5 : 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.string(
                            '''
                <svg width="25" height="27" viewBox="0 0 25 27" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M19.3743 5.76411C21.0365 7.37333 21.9872 9.54538 22.0253 11.821C22.0634 14.0966 21.186 16.2974 19.5785 17.9579L19.3743 18.1624L15.1058 22.2942C14.5642 22.8183 13.8371 23.1234 13.0718 23.1479C12.3065 23.1723 11.5603 22.9141 10.9842 22.4257L10.8393 22.2942L6.56985 18.1615C4.87188 16.5175 3.91797 14.2877 3.91797 11.9628C3.91797 9.63783 4.87188 7.4081 6.56985 5.76411C8.26782 4.12012 10.5708 3.19653 12.9721 3.19653C15.3733 3.19653 17.6763 4.12012 19.3743 5.76411ZM12.9721 9.04072C12.5757 9.04072 12.1833 9.1163 11.8171 9.26315C11.4509 9.41 11.1182 9.62524 10.838 9.89658C10.5577 10.1679 10.3354 10.49 10.1838 10.8446C10.0321 11.1991 9.95404 11.5791 9.95404 11.9628C9.95404 12.3465 10.0321 12.7265 10.1838 13.081C10.3354 13.4355 10.5577 13.7577 10.838 14.029C11.1182 14.3003 11.4509 14.5156 11.8171 14.6624C12.1833 14.8093 12.5757 14.8849 12.9721 14.8849C13.7725 14.8849 14.5401 14.577 15.1061 14.029C15.6721 13.481 15.9901 12.7378 15.9901 11.9628C15.9901 11.1878 15.6721 10.4446 15.1061 9.89658C14.5401 9.34858 13.7725 9.04072 12.9721 9.04072Z" 
    fill="#034703"/>
</svg>

                ''',
                            width: 20,
                            height: 22,
                            color: Color(0xFF034703),
                          ),
                          Text(
                            'Change',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF034703),
                              fontSize: isMobile ? 12 : 14,
                              fontWeight: FontWeight.w500,
                              height: 1.32, // 29/22
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'To Pay',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(0, 0, 0, 0.75),
                            ),
                          ),
                          Text(
                            '₹92',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(0, 0, 0, 0.85),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // showAddressPopup(context);
                          showConfirmAddress(context);
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => OrderStatus(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                          backgroundColor: const Color(0xFF034703),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 0 : 10,
                          ),
                          // width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(),
                          child: Center(
                            child: Text(
                              'Continue to Payment',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: isMobile ? 12 : 16,
                                fontWeight: FontWeight.w500,
                                height: 0.81, // 14.5/18
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.string(
                        '''
                <svg width="25" height="27" viewBox="0 0 25 27" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M19.3743 5.76411C21.0365 7.37333 21.9872 9.54538 22.0253 11.821C22.0634 14.0966 21.186 16.2974 19.5785 17.9579L19.3743 18.1624L15.1058 22.2942C14.5642 22.8183 13.8371 23.1234 13.0718 23.1479C12.3065 23.1723 11.5603 22.9141 10.9842 22.4257L10.8393 22.2942L6.56985 18.1615C4.87188 16.5175 3.91797 14.2877 3.91797 11.9628C3.91797 9.63783 4.87188 7.4081 6.56985 5.76411C8.26782 4.12012 10.5708 3.19653 12.9721 3.19653C15.3733 3.19653 17.6763 4.12012 19.3743 5.76411ZM12.9721 9.04072C12.5757 9.04072 12.1833 9.1163 11.8171 9.26315C11.4509 9.41 11.1182 9.62524 10.838 9.89658C10.5577 10.1679 10.3354 10.49 10.1838 10.8446C10.0321 11.1991 9.95404 11.5791 9.95404 11.9628C9.95404 12.3465 10.0321 12.7265 10.1838 13.081C10.3354 13.4355 10.5577 13.7577 10.838 14.029C11.1182 14.3003 11.4509 14.5156 11.8171 14.6624C12.1833 14.8093 12.5757 14.8849 12.9721 14.8849C13.7725 14.8849 14.5401 14.577 15.1061 14.029C15.6721 13.481 15.9901 12.7378 15.9901 11.9628C15.9901 11.1878 15.6721 10.4446 15.1061 9.89658C14.5401 9.34858 13.7725 9.04072 12.9721 9.04072Z" 
    fill="#034703"/>
</svg>

                ''',
                        width: isMobile ? 22 : 24,
                        height: isMobile ? 24 : 26,
                        color: Color(0xFF034703),
                      ),
                      Text(
                        'Enter your Delivery Address',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF034703),
                          fontSize: isMobile ? 14 : 18,
                          fontWeight: FontWeight.w500,
                          height: 1.32, // 29/22
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  ElevatedButton(
                    onPressed: () {
                      showAddressPopup(context);
                      // showConfirmAddress(context);
                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      backgroundColor: const Color(0xFF034703),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(),
                      child: Center(
                        child: Text(
                          'Add Address to Proceed',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 0.81, // 14.5/18
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }

  void showAddressPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 400,
            // height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Search Field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xFF034703),
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: "Search a new address",
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Address List
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 6,
                      radius: const Radius.circular(8),

                      child: ListView.separated(
                        itemCount: addressList.length,
                        separatorBuilder:
                            (_, __) => Divider(color: Colors.grey.shade500),
                        itemBuilder: (context, index) {
                          final item = addressList[index];
                          return ListTile(
                            leading: SvgPicture.asset(
                              'icons/location.svg',
                              color: Color(0xFF034703),
                              width: 30,
                            ),
                            title: Text(
                              item.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              item.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              // Handle tap
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showConfirmAddress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // allows tap outside to close
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 300,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('icons/check_address.png', width: 65, height: 65),
                SizedBox(height: 16),
                Text(
                  'Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your address has been saved',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF034703),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(double.infinity, 45),
                  ),
                  onPressed: () {
                    // Handle button action
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
