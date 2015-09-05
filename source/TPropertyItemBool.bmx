
rem
bbdoc: creates a bool value item
endrem
Function CreatePropertyItemBool:TPropertyItemBool(label:String, value:Int = 1, id:Int, parent:TPropertyGroup)
	Return New TPropertyItemBool.Create(label, value, id, parent)
End Function


Rem
bbdoc: an interactive bool value item
endrem
Type TPropertyItemBool Extends TPropertyItem

	Rem
	bbdoc: Constructor
	endrem
	Method Create:TPropertyItemBool(label:String, defaultValue:Int, id:Int, parent:TPropertyGroup)
		CreateItemLayout(parent)
		SetLabel(label)
		SetItemID(id)

		interact = CreateButton("", interactX, 1, TPropertyGrid.INTERACT_WIDTH - 1, TPropertyGrid.ITEM_SIZE - 2, containerPanel, BUTTON_CHECKBOX)
		SetGadgetLayout(interact, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetButtonState(interact, defaultValue)
		UpdateBoolText()

		AddHook(EmitEventHook, eventHandler, Self, 0)
		parent.AddItem(Self)
		Return Self
	End Method



	Function eventHandler:Object(id:Int, data:Object, context:Object)
		Local tmpItem:TPropertyItemBool = TPropertyItemBool(context)
		If tmpItem Then data = tmpItem.eventHook(id, data, context)
		Return data
	End Function



	Method EventHook:Object(id:Int, data:Object, context:Object)
		Local tmpEvent:TEvent = TEvent(data)
		If Not tmpEvent Then Return data

		Select tmpEvent.source
			Case interact
				Select tmpEvent.id
					Case EVENT_GADGETACTION
						UpdateBoolText()
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
	bbdoc: Updates item text according to bool value
	endrem
	Method UpdateBoolText()
		If ButtonState(interact) = True Then SetGadgetText(interact, "True")
		If ButtonState(interact) = False Then SetGadgetText(interact, "False")
	EndMethod



	rem
	bbdoc: Returns bool value status
	endrem
	Method GetValue:Int()
		Return ButtonState(interact)
	End Method



	rem
	bbdoc: Set bool status
	endrem
	Method SetValue(bool:Int)
		SetButtonState(interact, bool)
		UpdateBoolText()
	End Method


	Rem
		bbdoc:   Returns item as a string.
		about:   format: paramater,itemtype,name,value
		returns: String
	EndRem
	Method ToString:String()
		Return "parameter,bool," + Self.Getlabel() + ","+Self.GetValue()
	EndMethod

End Type

