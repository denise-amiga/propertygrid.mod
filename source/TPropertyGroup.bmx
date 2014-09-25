

rem
bbdoc: a property group which can contain items or more groups
endrem
Type TPropertyGroup Extends TPropertyBase

	Global barIcon1:TPixmap = LoadPixmap("incbin::media/header.bmp")		'closed
	Global barIcon2:TPixmap = LoadPixmap("incbin::media/header2.bmp")		'open

	Field titleIcon:TGadget
	Field labelPanel:TGadget

	'items in this group go here
	Field itemList:TList

	'bool
	Field collapsed:Int

	'bool. true when user LMBs on group label
	Field hit:Int



	Method New()
		itemList = New TList
		collapsed = False
	End Method


	rem
	bbdoc: Constructor
	endrem
	Function Create:TPropertyGroup(title:String, groupID:Int, parent:TPropertyBase)
		Local g:TPropertyGroup = New TPropertyGroup

		'set id for this group. used for event handling
		g.SetItemID(groupID)

		'add group event hook
		AddHook(EmitEventHook, EventHandler, g, -1)

		'set indent level according to parent type
		If TPropertyGrid(parent)
			g.SetIndentLevel(0)
		ElseIf TPropertyGroup(parent)
			g.SetIndentLevel( parent.GetIndentLevel() + TPropertyGrid.ITEM_INDENT_SIZE )
		Else
			RuntimeError("No valid parent!")
		EndIf

		'set up the label and rest of the layout
		g.CreateLayout(title, parent.GetContainerPanel())

		Return g
	End Function


	Rem
	bbdoc: Sets up the default layout of this property group
	endrem
	Method CreateLayout(title:String, parentPanel:TGadget)

		'the containerpanel will contain the title bar and all items in the group.
		containerPanel = CreatePanel(0, 0, ClientWidth(parentPanel), TPropertyGrid.ITEM_SIZE, parentPanel)
		SetGadgetLayout(containerPanel, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetColor(containerPanel, 225, 225, 225)

		'this panel contains the little arrow in the titlebar
		titleIcon = CreatePanel(4, 1, TPropertyGrid.ITEM_INDENT_SIZE, TPropertyGrid.ITEM_SIZE - 4, containerPanel)
		SetGadgetLayout(titleIcon, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetPixmap(titleIcon, barIcon2, PANELPIXMAP_CENTER)

		'this panel contains the label and it can be clicked on to open or close the group

		labelPanel = CreatePanel(TPropertyGrid.ITEM_SIZE, 0, ClientWidth(containerPanel) - TPropertyGrid.ITEM_SIZE, TPropertyGrid.ITEM_SIZE, containerPanel)
		SetGadgetLayout(labelPanel, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetColor(labelPanel, 225, 225, 225)

		Local labelX:Int = 2 + indentLevel - TPropertyGrid.ITEM_INDENT_SIZE
		If indentLevel = 0 Then labelX = 2  ' <padding to left of label
		label = CreateLabel(title, labelX, 3, ClientWidth(labelPanel) - labelX, TPropertyGrid.ITEM_SIZE - 3, labelPanel)
		SetGadgetLayout(label, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetFont(label, LookupGuiFont(GUIFONT_SYSTEM, 0, FONT_BOLD))
		SetGadgetTextColor(label, 100, 100, 100)
		SetGadgetSensitivity(label, SENSITIZE_MOUSE)
	End Method



	Rem
	bbdoc: Opens or closes group
	endrem
	Method Toggle()
		collapsed = Not collapsed
		If collapsed
			SetGadgetPixmap(titleIcon, barIcon1, PANELPIXMAP_CENTER)
			SetVerticalSize(TPropertyGrid.ITEM_SIZE)  	'only show title
		Else
			SetGadgetPixmap(titleIcon, barIcon2, PANELPIXMAP_CENTER)
		End If

		EmitEvent CreateEvent(EVENT_PG_GROUPTOGGLED, Self, itemID)
	End Method



	Rem
	bbdoc: Refresh the item layout in this group
	about: called from TPropertygrid.RefreshLayout()
	endrem
	Method RefreshLayout()
		Local ypos:Int = TPropertyGrid.ITEM_SIZE + TPropertyGrid.ITEM_SPACING			'start below the label

		'arrange items in this group
		For Local g:TPropertyBase = EachIn itemList
			If TPropertyGroup(g) Then TPropertyGroup(g).RefreshLayout()

			g.SetVerticalPosition(ypos)
			ypos:+g.GetVerticalSize() + TPropertyGrid.ITEM_SPACING
		Next

		'ypos now indicates the needed size; unless it is collapsed. then only show the label
		If collapsed Then ypos = TPropertyGrid.ITEM_SIZE

		'size this groups container vertically so we can see all items on it
		SetVerticalSize(ypos - TPropertyGrid.ITEM_SPACING)
	End Method



	Rem
	bbdoc: Returns a list containing the group items
	endrem
	Method GetItemList:TList()
		Return itemList
	End Method



	Rem
	bbdoc: Adds an item to the group
	endrem
	Method AddItem(i:TPropertyItem)
		itemList.AddLast(i)
	End Method



	rem
	bbdoc: Adds a group to this group
	endrem
	Method AddGroup:TPropertyGroup(label:String, groupID:Int)
		Local g:TPropertyGroup = TPropertyGroup.Create(label, groupID, Self)
		itemList.AddLast(g)

		'sub groups have a white label
		SetGadgetColor(g.labelPanel, 255, 255, 255)

		Return g
	End Method




	Rem
	bbdoc: Frees property group and its items
	endrem
	Method CleanUp()

'		For Local i:TPropertyItemBase = EachIn itemList
'			i.CleanUp()
'		Next
		itemList.Clear()

		FreeGadget titleIcon
		FreeGadget label
		FreeGadget labelPanel
	End Method



	Rem
	bbdoc: Sets path value by item name
	endrem
	Method SetPathByLabel(label:String, newValue:String)
		For Local i:TPropertyItemPath = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				i.SetValue(newValue)
				Return
			End If
		Next
	End Method



	Rem
	bbdoc: Returns path value by item name
	endrem
	Method GetPathByLabel:String(label:String)
		For Local i:TPropertyItemPath = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.GetValue()
			End If
		Next
	End Method



	Rem
	bbdoc: Sets string value by item name
	endrem
	Method SetStringByLabel(label:String, newValue:String)
		For Local i:TPropertyItemString = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				i.SetValue(newValue)
				Return
			End If
		Next
	End Method



	Rem
	bbdoc: Returns string value by item name
	endrem
	Method GetStringByLabel:String(label:String)
		For Local i:TPropertyItemString = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.GetValue()
			End If
		Next
	End Method



	Rem
	bbdoc: Sets int value by item name
	endrem
	Method SetIntByLabel(label:String, newValue:Int)
		For Local i:TPropertyItemInt = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				i.setvalue(newValue)
				Return
			End If
		Next
	End Method



	Rem
	bbdoc: Returns int value by item name
	endrem
	Method GetIntByLabel:Int(label:String)
		For Local i:TPropertyItemInt = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.GetValue()
			End If
		Next
	End Method



	Rem
	bbdoc: Sets float value by item name
	endrem
	Method SetFloatByLabel(label:String, newValue:Float)
		For Local i:TPropertyItemFloat = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				i.setvalue(newValue)
				Return
			End If
		Next
	End Method



	Rem
	bbdoc: Returns float value by item name
	endrem
	Method GetFloatByLabel:Float(label:String)
		For Local i:TPropertyItemFloat = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.GetValue()
			End If
		Next
	End Method



	Rem
	bbdoc: Sets color value by item name
	endrem
	Method SetColorByLabel(label:String, r:Int, g:Int, b:Int)
		For Local i:TPropertyItemColor = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				i.SetColorValue(r,g,b)
				Return
			End If
		Next
	End Method



	Rem
	bbdoc: Returns color value by item name
	returns: int array
	endrem
	Method GetColorByLabel:Int[] (label:String)
		For Local i:TPropertyItemColor = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.GetColorValue()
			End If
		Next
	End Method



	Rem
	bbdoc: Sets boolean value by item name
	endrem
	Method SetBoolByLabel(label:String, bool:Int)
		For Local i:TPropertyItemBool = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				i.SetValue(bool)
				Return
			End If
		Next
	End Method



	Rem
	bbdoc: Returns boolean value by item name
	endrem
	Method GetBoolByLabel:Int(label:String)
		For Local i:TPropertyItemBool = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.GetValue()
			End If
		Next
	End Method



	Rem
	bbdoc: Sets choice value by item name
	endrem
	Method SetChoiceByLabel(label:String, index:Int)
		For Local i:TPropertyItemChoice = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				i.SetIndexValue(index)
				Return
			End If
		Next
	End Method



	Rem
	bbdoc: Gets selected choice index by item name
	endrem
	Method GetChoiceByLabel:Int(label:String)
		For Local i:TPropertyItemChoice = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.getValue()
			End If
		Next
	End Method



	Rem
	bbdoc: Gets selected choice text by item name
	endrem
	Method GetChoiceTextByLabel:String(label:String)
		For Local i:TPropertyItemChoice = EachIn itemList
			If i.GetLabel().ToLower() = label.ToLower()
				Return i.getValueLabel()
			End If
		Next
	End Method




	Function eventHandler:Object(id:Int, data:Object, context:Object)
		Local tmpPropertyGroup:TPropertyGroup = TPropertyGroup(context)
		If tmpPropertyGroup Then data = tmpPropertyGroup.eventHook(id, data, context)
		Return data
	End Function



	Method EventHook:Object(id:Int, data:Object, context:Object)
		Local tmpEvent:TEvent = TEvent(data)
		If Not tmpEvent Then Return data

		Select tmpEvent.source
			Case label
				Select tmpEvent.id
					Case EVENT_MOUSEENTER
						SetGadgetTextColor(label, 0, 0, 0)
						hit = False

					Case EVENT_MOUSELEAVE
						SetGadgetTextColor (label, 100, 100, 100)
						hit = False

					Case EVENT_MOUSEDOWN
						If tmpEvent.data = 1 Then hit = True

					Case EVENT_MOUSEUP
						If tmpEvent.data = 1 And hit = True Then Toggle()

					Default
						'it is an event from this label we're not interested in.
						Return data
				End Select

				'label handled, so get rid of old data
				data = Null

			Default
				'no event for this group
				Return data
		End Select

		Return data
	End Method

End Type
