enum Responsive {
  smallMobile(400),
  mobile(600),
  tablet(900),
  desktop(1200);

  final int maxWidth;

  const Responsive(this.maxWidth);
}
