import 'package:hive/hive.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_department_model.dart';
import 'package:medicore_app/features/home/data/models/hive/hive_doctor_model.dart';
import 'package:medicore_app/features/home/domain/entities/department_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_department_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_entity.dart';
import 'package:medicore_app/features/home/domain/entities/doctor_user_entity.dart';

class HiveHomeLocalStorge {
  final Box<HiveDepartmentModel> departmentBox;
  final Box<HiveDoctorModel> doctorBox;

  HiveHomeLocalStorge(this.departmentBox, this.doctorBox);

  Future<void> cacheDepartments(List<DepartmentEntity> departments) async {
    await departmentBox.clear();
    for (final d in departments) {
      departmentBox.put(
        d.id,
        HiveDepartmentModel(
          id: d.id,
          name: d.departmentName,
          description: d.description,
          image: d.image,
        ),
      );
    }
  }

  Future<void> cacheDoctors(List<DoctorEntity> doctors) async {
    await doctorBox.clear();
    for (final d in doctors) {
      doctorBox.put(
        d.doctorId,
        HiveDoctorModel(
          doctorId: d.doctorId,
          departmentId: d.departmentId,
          userId: d.userId,
          bio: d.bio,
          departmentName:d.department!=null? d.department!.name : '',
          departmentImage:d.department!=null? d.department!.image:'',
          doctorUserFirstName: d.user.firstName,
          doctorUserLastName: d.user.lastName,
          doctorUserImage: d.user.imagePath,
          doctorUserEmail: d.user.email,
          doctorUserPhone: d.user.phone,
          doctorUserExperience: d.user.experience,
        ),
      );
    }
  }

  Future<List<DepartmentEntity>> getCachedDepartments() async {
    return departmentBox.values
        .map(
          (h) => DepartmentEntity(
            id: h.id,
            departmentName: h.name,
            description: h.description,
            image: h.image,
          ),
        )
        .toList();
  }

  Future<List<DoctorEntity>> getCachedDoctors() async {
    return doctorBox.values
        .map(
          (h) => DoctorEntity(
            doctorId: h.doctorId,
            departmentId: h.departmentId,
            userId: h.userId,
            bio: h.bio,
            department: DoctorDepartmentEntity(
              departmentId: h.departmentId,
              name: h.departmentName,
              image: h.departmentImage,
            ),
            user: DoctorUserEntity(
              firstName: h.doctorUserFirstName,
              lastName: h.doctorUserLastName,
              email: h.doctorUserEmail,
              phone: h.doctorUserPhone,
              imagePath: h.doctorUserImage,
              experience: h.doctorUserExperience,
            ),
          ),
        )
        .toList();
  }
}
