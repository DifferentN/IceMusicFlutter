
import 'package:ice_music_flutter/data/PersonalInfoData.dart';
import 'package:ice_music_flutter/data/PersonalPreferMusicData.dart';
import 'package:ice_music_flutter/data/PersonalPreferSettingGroupData.dart';
import 'package:ice_music_flutter/data/PersonalSongListGroup.dart';

Future<List<Object>> loadPersonalData() async{
  //从数据库中读取个人信息等数据

  //模拟加载用户信息
  List<Object> res = <Object>[];
  PersonalInfoData personalInfoData = PersonalInfoData("","Jack","10","12");
  res.add(personalInfoData);

  //模拟加载用户偏爱数据
  List<PersonalPreferSettingData> prefers = <PersonalPreferSettingData>[];
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  prefers.add(PersonalPreferSettingData.name("images/music.png", "本地/下载"));
  PersonalPreferSettingGroupData preferSettingGroupData = PersonalPreferSettingGroupData(prefers);
  res.add(preferSettingGroupData);

  //模拟喜欢的音乐数据
  String imageUrl = "http://p1.music.126.net/Vy7krgUDd_PdLyftv81ACg==/109951165988711397.jpg?param=140y140";
  PersonalPreferMusicData personalPreferMusicData = PersonalPreferMusicData(imageUrl,163);
  res.add(personalPreferMusicData);

  //模拟歌单数据
  //歌单标题
  List<SongListEntry> songListEntries = <SongListEntry>[];
  songListEntries.add(SongListEntry("创建歌单"));
  songListEntries.add(SongListEntry("收藏歌单"));
  songListEntries.add(SongListEntry("歌单助手"));
  SongListEntryGroup songListEntryGroup = SongListEntryGroup(songListEntries);
  res.add(songListEntryGroup);

  //自建歌单
  List<SongListItemData> items = <SongListItemData>[];
  items.add(SongListItemData(imageUrl,
      "年度歌单", 13, ""));
  items.add(SongListItemData(imageUrl,
      "毕业季", 24, ""));
  items.add(SongListItemData(imageUrl,
      "国语", 26, ""));
  items.add(SongListItemData(imageUrl,
      "临时下载歌单", 30, ""));
  res.add(CreatingSongListData(4, items));

  //收藏歌单
  List<SongListItemData> collectingItems = <SongListItemData>[];
  items.add(SongListItemData(imageUrl,
      "【欧美】简直好听到起飞", 353, "深海鱼溺亡事件"));
  items.add(SongListItemData(imageUrl,
      "[窸窣低语]沉寂在脑海深处的孤音", 23, "苏子星河"));
  items.add(SongListItemData(imageUrl,
      "100首经典英文歌曲排行榜*上篇", 50, "pure日月"));
  res.add(CollectingSongListData(4, items));

  List<AssistantSongListItemHintData> hintItems = <AssistantSongListItemHintData>[];
  hintItems.add(AssistantSongListItemHintData("循环提示词 1"));
  hintItems.add(AssistantSongListItemHintData("循环提示词 2"));
  hintItems.add(AssistantSongListItemHintData("循环提示词 3"));
  hintItems.add(AssistantSongListItemHintData("循环提示词 4"));
  hintItems.add(AssistantSongListItemHintData("循环提示词 5"));
  res.add(AssistantSongListData(hintItems));
  return res;
}