package levelgen
{
public class AS3Embed
{

[Embed(source = "../../assets/levels/1/Level_1.xml", mimeType="application/octet-stream")] private static var Level_15:Class;
[Embed(source = "../../assets/levels/1/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground5:Class;
[Embed(source = "../../assets/levels/1/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water5:Class;
[Embed(source = "../../assets/levels/2/Level_2.xml", mimeType="application/octet-stream")] private static var Level_26:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water6:Class;
[Embed(source = "../../assets/levels/3/Level_3.xml", mimeType="application/octet-stream")] private static var Level_37:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Door.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Door7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_FlashGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FlashGates7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_FreezeGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FreezeGates7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_HeatGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_HeatGates7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Key.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Key7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Platforms.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Platforms7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water7:Class;
[Embed(source = "../../assets/levels/4/Level_4.xml", mimeType="application/octet-stream")] private static var Level_48:Class;
[Embed(source = "../../assets/levels/4/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground8:Class;
[Embed(source = "../../assets/levels/4/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water8:Class;
[Embed(source = "../../assets/levels/5/Level_5.xml", mimeType="application/octet-stream")] private static var Level_59:Class;
[Embed(source = "../../assets/levels/5/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground9:Class;
[Embed(source = "../../assets/levels/5/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water9:Class;
[Embed(source = "../../assets/levels/8/Level_8.xml", mimeType="application/octet-stream")] private static var Level_810:Class;
[Embed(source = "../../assets/levels/8/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground10:Class;
[Embed(source = "../../assets/levels/8/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water10:Class;
[Embed(source = "../../assets/levels/9/Level_9.xml", mimeType="application/octet-stream")] private static var Level_911:Class;
[Embed(source = "../../assets/levels/9/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground11:Class;
[Embed(source = "../../assets/levels/9/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water11:Class;

public static function GetTextAsset(filename:String):String{
if(filename == "levels/1/Level_1.xml") { return new Level_15; }
if(filename == "levels/1/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground5; }
if(filename == "levels/1/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water5; }
if(filename == "levels/2/Level_2.xml") { return new Level_26; }
if(filename == "levels/2/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground6; }
if(filename == "levels/2/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water6; }
if(filename == "levels/3/Level_3.xml") { return new Level_37; }
if(filename == "levels/3/mapCSV_Group1_Door.csv") { return new mapCSV_Group1_Door7; }
if(filename == "levels/3/mapCSV_Group1_FlashGates.csv") { return new mapCSV_Group1_FlashGates7; }
if(filename == "levels/3/mapCSV_Group1_FreezeGates.csv") { return new mapCSV_Group1_FreezeGates7; }
if(filename == "levels/3/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground7; }
if(filename == "levels/3/mapCSV_Group1_HeatGates.csv") { return new mapCSV_Group1_HeatGates7; }
if(filename == "levels/3/mapCSV_Group1_Key.csv") { return new mapCSV_Group1_Key7; }
if(filename == "levels/3/mapCSV_Group1_Platforms.csv") { return new mapCSV_Group1_Platforms7; }
if(filename == "levels/3/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water7; }
if(filename == "levels/4/Level_4.xml") { return new Level_48; }
if(filename == "levels/4/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground8; }
if(filename == "levels/4/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water8; }
if(filename == "levels/5/Level_5.xml") { return new Level_59; }
if(filename == "levels/5/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground9; }
if(filename == "levels/5/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water9; }
if(filename == "levels/8/Level_8.xml") { return new Level_810; }
if(filename == "levels/8/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground10; }
if(filename == "levels/8/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water10; }
if(filename == "levels/9/Level_9.xml") { return new Level_911; }
if(filename == "levels/9/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground11; }
if(filename == "levels/9/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water11; }

return "error";
}
}
}