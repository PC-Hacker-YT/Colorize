#NoTrayIcon

While 1
    $Red = Hex(Random(0, 255, 1), 2)
    $Green = Hex(Random(0, 255, 1), 2)
    $Blue = Hex(Random(0, 255, 1), 2)

    RegWrite("HKCU\Software\Microsoft\Windows\DWM", "EnableWindowColorization", "REG_DWORD", "1")
    RegWrite("HKCU\Software\Microsoft\Windows\DWM", "ColorPrevalence", "REG_DWORD", "1")
    RegWrite("HKCU\Software\Microsoft\Windows\DWM", "AccentColor", "REG_DWORD", Dec("ff" & $Blue & $Green & $Red))
    RegWrite("HKCU\Software\Microsoft\Windows\DWM", "ColorizationAfterglow", "REG_DWORD", Dec("c4" & $Red & $Green & $Blue))
    RegWrite("HKCU\Software\Microsoft\Windows\DWM", "ColorizationColor", "REG_DWORD", Dec("c4" & $Red & $Green & $Blue))
    Sleep(10)
WEnd