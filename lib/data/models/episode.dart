class Episode
{
late String episode;
Episode.fromJson(Map<String,dynamic>json)
{
  episode=json['episode'];
}
}