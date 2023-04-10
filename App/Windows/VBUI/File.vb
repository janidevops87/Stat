Option Strict Off
Option Explicit On
Module modFile
	
	Private Const ENUM_BUF_SIZE As Short = 4096 ' Key enumeration buffer, see GetProfile()	
	
	Structure OFSTRUCT
		<VBFixedString(1),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=1)> Public cBytes() As Char
		<VBFixedString(1),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=1)> Public fFixedDisk() As Char
		Dim nErrCode As Short
		<VBFixedString(4),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=4)> Public Reserved() As Char
		<VBFixedString(128),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=128)> Public szPathName() As Char
	End Structure
End Module