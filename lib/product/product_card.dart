
import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String img;
  final Color backgroundColor;


  const ProductCard(
    {
    required this.title,
    required this.price,
    required this.img,
    required this.backgroundColor,

    super.key

    
    }
    
    
    );

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 5),
          Text("\$$price",
          style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 5),
          Center(child: Image.asset(img, height: 175,)),
        ],
      ),
    );
  }
}