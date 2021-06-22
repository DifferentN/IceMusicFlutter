import 'package:flutter/material.dart';
import 'package:ice_music_flutter/data/PersonalInfoData.dart';
import 'package:ice_music_flutter/data/PersonalPreferMusicData.dart';
import 'package:ice_music_flutter/data/PersonalPreferSettingGroupData.dart';
import 'package:ice_music_flutter/data/PersonalSongListGroup.dart';
import 'package:ice_music_flutter/load_data/database_load.dart';
import 'package:ice_music_flutter/load_data/image_load.dart';
import 'package:ice_music_flutter/observable/BoolObservable.dart';
import 'package:ice_music_flutter/personal_page/ScrollIndexWidget.dart';
import 'package:ice_music_flutter/personal_page/assistant_song_list_widget.dart';

class PersonalMainPage extends StatefulWidget{
  @override
  _PersonalMainPageState createState() {
    return _PersonalMainPageState();
  }
}
class _PersonalMainPageState extends State<PersonalMainPage> with TickerProviderStateMixin{
  //整个页面的左右内边距
  double leftPadding = 10;
  double rightPadding = 10;

  //topBar的高度
  double personalPageTopBarHeight = 30;
  double topBarMenuImageSize = 20;
  double topBarMiddleImageSIze = 20;
  double topBarMiddleImageRadius = 10;

  ///个人信息模块
  double personalImageWidth = 60;
  double personalImageHeight = 60;
  double personalImageRadius = 30;
  double personalImageHorMargin = 10;
  //详情右箭头
  double rightArrowWidth = 60;
  double rightArrowHeight = 60;

  ///偏好Widget
  double preferSettingHorMargin = 12;
  double preferSettingVerMargin = 12;
  double preferSettingImageBottomMargin = 6;

  ///喜欢的音乐
  double preferMusicWidgetHeight = 50;
  double preferMusicImageWidth = 30;
  double preferMusicImageHeight = 30;
  double preferMusicImageEndMargin = 10;

  double preferMusicHeartWidth = 20;
  double preferMusicHeartHeight = 20;

  double preferMusicRadius = 20;

  double preferMusicHeartModelWidgetHeight = 20;

  TextStyle musicHeartTitleStyle = const TextStyle(
    fontStyle: FontStyle.normal,fontSize: 20
  );
  TextStyle musicHeartNumStyle = const TextStyle(
    color: Colors.grey,fontSize: 10,fontStyle: FontStyle.normal
  );
  TextStyle musicHeartBeatStyle = const TextStyle(
      fontSize: 10,fontStyle: FontStyle.normal
  );

  ///歌单大小文字设置
  //歌曲标题文字设置
  TextStyle songListEntryStyle = const TextStyle(
    fontSize: 16,fontStyle: FontStyle.normal
  );
  //歌单标题的间隔条大小
  double songListSpliterHeight = 5;
  double songListSpliterWidth = 1;
  double songListSpliterHorMargin = 20;
  //歌曲标题底部颜色条
  double songListEntryBottomHeight = 10;
  double songListEntryBottomRadius = 10;
  double songListEntryTitleBottomMargin = 5;

  ///
  //歌单内间距大小
  double songListLeftPadding = 10;
  double songListRightPadding = 10;
  double songListTopPadding = 10;
  double songListBottomPadding = 10;

  double songListItemTopPadding = 10;
  //歌单子标题
  TextStyle songListSubTitleStyle = const TextStyle(
    fontStyle: FontStyle.normal,color: Colors.grey,fontSize: 14
  );
  //创建歌单图标大小
  double addSongListImageSize = 40;
  //歌单菜单图标大小
  double songListDotsImageSize = 40;
  double songListDotsLeftMargin = 10;
  //歌单图片大小
  double songListItemImageSize = 50;
  double songListItemImageRadius = 4;
  double songListItemImageRightMargin = 5;
  //歌单名称
  TextStyle songListNameStyle = const TextStyle(
    fontSize: 16,fontStyle: FontStyle.normal
  );
  //歌单中歌曲数量
  TextStyle songListNumStyle = const TextStyle(
    fontSize: 12,color: Colors.grey,fontStyle: FontStyle.normal
  );
  //导入外部歌单
  TextStyle importTextStyle = const TextStyle(
    fontStyle: FontStyle.normal,fontSize: 16
  );
  double importImageSize = 50;
  ///

