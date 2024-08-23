import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/groups/bloc/group_event.dart';
import 'package:millima/features/user/ui/screens/admin_screen.dart';
import 'package:millima/features/user/ui/widgets/custom_drawer_for_admin.dart';
import 'package:millima/features/user/ui/widgets/teacher_drop_down.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TeacherDropDown mainTeacherDropDown =
      TeacherDropDown(label: "Select Main Teacher");
  TeacherDropDown assistantTeacherDropDown =
      TeacherDropDown(label: "Select Assistant Teacher");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: const CustomDrawerForAdmin(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            mainTeacherDropDown,
            const SizedBox(height: 15),
            assistantTeacherDropDown,
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  print(nameEditingController.text);
                  print(mainTeacherDropDown.id);
                  print(assistantTeacherDropDown.id);
                  context.read<GroupBloc>().add(
                        AddGroupEvent(
                          name: nameEditingController.text,
                          main_teacher_id: mainTeacherDropDown.id,
                          assistant_teacher_id: assistantTeacherDropDown.id,
                        ),
                      );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: const Text(
                  "Add Group",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}