import os

textassetstring = ""
artassetstring = ""
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
            temp = "if(filename == \"" + fileWDir + "\") { return " + varName + "; }\n"
            artassetstring += temp
        if fileExtension == ".xml" or fileExtension == ".csv":
            varName = fileName + str(i)
            temp = "[Embed(source = \"../../assets/" + fileWDir + "\", mimeType=\"application/octet-stream\")] private static var " + varName + ":Class;\n"
            embedstring += temp
            temp = "if(filename == \"" + fileWDir + "\") { return new " + varName + "; }\n"
            textassetstring += temp
    i += 1
    
output = "package levelgen\n{\npublic class AS3Embed\n{\n\n"
output += embedstring
output += "\npublic static function GetTextAsset(filename:String):String{\n"
output += textassetstring + "\nreturn \"error\";\n}\n"
output += "\npublic static function GetArtAsset(filename:String):Class{\n"
output += artassetstring + "\nreturn null;\n}\n"
output += "}\n}";

file_object = open("../src/levelgen/AS3Embed.as",'w')
file_object.write(output)
file_object.close()