
'unit tests for TPropertyGrid

Type PropertyGridTest Extends TTest

	Field p:TPropertyGridMock

	'mockwindow goes here
	Field w:TGadget
	
	Method MockWindow()
		w = CreateWindow("mock",0,0,421,10, Null, WINDOW_HIDDEN | WINDOW_CLIENTCOORDS ) ' < 421 client size
	End Method
	

	Method Before() {before}
		p = New TPropertyGridMock
	End Method
	
	
	Method After() {after}
		p.CleanUp()
		p = Null
		w = Null
	End Method
	
	
	Method constructor() {test}
		assertNotNull(p)
		assertNotNull(p.GetGroupList())
	End Method
	
	
	Method Initialize() {test}	
		MockWindow()
		
		'option of 1 should result in a scrollpanel on the right side of the window
		p.Initialize(w, 1)		
		assertEqualsI(100, p.scrollPanel.GetXPos())
		
		p.Initialize(w, 0)
		assertEqualsI(0, p.scrollPanel.GetXPos())
	End Method
	
	
	Method AddAndGetGroup() {test}
		MockWindow()
		p.Initialize(w,1)
	
		Local g:TPropertyGroup = p.AddGroup("test", 1)
		assertSame(g, p.GetGroup("test"))
	End Method
	
	
	Method AddMoreGroups() {test}
		MockWindow()
		p.Initialize(w,1)
		assertEqualsI(0, p.GetGroupList().Count())
		
		Local g1:TPropertyGroup = p.AddGroup("test1", 1)
		Local g2:TPropertyGroup = p.AddGroup("test2", 2)
		
		assertEqualsI(2, p.GetGroupList().Count())
		
		assertSame(g1, p.GetGroup("test1"))
		assertSame(g2, p.GetGroup("test2"))
	End Method
	
	
	Method RemoveGroup() {test}
		MockWindow()
		p.Initialize(w,1)
		
		Local g:TPropertyGroup = p.AddGroup("test", 1)
		assertSame(g, p.GetGroup("test"))
		p.RemoveGroup("test")
		
		assertNull(p.GetGroup("test"))
		assertEqualsI(0, p.groupList.Count())
		
	End Method
	

End Type
