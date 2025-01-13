import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FAQ UI',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ),
      home: FAQPage(),
    );
  }
}

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int? expandedIndex;

  final List<FAQItem> faqItems = [
    FAQItem(
      question: '¿Qué es GDG Ica?',
      answer:
      'GDG Ica es el capítulo oficial de Google Developers Group en la ciudad de Ica. Es una comunidad de desarrolladores y entusiastas de la tecnología que se reúnen para explorar nuevas tecnologías y aprender juntos.',
    ),
    FAQItem(
      question: '¿Qué significa GDG?',
      answer: 'GDG significa Google Developer Group.',
    ),
    FAQItem(
      question: '¿Qué tipo de eventos y actividades organiza GDG Ica?',
      answer: 'Organizan talleres, charlas y hackatones relacionados con tecnología.',
    ),
    FAQItem(
      question: '¿Qué es DevFest?',
      answer:
      'DevFest es un evento anual organizado por GDG que reúne a desarrolladores para compartir conocimientos y experiencias.',
    ),
    FAQItem(
      question: '¿Cuándo se llevará a cabo el DevFest de este año?',
      answer: 'El DevFest se llevará a cabo en noviembre de este año.',
    ),
    FAQItem(
      question: '¿Cuál es el objetivo del DevFest?',
      answer: 'El objetivo es fomentar la colaboración y el aprendizaje en tecnología.',
    ),
    FAQItem(
      question: '¿Qué tipo de charlas y temas se tratarán en el DevFest?',
      answer: 'Se tratarán temas de inteligencia artificial, desarrollo web y móvil.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search FAQs...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (query) {
                setState(() {
                  // Filter logic can be added here if needed
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                final item = faqItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    key: Key(index.toString()),
                    title: Text(item.question, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        expandedIndex = isExpanded ? index : null;
                      });
                    },
                    initiallyExpanded: expandedIndex == index,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(item.answer),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Learn More', style: TextStyle(color: Colors.blue)),
                          ),
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: () {},
                            child: Text('Share', style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
