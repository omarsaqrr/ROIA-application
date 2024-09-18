import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/requests/shared_units_request.dart';
import 'package:frontend/screens/all_sugessted_units.dart';
import 'package:frontend/screens/shared_unit_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../DTO/shared_unit_response.dart';
import '../../DTO/unit_response.dart';
import '../../requests/units_request.dart';
import '../../widgets/devolopers_item.dart';
import '../../widgets/shared_unit_details_widget.dart';
import '../../widgets/unit_widget.dart';
import '../roi_screen.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = "home_tab";
  final String userId;

  const HomeTab({Key? key, required this.userId}) : super(key: key);
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool _isSearchFocused = false;
  FocusNode _searchFocusNode = FocusNode();
  List<UnitResponse>? units;
  List<UnitResponse>? searchResults;
  bool isLoading = true;

  List<SharedUnitResponse>? sharedUnits;

  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
    fetchUnits();
    fetchSharedUnits();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (_searchController.text.isNotEmpty) {
        UnitsRequest unitsRequest = UnitsRequest();
        List<UnitResponse>? fetchedUnits = await unitsRequest
            .searchUnitsByTitleRequest(_searchController.text);
        setState(() {
          searchResults = fetchedUnits;
        });
      } else {
        setState(() {
          searchResults = null;
        });
      }
    });
  }

  Future<void> fetchUnits() async {
    UnitsRequest unitsRequest = UnitsRequest();
    List<UnitResponse>? fetchedUnits = await unitsRequest.getAllUnitsRequest();
    setState(() {
      units = fetchedUnits;
      isLoading = false;
    });
  }

  Future<void> fetchSharedUnits() async {
    SharedUnitsRequest sharedUnitsRequest = SharedUnitsRequest();
    List<SharedUnitResponse>? fetchedSharedUnits = await sharedUnitsRequest.getAllSharedUnitsRequest();
    setState(() {
      sharedUnits = fetchedSharedUnits;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (_isSearchFocused) {
            setState(() {
              _isSearchFocused = false;
            });
            _searchFocusNode.unfocus();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ROIA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004182),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            style: const TextStyle(color: Color(0xFF004182)),
                            decoration: InputDecoration(
                              hintText: 'What do you search for?',
                              hintStyle:
                              const TextStyle(color: Color(0xFF004182)),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Icon(Icons.search,
                                    color: Color(0xFF004182), size: 35),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF004182),
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF004182),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF004182),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_alt_outlined,
                              color: Color(0xFF004182), size: 40),
                          onPressed: () {
                            // Handle filter icon press
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _isSearchFocused
                  ? Expanded(child: _buildSearchResults())
                  : buildMainContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults == null || searchResults!.isEmpty) {
      return const Center(
          child: Text(
            'No units found.',
            style: TextStyle(color: paletteRed),
          ));
    }

    return ListView.builder(
      itemCount: searchResults!.length,
      itemBuilder: (context, index) {
        final unit = searchResults![index];
        return UnitWidget(unit: unit);
      },
    );
  }

  Widget buildMainContent(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 5.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * .2,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: [
                        buildCarouselItem('assets/images/roi.jpg',
                            'Summer Sale', 'Invest Now'),
                        buildCarouselItem('assets/images/roi.jpg',
                            'New Arrivals', 'Invest Now'),
                        buildCarouselItem('assets/images/roi.jpg',
                            'Best Deals', 'Invest Now'),
                      ],
                    ),
                    Positioned(
                      bottom: 15.0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: _current,
                          count: 3,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Color(0xFF004182),
                            dotColor: Colors.white,
                            dotHeight: 8.0,
                            dotWidth: 8.0,
                            radius: 50,
                          ),
                          onDotClicked: (index) {
                            _controller.animateToPage(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Developers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff06004F),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            buildDevelopersGridView(),
            Container(
              margin: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Shared Units',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff06004F),
                  ),
                ),
              ),
            ),
            buildSharedUnitsListView(),
            Container(
              margin: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Suggested Units',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff06004F),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuggestedUnits()));
                      },
                      child: const Text(
                        'view all',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(0xff06004F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            buildUnitsListView(), // ListView placed here
          ],
        ),
      ),
    );
  }

  Widget buildCarouselItem(String imagePath, String title, String buttonText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent, width: 3.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "ROI",
                        style: TextStyle(
                          color: Color(0xFF004182),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "of units",
                        style: TextStyle(
                          color: Color(0xFF004182),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Investment here",
                        style: TextStyle(
                          color: Color(0xFF004182),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 2),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  Roi()));
                        },
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF004182),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDevelopersGridView() {
    final List<Map<String, String>> developers = [
      {'name': 'Orascom', 'image': 'assets/images/orascom.png'},
      {'name': 'Sodic', 'image': 'assets/images/sodic.png'},
      {'name': 'Iwan', 'image': 'assets/images/iwan.png'},
      {'name': 'Palm Hills', 'image': 'assets/images/palm hills 2.png'},
      {'name': 'ORA', 'image': 'assets/images/ora 2.jpg'},
      {'name': 'Emaar', 'image': 'assets/images/emaar 1.jpeg'},
      // Add more developers here
    ];

    return Container(
      height: 120, // Set a fixed height for the horizontal grid
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 100,
        ),
        itemCount: developers.length,
        itemBuilder: (context, index) {
          final developer = developers[index];
          return DeveloperItem(
            name: developer['name']!,
            imagePath: developer['image']!,
          );
        },
      ),
    );
  }

  Widget buildUnitsListView() {
    if (units == null || units!.isEmpty) {
      return const Center(child: Text('No units available.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        final unit = units![index];
        return UnitWidget(unit: unit);
      },
    );
  }

  Widget buildSharedUnitsListView() {
    if (sharedUnits == null || sharedUnits!.isEmpty) {
      return const Center(child: Text('No shared units available.'));
    }

    return Container(
      height: 250, // Set a fixed height for the horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sharedUnits!.length,
        itemBuilder: (context, index) {
          final unit = sharedUnits![index];
          return Padding(
              padding: EdgeInsets.all(8.0),
              child: SharedUnitWidget(userId:widget.userId,sharedUnit: unit));
        },
      ),
    );
  }


}
