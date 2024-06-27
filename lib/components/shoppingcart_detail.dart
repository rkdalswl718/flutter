import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppingcart/constants.dart';
import 'package:flutter_shoppingcart/components/shoppingcart_header.dart';

class ShoppingCartDetail extends StatefulWidget {
  const ShoppingCartDetail({super.key});

  @override
  _ShoppingCartDetailState createState() => _ShoppingCartDetailState();
}

class _ShoppingCartDetailState extends State<ShoppingCartDetail> {
  int likes = 999;
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likes--;
      } else {
        likes++;
      }
      isLiked = !isLiked;
    });
  }

  void changeImage() {
    final headerState = context.findAncestorStateOfType<ShoppingCartHeaderState>();
    headerState?.changeImage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailNameAndPrice(),
            _buildDetailRatingAndReviewCount(),
            _buildDetailButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailNameAndPrice() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Polaroid Love",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRatingAndReviewCount() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          const Text("마이해픈", style: TextStyle(fontSize: 16, color: Colors.grey)),
          const Spacer(),
          GestureDetector(
            onTap: toggleLike,
            child: Icon(
              Icons.favorite,
              color: isLiked ? Colors.red : Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            "($likes)",
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context) {
    return Align(
      child: TextButton(
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text("다음 음악으로 넘길까요?"),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                    changeImage(); // 이미지 변경 함수 호출
                  },
                  child: const Text(
                    "확인",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "취소",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: kAccentColor,
          minimumSize: const Size(320, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "다음",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
