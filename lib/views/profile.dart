import 'package:flutter/material.dart';

class SellerProfile extends StatelessWidget {
  const SellerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCovidAnnouncement(),
              const SizedBox(height: 20),
              _buildSalesOverview(),
              const SizedBox(height: 20),
              _buildStatCards(),
              const SizedBox(height: 20),
              _buildSalesChart(),
              const SizedBox(height: 20),
              _buildManagementOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCovidAnnouncement() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(Icons.announcement, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'On An About Budget Related Announcements: Stay informed of changes that may impact your business on Shop Nest.',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesOverview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSalesInfo('Sales today so far', '1396 INR'),
        _buildSalesInfo('Units today so far', '100'),
        _buildSalesInfo('Current balance', '13.5K INR'),
      ],
    );
  }

  Widget _buildSalesInfo(String title, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildStatCards() {
    return Column(
      children: [
        _buildStatCard('BUDGET', '₹ 11,302', '💰', 0.65),
        const SizedBox(height: 20),
        _buildStatCard('Overall Progress', '64%', '💪', 0.64, isCircular: true),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String emoji, double progress, {bool isCircular = false}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                emoji,
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (!isCircular)
            LinearProgressIndicator(
              value: progress,
              color: Colors.yellow,
              backgroundColor: Colors.blue[300],
            )
          else
            Center(
              child: CircularProgressIndicator(
                value: progress,
                color: Colors.yellow,
                backgroundColor: Colors.blue[300],
                strokeWidth: 6.0,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Product sales', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          height: 200, // Adjusted height for the parent container
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChartBar(540, Colors.orange, 'March', 15),
              _buildChartBar(420, Colors.orange, 'April', 15),
              _buildChartBar(420, Colors.orange, 'May', 15),
              _buildChartBar(270, Colors.grey, 'June', 15),
              _buildChartBar(124, Colors.grey, 'This Month', 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartBar(double height, Color color, String label, double width) {
    return Column(
      children: [
        Container(
          height: 150, // Adjusted height for the bar container
          width: width,
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height / 4, // Simplified height to fit within the container
            width: width,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }


  Widget _buildManagementOptions() {
    return Column(
      children: [
        _buildManagementOption('Add a Product'),
        _buildManagementOption('Manage Orders', trailing: '45'),
        _buildManagementOption('Manage Returns'),
        _buildManagementOption('Manage Caselogs'),
        _buildManagementOption('Communications', trailing: '1'),
      ],
    );
  }

  Widget _buildManagementOption(String title, {String? trailing}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(title),
      trailing: trailing != null ? Text(trailing, style: TextStyle(color: Colors.blue)) : null,
      onTap: () {},
    );
  }
}
