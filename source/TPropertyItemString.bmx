
rem
bbdoc: creates a string value item.
endrem
Function CreatePropertyItemString:TPropertyItemString(label:String, Value:String = "", id:Int, parent:TPropertyGroup)
	Return New TPropertyItemString.Create(label, value, id, parent)
End Function



Type TPropertyItemString Extends TPropertyItem

	Method Create:TPropertyItemString(label:String, defaultValue:String, id:Int, parent:TPropertyGroup)
		CreateItemLayout(parent)
		SetLabel(label)
		SetItemID(id)

		interact = CreateTextField(interactX, 1, TPropertyGrid.INTERACT_WIDTH, TPropertyGrid.ITEM_SIZE - 2, containerPanel)
		SetGadgetLayout(interact, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetText(interact, String(defaultValue))
		SetGadgetFilter(interact, FilterInput)

		AddHook(EmitEventHook, eventHandler, Self, 0)

		parent.AddItem(Self)
		Return Self
	End Method



	Function eventHandler:Object(id:Int, data:Object, context:Object)
		Local tmpItem:TPropertyItemString = TPropertyItemString(context)
		If tmpItem Then data = tmpItem.eventHook(id, data, context)
		Return data
	End Function



	Method eventHook:Object(id:Int, data:Object, context:Object)
		Local tmpEvent:TEvent = TEvent(data)
		If Not tmpEvent Then Return data

		Select tmpEvent.source
			Case interact
				Select tmpEvent.id
					Case EVENT_GADGETLOSTFOCUS
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
	bbdoc: Returns string value
	endrem
	Method GetValue:String()
		Return GadgetText(interact)
	End Method



	rem
	bbdoc: Sets string value
	endrem
	Method SetValue(value:String)
		SetGadgetText(interact, String(Value))
	End Method



	rem
	bbdoc: Filters user input
	endrem
	Function FilterInput:Int(event:TEvent, context:Object)
		If event.id = EVENT_KEYCHAR
			if event.data = 44 then return 0
		EndIf
		Return 1
	End Function


	Rem
		bbdoc:   Returns item as a string.
		about:   format: paramater,itemtype,name,value
		returns: String
	EndRem
	Method ToString:String()
		Return "parameter,string," + Self.Getlabel() + ","+Self.GetValue()
	EndMethod

End Type


