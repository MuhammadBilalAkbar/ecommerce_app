import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../screens/checkout_screen.dart';
import '../utils/dialogs.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<CartProvider>(context, listen: false).initializeCart();
//   }
//
//   void _removeCartItem(BuildContext context, int index) {
//     final cart = Provider.of<CartProvider>(context, listen: false);
//     final removedItem = cart.items.values.toList()[index];
//
//     debugPrint('Removing item: ${removedItem.product.title}'); // Debugging line
//
//     cart.removeItem(removedItem.product.id);  // Ensure you are passing the correct ID
//     _listKey.currentState?.removeItem(
//       index,
//           (context, animation) => SlideTransition(
//         position: animation.drive(
//           Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).chain(
//             CurveTween(curve: Curves.easeInOut),
//           ),
//         ),
//         child: ListTile(
//           leading: Image.network(removedItem.product.image, width: 50),
//           title: Text(removedItem.product.title),
//           subtitle: Text('\$${removedItem.product.price.toString()}'),
//         ),
//       ),
//       duration: const Duration(milliseconds: 300),
//     );
//   }
//
//
//   void _updateCartItems(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       for (var i = 0; i < cart.items.length; i++) {
//         _listKey.currentState?.insertItem(i);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//     double height = MediaQuery.sizeOf(context).height;
//     if (_listKey.currentState == null) {
//       _updateCartItems(context);
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Cart'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: AnimatedList(
//               key: _listKey,
//               initialItemCount: cart.items.length,
//               itemBuilder: (ctx, index, animation) {
//                 if (index >= cart.items.length) {
//                   return Container(); // Handle invalid indices gracefully
//                 }
//
//                 final cartItem = cart.items.values.toList()[index];
//                 return SlideTransition(
//                   position: animation.drive(
//                     Tween<Offset>(
//                       begin: const Offset(1, 0),
//                       end: Offset.zero,
//                     ).chain(CurveTween(curve: Curves.easeInOut)),
//                   ),
//                   child: ListTile(
//                     leading: Image.network(cartItem.product.image, width: 50),
//                     title: Text(cartItem.product.title),
//                     subtitle: Text('\$${cartItem.product.price.toString()}'),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         DropdownButton<int>(
//                           value: cartItem.quantity,
//                           items: List.generate(10, (index) => index + 1)
//                               .map((quantity) => DropdownMenuItem(
//                             value: quantity,
//                             child: Text(quantity.toString()),
//                           ))
//                               .toList(),
//                           onChanged: (newQuantity) {
//                             if (newQuantity != null) {
//                               cart.updateItemQuantity(cartItem.product.id, newQuantity);
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             Dialogs().showRemoveConfirmationDialog(
//                               context,
//                               cartItem,
//                               onConfirmed: () => _removeCartItem(context, index),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 if (cart.items.isNotEmpty) {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const CheckoutScreen(),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context)
//                     ..removeCurrentSnackBar()
//                     ..showSnackBar(
//                       const SnackBar(
//                         content: Text('Your cart is empty!'),
//                       ),
//                     );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text(
//                 'Proceed to Checkout',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//         ],
//       ),
//     );
//   }
// }

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).initializeCart();
  }

  void _removeCartItem(BuildContext context, int index) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final removedItem = cart.items.values.toList()[index];

    cart.removeItem(removedItem.product.id);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => SlideTransition(
        position: animation.drive(
          Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: ListTile(
          leading: Image.network(removedItem.product.image, width: 50),
          title: Text(removedItem.product.title),
          subtitle: Text('\$${removedItem.product.price.toString()}'),
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: cart.items.length,
              itemBuilder: (ctx, index, animation) {
                final cartItem = cart.items.values.toList()[index];
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut)),
                  ),
                  child: ListTile(
                    leading: Image.network(cartItem.product.image, width: 50),
                    title: Text(cartItem.product.title),
                    subtitle: Text('\$${cartItem.product.price.toString()}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<int>(
                          value: cartItem.quantity,
                          items: List.generate(10, (index) => index + 1)
                              .map((quantity) => DropdownMenuItem(
                            value: quantity,
                            child: Text(quantity.toString()),
                          ))
                              .toList(),
                          onChanged: (newQuantity) {
                            if (newQuantity != null) {
                              cart.updateItemQuantity(
                                  cartItem.product.id, newQuantity);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Dialogs().showRemoveConfirmationDialog(
                              context,
                              cartItem,
                              onConfirmed: () => cart.removeItem(index),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (cart.items.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CheckoutScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Your cart is empty!'),
                      ),
                    );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }
}
