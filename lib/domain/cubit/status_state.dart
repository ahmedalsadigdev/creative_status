part of 'status_cubit.dart';

sealed class StatusState extends Equatable {
  const StatusState();

  @override
  List<Object> get props => [];
}

final class StatusInitial extends StatusState {}

final class UpdateStatusState extends StatusState {
  final TextStyle currentTextStyle;

  UpdateStatusState({required this.currentTextStyle});
  @override
  List<Object> get props => [currentTextStyle];
}

final class ChangeTextAlignState extends StatusState {
  final TextAlign textAlign;
  final TextDirection direction;

  ChangeTextAlignState({required this.direction, required this.textAlign});
  @override
  List<Object> get props => [textAlign, direction];
}

final class UpdateFieldBackgroundState extends StatusState {
  final Color color;

  UpdateFieldBackgroundState({required this.color});
  @override
  List<Object> get props => [color];
}

final class SaveLocalStatusState extends StatusState {
  final String message;

  SaveLocalStatusState({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoadLocalStatusState extends StatusState {
  final String message;

  LoadLocalStatusState({required this.message});
  @override
  List<Object> get props => [message];
}
