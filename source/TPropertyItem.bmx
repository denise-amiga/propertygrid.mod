
rem
bbdoc: base type for items
endrem
Type TPropertyItem Extends TPropertyBase Abstract

	'the gadget the user interacts with. it contains the value
	Field interact:TGadget

	'fixed position of interact gadget
	Global interactX:Int = TPropertyGrid.GRID_WIDTH - TPropertyGrid.INTERACT_WIDTH - TPropertyGrid.SLIDER_WIDTH - TPropertyGrid.ITEM_SIZE



	rem
	bbdoc: Sets interact gadget readonly value.
	endrem
	Method SetReadOnly(bool:Int)
		If bool
			DisableGadget(interact)
		Else
			EnableGadget(interact)
		End If
	End Method



	rem
	bbdoc: Creates the default layout items of a property item.
	endrem
	Method CreateItemLayout(parent:TPropertyGroup) Final
		indentLevel = parent.GetIndentLevel()
		Local parentPanel:TGadget = parent.GetContainerPanel()

		containerPanel = CreatePanel(TPropertyGrid.ITEM_SIZE, 0, ClientWidth(parentPanel) - TPropertyGrid.ITEM_SIZE, TPropertyGrid.ITEM_SIZE, parentPanel)
		SetGadgetLayout(containerPanel, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_ALIGNED, EDGE_CENTERED)
		SetGadgetColor(containerPanel, 255, 255, 255)
		label = CreateLabel("", indentLevel + 2, 4, ..
			ClientWidth(containerPanel) - TPropertyGrid.INTERACT_WIDTH - indentLevel - TPropertyGrid.SLIDER_WIDTH - 4, TPropertyGrid.ITEM_SIZE - 6, containerPanel)
	End Method



	Rem
	bbdoc: Creates a property item event
	about: This is to be caught by application event loop.
	endrem
	Method CreateItemEvent(id:Int, extra:Object)
		EmitEvent CreateEvent(id, Self, itemID, 0, 0, 0, extra)
	End Method



	Rem
		bbdoc:   Returns property item settings as string.
		about:	 format: paramater,itemtype,name,value
		returns: String
	EndRem
	Method ToString:String() Abstract

End Type