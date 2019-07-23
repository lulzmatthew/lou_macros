;rage's most basic magery trainer
;F3 to start, F4 to pause, F2 to show co-ord/color window
;don't press F2 twice or the script crashes
SendMode Input

;hotkey bindings
Med = 0
Spell = 9
Heal = 3
TargSelf = z

F4::Pause
F3::
	Loop,
	{
		;cast spell 3 times
		Loop, 2
		{
			SendHotkey(Spell)
			Sleep, 1200
			SendHotkey(TargSelf)
		}

		;heal until high HP
		while hasLowHP() 
		{
			SendHotkey(Heal)
			Sleep, 100
			SendHotkey(TargSelf)
			Sleep, 3000
		}
		
		;med 3 times
		while hasLowMana()
		{
			Loop, 3
			{
				SendHotkey(med)
				Sleep 11000
			}
		}
	}
;show the screen co-ords window
F2:: 
	CustomColor := "000000"
	Gui +LastFound +AlwaysOnTop +Border +ToolWindow  
	Gui, Color, %CustomColor%
	Gui, Font, s10
	Gui, Add, Text, Center vMyText cLime, XXX YYYYYYYYYYYYYYYYYY
	SetTimer, UpdateOSD, 200
	Gosub, UpdateOSD 
	Gui, Show, NoActivate
	return

UpdateOSD:
MouseGetPos, MouseX, MouseY   
PixelGetColor, mcolor, %MouseX%, %MouseY%                 
GuiControl,, MyText,X: %MouseX%  |  Y: %MouseY%  |  C: %mcolor%
return

SendHotkey(Hotkey)
{
	DefaultSleep = 500		; default sleep for keypress
	Lag = 15  			; adjust for lag
	Window = Legends of Aria
	ControlFocus, , %Window%
	ControlSend, , {%Hotkey% down}{}, %Window%
	DllCall("Sleep", "UInt", Lag)
	ControlSend, , {%Hotkey% up}{}, %Window%
	Sleep DefaultSleep
	return
}

hasLowHP()
{
	hpx := 320		;coordinates for health bar cutoff
	hpy := 109
	full_hp := 0x000096	;red 
	Window = Legends of Aria
	ControlFocus, , %Window%
	PixelGetColor, hpcolor, %hpx%, %hpy%
	if (hpcolor = full_hp)
	{
		return False
	} else 
	{
		return True
	}
}

hasLowMana()
{
	manax := 190		;coordinates for mana bar cutoff
	manay := 133
	full_mana := 0xA8571E	;blue
	Window = Legends of Aria
	ControlFocus, , %Window%
	PixelGetColor, manacolor, %manax%, %manay%
	if (manacolor = full_mana)
	{
		return False
	} else 
	{
		return True
	}
}