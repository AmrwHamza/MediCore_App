import '../../../home/data/models/doctor_model.dart';

class SearchDoctorModelBaseResponse {
  final List<DoctorModel> doctors;

  SearchDoctorModelBaseResponse({required this.doctors});

  factory SearchDoctorModelBaseResponse.fromJson(Map<String, dynamic> json) {
    return SearchDoctorModelBaseResponse(
      doctors: List<DoctorModel>.from(
        json['data'].map((x) => DoctorModel.fromJson(x)),
      ),
    );
  }
}
