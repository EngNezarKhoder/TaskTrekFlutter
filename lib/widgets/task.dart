import 'package:flutter/material.dart';

class Task {
  String title;
  String subtitle;
  bool isFinished;
  IconData icon;
  int id;

  Task({
    required this.subtitle,
    required this.title,
    required this.icon,
    required this.id,
    this.isFinished = false,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'isFinished': isFinished,
      'icon': icon.codePoint,
      'iconFamily': icon.fontFamily,
      'id': id
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        subtitle: json['subtitle'],
        title: json['title'],
        icon: IconData(json['icon'] ?? Icons.person.codePoint,
            fontFamily: json['iconFamily'] ?? "MaterialIcons"),
        id: json['id']);
  }
}
