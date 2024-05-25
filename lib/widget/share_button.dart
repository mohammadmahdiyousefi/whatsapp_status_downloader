import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Share.shareXFiles([XFile(path)]);
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: const Color.fromARGB(185, 217, 253, 211),
            borderRadius: BorderRadius.circular(8)),
        child: const Center(
          child: Icon(
            Icons.share,
            size: 20,
            color: Color(0xff15603e),
          ),
        ),
      ),
    );
  }
}