  //是否该显示TopBar中的个人信息.false表示不显示
  bool _topBarInfoShowState = false;

  late AnimationController _animationController;
  late Animation _positionAnimation;
  late Animation _opacityAnimation;
  late Duration _duration;


  TextStyle userNameTextStyle = const TextStyle(
      fontSize: 20, fontStyle: FontStyle.normal);
  TextStyle vipLevelTextStyle = const TextStyle(
      fontSize: 12, fontStyle: FontStyle.italic);
  TextStyle userLevelTextStyle = const TextStyle(
      fontSize: 12, fontStyle: FontStyle.normal);
  late PersonalInfoData _personalInfoData;

  late BoolObservable isBottomAnimationActive;

  @override
  void initState() {
    _duration = Duration(microseconds: 500);
    _animationController = AnimationController(duration: _duration,
        vsync: this)
        ..addListener(() {
          setState(() {});
        });

    _positionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController,
        curve: Curves.linear));

    _opacityAnimation = Tween<int>(begin: 0,end: 1).animate(CurvedAnimation(parent: _animationController,
        curve: Curves.linear));

    isBottomAnimationActive = BoolObservable();
  }

  @override
  void dispose() {
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(leftPadding, 0, rightPadding, 0),
        child: FutureBuilder(
          future: loadPersonalData(),
          builder: (BuildContext context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasData) {
              return createPersonalPageByListData(snapshot.data!);
            } else {
              return Container(
                child: Text("正在加载个人信息"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget createTopBar(){
    return Row(
      children: <Widget>[
        Container(
          width: topBarMenuImageSize,
          height: topBarMenuImageSize,
          child: Image.asset("images/menu.png"),
        ),
        Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.linear,
                  top: (personalPageTopBarHeight-topBarMenuImageSize)/2*_positionAnimation.value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: topBarMiddleImageRadius,
                        child: (_personalInfoData!=null&&_personalInfoData.imageFilePath.length>0)?Image.file(findImageFile(_personalInfoData.imageFilePath)):
                          Image.asset("images/personal_image.png"),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 6,),
                      Text(_personalInfoData!=null?_personalInfoData.userName:"加载失败")
                    ],
                  ),
                )
              ],
            ),
          )
        )
      ],
    );
  }

  Widget createPersonalPageByListData(List<Object> datas) {
    if (datas.isEmpty) {
      return Container(
        child: Text("数据加载失败"),
      );
    }
    return ScrollIndexWidget(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int index) {
            if (datas[index] is PersonalInfoData) {
              return createPersonalInfoWidget(datas[index] as PersonalInfoData);
            } else if(datas[index] is PersonalPreferSettingGroupData){
              return createPersonPreferSettingWidget(datas[index] as PersonalPreferSettingGroupData);
            } else if(datas[index] is PersonalPreferMusicData){
              return createPreferMusicWidget(datas[index] as PersonalPreferMusicData);
            } else if(datas[index] is SongListEntryGroup){
              return createSongListEntryGroup(datas[index] as SongListEntryGroup);
            } else if(datas[index] is CreatingSongListData){
              return createSelfSongListWidget(datas[index] as CreatingSongListData);
            } else if(datas[index] is CollectingSongListData){
              return createCollectingSongListWidget(datas[index] as CollectingSongListData);
            } else if(datas[index] is AssistantSongListData){
              return createAssistantSongListWidget(datas[index] as AssistantSongListData);
            }else{
              return Text("兜底文本");
            }
          },
        ),
        callback: (int first,int last){
          print('当前第一个可见元素下标 $first 当前最后一个可见元素下标 $last');
          if(last==datas.length-1){
            isBottomAnimationActive.setValue(true);
          }else{
            isBottomAnimationActive.setValue(false);
          }
        });
  }

  ///创建个人信息widget
  Widget createPersonalInfoWidget(PersonalInfoData personalInfoData) {
    return Row(
      children: <Widget>[
        SizedBox(width: personalImageHorMargin,),
        //个人头像
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: personalImageWidth,
            height: personalImageHeight,
            child: CircleAvatar(
              radius: personalImageRadius,
              child: personalInfoData.imageFilePath.length>0? 
                Image.file(findImageFile(personalInfoData.imageFilePath)):Image.asset("images/personal_image.png"),
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("images/personal_image.png"),
            ),
          ),
        ),
        SizedBox(width: personalImageHorMargin,),
        //个人名称，等级Widget
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //个人名称
            Text(personalInfoData.userName, style: userNameTextStyle,),
            SizedBox(height: 6,),
            //等级Widget
            Row(
              children: <Widget>[
                Container(
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Colors.grey
                  ),
                  child: Text(
                    personalInfoData.vipLevel, style: vipLevelTextStyle,),
                ),
                SizedBox(width: 3,),
                Container(
                  decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: Colors.white
                  ),
                  child: Text(
                    personalInfoData.userLevel, style: userLevelTextStyle,),
                )
              ],)
          ],
        ),
        //详情箭头
        Expanded(
          child:Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: rightArrowWidth,
              height: rightArrowHeight,
              child: Image.asset("images/right_arrow.png"),
            ),
          ),
        ),
      ],
    );
  }

  //创建个人偏好Widget
  Widget createPersonPreferSettingWidget(PersonalPreferSettingGroupData groupData){
    List<PersonalPreferSettingData> preferSettingDatas = groupData.setttingDatas;
    int num = preferSettingDatas.length;
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(preferSettingHorMargin, preferSettingVerMargin,
          preferSettingHorMargin, preferSettingVerMargin),
      crossAxisCount: 4,
      childAspectRatio: 1.0,
      children: getPreferSettingListWidget(preferSettingDatas),
    );
  }

  //创建偏好设置Widget组
  List<Widget> getPreferSettingListWidget(List<PersonalPreferSettingData> datas){
    return datas.map((e) => getPreferSettingWidget(e)).toList();
  }
  //创建单个PreferSettingWidget
  Widget getPreferSettingWidget(PersonalPreferSettingData settingData){
    //未设置宽高，交给gridView设置
    return Column(
      children: <Widget>[
        Image.asset(settingData.assetImagePath),
        SizedBox(height: preferSettingImageBottomMargin,),
        Text(settingData.settingName)
      ],
    );
  }


  Widget createPreferMusicWidget(PersonalPreferMusicData preferMusicData){
    return Container(
      height: preferMusicWidgetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 10,),
          //喜欢音乐图片
          Container(
            width: preferMusicImageWidth,
            height: preferMusicImageHeight,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(preferMusicData.imageUrl),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: preferMusicHeartWidth,
                    height: preferMusicHeartHeight,
                    child: Image.asset("images/heart.png"),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: preferMusicImageEndMargin,),
          //喜欢音乐标题及数量
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("我喜欢的音乐",style: musicHeartTitleStyle,),
              SizedBox(height: 10,),
              Text("${preferMusicData.preferSongNum}首",style: musicHeartNumStyle,)
            ],
          ),
          //心动模式
          Expanded(child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: preferMusicHeartModelWidgetHeight,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset("images/heartBeat.png"),
                  Text("心动模式",style: musicHeartBeatStyle,),
                  SizedBox(width: 5,)
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  //创建歌单标题组widget
  Widget createSongListEntryGroup(SongListEntryGroup songListEntryGroup){
    List<SongListEntry> songListEntries = songListEntryGroup.songListEntries;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        createSongListEntryItem(songListEntries[0].entryTitle),

        ///分割weight item
        SizedBox(width: songListSpliterHorMargin,),
        Container(
          width: songListSpliterWidth,
          height: songListSpliterHeight,
          color: Colors.grey,
        ),
        SizedBox(width: songListSpliterHorMargin,),
        ///
        createSongListEntryItem(songListEntries[1].entryTitle),

        ///分割weight item
        SizedBox(width: songListSpliterHorMargin,),
        Container(
          width: songListSpliterWidth,
          height: songListSpliterHeight,
          color: Colors.grey,
        ),
        SizedBox(width: songListSpliterHorMargin,),
        ///

        createSongListEntryItem(songListEntries[2].entryTitle),
      ],
    );
  }

  //创建歌单标题
  Widget createSongListEntryItem(String itemTitle){
    return Stack(
      children: <Widget>[
        //歌单标题底部色条
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: songListEntryBottomHeight,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(songListEntryBottomHeight/2)
            ),
          ),
        ),
        //歌单标题名称
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Text(itemTitle,style: songListEntryStyle,),
                SizedBox(height: songListEntryTitleBottomMargin,)
              ],
            ),
          ),
        )
      ],
    );
  }

  //创建歌单标题之间的间隔（未使用）
  Widget createListEntrySplitter(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: songListSpliterHorMargin,),
        Container(
          width: songListSpliterWidth,
          height: songListSpliterHeight,
          color: Colors.grey,
        ),
        SizedBox(width: songListSpliterHorMargin,),
      ],
    );
  }

  //创建自建的歌单Widget
  Widget createSelfSongListWidget(CreatingSongListData creatingSongListData){
    List<SongListItemData> items = creatingSongListData.items;
    int songListNum = creatingSongListData.songListNum;
    //增加顶部的导入歌单Widget
    int itemCount = songListNum+2;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            songListLeftPadding,
            songListTopPadding,
            songListRightPadding,
            songListBottomPadding),
      child: ListView.builder(
        itemCount: itemCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context,int index){
            if(index==0){
              return createSongListSubTitle("创建歌单${songListNum}个", true);
            }else if(index == itemCount-1){
              return createImportSongWidget();
            }else {
              //创建歌单项Widget
              return createSongListItem(items[index-1]);
            }
          })
    );
  }

  //创建收藏歌单
  Widget createCollectingSongListWidget(CollectingSongListData collectingSongListData){
    List<SongListItemData> items = collectingSongListData.items;
    int songListNum = collectingSongListData.songListNum;
    //增加导入歌单Widget
    int itemCount = songListNum+1;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            songListLeftPadding,
            songListTopPadding,
            songListRightPadding,
            songListBottomPadding),
        child: ListView.builder(
            itemCount: itemCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context,int index){
              if(index==0){
                return createSongListSubTitle("收藏歌单${songListNum}个", false);
              }else {
                //创建歌单项Widget
                return createSongListItem(items[index-1]);
              }
            })
    );
  }

  //创建歌单标题Widget addFlag表示是否有“添加图标”
  Widget createSongListSubTitle(String title,bool addFlag){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,style: songListSubTitleStyle,),
        Row(
          children: <Widget>[
            Container(
              width: addSongListImageSize,
              height: addSongListImageSize,
              child: addFlag?Image.asset("images/add.png"):Container(),
            ),
            SizedBox(width: songListDotsLeftMargin,),
            Container(
              width: songListDotsImageSize,
              height: songListDotsImageSize,
              child: Image.asset("images/dots_vertical.png"),
            )
          ],
        )
      ],
    );
  }

  //创建歌单项Widget
  Widget createSongListItem(SongListItemData songListItemData){
    return Padding(
      padding: EdgeInsets.only(top: songListItemTopPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              //歌单的图片
              Container(
                width: songListItemImageSize,
                height: songListItemImageSize,
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(songListItemImageRadius)
                    ),
                    image: DecorationImage(image: NetworkImage(songListItemData.songListImageUrl))
                ),
              ),
              SizedBox(width: songListItemImageRightMargin,),
              //歌单名称及歌曲数量
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(songListItemData.songListName,style: songListNameStyle,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 2,),
                  //歌曲数量或歌曲数据+作者
                  Text(songListItemData.subName,style: songListNumStyle,),
                ],
              )
            ],
          ),
          Container(
            width: songListDotsImageSize,
            height: songListDotsImageSize,
            child: Image.asset("images/dots_vertical.png"),
          )
        ],
      ),
    );
  }

  //创建导入外部音乐的Widget
  Widget createImportSongWidget(){
    return Padding(
      padding: EdgeInsets.only(top: songListItemTopPadding),
      child: Row(
        children: <Widget>[
          Container(
            width: importImageSize,
            height: importImageSize,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(songListItemImageRadius)
                ),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/import.png"))
            ),
          ),
          SizedBox(width: songListItemImageRightMargin,),
          Text("一键导入外部音乐",style: importTextStyle,)
        ],
      ),
    );
  }

  //创建SongListWidget
  Widget createAssistantSongListWidget(AssistantSongListData assistantSongListData){
    List<AssistantSongListItemHintData> hints = assistantSongListData.dataList;
    return AssistantSongListWidget(hints,isBottomAnimationActive);
  }

  void setTopBarInfoShowState(bool newState){
    _topBarInfoShowState = newState;
    setState(() {});
    if(_animationController.status == AnimationStatus.dismissed){
      _animationController.forward();
    }else if(_animationController.status == AnimationStatus.completed){
      _animationController.reverse();
    }
  }
}

