
rem
bbdoc: creates a disk path item.
endrem
Function CreatePropertyItemPath:TPropertyItemPath(label:String, Value:String = "", id:Int, parent:TPropertyGroup)
	Return New TPropertyItemPath.Create(label, value, id, parent)
End Function



Type TPropertyItemPath Extends TPropertyItem

	Global folderIcon:TPixmap = LoadPixmap("incbin::media/folder.bmp")

	'mouse hit on folder panel
	Field hit:Int

	Field selectorText:String
	Field selectorFilter:String
	Field folderPanel:TGadget

	Method Create:TPropertyItemPath(label:String, defaultValue:String, id:Int, parent:TPropertyGroup)
		CreateItemLayout(parent)
		SetLabel(label)
		SetItemID(id)

		interact = CreateTextField(interactX, 1, TPropertyGrid.INTERACT_WIDTH - TPropertyGrid.ITEM_SIZE, TPropertyGrid.ITEM_SIZE - 2, containerPanel)
		SetGadgetLayout(interact, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetText(interact, String(defaultValue))
		SetGadgetFilter(interact, FilterInput)

		Local xpos:Int = GadgetX(interact) + GadgetWidth(interact)
		folderPanel = CreatePanel(xpos, 1, TPropertyGrid.ITEM_SIZE, TPropertyGrid.ITEM_SIZE - 2, containerPanel)

		SetGadgetLayout(folderPanel, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetColor(folderPanel, 255, 0, 0)
		SetGadgetPixmap(folderPanel, folderIcon, PANELPIXMAP_STRETCH)
		SetGadgetSensitivity(folderPanel, SENSITIZE_MOUSE)

		selectorText = "Select file..."
		selectorFilter = "*Image Files:png,jpg,bmp;Text Files:txt;All Files:*"

		AddHook(EmitEventHook, eventHandler, Self, 0)
		parent.AddItem(Self)

		Return Self
	End Method



	Method SetFilterText(text:String)
		selectorFilter = text
	End Method

	Method SetSelectorText(text:String)
		selectorText = text
	End Method



	Rem
	bbdoc: Frees this item
	endrem
	Method Free()
		FreeGadget folderPanel
	End Method



	Function eventHandler:Object(id:Int, data:Object, context:Object)
		Local tmpItem:TPropertyItemPath = TPropertyItemPath(context)
		If tmpItem Then data = tmpItem.eventHook(id, data, context)
		Return data
	End Function



	Method EventHook:Object(id:Int, data:Object, context:Object)
		Local tmpEvent:TEvent = TEvent(data)
		If Not tmpEvent Then Return data

		Select tmpEvent.source
			Case folderPanel
				Select tmpEvent.id
					Case EVENT_MOUSEUP
						If tmpEvent.data = 1

							Local path:String = RequestFile(selectorText, selectorFilter, False, AppDir)

							If path <> ""
								SetGadgetText(interact, path)
								CreateItemEvent(EVENT_PG_ITEMCHANGED, GadgetText(interact))
							EndIf
						EndIf

					Default
						'it is an event we're not interested in.
						Return data
				End Select

				'handled, so get rid of old data
				data = Null
			case interact
				Select tmpEvent.id
					case EVENT_GADGETLOSTFOCUS
						CreateItemEvent(EVENT_PG_ITEMCHANGED, GadgetText(interact))
					Default
						'it is an event we're not interested in.
						Return data
				End Select

				'handled, so get rid of old data
				data = Null
			Default
				'no event for this item
				Return data
		End Select

		Return data
	End Method



	Rem
	bbdoc: Returns file path value as string
	endrem
	Method GetValue:String()
		Return GadgetText(interact)
	End Method



	rem
	bbdoc: Sets file path string value
	endrem
	Method SetValue(value:String)
		value = value.Replace("\", "/").Trim()
		SetGadgetText(interact, String(Value))
	End Method



	rem
	bbdoc: Filters user input
	endrem
	Function FilterInput:Int(event:TEvent, context:Object)
		If event.id = EVENT_KEYCHAR
			'no commas
			If event.data = 44 Then Return 0
		EndIf
		Return 1
	End Function

End Type


