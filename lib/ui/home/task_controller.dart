import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../infrastructure/model/task_model.dart';
import '../../infrastructure/services/connectivity_service.dart';
import '../../infrastructure/services/firestore_service.dart';
import '../../infrastructure/services/local_db.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class TaskController extends GetxController {
  final LocalDb _localDb = LocalDb();
  final FirestoreService _firestoreService = FirestoreService();
  final ConnectivityService _connectivityService = ConnectivityService();

  RxList<Task> tasks = <Task>[].obs;
  RxBool isSyncing = false.obs;
  RxBool isUpdate = false.obs;
  RxBool isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalTasks();

    // Listen to connectivity changes
    _connectivityService.connectivityStream.listen((event) {
      isOnline.value = event.isEmpty || event.first != ConnectivityResult.none;
      if (isOnline.value) {
        syncData();
      }
    });
  }

  Future<void> loadLocalTasks() async {
    final localTasks = await _localDb.getTasks();
    tasks.assignAll(localTasks);
  }

  Future<void> addOrUpdateTask(Task task) async {
    final now = DateTime.now();
    final newTask = Task(
      id: task.id.isEmpty ? Uuid().v4() : task.id,
      title: task.title,
      description: task.description,
      updatedAt: now,
    );

    await _localDb.insertOrUpdateTask(newTask);


    if (isOnline.value) {
      await _firestoreService.addOrUpdateTask(newTask);
    }
    tasks.removeWhere((t) => t.id == newTask.id);
    tasks.add(newTask);
    tasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  }

  Future<void> deleteTask(String id) async {
    await _localDb.deleteTask(id);
    tasks.removeWhere((t) => t.id == id);
    if (isOnline.value) {
      await _firestoreService.deleteTask(id);
    }
  }

  Future<void> syncData() async {
    if (isSyncing.value) return;
    isSyncing.value = true;

    try {
      final remoteTasks = await _firestoreService.getTasks();
      final localTasks = await _localDb.getTasks();

      // Create maps for quick lookup
      final remoteMap = {for (var t in remoteTasks) t.id: t};
      final localMap = {for (var t in localTasks) t.id: t};

      // Merge tasks based on updatedAt timestamp
      for (final localTask in localTasks) {
        final remoteTask = remoteMap[localTask.id];
        if (remoteTask == null) {
          // Upload local-only task to remote
          await _firestoreService.addOrUpdateTask(localTask);
        } else {
          if (localTask.updatedAt.isAfter(remoteTask.updatedAt)) {
            // Local newer -> update remote
            await _firestoreService.addOrUpdateTask(localTask);
          } else if (remoteTask.updatedAt.isAfter(localTask.updatedAt)) {
            // Remote newer -> update local
            await _localDb.insertOrUpdateTask(remoteTask);
          }
        }
      }

      // Add remote tasks missing locally
      for (final remoteTask in remoteTasks) {
        if (!localMap.containsKey(remoteTask.id)) {
          await _localDb.insertOrUpdateTask(remoteTask);
        }
      }

      await loadLocalTasks();
    } catch (e) {
      if (kDebugMode) {
        print("Sync error: $e");
      }
    }

    isSyncing.value = false;
  }
}
