class DbConstants {
  // Database Name
  static const String databaseName = 'sakinah.db';

  // User Profile Table Name
  static const String userProfileTableName = 'user_profile';
  static const String userId = 'user_id';
  static const String userName = 'name';
  static const String userCreatedAt = 'created_at';
  static const String userIsJoined = 'is_joined';

  // Prayer Time Table Name
  static const String prayerTimesTableName = 'prayer_times';
  static const String prayerId = 'payer_id';
  static const String prayerDate = 'date';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String locationName = 'location_name';
  static const String fajr = 'fajr';
  static const String sunrise = 'sunrise';
  static const String dhuhr = 'dhuhr';
  static const String asr = 'asr';
  static const String maghrib = 'maghrib';
  static const String isha = 'isha';

  // Progress Table Name
  static const String progressTableName = 'quran_progress';
  static const String progressId = 'progress_id';
  static const String lastPage = 'last_page';
  static const String lastSurah = 'last_surah';
  static const String lastAyah = 'last_ayah';
  static const String lastAyahText = 'last_ayah_text';
  static const String markedPage = 'marked_page';
  static const String markedSurah = 'marked_surah';
  static const String markedVerse = 'marked_verse';
  static const String markedAyahText = 'marked_ayah_text';
  static const String lastAudioSurah = 'last_audio_surah';
  static const String lastAudioAyah = 'last_audio_ayah';
  static const String lastReciterId = 'last_reciter_id';
  static const String lastReciterName = 'last_reciter_name';
  static const String updatedAt = 'updated_at';

  // Azkar Table Name
  static const String azkarTableName = 'daily_azkar_progress';
  static const String azkarId = 'azkar_id';
  static const String azkarDate = 'date';
  static const String azkarCategory = 'category';
  static const String zikrGlobalIndex = 'zikr_global_index';
  static const String currentCount = 'current_count';
  static const String zikrisCompleted = 'is_completed';

  // Recordings Table Name
  static const String recordingsTableName = 'recordings';
  static const String recordingId = 'recording_id';
  static const String recordingName = 'recorder_name';
  static const String recordingPath = 'file_path';
  static const String recordingDate = 'Date';
  static const String recordingDuration = 'duration';
  static const String recordingPlay = 'play';

  // Note Table Name
  static const String noteTableName = 'notes';
  static const String noteId = 'note_id';
  static const String noteTitle = 'title';
  static const String noteDescription = 'description';
  static const String noteDate = 'date';

  //List Tasks Table Name
  static const String listTasksTableName = 'list_tasks';
  static const String listTasksId = 'list_tasks_id';
  static const String taskOrder = 'task_order';
  static const String listTasksTitle = 'title';
  static const String listTasksDescription = 'description';
  static const String listTasksIsDone = 'is_done';
  static const String listTasksDate = 'date';

  // Audio Download Table Name
  static const String surahsDownloadTableName = 'audio_download';
  static const String surahsDownloadId = 'audio_download_id';
  static const String reciterId = 'reciter_id';
  static const String reciterName = 'reciter_name';
  static const String surahsDownloadNumber = 'audio_download_number';
  static const String surahsDownloadName = 'audio_download_name';
  static const String surahsDownloadPath = 'file_path';
  static const String surahsDownloadSize = 'size';
  static const String surahsDownloadDate = 'Date';
  static const String surahsDownloadDuration = 'duration';

  // Favorite Audio Table Name
  static const String favoriteAudioTableName = 'favorite_audio';
  static const String favoriteAudioId = 'favorite_audio_id';
  static const String favoriteAudioReciterId = 'reciter_id';
  static const String favoriteAudioNumber = 'favorite_audio_number';
  static const String favoriteAudioName = 'favorite_audio_name';
  static const String favoriteAudioDate = 'Date';
  static const String favoriteAudioDuration = 'duration';

  // Reminders Table Name
  static const String remindersTableName = 'reminders_config';
  static const String remindersKey = 'reminder_key';
  static const String remindersValue = 'value';
}
