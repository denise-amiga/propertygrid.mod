
'unit tests for propertygrid mod
'more test will be added when needed

SuperStrict

Framework bah.maxunit
Import wdw.propertygrid

Include "source/mocks.bmx"
Include "source/propertybase_test.bmx"
Include "source/propertygrid_test.bmx"
Include "source/propertygroup_test.bmx"

New TTestSuite.run()
