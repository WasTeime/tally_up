import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  final DocumentReference groupRef;

  const EventScreen({super.key, required this.groupRef});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
