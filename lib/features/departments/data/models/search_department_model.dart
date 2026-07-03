import '../../../home/data/models/department_model.dart';

class SearchDepartmentModel {
  final List<DepartmentModel> departments;

  SearchDepartmentModel({required this.departments});

  factory SearchDepartmentModel.fromJson(Map<String, dynamic> json) {
    return SearchDepartmentModel(
      departments: List<DepartmentModel>.from(
        json['data'].map((x) => DepartmentModel.fromJson(x)),
      ),
    );
  }
}
