import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';
import '../bloc/document_state.dart';

class DocumentListScreen extends StatelessWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Documents")),
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state.uploadedFiles.isEmpty) {
            return const Center(child: Text("No documents uploaded yet"));
          }

          return ListView.builder(
            itemCount: state.uploadedFiles.length,
            itemBuilder: (context, index) {
              final file = state.uploadedFiles[index];

              return ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: Text(file.name),
                subtitle: Text("${file.size.toStringAsFixed(2)} MB"),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
              );
            },
          );
        },
      ),
    );
  }
}
