class KeyValue {
  final String key;
  final String value;

  const KeyValue({required this.key, required this.value});

  factory KeyValue.fromJson(Map<String, dynamic> json) {
    return KeyValue(key: json['key'] ?? '', value: json['value'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'value': value};
  }

  KeyValue copyWith({String? key, String? value}) {
    return KeyValue(key: key ?? this.key, value: value ?? this.value);
  }
}

class KeyValueResponse {
  final List<KeyValue> items;

  const KeyValueResponse({required this.items});

  factory KeyValueResponse.fromJsonList(List<dynamic> jsonList) {
    List<KeyValue> items = jsonList
        .map((json) => KeyValue.fromJson(json as Map<String, dynamic>))
        .toList();
    return KeyValueResponse(items: items);
  }

  void addItem(KeyValue item) {
    items.add(item);
  }

  void removeItem(KeyValue item) {
    items.remove(item);
  }

  void clearItems() {
    items.clear();
  }

  void updateItem(int index, KeyValue newItem) {
    if (index >= 0 && index < items.length) {
      items[index] = newItem;
    }
  }

  List<Map<String, dynamic>> toJsonList() {
    return items.map((item) => item.toJson()).toList();
  }
}

const DEFAULT_KEY_VALUE = KeyValue(key: '', value: '');
const DEFAULT_KEY_VALUE_RESPONSE = KeyValueResponse(items: []);
