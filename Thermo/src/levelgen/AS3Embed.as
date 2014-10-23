package levelgen
{
public class AS3Embed
{

[Embed(source = "../../assets/levels/1/Level_1.xml", mimeType="application/octet-stream")] private static var Level_15:Class;
[Embed(source = "../../assets/levels/1/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground5:Class;
[Embed(source = "../../assets/levels/1/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water5:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Door.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Door6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_FlashGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FlashGates6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_FreezeGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FreezeGates6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_HeatGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_HeatGates6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Key.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Key6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Platforms.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Platforms6:Class;
[Embed(source = "../../assets/levels/2/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water6:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Door.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Door7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_FlashGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FlashGates7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_FreezeGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_FreezeGates7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Ground7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_HeatGates.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_HeatGates7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Key.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Key7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Platforms.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Platforms7:Class;
[Embed(source = "../../assets/levels/3/mapCSV_Group1_Water.csv", mimeType="application/octet-stream")] private static var mapCSV_Group1_Water7:Class;

public static function GetTextAsset(filename:String):String{
if(filename == "levels/1/Level_1.xml") { return new Level_15; }
if(filename == "levels/1/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground5; }
if(filename == "levels/1/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water5; }
if(filename == "levels/2/mapCSV_Group1_Door.csv") { return new mapCSV_Group1_Door6; }
if(filename == "levels/2/mapCSV_Group1_FlashGates.csv") { return new mapCSV_Group1_FlashGates6; }
if(filename == "levels/2/mapCSV_Group1_FreezeGates.csv") { return new mapCSV_Group1_FreezeGates6; }
if(filename == "levels/2/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground6; }
if(filename == "levels/2/mapCSV_Group1_HeatGates.csv") { return new mapCSV_Group1_HeatGates6; }
if(filename == "levels/2/mapCSV_Group1_Key.csv") { return new mapCSV_Group1_Key6; }
if(filename == "levels/2/mapCSV_Group1_Platforms.csv") { return new mapCSV_Group1_Platforms6; }
if(filename == "levels/2/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water6; }
if(filename == "levels/3/mapCSV_Group1_Door.csv") { return new mapCSV_Group1_Door7; }
if(filename == "levels/3/mapCSV_Group1_FlashGates.csv") { return new mapCSV_Group1_FlashGates7; }
if(filename == "levels/3/mapCSV_Group1_FreezeGates.csv") { return new mapCSV_Group1_FreezeGates7; }
if(filename == "levels/3/mapCSV_Group1_Ground.csv") { return new mapCSV_Group1_Ground7; }
if(filename == "levels/3/mapCSV_Group1_HeatGates.csv") { return new mapCSV_Group1_HeatGates7; }
if(filename == "levels/3/mapCSV_Group1_Key.csv") { return new mapCSV_Group1_Key7; }
if(filename == "levels/3/mapCSV_Group1_Platforms.csv") { return new mapCSV_Group1_Platforms7; }
if(filename == "levels/3/mapCSV_Group1_Water.csv") { return new mapCSV_Group1_Water7; }

return "error";
}
}
}