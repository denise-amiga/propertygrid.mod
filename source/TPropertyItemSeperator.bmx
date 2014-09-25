
rem
bbdoc: creates a non-interactive seperator item.
endrem
Function CreatePropertyItemSeparator:TPropertyItemSeparator(label:String, parent:TPropertyGroup)
	Return New TPropertyItemSeparator.Create(label, parent)
End Function


Type TPropertyItemSeparator Extends TPropertyItem

	Method Create:TPropertyItemSeparator(newlabel:String="", parent:TPropertyGroup)
		CreateItemLayout(parent)
		SetLabel(newlabel)

		SetGadgetColor(containerPanel, 255, 255, 255)
		SetGadgetFont(label, LookupGuiFont(GUIFONT_SYSTEM, 0, FONT_BOLD))
		SetGadgetTextColor(label, 100, 100, 100)

		parent.AddItem(Self)
		Return Self
	End Method

End Type


