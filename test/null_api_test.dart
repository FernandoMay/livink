// import 'package:flutter/cupertino.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:livink/services.dart';
// import 'package:livink/view.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;

// class MockHttpClient extends Mock implements http.Client {}

// void main() {
//   testWidgets('Test Product Search View', (WidgetTester tester) async {
//     // Create a mock instance of HttpClient
//     final mockHttpClient = MockHttpClient();

//     // Create a sample JSON response with product data
//     // const jsonResponse = '''
//     //   {
//     //     "plpResults": {
//     //       "Products": [
//     //         {"name": "Product 1", "price": 10.0},
//     //         {"name": "Product 2", "price": 20.0},
//     //         {"name": "Product 3", "price": 15.0}
//     //       ]
//     //     }
//     //   }
//     // ''';

//     const jsonResponse = '''
//     ''';

//     // Set up the behavior of the mock HttpClient for the request
//     when(mockHttpClient.get(any, headers: anyNamed('headers')))
//         .thenAnswer((_) async => http.Response(jsonResponse, 200));

//     // Create an instance of ProductRepository with the mock HttpClient
//     final productRepository = ProductRepository();

//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const ProductSearchView());

//     // Enter a search term into the search field
//     await tester.enterText(find.byType(CupertinoSearchTextField), 'bolsa');

//     // Tap the search button
//     await tester.tap(find.text('Search'));

//     // Wait for the response to be processed
//     await tester.pump();

//     // Expect to see the status code and JSON response on the screen
//     expect(find.text('Status Code: 200'), findsOneWidget);
//     expect(
//       find.text(
//           'Response: [Product(name: Product 1, price: 10.0), Product(name: Product 2, price: 20.0), Product(name: Product 3, price: 15.0)]'),
//       findsOneWidget,
//     );

//     // Clear the search field
//     await tester.enterText(find.byType(CupertinoSearchTextField), '');

//     // Tap the search button again
//     await tester.tap(find.text('Search'));

//     // Wait for the response to be processed
//     await tester.pump();

//     // Expect to see the status code and a message for empty response
//     expect(find.text('Status Code: 200'), findsOneWidget);
//     expect(find.text('Response: No products found'), findsOneWidget);
//   });
// }


// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:mockito/mockito.dart';
// // import 'package:http/http.dart' as http;

// // // Create a mock HTTP client using Mockito
// // class MockHttpClient extends Mock implements http.Client {}

// // void main() {
// //   group('API Service Test', () {
// //     test('Test API response with null data', () async {
// //       // Arrange
// //       final mockClient = MockHttpClient();
// //       final apiService = ApiService(httpClient: mockClient);

// //       // Mock the API response
// //       when(mockClient.get(any))
// //           .thenAnswer((_) async => http.Response('null', 200));

// //       // Act
// //       final response = await apiService.getProducts('b');

// //       // Assert
// //       expect(response,
// //           isNull); // Expecting null because the API response is 'null'
// //     });

// //     test('Test API response with non-null data', () async {
// //       // Arrange
// //       final mockClient = MockHttpClient();
// //       final apiService = ApiService(httpClient: mockClient);

// //       // Sample JSON data
// //       final jsonData = '{"name": "Product 1", "price": 10}';

// //       // Mock the API response
// //       when(mockClient.get(any))
// //           .thenAnswer((_) async => http.Response(jsonData, 200));

// //       // Act
// //       final response = await apiService.getProducts('b');

// //       // Assert
// //       expect(response,
// //           isNotNull); // Expecting non-null response because the API response contains data
// //       expect(
// //           response['name'],
// //           equals(
// //               'Product 1')); // Make additional assertions on the data if needed
// //     });
// //   });
// // }
