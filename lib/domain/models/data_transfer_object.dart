/// DTO to store order by.
class OrderBy {
  final String field;
  final bool isAscending;

  const OrderBy({
    this.field = 'id',
    this.isAscending = true,
  });
}

/// DTO to store where.
class Where {
  final String field;
  final dynamic value;

  const Where({
    required this.field,
    required this.value,
  });
}
