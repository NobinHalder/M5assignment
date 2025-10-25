import 'package:flutter/material.dart';

class FList extends StatelessWidget {
  const FList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Name TextFormField
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Phone TextFormField
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null, // UI-only, no functionality
                child: const Text('Add'),
              ),
            ),
            const SizedBox(height: 16),

            // Expanded ListView
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: ListTile(
                      leading: const Icon(Icons.person,
                          color: Colors.deepPurple),
                      title: const Text('Nobin'),
                      subtitle: const Text('01827564564'),
                      trailing: const Icon(Icons.delete, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
