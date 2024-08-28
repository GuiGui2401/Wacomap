import 'package:flutter/material.dart';
import 'package:login_register_app/screens/account_page.dart';
import 'package:login_register_app/screens/history_page.dart';
import 'package:login_register_app/screens/home_page.dart';
import 'package:login_register_app/water_drop_nav_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController pageController = PageController();
  int selectedIndex = 0;

  // Example markersData (replace this with your actual data)
  final List<Map<String, dynamic>> markersData = [
    {
      'marker': Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(3.8527005288496983, 11.499877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif alpha',
          snippet: 'Details about Dispositif alpha',
        ),
      ),
      'tag': 'Tag 1',
      'imageUrl':
          'https://qualitywatertreatment.com/cdn/shop/products/portable-structured-water-device-by-natural-action-technologies-484316_1024x1024.jpg?v=1686164435',
      'position': '3.8527005288496983, 11.499877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(3.8517906382215332, 11.496273015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif Beta',
          snippet: 'Details about Dispositif Beta',
        ),
      ),
      'tag': 'Tag 2',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw5H5ejIZTrZdfG5NpW4O9Oo2-tQsaid0Bzw&s',
      'position': '3.8517906382215332, 11.496273015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_3'),
        position: LatLng(3.8490288466472458, 11.50057527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif gamma',
          snippet: 'Details about Dispositif gamma',
        ),
      ),
      'tag': 'Tag 3',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ2m8Dk9d6hNORhUDYoh6XnTVmP3tc-AM6Og&s',
      'position': '3.8490288466472458, 11.50057527850416'
    },
    // Additional markers
    {
      'marker': Marker(
        markerId: MarkerId('marker_4'),
        position: LatLng(3.8530005288496983, 11.498877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif delta',
          snippet: 'Details about Dispositif delta',
        ),
      ),
      'tag': 'Tag 4',
      'imageUrl':
          'https://thewatermachine.com/cdn/shop/products/WATERMACHINEPic_600x600.png?v=1668979865',
      'position': '3.8530005288496983, 11.498877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_5'),
        position: LatLng(3.8500006382215332, 11.497000015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif epsilon',
          snippet: 'Details about Dispositif epsilon',
        ),
      ),
      'tag': 'Tag 5',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2022/05/smart-water-leak-detector-2048px-5218-3x2-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      'position': '3.8500006382215332, 11.497000015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_6'),
        position: LatLng(3.8480008466472458, 11.50100027850416),
        infoWindow: InfoWindow(
          title: 'Dispositif zeta',
          snippet: 'Details about Dispositif zeta',
        ),
      ),
      'tag': 'Tag 6',
      'imageUrl':
          'https://newater.com/wp-content/uploads/2021/06/Water-Purification-Equipment-1.jpg',
      'position': '3.8480008466472458, 11.50100027850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_7'),
        position: LatLng(3.8522005288496983, 11.499077904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif eta',
          snippet: 'Details about Dispositif eta',
        ),
      ),
      'tag': 'Tag 7',
      'imageUrl':
          'https://aqua-waterfilter.com/wp-content/uploads/2022/03/%D8%AF%D9%83%D8%AA%D9%88%D8%B1-%D9%88%D9%88%D8%AA%D8%B1.webp',
      'position': '3.8522005288496983, 11.499077904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_8'),
        position: LatLng(3.8510006382215332, 11.495273015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif theta',
          snippet: 'Details about Dispositif theta',
        ),
      ),
      'tag': 'Tag 8',
      'imageUrl':
          'https://i.pcmag.com/imagery/reviews/05qHubkeqL1k5hy54lntEWP-2.fit_lim.size_1050x.png',
      'position': '3.8510006382215332, 11.495273015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_9'),
        position: LatLng(3.8495008466472458, 11.49977527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif iota',
          snippet: 'Details about Dispositif iota',
        ),
      ),
      'tag': 'Tag 9',
      'imageUrl':
          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-169675,resizemode-75,msid-46804392/magazines/panache/how-to-save-your-phone-if-you-dropped-it-in-water.jpg',
      'position': '3.8495008466472458, 11.49977527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_10'),
        position: LatLng(3.8525005288496983, 11.500877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif kappa',
          snippet: 'Details about Dispositif kappa',
        ),
      ),
      'tag': 'Tag 10',
      'imageUrl':
          'https://media.easy.co.il/images/UserThumbs/10073649_1644306780547.jpeg',
      'position': '3.8525005288496983, 11.500877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_11'),
        position: LatLng(3.8505006382215332, 11.496500015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif lambda',
          snippet: 'Details about Dispositif lambda',
        ),
      ),
      'tag': 'Tag 11',
      'imageUrl':
          'https://cdn.shopify.com/s/files/1/0078/6156/7570/files/K19-H.png?v=1679639948',
      'position': '3.8505006382215332, 11.496500015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_12'),
        position: LatLng(3.8485008466472458, 11.50257527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif mu',
          snippet: 'Details about Dispositif mu',
        ),
      ),
      'tag': 'Tag 12',
      'imageUrl':
          'https://wp.culligan.com/wp-content/uploads/2021/06/Aquasential%C2%AE-Reverse-Osmosis-Drinking-Water-System.png?quality=80',
      'position': '3.8485008466472458, 11.50257527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_13'),
        position: LatLng(3.8532005288496983, 11.498077904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif nu',
          snippet: 'Details about Dispositif nu',
        ),
      ),
      'tag': 'Tag 13',
      'imageUrl': 'https://www.envest.com.tr/dosya/aqua_cnt22.png',
      'position': '3.8532005288496983, 11.498077904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_14'),
        position: LatLng(3.8502006382215332, 11.497000015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif xi',
          snippet: 'Details about Dispositif xi',
        ),
      ),
      'tag': 'Tag 14',
      'imageUrl':
          'https://cdn.shopify.com/s/files/1/0534/0993/9642/files/freestandingwatercoolerdispenser_375b49ab-4fe9-492a-b22b-ae7f522b6042_480x480.png?v=1636373905',
      'position': '3.8502006382215332, 11.497000015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_15'),
        position: LatLng(3.8492008466472458, 11.50157527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif omicron',
          snippet: 'Details about Dispositif omicron',
        ),
      ),
      'tag': 'Tag 15',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2022/05/smart-water-leak-detector-2048px-5218-3x2-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      'position': '3.8492008466472458, 11.50157527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_16'),
        position: LatLng(3.8528005288496983, 11.498877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif pi',
          snippet: 'Details about Dispositif pi',
        ),
      ),
      'tag': 'Tag 16',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK1xB8NmICudXUovVEPOkqyFrN_swHqBChYQ&s',
      'position': '3.8528005288496983, 11.498877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_17'),
        position: LatLng(3.8508006382215332, 11.497773015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif rho',
          snippet: 'Details about Dispositif rho',
        ),
      ),
      'tag': 'Tag 17',
      'imageUrl':
          'https://thetradetable.com/cdn/shop/collections/Structured_Water_Device_1024x1024.jpg?v=1701983473',
      'position': '3.8508006382215332, 11.497773015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_18'),
        position: LatLng(3.8498008466472458, 11.50057527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif sigma',
          snippet: 'Details about Dispositif sigma',
        ),
      ),
      'tag': 'Tag 18',
      'imageUrl':
          'https://thetradetable.com/cdn/shop/collections/Structured_Water_Device_1024x1024.jpg?v=1701983473',
      'position': '3.8498008466472458, 11.50057527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_19'),
        position: LatLng(3.8534005288496983, 11.498377904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif tau',
          snippet: 'Details about Dispositif tau',
        ),
      ),
      'tag': 'Tag 19',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2022/05/smart-water-leak-detector-2048px-5218-3x2-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      'position': '3.8534005288496983, 11.498377904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_20'),
        position: LatLng(3.8512006382215332, 11.496773015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif upsilon',
          snippet: 'Details about Dispositif upsilon',
        ),
      ),
      'tag': 'Tag 20',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2024/04/smartleakdetectors-2048px-08157.jpg',
      'position': '3.8512006382215332, 11.496773015511457'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomePage(),
          HistoryPage(markersData: markersData), // Pass markersData here
          AccountPage(),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined),
          BarItem(
              filledIcon: Icons.history_rounded,
              outlinedIcon: Icons.history_outlined),
          BarItem(
            filledIcon: Icons.account_box,
            outlinedIcon: Icons.account_box_outlined,
          ),
        ],
      ),
    );
  }
}
