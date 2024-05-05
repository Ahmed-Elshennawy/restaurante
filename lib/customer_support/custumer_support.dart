// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurante support'),
        backgroundColor: const Color(0XFFF7931E),
        elevation: 0,
      ),
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/6637c8e39a809f19fb2da840/1ht4uhe67',
        visitor: TawkVisitor(
          name: 'Ahmed Ibrahem', /// اسحب الاسم والايميل من الداتا بيز
          email: 'ahmedlshennawy90@gmail.com',
        ),
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
