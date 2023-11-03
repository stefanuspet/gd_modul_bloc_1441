import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gd_modul_bloc_1441/bloc/login_event.dart';
import 'package:gd_modul_bloc_1441/bloc/login_state.dart';
import 'package:gd_modul_bloc_1441/repository/login_repository.dart';
import 'package:gd_modul_bloc_1441/bloc/form_submission_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository = LoginRepository();
  LoginBloc() : super(LoginState()) {
    on<IsPasswordVisibleChanged>(
        (event, emit) => _onIsPasswordVisibleChanged(event, emit));
    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
  }
  void _onIsPasswordVisibleChanged(
      IsPasswordVisibleChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
        formSubmissionState: const InitalFormState()
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formSubmissionState: FormSubmitting()));
    try {
      await loginRepository.login(event.username, event.password);
      emit(state.copyWith(formSubmissionState: SubmissionSuccess()));
    } on FailedLogin catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e.errorMessage())));
    } on String catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e)));
    } catch (e) {
      emit(state.copyWith(
          formSubmissionState: SubmissionFailed(e.toString())));
    }
  }
}
