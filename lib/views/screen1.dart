import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homescr(),
    );
  }
}

class Homescr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop by Category'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenScreen()),
              );
            },
            child: CategoryContainer(
              image: 'assets/logo/snbird2.jpg',
              label: 'MEN',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WomenScreen()),
              );
            },
            child: CategoryContainer(
              image: 'assets/logo/snbird3.jpg',
              label: 'WOMEN',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PetsScreen()),
              );
            },
            child: CategoryContainer(
              image: 'assets/logo/snbird4.jpg',
              label: 'PETS',
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final String image;
  final String label;

  CategoryContainer({required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Men'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductTile(
            image: 'assets/logo/snbird4.jpg',
            title: '2-Pack Crewneck T-Shirts',
            price: '\$12.99',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    image: 'assets/logo/snbird4.jpg',
                    title: '2-Pack Crewneck T-Shirts - Black',
                    price: '\$12.99',
                  ),
                ),
              );
            },
          ),
          // Add more products here
        ],
      ),
    );
  }
}

class WomenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Women'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductTile(
            image: 'assets/logo/snbird3.jpg',
            title: 'Women\'s Dress',
            price: '\$29.99',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    image: 'assets/logo/snbird3.jpg',
                    title: 'Women\'s Dress',
                    price: '\$29.99',
                  ),
                ),
              );
            },
          ),
          // Add more products here
        ],
      ),
    );
  }
}

class PetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pets'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          ProductTile(
            image: 'assets/logo/snbird4.jpg',
            title: 'Dog Food',
            price: '\$19.99',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    image: 'assets/logo/snbird4.jpg',
                    title: 'Dog Food',
                    price: '\$19.99',
                  ),
                ),
              );
            },
          ),
          // Add more products here
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback? onTap;

  ProductTile({required this.image, required this.title, required this.price, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.yellowAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  ProductDetailsScreen({required this.image, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                image,
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer quis purus laoreet, efficitur libero vel, feugiat ante. Vestibulum tempor, ligula.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Size',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizeOption(label: 'S'),
                SizeOption(label: 'M'),
                SizeOption(label: 'L'),
                SizeOption(label: 'XL'),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String label;

  SizeOption({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(label),
      ),
    );
  }
}
