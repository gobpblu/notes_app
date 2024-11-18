import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/di/dependency_injection.dart';
import 'package:notes_app/core/ui/widgets/calendar/calendar.dart';
import 'package:notes_app/features/reminder_details/presentation/bloc/reminder_details_bloc.dart';
import 'package:notes_app/features/reminder_details/presentation/models/reminder_type.dart';
import 'package:notes_app/generated/l10n.dart';

class ReminderDetailsPage extends StatelessWidget {
  const ReminderDetailsPage({super.key, this.date, this.id});

  final DateTime? date;
  final String? id;

  @override
  Widget build(BuildContext context) {
    print('DATE => $date');
    print('ID => $id');
    return BlocProvider(
      create: (context) => getIt.get<ReminderDetailsBloc>(param1: date)..add(ReminderDetailsByIdLoaded(id: id)),
      child: BlocListener<ReminderDetailsBloc, ReminderDetailsState>(
        listener: (context, state) {
          if (state.needExit) {
            context.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            // systemOverlayStyle: SystemUiOverlayStyle.dark,
            forceMaterialTransparency: true,
            title: Text('REMINDER DETAILS'),
            actions: [
              _SaveButton(),
            ],
          ),
          body: _Body(date: date),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final reminderType = context.select((ReminderDetailsBloc bloc) => bloc.state.type);
    final isLoading = context.select((ReminderDetailsBloc bloc) => bloc.state.isLoading);
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (reminderType == ReminderType.event) {
    } else {}
    return SingleChildScrollView(
      child: Column(
        children: [
          _TitleField(),
          _TagsRow(selectedType: reminderType),
          if (reminderType == ReminderType.event) _EventBody() else _TaskBody(),
        ],
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    return TextField(
      controller: bloc.titleController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: S.of(context).reminder_task_enter_title,
        hintStyle: const TextStyle(fontSize: 24),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: TextStyle(fontSize: 24),
      onChanged: (value) {
        bloc.add(ReminderDetailsTitleChanged(title: value));
      },
    );
  }
}

class _TagsRow extends StatelessWidget {
  const _TagsRow({super.key, required this.selectedType});

  final ReminderType selectedType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          for (var type in ReminderType.values) ...[
            _TagWidget(type: type, isSelected: type == selectedType),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _EventBody extends StatelessWidget {
  const _EventBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _CurrentDate(),
              _CurrentTime(),
            ],
          ),
        ),
      ],
    );
  }
}

class _TaskBody extends StatelessWidget {
  const _TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isAllDay = context.select((ReminderDetailsBloc bloc) => bloc.state.isAllDay);
    return Column(
      children: [
        _AllDayWidget(),
        _CurrentDate(),
        if (!isAllDay) _CurrentTime(),
        Divider(),
        _DescriptionWidget(),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.description),
          // SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: context.read<ReminderDetailsBloc>().descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: S.of(context).reminder_task_enter_description,
                  // contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentDate extends StatelessWidget {
  const _CurrentDate({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    final date = context.select((ReminderDetailsBloc bloc) => bloc.state.selectedDay);
    final dateFormat = DateFormat.yMMMMd('ru');
    final formattedDate = dateFormat.format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        children: [
          Text('Выбранная дата: '),
          SizedBox(width: 20),
          TextButton(
            onPressed: () async {
              final selectedDay = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              bloc.add(ReminderDetailsDayTapped(selectedDay: selectedDay));
            },
            child: Text(formattedDate),
          ),
        ],
      ),
    );
  }
}

class _CurrentTime extends StatelessWidget {
  const _CurrentTime({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    final date = context.select((ReminderDetailsBloc bloc) => bloc.state.selectedDay);
    final dateFormat = DateFormat.Hm('ru');
    final formattedDate = dateFormat.format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        children: [
          Text('Выбранное время: '),
          SizedBox(width: 20),
          TextButton(
            onPressed: () async {
              final timeOfDay = TimeOfDay.fromDateTime(date);
              final selectedTimeOfDay = await showTimePicker(context: context, initialTime: timeOfDay);
              print('selectedTimeOfDay: $selectedTimeOfDay');
              bloc.add(ReminderDetailsTimeSelected(timeOfDay: selectedTimeOfDay));
            },
            child: Text(formattedDate),
          ),
        ],
      ),
    );
  }
}

class _TagWidget extends StatelessWidget {
  const _TagWidget({super.key, required this.type, required this.isSelected});

  final ReminderType type;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    return InkWell(
      onTap: () {
        bloc.add(ReminderDetailsTypeChanged(type: type));
      },
      splashColor: Colors.blueAccent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.blueAccent.shade200 : Colors.transparent,
        ),
        child: Text(
          type.getTitle(),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class _AllDayWidget extends StatelessWidget {
  const _AllDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_outlined),
              SizedBox(width: 12),
              Text(
                S.of(context).reminder_task_all_day,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          BlocSelector<ReminderDetailsBloc, ReminderDetailsState, bool>(
            selector: (state) {
              return state.isAllDay;
            },
            builder: (context, value) {
              return Switch(
                value: value,
                onChanged: (value) => bloc.add(ReminderDetailsIsAllDayChanged(isAllDay: value)),
              );
            },
          )
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    final title = context.select((ReminderDetailsBloc bloc) => bloc.state.title);
    return TextButton(
      onPressed: title.isEmpty
          ? null
          : () {
              bloc.add(ReminderDetailsSaveButtonClicked());
            },
      child: Text(S.of(context).button_save),
    );
  }
}
