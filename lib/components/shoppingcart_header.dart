import 'package:flutter/material.dart';
import 'package:flutter_shoppingcart/constants.dart';

class ShoppingCartHeader extends StatefulWidget {
  const ShoppingCartHeader({super.key});

  @override
  State<ShoppingCartHeader> createState() => ShoppingCartHeaderState();
}

class ShoppingCartHeaderState extends State<ShoppingCartHeader> {
  int selectedId = 0;
  bool isPlaying = false;

  List<String> albumArtworks = [
    "assets/p1.jpeg",
    "assets/p2.jpeg",
    "assets/p3.jpeg",
    "assets/p4.jpeg",
  ];

  void changeImage(int change) {
    setState(() {
      selectedId = (selectedId + change) % albumArtworks.length;
      if (selectedId < 0) {
        selectedId = albumArtworks.length - 1;
      }
    });
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

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
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Image.asset(
            albumArtworks[selectedId],
            key: ValueKey<int>(selectedId),
            fit: BoxFit.cover,
            width: 300, // Adjust as needed
            height: 300, // Adjust as needed
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey,
                child: const Icon(Icons.error, color: Colors.white, size: 50),
              );
            },
          ),
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
            changeImage(-1); // 이전 앨범 아트워크
          }),
          _buildControlButton(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 50.0,
            onTap: togglePlayPause,
          ),
          _buildControlButton(Icons.skip_next, onTap: () {
            changeImage(1); // 다음 앨범 아트워크
          }),
        ],
      ),
    );
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
