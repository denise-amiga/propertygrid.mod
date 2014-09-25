
rem
bbdoc: creates a color choice item.
endrem
Function CreatePropertyItemColor:TPropertyItemColor(label:String, red:Int = 255, green:Int = 255, blue:Int = 255, id:Int, parent:TPropertyGroup)
	Return New TPropertyItemColor.Create(label, red, green, blue, id, parent)
End Function



Rem
bbdoc: an interactive color selector item.
endrem
Type TPropertyItemColor Extends TPropertyItem

	Field colorLabel:TGadget

	'color values
	Field r:Int, g:Int, b:Int

	Method Create:TPropertyItemColor(label:String, defaultRed:Int, defaultGreen:Int, defaultBlue:Int, id:Int, parent:TPropertyGroup)
		CreateItemLayout(parent)
		SetLabel(label)
		SetItemID(id)

		' the color recangle
		interact = CreatePanel(interactX, 2, TPropertyGrid.ITEM_SIZE, TPropertyGrid.ITEM_SIZE - 3, containerPanel, PANEL_BORDER)
		SetGadgetSensitivity(interact, SENSITIZE_MOUSE)

		'text RGB
		colorLabel = CreateLabel("", interactX + TPropertyGrid.ITEM_SIZE + 4, 3, ClientWidth(containerPanel) - TPropertyGrid.ITEM_SIZE - 4, TPropertyGrid.ITEM_SIZE, containerPanel)
		SetGadgetLayout(colorLabel, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetColor(colorLabel, 255, 255, 255)

		SetColorValue(defaultRed, defaultGreen, defaultBlue)

		AddHook(EmitEventHook, eventHandler, Self, 0)
		parent.AddItem(Self)

		Return Self
	End Method



	Function eventHandler:Object(id:Int, data:Object, context:Object)
		Local tmpItem:TPropertyItemColor = TPropertyItemColor(context)
		If tmpItem Then data = tmpItem.eventHook(id, data, context)
		Return data
	End Function



	Method EventHook:Object(id:Int, data:Object, context:Object)
		Local tmpEvent:TEvent = TEvent(data)
		If Not tmpEvent Then Return data

		Select tmpEvent.source
			Case interact
				Select tmpEvent.id
					Case EVENT_MOUSEUP
						If tmpEvent.data = 1
							If RequestColor(r, g, b)
								SetColorValue(RequestedRed(), RequestedGreen(), RequestedBlue())
							EndIf
						End If
						CreateItemEvent(EVENT_PG_ITEMCHANGED, GetColorValue())

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
	bbdoc: Frees this item.
	endrem
	Method Free()
		FreeGadget interact
		FreeGadget colorLabel
	End Method



	Rem
	bbdoc: Returns red component of color value.
	endrem
	Method GetRed:Int()
		Return r
	End Method



	Rem
	bbdoc: Returns green component of color value.
	endrem
	Method GetGreen:Int()
		Return g
	End Method



	Rem
	bbdoc: Returns blue component of color value.
	endrem
	Method GetBlue:Int()
		Return b
	End Method



	Rem
	bbdoc: Returns color values in an array.
	endrem
	Method GetColorValue:Int[] ()
		Local array:Int[3]
		array[0] = r
		array[1] = g
		array[2] = b
		Return array
	End Method



	Rem
	bbdoc: Sets color values.
	endrem
	Method SetColorValue(red:Int, green:Int, blue:Int)
		r = red
		g = green
		b = blue
		SetGadgetColor(interact, r, g, b)
		SetGadgetText(colorLabel, "(" + String(r) + "," + String(g) + "," + String(b) + ")")
	End Method

End Type

