import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/act.dart';

class ActList extends StatelessWidget {
  const ActList({super.key});

  final data = lineup;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('acts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var list = snapshot.data?.docs ?? [];

          return ListView(
              children: list.map<Widget>((act) {
            return ListTile(
  leading: CircleAvatar(child: Text("${act['day']}")),
  title: Text(
    act['name'],
    style: const TextStyle(
      fontSize: 20, // Aumenta o tamanho da fonte
      fontWeight: FontWeight.bold, // Deixa o texto em negrito
      color: Color(0xFFFAFAFA), // Deixa o texto em cor branca
    ),
  );         
        title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Move a data para o lado direito
                  children: [
                    Text(
                      act['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFAFAFA),
                      ),
                    ),
                    Text(
                      'Dia ${act['day']}', // Mostra a data à direita
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ajuste a cor conforme necessário
                      ),
                    ),
                  ],
                ),
  subtitle: Wrap(
    spacing: 8,
    runSpacing: 4,
    children: act['tags']
        .map<Widget>((tag) => Chip(label: Text("#$tag")))
        .toList(),
  ),
);
          }).toList());
        });
  }
}
