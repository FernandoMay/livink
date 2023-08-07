// import 'package:flutter/cupertino.dart';
// import 'package:livink/services.dart';

// class ProductSearchView extends StatefulWidget {
//   const ProductSearchView({Key? key}) : super(key: key);

//   @override
//   _ProductSearchViewState createState() => _ProductSearchViewState();
// }

// class _ProductSearchViewState extends State<ProductSearchView> {
//   final TextEditingController _searchController = TextEditingController();
//   String _responseJson = '';
//   String _statusCode = '';

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text('Product Search'),
//       ),
//       child: CustomScrollView(
//         slivers: [
//           SliverPadding(
//             padding: const EdgeInsets.all(16.0),
//             sliver: SliverToBoxAdapter(
//               child: CupertinoSearchTextField(
//                 controller: _searchController,
//                 placeholder: 'Enter product name',
//                 onChanged: (value) {
//                   _fetchProducts();
//                 },
//                 onSubmitted: (value) {
//                   _fetchProducts();
//                 },
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Status Code: $_statusCode'),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Response JSON: $_responseJson'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _fetchProducts() async {
//     try {
//       final searchTerm = _searchController.text;
//       final repository = ProductRepository();
//       final products = await repository.searchProducts(searchTerm);

//       setState(() {
//         _statusCode = products.status!.statusCode.toString();
//         _responseJson = products.plpResults!.records.toString();
//       });
//     } catch (e) {
//       setState(() {
//         _statusCode = e.toString();
//         _responseJson = 'Error fetching products: $e';
//       });
//     }
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:livink/detail.dart';
import 'package:livink/models.dart';
import 'package:livink/services.dart';

class ProductSearchView extends StatefulWidget {
  const ProductSearchView({super.key});

  @override
  _ProductSearchViewState createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ProductSearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<Record> _products = [];
  String _currentSortOption = 'Relevancia|0';

  List<Widget> _buildSortOptions() {
    return [
      const Text('Relevancia'),
      const Text('Lo Más Nuevo'),
      const Text('Menor precio'),
      const Text('Mayor precio'),
      const Text('Calificaciones'),
      const Text('Más visto'),
      const Text('Más vendido'),
    ];
  }

  void _onSortOptionChanged(int index) {
    final sortOptions = [
      'Relevancia|0',
      'newArrival|1',
      'sortPrice|0',
      'sortPrice|1',
      'rating|1',
      'viewed|1',
      'sold|1',
    ];

    setState(() {
      _currentSortOption = sortOptions[index];
    });

    _fetchProducts();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Búsqueda de Producto'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Ingresa nombre de producto',
                onChanged: (value) => _fetchProducts(),
                onSubmitted: (value) => _fetchProducts(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: CupertinoFormRow(
                prefix: const Text('Ordenar por:'),
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  onSelectedItemChanged: (index) => _onSortOptionChanged(index),
                  children: _buildSortOptions(),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildProductItem(_products[index]),
              childCount: _products.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchProducts() async {
    try {
      final searchTerm = _searchController.text;
      final repository = ProductRepository();
      final products = await repository.searchProducts(
        searchTerm,
        sortOption: _currentSortOption,
      );
      setState(() {
        _products = products.plpResults!.records!;
      });
    } catch (e) {
      setState(() {
        _products = [Record(productDisplayName: e.toString())];
      });
    }
  }

  Widget _buildProductItem(Record product) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.lgImage ?? "https://picsum.photos/500",
              width: MediaQuery.of(context).size.width * 0.31416,
              height: MediaQuery.of(context).size.width * 0.31416,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.productDisplayName ?? "Product Name",
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .textStyle
                        .copyWith(fontSize: 16),
                  ),
                ),
                if (product.listPrice != product.promoPrice)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$${product.listPrice?.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${product.promoPrice?.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: CupertinoColors.systemRed, fontSize: 24),
                  ),
                ),
                if (product.variantsColor != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Colores disponibles:',
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .textStyle
                              .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 4),
                        Wrap(
                          spacing: 4,
                          children: product.variantsColor!
                              .map(
                                (color) => Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: _parseColor(
                                        color.colorHex ?? '#3A5C7F'),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String color) {
    final hexColor = color.replaceFirst('#', '');
    return Color(int.parse('FF$hexColor', radix: 16));
  }
}
