import 'package:flutter/cupertino.dart';
import 'package:livink/models.dart';

class ProductDetailScreen extends StatelessWidget {
  final Record product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Product Details'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(
                    product.xlImage ?? product.lgImage ?? product.smImage ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.productDisplayName ?? '',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  product.brand ?? '',
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
                const SizedBox(height: 8),
                if (product.listPrice != product.promoPrice)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$${product.listPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${product.promoPrice!.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: CupertinoColors.systemRed, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Description:',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "${product.skuRepositoryId}\n${product.category}\n${product.productType}\n${product.dwPromotionInfo!.dwToolTipInfo} ${product.dwPromotionInfo!.dWPromoDescription}",
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(CupertinoIcons.star_fill,
                        color: CupertinoColors.systemYellow),
                    const SizedBox(width: 4),
                    Text(
                      product.productAvgRating?.toStringAsFixed(1) ?? 'N/A',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      CupertinoIcons.tag_fill,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      product.category ?? 'N/A',
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (product.variantsColor?.isNotEmpty == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Available Colors:',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      CupertinoSegmentedControl(
                        children: _buildColorSegments(context),
                        onValueChanged: (int? newValue) {
                          // Handle color selection here
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                CupertinoButton.filled(
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text('Success'),
                          content:
                              const Text('Product added to cart successfully'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                                Navigator.pop(
                                    context); // Navigate back to previous screen
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<int, Widget> _buildColorSegments(BuildContext context) {
    final Map<int, Widget> colorSegments = {};
    for (int i = 0; i < product.variantsColor!.length; i++) {
      final color = product.variantsColor![i];
      colorSegments[i] = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _parseColor(color.colorHex!),
          shape: BoxShape.circle,
        ),
      );
    }
    return colorSegments;
  }

  Color _parseColor(String color) {
    final hexColor = color.replaceFirst('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
