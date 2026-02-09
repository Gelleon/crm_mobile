import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import '../domain/entities/deal.dart';
import '../domain/entities/product.dart';
import '../domain/entities/deal_status.dart';

@lazySingleton
class DraftService {
  Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/deal_drafts.json');
  }

  Future<void> saveDraft(String dealId, Map<String, dynamic> data) async {
    final file = await _file;
    Map<String, dynamic> drafts = {};
    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        drafts = jsonDecode(content) as Map<String, dynamic>;
      } catch (e) {
        // ignore error
      }
    }
    drafts[dealId] = data;
    await file.writeAsString(jsonEncode(drafts));
  }

  Future<Map<String, dynamic>?> getDraft(String dealId) async {
    final file = await _file;
    if (!await file.exists()) return null;
    try {
      final content = await file.readAsString();
      final drafts = jsonDecode(content) as Map<String, dynamic>;
      return drafts[dealId] as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  Future<void> clearDraft(String dealId) async {
    final file = await _file;
    if (!await file.exists()) return;
    try {
      final content = await file.readAsString();
      final drafts = jsonDecode(content) as Map<String, dynamic>;
      drafts.remove(dealId);
      await file.writeAsString(jsonEncode(drafts));
    } catch (e) {
      // ignore
    }
  }
}
