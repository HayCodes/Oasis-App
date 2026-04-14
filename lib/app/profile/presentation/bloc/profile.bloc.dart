import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/profile/data/profile.repository.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.events.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.states.dart';
import 'package:oasis/common/common.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profileRepository) : super(const ProfileState()) {
    on<FetchProfileEvent>(_fetchProfileEvent);
  }

  final ProfileRepository _profileRepository;

  Future<void> _fetchProfileEvent(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: FetchStatus.loading));
    final res = await _profileRepository.getUserProfile();

    res.fold(
      (error) =>
          emit(state.copyWith(status: FetchStatus.failure, error: error)),
      (user) => emit(
        state.copyWith(
          email: user.email,
          name: user.name,
          avatar: user.avatar,
          emailVerified: user.emailVerified,
          status: FetchStatus.success,
        ),
      ),
    );
  }

  // Future<void> _submitProfileChange(SubmitProfileChangeEvent event,
  //     Emitter<ProfileState> emit,) async {
  //   emit(state.copyWith(status: FetchStatus.loading));
  //
  //   final res = await _profileRepository.updateProfile(event.data);
  //
  //   res.fold(
  //         (error) =>
  //         emit(state.copyWith(
  //           status: FetchStatus.failure,
  //           error: error,
  //         )),
  //         (user) =>
  //         emit(state.copyWith(
  //           name: user.name,
  //           email: user.email,
  //           avatar: user.avatar,
  //           status: FetchStatus
  //               .success,
  //         )),
  //   );
  // }
}
