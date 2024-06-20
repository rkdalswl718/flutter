import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppingcart/constants.dart';

class ShoppingCartHeader extends StatefulWidget {
  const ShoppingCartHeader({Key? key}) : super(key: key);

  @override
  State<ShoppingCartHeader> createState() => _ShoppingCartHeaderState();
}

class _ShoppingCartHeaderState extends State<ShoppingCartHeader> {
  int selectedId = 0;

  List<String> albumArtworks = [
    "assets/p1.jpeg",
    "assets/p2.jpeg",
    "assets/p3.jpeg",
    "assets/p4.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAlbumArtwork(),
        _buildPlayerControls(),
      ],
    );
  }

  Widget _buildAlbumArtwork() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(
          albumArtworks[selectedId],
          fit: BoxFit.cover,
          width: 300, // Adjust as needed
          height: 300, // Adjust as needed
        ),
      ),
    );
  }

  Widget _buildPlayerControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(Icons.skip_previous, onTap: () {
            _changeSelectedId(-1); // 이전 앨범 아트워크
          }),
          _buildControlButton(Icons.play_arrow, size: 50.0, onTap: () {
            // Handle play button tap
          }),
          _buildControlButton(Icons.skip_next, onTap: () {
            _changeSelectedId(1); // 다음 앨범 아트워크
          }),
        ],
      ),
    );
  }

  void _changeSelectedId(int change) {
    setState(() {
      selectedId = (selectedId + change) % albumArtworks.length;
      if (selectedId < 0) {
        selectedId = albumArtworks.length - 1;
      }
    });
  }

  Widget _buildControlButton(IconData iconData, {double size = 40.0, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: kAccentColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          iconData,
          color: Colors.white,
          size: size * 0.6,
        ),
      ),
    );
  }
}
