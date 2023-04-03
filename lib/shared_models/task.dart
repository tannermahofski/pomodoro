import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Task extends Equatable {
  const Task({
    required this.name,
    required this.duration,
    required this.moreInfo,
    this.icon,
  });

  final String name;
  final String duration;
  final String moreInfo;
  final Icon? icon;

  factory Task.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> snapshot = doc.data()!;
    return Task(
      name: snapshot['name'],
      duration: snapshot['duration'],
      moreInfo: snapshot['moreInfo'],
    );
  }

  factory Task.fromMap(Map<String, dynamic> snapshot) {
    return Task(
      name: snapshot['name'],
      duration: snapshot['duration'],
      moreInfo: snapshot['moreInfo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'moreInfo': moreInfo,
    };
  }

  @override
  List<Object?> get props => [name, duration, moreInfo, icon];
}
