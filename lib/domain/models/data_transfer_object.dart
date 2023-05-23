/// DTO to store order by.
class OrderBy {
  final String field;
  final bool byAscending;

  const OrderBy({
    this.field = 'id',
    this.byAscending = true,
  });
}
