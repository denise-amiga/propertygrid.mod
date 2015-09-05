
rem
bbdoc: creates a choice value item
endrem
Function CreatePropertyItemChoice:TPropertyItemChoice(label:String, id:Int, parent:TPropertyGroup)
	Return New TPropertyItemChoice.Create(label, id, parent)
End Function


Rem
bbdoc: an interactive choice value item
endrem
Type TPropertyItemChoice Extends TPropertyItem

	Rem
	bbdoc: Constructor
	endrem
	Method Create:TPropertyItemChoice(label:String, id:Int, parent:TPropertyGroup)
		CreateItemLayout(parent)
		SetLabel(label)
		SetItemID(id)

		interact = CreateComboBox(interactX, 0, TPropertyGrid.INTERACT_WIDTH, TPropertyGrid.ITEM_SIZE, containerPanel, 0)
		SetGadgetLayout(interact, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)

		AddHook(EmitEventHook, eventHandler, Self, 0)
		parent.AddItem(Self)
		Return Self
	End Method



	Function eventHandler:Object(id:Int, data:Object, context:Object)
		Local tmpItem:TPropertyItemChoice = TPropertyItemChoice(context)
		If tmpItem Then data = tmpItem.eventHook(id, data, context)
		Return data
	End Function



	Method eventHook:Object(id:Int, data:Object, context:Object)
		Local tmpEvent:TEvent = TEvent(data)
		If Not tmpEvent Then Return data

		Select tmpEvent.source
			Case interact
				Select tmpEvent.id
					Case EVENT_GADGETACTION
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
	bbdoc: Add choice option
	endrem
	Method AddItem(itemLabel:String)
		AddGadgetItem interact, itemLabel
	End Method



	rem
	bbdoc: Removes all options
	endrem
	Method RemoveItems()
		ClearGadgetItems(interact)
	End Method



	rem
	bbdoc: Returns index of selected choice
	endrem
	Method GetValue:Int()
		Return SelectedGadgetItem(interact)
	End Method


	Rem
		bbdoc: returns the text of the selected choice
	endrem
	Method GetValueLabel:String()
		Return GadgetText(interact)
	End Method



	rem
	bbdoc: Sets choice to passed index
	endrem
	Method SetIndexValue(index:Int)
		SelectGadgetItem(interact, index)
	End Method


	Rem
		bbdoc:   Returns item as a string.
		about:   format: paramater,itemtype,name,value
		returns: String
	EndRem
	Method ToString:String()
		Return "parameter,choice," + Self.Getlabel() + ","+Self.GetValueLabel()
	EndMethod

End Type
