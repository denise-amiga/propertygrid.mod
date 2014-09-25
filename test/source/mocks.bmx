
'simplified mocks for unit tests

Type TPropertyBaseMock Extends TPropertyBase

	Method RefreshLayout()
	End Method

End Type



Type TPropertyGridMock Extends TPropertyGrid

	Global instance:TPropertyGridMock

	Function GetInstance:TPropertyGridMock()
		If Not instance Then Return New TPropertyGridMock
		Return instance
	End Function
	
	Method RefreshLayout()
	End Method
	
End Type
