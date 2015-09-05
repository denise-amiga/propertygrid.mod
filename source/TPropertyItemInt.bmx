
rem
bbdoc: creates an integer value item.
endrem
Function CreatePropertyItemInt:TPropertyItemInt(label:String, Value:Int = 0, id:Int, parent:TPropertyGroup)
	Return New TPropertyItemInt.Create(label, value, id, parent)
End Function


Type TPropertyItemInt Extends TPropertyItem

	Method Create:TPropertyItemInt(label:String, defaultValue:Int, id:Int, parent:TPropertyGroup)

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
		Local tmpItem:TPropertyItemInt = TPropertyItemInt(context)
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
						If GadgetText(interact) = "" Then SetGadgetText(interact, "0")
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



	rem
	bbdoc: Returns integer value
	endrem
	Method GetValue:Int()
		Return Int(GadgetText(interact))
	End Method


	rem
	bbdoc: Sets integer value
	endrem
	Method SetValue(value:Int)
		If value Then SetGadgetText(interact, value)
	End Method



	rem
	bbdoc: Filters user input. Only decimals allowed, DEL or -
	endrem
	Function FilterInput:Int(event:TEvent, context:Object)
		If event.id = EVENT_KEYCHAR
			If event.data = 45 Then Return 1
			If event.data = 8 Then Return 1	'del
			If event.data < 48 Or event.data > 57 Return 0
		EndIf
		Return 1
	End Function


	Rem
		bbdoc:   Returns item as a string.
		about:   format: paramater,itemtype,name,value
		returns: String
	EndRem
	Method ToString:String()
		Return "parameter,int," + Self.Getlabel() + ","+Self.GetValue()
	EndMethod

End Type
