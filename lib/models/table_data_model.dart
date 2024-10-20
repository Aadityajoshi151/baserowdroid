class TableData {
  int? id; // SQLite auto-incremented ID (optional)
  String tableName;
  int baserowTableId;

  TableData({this.id, required this.tableName, required this.baserowTableId});

  // Convert a TableData object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table_name': tableName,
      'baserow_table_id': baserowTableId,
    };
  }

  // Extract a TableData object from a Map object
  factory TableData.fromMap(Map<String, dynamic> map) {
    return TableData(
      id: map['id'],
      tableName: map['table_name'],
      baserowTableId: map['baserow_table_id'],
    );
  }
}
