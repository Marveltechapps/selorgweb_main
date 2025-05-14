import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilesection extends StatefulWidget {
  const Profilesection({Key? key}) : super(key: key);

  @override
  State<Profilesection> createState() => _ProfilesectionState();
}

class _ProfilesectionState extends State<Profilesection> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _mobile;
  String? _email;

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission
      print('Form submitted with:');
      print('Name: $_name');
      print('Mobile: $_mobile');
      print('Email: $_email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 806),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomInputField(
                    label: 'Name',
                    keyboardType: TextInputType.name,
                    onChanged: (value) => setState(() => _name = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.314),
                  CustomInputField(
                    label: 'Mobile Number',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => setState(() => _mobile = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.314),
                  CustomInputField(
                    label: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    helperText: 'We promise not spam you',
                    onChanged: (value) => setState(() => _email = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.314),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 278,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF034703),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34.961),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            height: 1, // equivalent to line-height: 14px
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final String? helperText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    required this.label,
    this.helperText,
    required this.keyboardType,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label*',
          style: GoogleFonts.poppins(
            color: Color(0xFF222222),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1, // equivalent to line-height: 20px
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          style: GoogleFonts.poppins(fontSize: 15),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.37),
              borderSide: const BorderSide(
                color: Color(0xFF222222),
                width: 1.093,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.37),
              borderSide: const BorderSide(
                color: Color(0xFF222222),
                width: 1.093,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.37),
              borderSide: const BorderSide(
                color: Color(0xFF222222),
                width: 1.093,
              ),
            ),
          ),
        ),
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              helperText!,
              style: GoogleFonts.poppins(
                color: Color(0xFF4E7909),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1, // equivalent to line-height: 17px
              ),
            ),
          ),
      ],
    );
  }
}
