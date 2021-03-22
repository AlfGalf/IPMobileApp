class StorageModel {
    // Static values
    final String configFilePath = "/config.json";

    // Saved config values
    String serverUrl;
    List<HistoryModel> history;
    
    StorageModel({
        this.serverUrl = "",
        this.history
    });

    factory StorageModel.fromJson(Map<String, dynamic> json) => StorageModel(
        serverUrl: json["serverUrl"],
        history: new List<HistoryModel>.from(json["history"])
    );

    Map<String, dynamic> toJson() => {
        "serverUrl": serverUrl,
        "history": history.map((x) => x.toJson()).toList()
    };
}

class HistoryModel {
    DateTime creationDate;
    String text;

    HistoryModel({
        this.creationDate,
        this.text
    });

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        creationDate: DateTime.parse(json["creationDate"] + " " + json["creationTime"]),
        text: json["text"]
    );

    Map<String, dynamic> toJson() => {
        "creationDate": "${creationDate.year.toString().padLeft(4, '0')}-${creationDate.month.toString().padLeft(2, '0')}-${creationDate.day.toString().padLeft(2, '0')}",
        "creationTime": "${creationDate.hour.toString().padLeft(2, '0')}:${creationDate.minute.toString().padLeft(2, '0')}:${creationDate.second.toString().padLeft(2, '0')}",
        "text": text
    };
}