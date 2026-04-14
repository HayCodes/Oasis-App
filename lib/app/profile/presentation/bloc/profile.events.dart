abstract class ProfileEvent {
  const ProfileEvent();
}

class FetchProfileEvent extends ProfileEvent {
  const FetchProfileEvent();
}

class SubmitProfileChangeEvent extends ProfileEvent {
  const SubmitProfileChangeEvent();
}