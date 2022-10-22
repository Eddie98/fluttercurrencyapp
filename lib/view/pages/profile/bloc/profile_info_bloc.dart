import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../profile_info_repository.dart';
part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final ProfileInfoRepository repository;

  ProfileInfoBloc(this.repository) : super(ProfileInfoInitial()) {
    on<ProfileInfoEvent>((event, emit) {});
  }
}
