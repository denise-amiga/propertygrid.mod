Intro
-------------------------------------------------------------------------------

This Blitzmax module will make it possible to use a property grid in your maxgui application without hassle. The propertygrid is event-driven and integrates into the maxgui event system by the use of custom events.

This is what it looks like:

![propertygrid](https://dl.dropboxusercontent.com/u/12644619/pics/dev/propertygrid_example.png)

Documentation
-------------------------------------------------------------------------------

Documentation is currently viewable on the [project's wiki](http://wiki.github.com/wiebow/propertygrid.mod/).

Installation
-------------------------------------------------------------------------------

All my modules must be put in a subfolder of `Blitzmax/mod/wdw.mod`.
To install this module, put the `propertygrid.mod` folder in `Blitzmax/mod/wdw.mod`. You can do this in the following ways:

1. Clone the repository into your `BlitzMax/mod/wdw.mod` directory using `git clone git://github.com/wiebow/propertygrid.mod.git`
2. Click the 'Download Source' button at the top of the Source section of the GitHub repository and extract this into your `BlitzMax/mod/wdw.mod` directory.

After this, simply run `bmk makemods wdw.propertygrid` or rebuild the module from your IDE.

Types
-------------------------------------------------------------------------------

The module consists of the following types:

  * *TPropertyGrid*: This is the main container object. It holds the property groups on a _scrollpanel_ and handles group events. You can create one property grid, as it is a _singleton_. 
  * *TPropertyGroup*: A group contains items. It can also contain other groups, etc.
  * *TPropertyItem*: there are several property item types:
    * TpropertyItemBool: a button to select True or False.
    * TpropertyItemChoice: a pull-down gadget to select a choice from a list
    * TpropertyItemColor: click-able color select icon.
    * TpropertyItemFloat: a field to enter a FLOAT value. Input is filtered.
    * TpropertyItemInt: a field to enter an INT value. Input is filtered.
    * TpropertyItemSeparator: an empty item which can contain a label. Useful for grouping items.
    * TpropertyItemString: a field to enter a STRING value. Input is filtered.
    * TpropertyItemPath: a click-able folder icon to select a file.

Events
-------------------------------------------------------------------------------

The module registeres two custom events:

EVENT_PG_GROUPTOGGLED: This event is raised when a group is opened or closed. TPropertyGrid uses this event to refresh the grid layout when needed.

EVENT_PG_ITEMCHANGED: This event is raised by a TPropertyItem when enter is pressed in a field, a gadget has been interacted with or the cursor leaves a text field. Your application main event loop can use this event to signal property value changes.
EventSource contains the property item, EventData contains the property item ID, and EventExtra contains the new value. The event source is returned as an object, so it must be cast to the correct type.

How to use
-------------------------------------------------------------------------------

The repository contains an example application so you can see how to use the module.
Here is some example code to show how to set up a simple propertygrid:

    Import wdw.propertygrid
    Local w:TGadget = CreateWindow("test", 50, 50, 600, 600, Null, WINDOW_TITLEBAR | WINDOW_RESIZABLE | WINDOW_CLIENTCOORDS)
    Local g:TPropertyGrid = TPropertyGrid.GetInstance()
    g.Initialize(w, 1)

Now we can create a group and add items to it. Each group and item must have a unique ID for event handling:

    Local group1:TPropertyGroup = g.AddGroup("Group 1", 9001)
    CreatePropertyItemBool("Bool", 1, 100, group1)
    Local choice:TPropertyItemChoice = CreatePropertyItemChoice("Choice", 101, group1)
    choice.AddItem("A")
    choice.AddItem("B")
    choice.AddItem("C")
    CreatePropertyItemColor("Color", 255, 255, 0, 102, group1)

The layout of the grid must be refreshed so we can see the groups and items:

    g.RefreshLayout()

The application main event loop can now react to changes in the items:

    Repeat
    WaitEvent()
       Select EventID()
    		Case EVENT_WINDOWCLOSE, EVENT_APPTERMINATE		
			    TPropertyGrid.GetInstance().CleanUp()
			    End
		    Case EVENT_PG_ITEMCHANGED
		    	Select EventData()
		    		Case 100
				    	Local i:TPropertyItemBool = TPropertyItemBool(EventSource())
				    	Print "Changed item: " + i.GetLabel() + ". New value is: " + EventText()
				    Case 101
				    	Local i:TPropertyItemChoice = TPropertyItemChoice(EventSource())
				    	Print "Changed item: " + i.GetLabel() + ". New value is: " + EventText()
				    Case 102
				    	Local i:TPropertyItemColor = TPropertyItemColor(EventSource())
			    		Print "Changed item:" + i.GetLabel() + ". New value is: " + EventText()
		    	End Select
	    End Select
    Forever

License
-------------------------------------------------------------------------------

Propertygrid is licensed under the MIT license:

    Copyright (c) 2014 Wiebo de Wit.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
