import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/card_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({required this.product, super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product['title'] as String,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              Image.asset(
                                widget.product['imageUrl'] as String,
                                height: 250,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: _buildDetailsSection(context),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          widget.product['title'] as String,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Image.asset(
                          widget.product['imageUrl'] as String,
                          height: 250,
                        ),
                        const SizedBox(height: 16),
                        _buildDetailsSection(context),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 247, 249, 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\$${widget.product['price']}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (widget.product['sizes'] as List<int>).length,
              itemBuilder: (context, index) {
                final size = (widget.product['sizes'] as List<int>)[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    child: Chip(
                      label: Text(size.toString()),
                      backgroundColor: selectedSize == size
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[200],
                      labelStyle: TextStyle(
                        color: selectedSize == size ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedSize == null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Select Shoe Size"),
                      content: const Text("Please select a shoe size before adding to cart."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  Provider.of<CartProvider>(context, listen: false).addProduct(widget.product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Added successfully"),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                fixedSize: const Size(350, 50),
              ),
              child: const Text(
                'Add To Cart',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
