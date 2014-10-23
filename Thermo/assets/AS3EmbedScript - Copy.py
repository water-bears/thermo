import os

mapName = "filemap"
mapstring = ""
embedstring = ""

i = 1
for subdir, dirs, files in os.walk("."):
    subdir = subdir.lstrip(' ./\\')
    subdir = subdir.replace("\\","/")

    for file in files:
        fileName, fileExtension = os.path.splitext(file)
        fileWDir = subdir + "/" + file
        fileWDir = fileWDir.lstrip(' ./\\')
        if fileExtension == ".png":
            varName = fileName + str(i)
            temp = "[Embed(source = \"../../assets/" + fileWDir + "\")] private static var " + varName + ":Class;\n"
            embedstring += temp
            temp = mapName + "[\"" + fileWDir + "\"] = " + varName + ";\n"
            mapstring += temp
        if fileExtension == ".xml" or fileExtension == ".csv":
            varName = fileName + str(i)
            temp = "[Embed(source = \"../../assets/" + fileWDir + "\", mimeType = \"application/octet-stream\")] private static var " + varName + ":Class;\n"
            embedstring += temp
            temp = mapName + "[\"" + fileWDir + "\"] = new " + varName + ";\n"
            mapstring += temp
    i += 1
    
output = "package levelgen\n{\npublic class AS3Embed\n{\n\n"
output += "private static var initialized:Boolean = false;\n\n"
output += "private static var " + mapName + ":Object = new Object();\n\n"
output += embedstring
output += "\npublic static function GetAsset(filename:String){\n"
output += "if(!initialized){\n"
output += mapstring + "initialized = true;\n}\n\n"
output += "return " + mapName + "[filename];\n}\n\n"
output += "}\n\n}"

file_object = open("..\src\levelgen\AS3Embed.as",'w')
file_object.write(output)
file_object.close()