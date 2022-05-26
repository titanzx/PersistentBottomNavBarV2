part of persistent_bottom_nav_bar_v2;

class BottomNavStyle3 extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;

  BottomNavStyle3({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height) {
    return this.navBarEssentials!.navBarHeight == 0
        ? SizedBox.shrink()
        : AnimatedContainer(
            width: 100.0,
            height: height! / 1.0,
            duration:
                this.navBarEssentials!.itemAnimationProperties?.duration ??
                    Duration(milliseconds: 1000),
            curve: this.navBarEssentials!.itemAnimationProperties?.curve ??
                Curves.ease,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration:
                  this.navBarEssentials!.itemAnimationProperties?.duration ??
                      Duration(milliseconds: 1000),
              curve: this.navBarEssentials!.itemAnimationProperties?.curve ??
                  Curves.ease,
              alignment: Alignment.center,
              height: height / 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Transform.scale(
                      alignment: Alignment.bottomCenter,
                      scale: item.iconSize,
                      child: IconTheme(
                        data: IconThemeData(
                            // size: item.iconSize,
                            color: isSelected
                                ? (item.activeColorSecondary == null
                                    ? item.activeColorPrimary
                                    : item.activeColorSecondary)
                                : item.inactiveColorPrimary == null
                                    ? item.activeColorPrimary
                                    : item.inactiveColorPrimary),
                        child: isSelected
                            ? item.icon
                            : item.inactiveIcon ?? item.icon,
                      )),
                  item.title == null
                      ? SizedBox.shrink()
                      : Material(
                          type: MaterialType.transparency,
                          child: DefaultTextStyle.merge(
                            style: TextStyle(
                                color: item.textStyle != null
                                    ? item.textStyle!.apply(
                                        color: isSelected
                                            ? (item.activeColorSecondary == null
                                                ? item.activeColorPrimary
                                                : item.activeColorSecondary)
                                            : item
                                                .inactiveColorPrimary) as Color?
                                    : isSelected
                                        ? (item.activeColorSecondary == null
                                            ? item.activeColorPrimary
                                            : item.activeColorSecondary)
                                        : item.inactiveColorPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                            child: FittedBox(
                                fit: BoxFit.fill, child: Text(item.title!)),
                          ),
                        ),
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Color selectedItemActiveColor = this
        .navBarEssentials!
        .items![this.navBarEssentials!.selectedIndex!]
        .activeColorPrimary;
    double itemWidth = ((MediaQuery.of(context).size.width -
            ((this.navBarEssentials!.padding?.left ??
                    MediaQuery.of(context).size.width * 0.01) +
                (this.navBarEssentials!.padding?.right ??
                    MediaQuery.of(context).size.width * 0.01))) /
        this.navBarEssentials!.items!.length);
    return Container(
      width: double.infinity,
      height: this.navBarEssentials!.navBarHeight,
      padding: EdgeInsets.only(
          top: this.navBarEssentials!.padding?.top ?? 0.0,
          left: this.navBarEssentials!.padding?.left ??
              MediaQuery.of(context).size.width * 0.01,
          right: this.navBarEssentials!.padding?.right ??
              MediaQuery.of(context).size.width * 0.01,
          bottom: this.navBarEssentials!.padding?.bottom ??
              this.navBarEssentials!.navBarHeight! * 0.1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration:
                    this.navBarEssentials!.itemAnimationProperties?.duration ??
                        Duration(milliseconds: 300),
                curve: this.navBarEssentials!.itemAnimationProperties?.curve ??
                    Curves.ease,
                color: Colors.transparent,
                width: this.navBarEssentials!.selectedIndex == 0
                    ? MediaQuery.of(context).size.width * 0.0
                    : itemWidth * this.navBarEssentials!.selectedIndex!,
                height: 2.0,
              ),
              Flexible(
                child: AnimatedContainer(
                  duration: this
                          .navBarEssentials!
                          .itemAnimationProperties
                          ?.duration ??
                      Duration(milliseconds: 300),
                  curve:
                      this.navBarEssentials!.itemAnimationProperties?.curve ??
                          Curves.ease,
                  margin: EdgeInsets.only(left: 4, right: 4),
                  width: itemWidth - 8,
                  height: 2.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: selectedItemActiveColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      )),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: this.navBarEssentials!.items!.map((item) {
                  int index = this.navBarEssentials!.items!.indexOf(item);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        if (this.navBarEssentials!.items![index].onPressed !=
                            null) {
                          this.navBarEssentials!.items![index].onPressed!(this
                              .navBarEssentials!
                              .selectedScreenBuildContext);
                        } else {
                          this.navBarEssentials!.onItemSelected!(index);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: _buildItem(
                            item,
                            this.navBarEssentials!.selectedIndex == index,
                            this.navBarEssentials!.navBarHeight),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
