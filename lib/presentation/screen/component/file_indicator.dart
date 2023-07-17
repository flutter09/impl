import 'package:chat_application/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FileIndicator extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final bool? isDownloading;
  final VoidCallback startDownload;
  final bool? showDownloadOption;

  const FileIndicator({super.key, required this.fileName, required this.fileSize , this.isDownloading, required this.startDownload, this.showDownloadOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.attach_file,
            color: Colors.grey[800],
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  fileSize,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          (showDownloadOption ?? true) ? Container(
              padding : const EdgeInsets.all(3),
              width:40, height: 40,
              child: isDownloading == true ?
              const CircularProgressIndicator(color: colorPrimary,strokeWidth: 3,) :
              IconButton(padding: const EdgeInsets.all(0),onPressed: startDownload, icon:const Icon(Icons.download , color: colorPrimary,)),
          ) : const SizedBox()
        ],
      ),
    );
  }
}