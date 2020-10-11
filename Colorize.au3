#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icon.ico
#AutoIt3Wrapper_Outfile=Colorize_x86.exe
#AutoIt3Wrapper_Outfile_x64=Colorize_x64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Colorizer-Tool
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_ProductName=Colorize
#AutoIt3Wrapper_Res_ProductVersion=1.1
#AutoIt3Wrapper_Res_CompanyName=Jonas
#AutoIt3Wrapper_Res_LegalCopyright=2020, Jonas
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#NoTrayIcon
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>

if @OSVersion <> "WIN_10" Then
    MsgBox(16, "Colorize", "This Tool is for Windows 10 only. You are using " & @OSVersion & ".")
    Exit
EndIf

$Red = 00
$Green = 00
$Blue = 00
$Red = Hex(Random(0, 255, 1), 2)
$Green = Hex(Random(0, 255, 1), 2)
$Blue = Hex(Random(0, 255, 1), 2)

$idFormMain = GUICreate("Colorize", 130, 205, Default, Default, $DS_MODALFRAME)
$idLabelMin = GUICtrlCreateLabel("Min", 48, 8, 21, 17)
$idLabelMax = GUICtrlCreateLabel("Max", 88, 8, 24, 17)

$idLabelRed = GUICtrlCreateLabel("Red", 8, 32, 24, 17)
$idInputRedMin = GUICtrlCreateInput("0", 48, 32, 33, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3)
$idInputRedMax = GUICtrlCreateInput("255", 88, 32, 33, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3)

$idLabelGreen = GUICtrlCreateLabel("Green", 8, 56, 33, 17)
$idInputGreenMin = GUICtrlCreateInput("0", 48, 56, 33, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3)
$idInputGreenMax = GUICtrlCreateInput("255", 88, 56, 33, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3)

$idLabelBlue = GUICtrlCreateLabel("Blue", 8, 80, 25, 17)
$idInputBlueMin = GUICtrlCreateInput("0", 48, 80, 33, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3)
$idInputBlueMax = GUICtrlCreateInput("255", 88, 80, 33, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3)

$idButtonGo = GUICtrlCreateButton("Colorize!", 8, 112, 115, 57)
$idButtonExit = GUICtrlCreateButton("Exit", 8, 8, 27, 17)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
    Switch $nMsg
        
        Case $idButtonGo
            if GUICtrlRead($idInputRedMin) > 255 Or GUICtrlRead($idInputRedMax) > 255 Or GUICtrlRead($idInputGreenMin) > 255 Or GUICtrlRead($idInputGreenMax) > 255 Or GUICtrlRead($idInputBlueMin) > 255 Or GUICtrlRead($idInputBlueMax) > 255 Then
                MsgBox(16, "Colorize", "The color-values should be between 0 and 255!")
            ElseIf GUICtrlRead($idInputRedMax) < GUICtrlRead($idInputRedMin) Or GUICtrlRead($idInputGreenMax) < GUICtrlRead($idInputGreenMin) Or GUICtrlRead($idInputBlueMax) < GUICtrlRead($idInputBlueMin) Then
                MsgBox(16, "Colorize", "The maximum should be greater than the minimum!")
            Else
                $Red = Hex(Random(GUICtrlRead($idInputRedMin), GUICtrlRead($idInputRedMax), 1), 2)
                $Green = Hex(Random(GUICtrlRead($idInputGreenMin), GUICtrlRead($idInputGreenMax), 1), 2)
                $Blue = Hex(Random(GUICtrlRead($idInputBlueMin), GUICtrlRead($idInputBlueMax), 1), 2)

                RegWrite("HKCU\Software\Microsoft\Windows\DWM", "ColorPrevalence", "REG_DWORD", "1")
                $err1 = @error
                RegWrite("HKCU\Software\Microsoft\Windows\DWM", "AccentColor", "REG_DWORD", Dec("ff" & $Blue & $Green & $Red))
                $err2 = @error
                RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent", "AccentColorMenu", "REG_DWORD", Dec("ff" & $Blue & $Green & $Red))
                $err3 = @error
                if $err1 = 0 And $err2 = 0 And $err3 = 0 Then
                    MsgBox(64, "Colorize", "Color set to #" & $Red & $Green & $Blue)
                Else
                    MsgBox(16, "Colorize", "Error writing the values to the registry! " & "Error-code: " & $err1 & " " & $err2 & " " & $err3)
                EndIf
            EndIf


		Case $idButtonExit
			Exit

	EndSwitch
WEnd


