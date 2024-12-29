import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.purple.withOpacity(0.4),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.withOpacity(0.4), Colors.purple.withOpacity(0.4),Colors.blue.withOpacity(0.2)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.only(left: 28.0, right: 27, top: 9),
                  color: Colors.transparent, // Semi-transparent background
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hey! VeggieMart Customer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: Icon(Icons.flash_on, color: Colors.orange),
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                '82',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'assets/vip.png'  ,fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Get",
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "VIP",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.deepPurple),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'access',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 19),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12.0, bottom: 36),
                      child: Text(
                        "Your  Coins",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.0),
                      color: Colors.white.withOpacity(0.4),
                    border: Border.all(color: Colors.white70, width: 1.0),
                  ),
                 // Semi-transparent background
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Credit Options',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListTile(
                        leading: Icon(Icons.account_balance_wallet, color: Colors.orange),
                        title: Text('Personal Loan'),
                        subtitle: Text('Quick cash up to ₹10,00,000.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.credit_card, color: Colors.orange),
                        title: Text('VM Axis Bank Credit Card'),
                        subtitle: Text('Apply & enter world of unlimited benefits!'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.payment, color: Colors.orange),
                        title: Text('VM Pay Later'),
                        subtitle: Text('Get ₹20,000* worth Times Prime benefits'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                SizedBox(
                  height: 20,
                ),
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0), // No blur applied
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.0),
                    color: Colors.white.withOpacity(0.4), // Semi-transparent background
                    border: Border.all(color: Colors.white70, width: 1.0), // Light border
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Activity',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListTile(
                        leading: Icon(Icons.rate_review_sharp, color: Colors.orange),
                        title: Text('Reviews'),
                        subtitle: Text('Reviews on product'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.question_answer_sharp, color: Colors.orange),
                        title: Text("Questions & Answers"),
                        subtitle: Text('Apply & enter world of unlimited benefits!'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                SizedBox(
                  height: 20,
                ),
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0), // No blur applied
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.0),
                    color: Colors.white.withOpacity(0.4), // Semi-transparent background
                    border: Border.all(color: Colors.white70, width: 1.0), // Light border
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Earn With Veggie Mart',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListTile(
                        leading: Icon(Icons.monetization_on_outlined, color: Colors.orange),
                        title: Text('VM Creater Studio'),
                        subtitle: Text('Make your World'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.currency_bitcoin_outlined, color: Colors.orange),
                        title: Text('Previous Stocks'),
                        subtitle: Text('Investments in ShopNice'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                SizedBox(
                  height: 20,
                ),
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0), // No blur applied
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29.0),
                    color: Colors.white.withOpacity(0.4), // Semi-transparent background
                    border: Border.all(color: Colors.white70, width: 1.0), // Light border
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feedback & Information',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListTile(
                        leading: Icon(Icons.policy_outlined, color: Colors.orange),
                        title: Text('Terms, Polices and Licensed'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.search_sharp, color: Colors.orange),
                        title: Text('Browse FAQ s'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
