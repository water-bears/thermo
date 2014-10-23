package levelgen
{
public class AS3Embed
{

[Embed(source = "../../assets/levels/1/Level_1.xml", mimeType="application/octet-stream")] private static var Level_15:Class;
[Embed(source = "../../assets/levels/1/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground5:Class;
[Embed(source = "../../assets/levels/1/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water5:Class;
[Embed(source = "../../assets/levels/11/Level_11.xml", mimeType="application/octet-stream")] private static var Level_116:Class;
[Embed(source = "../../assets/levels/11/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground6:Class;
[Embed(source = "../../assets/levels/11/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water6:Class;
[Embed(source = "../../assets/levels/2/Level_2.xml", mimeType="application/octet-stream")] private static var Level_27:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground7:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water7:Class;
[Embed(source = "../../assets/levels/3/Level_3.xml", mimeType="application/octet-stream")] private static var Level_38:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Door.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Door8:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_FlashGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FlashGates8:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_FreezeGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FreezeGates8:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground8:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_HeatGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_HeatGates8:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Key.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Key8:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Platforms.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Platforms8:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water8:Class;
[Embed(source = "../../assets/levels/4/Level_4.xml", mimeType="application/octet-stream")] private static var Level_49:Class;
[Embed(source = "../../assets/levels/4/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground9:Class;
[Embed(source = "../../assets/levels/4/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water9:Class;
[Embed(source = "../../assets/levels/5/Level_5.xml", mimeType="application/octet-stream")] private static var Level_510:Class;
[Embed(source = "../../assets/levels/5/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground10:Class;
[Embed(source = "../../assets/levels/5/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water10:Class;
[Embed(source = "../../assets/levels/6/Level_6.xml", mimeType="application/octet-stream")] private static var Level_611:Class;
[Embed(source = "../../assets/levels/6/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground11:Class;
[Embed(source = "../../assets/levels/6/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water11:Class;
[Embed(source = "../../assets/levels/7/Level_7.xml", mimeType="application/octet-stream")] private static var Level_712:Class;
[Embed(source = "../../assets/levels/7/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground12:Class;
[Embed(source = "../../assets/levels/7/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water12:Class;
[Embed(source = "../../assets/levels/8/Level_8.xml", mimeType="application/octet-stream")] private static var Level_813:Class;
[Embed(source = "../../assets/levels/8/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground13:Class;
[Embed(source = "../../assets/levels/8/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water13:Class;

public static function GetTextAsset(filename:String):String{
if(filename == "levels/1/Level_1.xml") { return new Level_15; }
if(filename == "levels/1/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground5; }
if(filename == "levels/1/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water5; }
if(filename == "levels/11/Level_11.xml") { return new Level_116; }
if(filename == "levels/11/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground6; }
if(filename == "levels/11/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water6; }
if(filename == "levels/2/Level_2.xml") { return new Level_27; }
if(filename == "levels/2/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground7; }
if(filename == "levels/2/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water7; }
if(filename == "levels/3/Level_3.xml") { return new Level_38; }
if(filename == "levels/3/mapCSV_Group1_Door.csv") { return new mapCSV_Group1_Door8; }
if(filename == "levels/3/mapCSV_Group1_FlashGates.csv") { return new mapCSV_Group1_FlashGates8; }
if(filename == "levels/3/mapCSV_Group1_FreezeGates.csv") { return new mapCSV_Group1_FreezeGates8; }
if(filename == "levels/3/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground8; }
if(filename == "levels/3/mapCSV_Group1_HeatGates.csv") { return new mapCSV_Group1_HeatGates8; }
if(filename == "levels/3/mapCSV_Group1_Key.csv") { return new mapCSV_Group1_Key8; }
if(filename == "levels/3/mapCSV_Group1_Platforms.csv") { return new mapCSV_Group1_Platforms8; }
if(filename == "levels/3/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water8; }
if(filename == "levels/4/Level_4.xml") { return new Level_49; }
if(filename == "levels/4/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground9; }
if(filename == "levels/4/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water9; }
if(filename == "levels/5/Level_5.xml") { return new Level_510; }
if(filename == "levels/5/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground10; }
if(filename == "levels/5/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water10; }
if(filename == "levels/6/Level_6.xml") { return new Level_611; }
if(filename == "levels/6/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground11; }
if(filename == "levels/6/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water11; }
if(filename == "levels/7/Level_7.xml") { return new Level_712; }
if(filename == "levels/7/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground12; }
if(filename == "levels/7/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water12; }
if(filename == "levels/8/Level_8.xml") { return new Level_813; }
if(filename == "levels/8/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground13; }
if(filename == "levels/8/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water13; }

return "error";
}
}
}