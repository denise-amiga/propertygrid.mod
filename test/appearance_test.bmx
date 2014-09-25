
'test setup to view new stuff and interaction

Import wdw.propertygrid

Local w:TGadget = CreateWindow("test", 50, 50, 600, 600, Null, WINDOW_TITLEBAR | WINDOW_RESIZABLE | WINDOW_CLIENTCOORDS)

Local g:TPropertyGrid = TPropertyGrid.GetInstance()
g.Initialize(w, 1)


Local group1:TPropertyGroup = g.AddGroup("Group 1", 9001)
Local group2:TPropertyGroup = g.AddGroup("Group 2", 9002)
Local group3:TPropertyGroup = group1.AddGroup("Group 3", 9003)

CreatePropertyItemBool("Bool", 1, 100, group1)
Local choice:TPropertyItemChoice = CreatePropertyItemChoice("Choice", 101, group1)
choice.AddItem("A")
choice.AddItem("B")
choice.AddItem("C")
CreatePropertyItemColor("Color", 255, 255, 0, 102, group1)
CreatePropertyItemFloat("Float", 2.01, 103, group3)
CreatePropertyItemInt("Integer", 50, 104, group2)
CreatePropertyItemPath("File Path", "", 105, group2)
CreatePropertyItemSeparator("Separator --", group3)
CreatePropertyItemString("String", "H3ll0!", 106, group3)

g.RefreshLayout()

Repeat
	WaitEvent()
	
	Select EventID()
		Case EVENT_WINDOWCLOSE, EVENT_APPTERMINATE
			TPropertyGrid.GetInstance().CleanUp()
			End

		Case EVENT_PG_ITEMCHANGED
			Select EventData()
				Case 106
					Local s:TPropertyItemString = TPropertyItemString(EventSource())
					Print "Changed item: " + s.GetLabel() + ". New value is: " + String(CurrentEvent.extra)
				Case 100
					Local b:TPropertyItemBool = TPropertyItemBool(EventSource())
					Print "Changed item: " + b.GetLabel() + ". New value is: " + String(CurrentEvent.extra)
				Case 101
					Local c:TPropertyItemChoice = TPropertyItemChoice(EventSource())
					Print "Changed item: " + c.GetLabel() + ". New value is: " + String(CurrentEvent.extra)
				'	Print c.GetValue()
				'	Print c.GetValueLabel()
					
			End Select
	End Select
Forever


