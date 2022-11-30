// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

@immutable
class Todo {
  final String title;
  final String subtitle;
  final String id;
  bool isChecked;

  Todo({
    this.isChecked = false,
    required this.title,
    required this.subtitle,
    String? id,
  }) : id = id ?? const Uuid().v4();

  Todo update([String? title, String? subtitle]) {
    return Todo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isChecked: isChecked,
      id: id,
    );
  }

  @override
  String toString() => 'Todo(title: $title, subtitle: $subtitle, id: $id)';

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
