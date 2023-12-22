class HomeScreenModel {
    List<DashboardItem>? dashboardItems;
    PieChart? pieChart;
    List<HomeDataContainer>? homeDataContainers;
    List<ActiveMedication>? activeMedications;
    List<TrackingMeasure>? trackingMeasures;

    HomeScreenModel({
        this.dashboardItems,
        this.pieChart,
        this.homeDataContainers,
        this.activeMedications,
        this.trackingMeasures,
    });

    factory HomeScreenModel.fromJson(Map<String, dynamic> json) => HomeScreenModel(
        dashboardItems: List<DashboardItem>.from(json["dashboardItems"].map((x) => DashboardItem.fromJson(x))),
        pieChart: PieChart.fromJson(json["pieChart"]),
        homeDataContainers: List<HomeDataContainer>.from(json["homeDataContainers"].map((x) => HomeDataContainer.fromJson(x))),
        activeMedications: List<ActiveMedication>.from(json["activeMedications"].map((x) => ActiveMedication.fromJson(x))),
        trackingMeasures: List<TrackingMeasure>.from(json["trackingMeasures"].map((x) => TrackingMeasure.fromJson(x))),
    );

   
}

class ActiveMedication {
    String? name;
    String? description;
    bool? isMorning;
    bool? isAfternoon;
    bool? isEvening;

    ActiveMedication({
        this.name,
        this.description,
        this.isMorning,
        this.isAfternoon,
        this.isEvening,
    });

    factory ActiveMedication.fromJson(Map<String, dynamic> json) => ActiveMedication(
        name: json["name"],
        description: json["description"],
        isMorning: json["isMorning"],
        isAfternoon: json["isAfternoon"],
        isEvening: json["isEvening"],
    );
}


class DashboardItem {
    String? label;
    int? badgeCount;

    DashboardItem({
        this.label,
        this.badgeCount,
    });

    factory DashboardItem.fromJson(Map<String, dynamic> json) => DashboardItem(
        label: json["label"],
        badgeCount: json["badgeCount"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "badgeCount": badgeCount,
    };
}

class HomeDataContainer {
    String? visitsText;
    String? number;

    HomeDataContainer({
        this.visitsText,
        this.number,
    });

    factory HomeDataContainer.fromJson(Map<String, dynamic> json) => HomeDataContainer(
        visitsText: json["visitsText"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "visitsText": visitsText,
        "number": number,
    };
}

class PieChart {
    List<Segment>? segments;
    String? topLabel;
    String? bottomLabel;

    PieChart({
        this.segments,
        this.topLabel,
        this.bottomLabel,
    });

    factory PieChart.fromJson(Map<String, dynamic> json) => PieChart(
        segments: List<Segment>.from(json["segments"].map((x) => Segment.fromJson(x))),
        topLabel: json["topLabel"],
        bottomLabel: json["bottomLabel"],
    );
}

class Segment {
    double? value;
    String? color;

    Segment({
        this.value,
        this.color,
    });

    factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        value: json["value"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "color": color,
    };
}

class TrackingMeasure {
    String? date;
    String? measurement;
    String? value;
    String? status;
    String? statusColor;
    String? lastTestResult;

    TrackingMeasure({
        this.date,
        this.measurement,
        this.value,
        this.status,
        this.statusColor,
        this.lastTestResult,
    });

    factory TrackingMeasure.fromJson(Map<String, dynamic> json) => TrackingMeasure(
        date: json["date"],
        measurement: json["measurement"],
        value: json["value"],
        status: json["status"],
        statusColor: json["statusColor"],
        lastTestResult: json["lastTestResult"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "measurement": measurement,
        "value": value,
        "status": status,
        "statusColor": statusColor,
        "lastTestResult": lastTestResult,
    };
}
