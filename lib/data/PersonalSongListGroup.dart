class PersonalSongListGroupData{

}
class CreatingSongListData{
  int songListNum;
  List<SongListItemData> items;
  CreatingSongListData(this.songListNum,this.items);
}
class CollectingSongListData{
  int songListNum;
  List<SongListItemData> items;
  CollectingSongListData(this.songListNum,this.items);
}
class AssistantSongListData{
  List<AssistantSongListItemHintData> dataList;
  AssistantSongListData(this.dataList);
}
class AssistantSongListItemHintData{
  String hintWord;
  AssistantSongListItemHintData(this.hintWord);
}
//歌单中的展示Item
class SongListItemData{
  String songListImageUrl;
  String songListName;
  int songNum;
  String songListAuthorName;
  late String subName;
  SongListItemData(this.songListImageUrl,this.songListName,this.songNum,this.songListAuthorName){
    subName = "${songNum}首";
    if(songListAuthorName!=null&&songListAuthorName.length>0){
      subName = "${songNum}首,by ${songListAuthorName}";
    }
  }
}
//歌单标题
class SongListEntry{
  String entryTitle;
  SongListEntry(this.entryTitle);
}
class SongListEntryGroup{
  List<SongListEntry> songListEntries;
  SongListEntryGroup(this.songListEntries);
}