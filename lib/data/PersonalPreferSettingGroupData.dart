class PersonalPreferSettingGroupData{
  List<PersonalPreferSettingData> setttingDatas;

  PersonalPreferSettingGroupData(this.setttingDatas);
}
class PersonalPreferSettingData{
  String assetImagePath;
  String settingName;

  PersonalPreferSettingData.name(this.assetImagePath, this.settingName);
}
