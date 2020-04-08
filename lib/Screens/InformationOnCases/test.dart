import 'package:coronavirusapp/Screens/InformationOnCases/citiesinfo.dart';
import 'package:flutter/material.dart';


class testing extends StatefulWidget {
  @override
  _testingState createState() => _testingState();
}

class _testingState extends State<testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: CustomSliverDelegate(
                    expandedHeight: 120,
                  ),
                ),
                SliverFillRemaining(
                  child: Center(
                    child: Container(
                      height: 400,
                      color: Colors.blue,
                      child: Column(
                        children: <Widget>[
                       Container(
                         width: 100,
                         height: 300,
                         color: Colors.brown
                       ) ,
                        Container(
                         width: 100,
                         height: 300,
                         color: Colors.brown
                       ) ,
                        Container(
                         width: 100,
                         height: 300,
                         color: Colors.brown
                       ) ,
                        Container(
                         width: 100,
                         height: 300,
                         color: Colors.brown
                       ) ,
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
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
      final double expandedHeight;
      final bool hideTitleWhenExpanded;

      CustomSliverDelegate({
        @required this.expandedHeight,
        this.hideTitleWhenExpanded = true,
      });

      @override
      Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) {
        final appBarSize = expandedHeight - shrinkOffset;
        final cardTopPosition = expandedHeight / 2 - shrinkOffset;
        final proportion = 2 - (expandedHeight / appBarSize);
        final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
        return SizedBox(
          child: Stack(
            children: [
              SizedBox(
                height: 400,
                child: AppBar(
                  backgroundColor: Colors.green,
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  elevation: 0.0,
                  title: Opacity(
                      opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                      child: Text("Test")),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: cardTopPosition > 0 ? cardTopPosition : 0,
                bottom: 0.0,
                child: Opacity(
                  opacity: percent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                    child: Card(
                      elevation: 20.0,
                      child: Center(
                        child: Text("Header"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      @override
      double get maxExtent => expandedHeight + expandedHeight / 2;

      @override
      double get minExtent => kToolbarHeight;

      @override
      bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
        return true;
      }
    }
    