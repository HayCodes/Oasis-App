import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


enum PermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted // iOS only
}

class PermissionHandler {
  static Future<Map<Permission, PermissionStatus>>
  _checkPermissionStatus() async {
    final statuses = <Permission, PermissionStatus>{};
    for (final permission in [Permission.camera, Permission.microphone]) {
      final status = await permission.status;
      if (status.isGranted) {
        statuses[permission] = PermissionStatus.granted;
      } else if (status.isDenied) {
        statuses[permission] = PermissionStatus.denied;
      } else if (status.isPermanentlyDenied) {
        statuses[permission] = PermissionStatus.permanentlyDenied;
      } else if (status.isRestricted) {
        statuses[permission] = PermissionStatus.restricted;
      }
    }
    return statuses;
  }

  Future<bool> requestPermissions(BuildContext context) async {
    var allGranted = true;
    final statuses = await _checkPermissionStatus();

    for (final entry in statuses.entries) {
      final permission = entry.key;
      final status = entry.value;


      switch (status) {
        case PermissionStatus.granted:
          continue;

        case PermissionStatus.denied:
          final result = await permission.request();

          if (!result.isGranted) {
            allGranted = false;
          }
          break;

        case PermissionStatus.permanentlyDenied:
          if (context.mounted) {
            final shouldOpenSettings = await _showPermissionDialog(
              context,
              permission: permission,
              isPermanent: true,
            );
            if (shouldOpenSettings) {
              await openAppSettings();
              // Wait for user to return from settings
              // Check permission status again
              final newStatus = await permission.status;
              if (!newStatus.isGranted) {
                allGranted = false;
              }
            } else {
              allGranted = false;
            }
          }
          break;

        case PermissionStatus.restricted:
          if (context.mounted) {
            await _showPermissionDialog(
              context,
              permission: permission,
              isRestricted: true,
            );
          }
          allGranted = false;
          break;
      }
    }

    return allGranted;
  }

  Future<bool> _showPermissionDialog(BuildContext context, {
    required Permission permission,
    bool isPermanent = false,
    bool isRestricted = false,
  }) async {
    String title;
    String message;
    String primaryButtonText;
    String? secondaryButtonText;

    if (isRestricted) {
      title = 'Permission Restricted';
      message =
      '$permission access is restricted. This might be due to parental controls or other system settings.';
      primaryButtonText = 'OK';
      secondaryButtonText = null;
    } else if (isPermanent) {
      title = 'Permission Required';
      message =
      'To use video/audio calling features, please enable $permission access in your device settings.';
      primaryButtonText = 'Open Settings';
      secondaryButtonText = 'Cancel';
    } else {
      title = 'Permission Required';
      message =
      '$permission access is required for video/audio calling features to work properly.';
      primaryButtonText = 'Grant Access';
      secondaryButtonText = 'Cancel';
    }

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              if (secondaryButtonText != null)
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(secondaryButtonText),
                ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(primaryButtonText),
              ),
            ],
          ),
    );

    return result ?? false;
  }
}
