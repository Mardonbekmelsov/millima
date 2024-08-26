import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/timetable/bloc/timetable_bloc.dart';
import 'package:millima/features/timetable/bloc/timetable_event.dart';
import 'package:millima/features/timetable/bloc/timetable_state.dart';
import 'package:millima/data/models/timetable/week_day.dart';

class GetGroupTimetablesScreen extends StatelessWidget {
  final int groupId;

  const GetGroupTimetablesScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Group Timetables"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: BlocProvider(
        create: (context) => TimetableBloc()..add(GetTimeTablesEvent(group_id: groupId)),
        child: BlocBuilder<TimetableBloc, TimeTableState>(
          builder: (context, state) {
            if (state is TimeTableLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            } else if (state is TimeTableLoadedState) {
              return _buildTimetable(context, state.timeTables.week_days);
            } else if (state is TimeTableErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink(); // Should not reach here
            }
          },
        ),
      ),
    );
  }

  Widget _buildTimetable(BuildContext context, Map<String, List<WeekDay>> weekDays) {
    if (weekDays.isEmpty) {
      return Center(
        child: Text(
          "No timetable data available.",
          style: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 18,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: weekDays.length,
      itemBuilder: (context, index) {
        String day = weekDays.keys.elementAt(index);
        List<WeekDay> sessions = weekDays[day] ?? [];

        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                const Divider(color: Colors.black54),
                ...sessions.map((session) => _buildSessionItem(session)).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSessionItem(WeekDay session) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.room,
            color: Colors.blue.shade700,
            size: 28,
          ),
          const SizedBox(width: 10),
          Text(
            session.room,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue.shade900,
            ),
          ),
          const Spacer(),
          Text(
            "${session.start_time} - ${session.end_time}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
