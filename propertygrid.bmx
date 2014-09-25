
Rem
	Copyright (c) 2012 Wiebo de Wit

	Permission is hereby granted, free of charge, to any person obtaining a copy of this
	software and associated documentation files (the "Software"), to deal in the
	Software without restriction, including without limitation the rights to use, copy,
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
	and to permit persons to whom the Software is furnished to do so, subject to the
	following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
endrem

SuperStrict


Rem
	bbdoc: Propertygrid module
endrem
Module wdw.propertygrid

ModuleInfo "Version: 1.01"
ModuleInfo "License: MIT"
ModuleInfo "Copyright: 2012 Wiebo de Wit"

ModuleInfo "History: 1.01"
ModuleInfo "Small fixes to retrieving values from items"
ModuleInfo "History: 1.00"
ModuleInfo "Initial Release."

Import maxgui.drivers
Import maxgui.proxygadgets
Import brl.eventqueue
Import brl.retro
Import brl.bmploader

Incbin "media/header.bmp"
Incbin "media/header2.bmp"
Incbin "media/folder.bmp"

Include "source/TPropertyEvents.bmx"
Include "source/TPropertyBase.bmx"
Include "source/TPropertyGrid.bmx"
Include "source/TPropertyGroup.bmx"
Include "source/TPropertyItem.bmx"
Include "source/TPropertyItemBool.bmx"
Include "source/TPropertyItemChoice.bmx"
Include "source/TPropertyItemColor.bmx"
Include "source/TPropertyItemFloat.bmx"
Include "source/TPropertyItemInt.bmx"
Include "source/TPropertyItemPath.bmx"
Include "source/TPropertyItemSeperator.bmx"
Include "source/TPropertyItemString.bmx"
