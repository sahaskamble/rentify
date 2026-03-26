import 'package:flutter/material.dart';
import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Rentify App", home: ListinsScreen());
  }
}

class ListinsScreen extends StatefulWidget {
  const ListinsScreen({super.key});

  @override
  State<ListinsScreen> createState() => _ListinsScreenState();
}

class _ListinsScreenState extends State<ListinsScreen> {
  final service = ListingService();
  late Future<List<ListingsRecord>> future;

  @override
  void initState() {
    super.initState();
    future = service.getListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listings')),
      body: FutureBuilder<List<ListingsRecord>>(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final listings = snapshot.data!;
          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final item = listings[index];
              return ListTile(
                title: Text(item.title.isEmpty ? "No Title" : item.title),
                subtitle: Column(
                  children: [
                    Text("₹${item.pricePerDay} / day"),
                    Text("₹${item.pricePerWeek} / week"),
                    Text("₹${item.pricePerMonth} / month"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
