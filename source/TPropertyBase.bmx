
rem
bbdoc: module types are derived from this base type.
endrem
Type TPropertyBase Abstract

	'id of this item. used for event handling
	Field itemID:Int

	'container panel. child items (groups or items) are placed here
	Field containerPanel:TGadget
	
	'text label
	Field label:TGadget
	
	'indent level of this item
	Field indentLevel:Int
	
		
	rem
	bbdoc: Returns container panel
	endrem	
	Method GetContainerPanel:TGadget()
		Return containerPanel
	End Method
	
	
	Rem
	bbdoc: Sets main container panel
	endrem
	Method SetContainerPanel(p:TGadget)
		containerPanel = p
	End Method
		
	
	
	Rem
	bbdoc: Sets item label
	EndRem
	Method SetLabel(value:String)
		SetGadgetText(label, value)
	End Method



	rem
	bbdoc: Returns item name
	endrem
	Method GetLabel:String()
		Return GadgetText(label)
	End Method
	
	
	
	rem
	bbdoc: Sets item indent level
	endrem
	Method SetIndentLevel(Value:Int)
		indentLevel = Value
	End Method
		
	
	
	rem
	bbdoc: Returns item indent level
	endrem	
	Method GetIndentLevel:Int()
		Return indentLevel
	End Method
	
	
	
	Rem
	bbdoc: Sets vertical size of container panel
	endrem	
	Method SetVerticalSize(amount:Int)
		SetGadgetShape(containerPanel, GadgetX(containerPanel), GadgetY(containerPanel), ..
			GadgetWidth(containerPanel), amount)
	End Method
	
	
	
	rem
	bbdoc: Returns vertical size of container panel
	endrem	
	Method GetVerticalSize:Int()
		Return GadgetHeight(containerPanel)
	End Method
	
	
	
	Rem
	bbdoc: Sets vertical position of container panel
	endrem	
	Method SetVerticalPosition(ypos:Int)
		SetGadgetShape(containerPanel, GadgetX(containerPanel), ypos, ..
			GadgetWidth(containerPanel), GadgetHeight(containerPanel))
	End Method
	
	
	
	Rem
	bbdoc: Returns the vertical position of this item
	end rem
	Method GetVerticalPosition:Int()
		Return GadgetY(containerPanel)
	End Method
	
	
	
	rem
	bbdoc: Returns item ID
	EndRem
	Method GetItemID:Int()
		Return itemID
	End Method
	
	
	
	rem
	bbdoc: Sets item ID
	endrem
	Method SetItemID(value:Int)
		itemID = value
	End Method
		
End Type