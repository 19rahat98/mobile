import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'pin_event.dart';
part 'pin_state.dart';

typedef _Emitter = Emitter<PinState>;

class PinBloc extends Bloc<PinEvent, PinState> {
  PinBloc({
    required IProfileCache cache,
  })  : _profileCache = cache,
        super(const _Loading()) {
    on<_Init>(_init);
    on<_Verify>(_verify);
    on<_Fail>(_fail);
  }

  final IProfileCache _profileCache;
  late final String _profileId;

  Future<void> _init(_Init event, _Emitter emit) async {
    _profileId = event.profileId;
    final result = await _profileCache.hasPin(_profileId);

    if (result.isError) {
      emit(_Error('${result.error.exception}'));
    } else if (!result.value) {
      emit(const _Error('No Pin found'));
    }

    final lastVerificationResult = await _profileCache.lastPinVerification();

    if (lastVerificationResult.isSuccess) {
      emit(_Ready(lastVerificationResult.value));
    } else {
      emit(_Ready(PinVerification.fail()));
    }
  }

  FutureOr<void> _verify(_Verify event, _Emitter emit) async {
    final result = await _profileCache.verifyPin(_profileId, event.pin);

    if (result.isError) {
      emit(_Error('${result.error.exception}'));
    } else if (!result.value.wasVerified) {
      emit(_Failed(result.value));
    } else {
      emit(const _Verified());
    }
  }

  FutureOr<void> _fail(_Fail event, Emitter<PinState> emit) {
    emit(const _Error('Cannot verify pin at this time'));
  }
}
