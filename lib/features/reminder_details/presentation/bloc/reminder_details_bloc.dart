import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes_app/features/reminder_details/domain/reminder_details_interactor.dart';
import 'package:notes_app/features/reminder_details/presentation/models/reminder_type.dart';
import 'package:uuid/uuid.dart';

part 'reminder_details_event.dart';

part 'reminder_details_state.dart';

class ReminderDetailsBloc extends Bloc<ReminderDetailsEvent, ReminderDetailsState> {
  ReminderDetailsBloc({
    DateTime? selectedDay,
    required ReminderDetailsInteractor reminderDetailsInteractor,
  })  : _reminderDetailsInteractor = reminderDetailsInteractor,
        super(
          ReminderDetailsState(
            selectedDay: selectedDay ?? DateTime.now(),
            type: ReminderType.event,
          ),
        ) {
    on<ReminderDetailsByIdLoaded>(_onRemindersByIdLoaded);
    on<ReminderDetailsDayTapped>(_onRemindersDayTapped);
    on<ReminderDetailsTimeSelected>(_onRemindersTimeSelected);
    on<ReminderDetailsTypeChanged>(_onRemindersTypeChanged);
    on<ReminderDetailsIsAllDayChanged>(_onRemindersIsAllDayChanged);
    on<ReminderDetailsSaveButtonClicked>(_onRemindersSaveButtonClicked);
    on<ReminderDetailsTitleChanged>(_onRemindersTitleChanged);
  }

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final ReminderDetailsInteractor _reminderDetailsInteractor;

  void _onRemindersDayTapped(ReminderDetailsDayTapped event, Emitter<ReminderDetailsState> emit) {
    emit(state.copyWith(selectedDay: event.selectedDay));
  }

  void _onRemindersTimeSelected(ReminderDetailsTimeSelected event, Emitter<ReminderDetailsState> emit) {
    final timeOfDay = event.timeOfDay;
    if (timeOfDay == null) return;
    final currentDate = state.selectedDay.copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);
    emit(state.copyWith(selectedDay: currentDate));
  }

  void _onRemindersTypeChanged(ReminderDetailsTypeChanged event, Emitter<ReminderDetailsState> emit) {
    emit(state.copyWith(type: event.type));
  }

  void _onRemindersIsAllDayChanged(ReminderDetailsIsAllDayChanged event, Emitter<ReminderDetailsState> emit) {
    emit(state.copyWith(isAllDay: event.isAllDay));
  }

  void _onRemindersTitleChanged(ReminderDetailsTitleChanged event, Emitter<ReminderDetailsState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onRemindersSaveButtonClicked(
    ReminderDetailsSaveButtonClicked event,
    Emitter<ReminderDetailsState> emit,
  ) async {
    final id = state.id ?? const Uuid().v4();

    final reminder = ReminderData(
      id: id,
      title: titleController.text,
      description: descriptionController.text,
      isAllDay: state.isAllDay,
      date: state.selectedDay,
      type: state.type,
    );
    final currentTime = DateTime.now();
    final remainSeconds = state.selectedDay.difference(currentTime).inSeconds;
    print('remainSeconds: $remainSeconds');
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 100,
        channelKey: 'basic_channel',
        title: reminder.title,
        body: reminder.description,
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationInterval(
        interval: 5,
        // timeZone: localTimeZone,
        preciseAlarm: false,
        // repeats: true,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
    );
    print('reminder: $reminder');
    await _reminderDetailsInteractor.saveReminder(reminder);
    emit(state.copyWith(needExit: true));
  }

  void _onRemindersByIdLoaded(ReminderDetailsByIdLoaded event, Emitter<ReminderDetailsState> emit) async {
    final id = event.id;
    if (id == null) return;
    emit(state.copyWith(id: event.id, isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    final reminder = await _reminderDetailsInteractor.getReminderById(id);
    titleController.text = reminder?.title ?? '';
    descriptionController.text = reminder?.description ?? '';
    emit(state.copyWith(
      isLoading: false,
      selectedDay: reminder?.date,
      type: reminder?.type,
      isAllDay: reminder?.isAllDay,
    ));
  }
}
