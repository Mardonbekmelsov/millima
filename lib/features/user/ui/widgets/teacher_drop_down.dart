// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/users/bloc/users_bloc.dart';
import 'package:millima/features/users/bloc/users_event.dart';
import 'package:millima/features/users/bloc/users_state.dart';

class TeacherDropDown extends StatefulWidget {
  final String label;

  TeacherDropDown({super.key, required this.label});

  int? selectedId;

  int get id => selectedId!;

  @override
  State<TeacherDropDown> createState() => _TeacherDropDownState();
}

class _TeacherDropDownState extends State<TeacherDropDown> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoadedState) {
          for (var user in state.users) {
            print(user.role);
          }
          final teachers =
              state.users.where((user) => user.role.name == 'teacher').toList();

          return DropdownButtonFormField<int>(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.label,
            ),
            items: [
              for (var teacher in teachers)
                DropdownMenuItem(
                  value: teacher.id,
                  child: Text(teacher.name), 
                ),
            ],
            onChanged: (value) {
              setState(() {
                widget.selectedId = value;
              });
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}