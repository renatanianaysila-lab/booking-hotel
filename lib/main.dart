import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bpshdfqjqiykczfqjule.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwc2hkZnFqcWl5a2N6ZnFqdWxlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgyNzE5NTgsImV4cCI6MjA5Mzg0Nzk1OH0.PqLDl4epeY-uF1s1jSGM2yKbnlnW6lcy3tcgZn3yQnw',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Hotel',
      home: Scaffold(
        body: Center(
          child: Text('Supabase Connected!'),
        ),
      ),
    );
  }
}