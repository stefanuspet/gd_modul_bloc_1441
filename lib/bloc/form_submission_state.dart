abstract class FormSubmissionState {
  const FormSubmissionState();
}

class InitalFormState extends FormSubmissionState {
  const InitalFormState();
}

class FormSubmitting extends FormSubmissionState {}

class SubmissionSuccess extends FormSubmissionState {}

class SubmissionFailed extends FormSubmissionState {
  final String exception;

  const SubmissionFailed(this.exception);
}
