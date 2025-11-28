import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/cupertino.dart';

class GuestPulsaProdukPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/pulsa/produk';

  const GuestPulsaProdukPage({super.key});

  @override
  State<GuestPulsaProdukPage> createState() => _GuestPulsaProdukPageState();
}

class _GuestPulsaProdukPageState extends State<GuestPulsaProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Guest Pulsa Produk Page',
        style: CupertinoTheme.of(context).textTheme.textStyle,
      ),
    );
  }
}
