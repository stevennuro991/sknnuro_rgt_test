import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rgt_test/utils/assets_paths.dart';
import 'package:rgt_test/utils/sized_boxes.dart';

class HomeDataContainers extends StatelessWidget {
  final String visitsText;
  final String number;
  final String iconPath;
  final bool isVisits, isVaccines, isLab, isSurgeries;

  const HomeDataContainers({
    Key? key,
    required this.visitsText,
    required this.number,
    required this.iconPath,
    this.isVisits = false,
    this.isVaccines = false,
    this.isLab = false,
    this.isSurgeries = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 12, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              visitsText,
              style: GoogleFonts.inter(
                color: const Color(0xFF334154),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            decoration: ShapeDecoration(
              color: isVaccines
                  ? const Color(0xFFFBBF24)
                  : isSurgeries
                      ? const Color(0xFFF472B6)
                      : isLab
                          ? const Color(0xFFFB7185)
                          : const Color(0xFF22D3EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(AssetsPaths.dropdownIcon)
        ],
      ),
    );
  }
}

class MyCustomContainer extends StatelessWidget {
  final String title, subtitle;
  final bool isMorning, isAfternoon, isEvening;
  const MyCustomContainer(
      {super.key,
      required this.title,
      required this.subtitle,
      this.isMorning = false,
      this.isAfternoon = false,
      this.isEvening = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 206,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF111826),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: const Color(0xFF64748A),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(isMorning
                  ? AssetsPaths.morningActiveIcon
                  : AssetsPaths.moonIcon),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                  isAfternoon ? AssetsPaths.sunIcon : AssetsPaths.sunIcon),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(isEvening
                  ? AssetsPaths.moonActiveIcon
                  : AssetsPaths.moonIcon),
            ],
          )
        ],
      ),
    );
  }
}

class DynamicDashboardRow extends StatelessWidget {
  final List<String> imagePaths;
  final List<String> labels;
  final List<int> badgeCounts;

  const DynamicDashboardRow({
    Key? key,
    required this.imagePaths,
    required this.labels,
    required this.badgeCounts,
  })  : assert(imagePaths.length == labels.length &&
            labels.length == badgeCounts.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          imagePaths.length, (index) => _buildItem(index, context)),
    );
  }

  Widget _buildItem(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(imagePaths[index]),
              if (badgeCounts[index] > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      badgeCounts[index].toString(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            labels[index],
            style: GoogleFonts.inter(
              color: const Color(0xFF111826),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 0.08,
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicPieChart extends StatelessWidget {
  final List<double> values;
  final List<Color> colors;
  final double radius;
  final String topLabel;
  final String bottomLabel;

  const DynamicPieChart({
    Key? key,
    required this.values,
    required this.colors,
    this.radius = 30,
    required this.topLabel,
    required this.bottomLabel,
  })  : assert(values.length == colors.length,
            'Values and colors lists must be of the same length.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = List.generate(values.length, (index) {
      return PieChartSectionData(
        color: colors[index],
        value: values[index],
        radius: radius,
        showTitle: false,
      );
    });

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 26),
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              borderData: FlBorderData(show: false),
              sectionsSpace: 10,
              centerSpaceRadius: double.infinity,
              sections: sections,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                topLabel,
                style: GoogleFonts.inter(
                  color: const Color(0xFF111826),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                bottomLabel,
                style: GoogleFonts.inter(
                  color: const Color(0xFF111826),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomSliderWidget extends StatefulWidget {
  const CustomSliderWidget({super.key});

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  double _value = 200;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbShape: AlwaysVisibleTooltipThumbShape(value: _value),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
          ),
          child: Slider(
            min: 0,
            max: 2000,
            divisions: 2000,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            activeColor: _value < 200
                ? Colors.red
                : (_value > 1100 ? Colors.red : Colors.green),
            inactiveColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class AlwaysVisibleTooltipThumbShape extends SliderComponentShape {
  final double? value;
  final double thumbRadius;
  final double tooltipHeight;

  const AlwaysVisibleTooltipThumbShape({
    this.value,
    this.thumbRadius = 16,
    this.tooltipHeight = 32,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint thumbPaint = Paint()..color = sliderTheme!.thumbColor!;
    canvas.drawCircle(center, thumbRadius * enableAnimation!.value, thumbPaint);

    final TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: tooltipHeight * 0.4,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor,
      ),
      text: '${this.value?.toStringAsFixed(0)}',
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset textCenter = Offset(
      center.dx - (tp.width / 2),
      center.dy - (tooltipHeight * 1.5),
    );
    tp.paint(canvas, textCenter);


    final Paint tooltipPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(
          center: textCenter + Offset(tp.width / 2, tp.height / 2),
          width: tp.width + 10,
          height: tooltipHeight),
      tooltipPaint,
    );

    tp.paint(canvas, textCenter);
  }
}

class DynamicHealthCard extends StatelessWidget {
  final String date;
  final String measurement;
  final String value;
  final String status;
  final Color statusColor;
  final String lastTestResult;

  const DynamicHealthCard({
    Key? key,
    required this.date,
    required this.measurement,
    required this.value,
    required this.status,
    required this.statusColor,
    required this.lastTestResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      width: 336,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              date,
              style: GoogleFonts.inter(
                color: const Color(0xFF111826),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      measurement,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF111826),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFDC2626),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    xBox(8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.inter(
                          color: const Color(0xFFDC2626),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                yBox(8),
                const Center(child: CustomSliderWidget()),
                yBox(8),
                Text(
                  lastTestResult,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748A),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
