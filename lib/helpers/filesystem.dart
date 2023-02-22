import 'package:file_picker/file_picker.dart' as picker;
import '../strings.dart';

class FileSystemHelper {
  static var _pickingFileSystemItem = false;

  static bool get isPickingFileSystemItem => _pickingFileSystemItem;

  static Future<String> pickDirectory() async {
    _pickingFileSystemItem = true;
    var selectedPath = await picker.FilePicker.platform.getDirectoryPath(
      dialogTitle: S.setFolder,
      lockParentWindow: true,
    );
    selectedPath = selectedPath?.trim() ?? '';
    _pickingFileSystemItem = false;
    return selectedPath;
  }
}
