class PaginationLink {

  const PaginationLink({this.url, required this.label, required this.active});

  factory PaginationLink.fromJson(Map<String, dynamic> json) => PaginationLink(
    url: json['url'] as String?,
    label: json['label'] as String,
    active: json['active'] as bool,
  );
  final String? url;
  final String label;
  final bool active;
}

class PaginationMeta {

  const PaginationMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
    currentPage: json['current_page'] as int,
    from: json['from'] as int,
    lastPage: json['last_page'] as int,
    links: (json['links'] as List)
        .map((e) => PaginationLink.fromJson(e as Map<String, dynamic>))
        .toList(),
    path: json['path'] as String,
    perPage: json['per_page'] as int,
    to: json['to'] as int,
    total: json['total'] as int,
  );
  final int currentPage;
  final int from;
  final int lastPage;
  final List<PaginationLink> links;
  final String path;
  final int perPage;
  final int to;
  final int total;
}

class PaginationLinks {

  const PaginationLinks({this.first, this.last, this.prev, this.next});

  factory PaginationLinks.fromJson(Map<String, dynamic> json) =>
      PaginationLinks(
        first: json['first'] as String?,
        last: json['last'] as String?,
        prev: json['prev'] as String?,
        next: json['next'] as String?,
      );
  final String? first;
  final String? last;
  final String? prev;
  final String? next;
}
