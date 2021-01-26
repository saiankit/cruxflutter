import 'package:flutter/material.dart';
import 'package:myapp/cartProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ItemsScreen(),
      ),
    );
  }
}

// Item Screen - Lists all the items in the shop
class ItemsScreen extends StatefulWidget {
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Items Screen",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ItemWidget(itemName: "Apple"),
          ItemWidget(itemName: "Banana"),
          ItemWidget(itemName: "Orange"),
        ],
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  final String itemName;

  const ItemWidget({Key key, this.itemName}) : super(key: key);
  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 75.0,
        width: 400.0,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.itemName}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Consumer<CartProvider>(
                builder: (context, cartProvider, _) => IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    cartProvider.addItemToCart(widget.itemName);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Cart Screen - Shows you the items that you have added to your shopping bag
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Shopping Cart ${cartProvider.shoppingCart.length}",
          ),
        ),
        body: ListView.builder(
          itemCount: cartProvider.shoppingCart.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(color: Colors.amberAccent),
                child: Center(
                  child: Text(cartProvider.shoppingCart[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
