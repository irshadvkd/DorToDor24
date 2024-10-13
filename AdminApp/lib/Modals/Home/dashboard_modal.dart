import 'dart:convert';
/// total : 3
/// pending : 1
/// processing : 1
/// shipped : 0
/// completed : 0
/// cancelled : 0

DashboardModal dashboardModalFromJson(String str) => DashboardModal.fromJson(json.decode(str));
String dashboardModalToJson(DashboardModal data) => json.encode(data.toJson());
class DashboardModal {
  DashboardModal({
      this.total, 
      this.pending, 
      this.processing, 
      this.shipped, 
      this.completed, 
      this.cancelled,});

  DashboardModal.fromJson(dynamic json) {
    total = json['total'];
    pending = json['pending'];
    processing = json['processing'];
    shipped = json['shipped'];
    completed = json['completed'];
    cancelled = json['cancelled'];
  }
  int? total;
  int? pending;
  int? processing;
  int? shipped;
  int? completed;
  int? cancelled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['pending'] = pending;
    map['processing'] = processing;
    map['shipped'] = shipped;
    map['completed'] = completed;
    map['cancelled'] = cancelled;
    return map;
  }

}