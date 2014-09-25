
'unit tests for TPropertyBase

Type PropertyBaseTest Extends TTest

	Field p:TPropertyBaseMock
	
	'mockwindow goes here
	Field w:TGadget
	
	Method MockWindow()
		w = CreateWindow("mock",0,0,10,10, Null, WINDOW_HIDDEN)
	End Method
	
	
	Method Before() {before}
		p = New TPropertyBaseMock
	End Method
	
	Method After() {after}
		p = Null
		w = Null
	End Method
	
	
	Method Constructor() {test}
		assertNotNull(p, "could not create propertybase")
	End Method

	
	Method SetandGetID() {test}
		p.SetItemID(10)
		assertEqualsI(10, p.GetItemID())
	End Method
	
	
	Method SetAndGetContainerPanel() {test}
		MockWindow()
		Local panel:TGadget = CreatePanel(0,0,5,5,w)
		p.SetContainerPanel( panel )
		
		assertSame( panel, p.GetContainerPanel())
	End Method
	
	
	Method GetVerticalSize() {test}
		MockWindow()
		Local panel:TGadget = CreatePanel(0,0,5,5,w)
		p.SetContainerPanel( panel )
		
		assertEqualsI( 5, p.GetVerticalSize())
	End Method
	
	
	Method GetAndSetIndentLevel() {test}
		p.SetIndentLevel(10)
		assertEqualsI(10, p.GetIndentLevel())
	End Method
	
	
	Method SetAndGetLabel() {test}
		MockWindow()
		Local panel:TGadget = CreatePanel(0,0,5,5,w)
		p.SetContainerPanel(panel)
		p.label = CreateLabel("mock",0,0,10,10, panel)
		p.SetLabel("mock_test")
		
		assertEquals("mock_test", p.GetLabel())
	End Method

		
	Method SetAndGetVerticalPosition() {test}
		MockWindow()
		Local panel:TGadget = CreatePanel(0,0,5,5,w)
		p.SetContainerPanel( panel )	
		p.SetVerticalPosition(50)
		assertEqualsI(50, p.GetVerticalPosition())	
	End Method
	
End Type
