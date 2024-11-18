import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes_app/features/reminders/domain/reminders_interactor.dart';

part 'reminders_event.dart';

part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc({
    required RemindersInteractor remindersInteractor,
  })  : _remindersInteractor = remindersInteractor,
        super(RemindersState(selectedDay: DateTime.now())) {
    on<RemindersDayTapped>(_onRemindersDayTapped);
    on<RemindersDataLoaded>(_onRemindersDataLoaded);
  }

  final RemindersInteractor _remindersInteractor;

  void _onRemindersDataLoaded(
    RemindersDataLoaded event,
    Emitter<RemindersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final reminders = await _remindersInteractor.getReminders();
      debugPrint('### notesListBLoc -> notes.length: ${reminders.length}, notes: $reminders');
      emit(state.copyWith(reminders: reminders, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onRemindersDayTapped(
    RemindersDayTapped event,
    Emitter<RemindersState> emit,
  ) {
    emit(state.copyWith(selectedDay: event.selectedDay));
  }
}
