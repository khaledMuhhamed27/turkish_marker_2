import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_event.dart';
import 'package:turkesh_marketer/bloc/bloc/requests_state.dart';
import 'package:turkesh_marketer/repository/all_requests_repo.dart';

class ImportBloc extends Bloc<ImportEvent, ImportState> {
  final ImportRepository importRepository;

  ImportBloc(this.importRepository) : super(ImportInitial()) {
    on<FetchImportsByType>((event, emit) async {
      emit(ImportLoading());
      try {
        final imports = await importRepository.getImportsByType(event.type);
        emit(ImportLoaded(imports));
      } catch (e) {
        emit(ImportError("Failed to fetch data: $e"));
      }
    });
  }
}
