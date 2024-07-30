enum RozetkaPayErrType {
  unkown(1),
  invalidCcNum(2),
  invalidCcExp(3);

  final int code;

  const RozetkaPayErrType(this.code);
}
