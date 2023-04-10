Option Explicit
Private Const NumFields = 5

Dim FolderCount

'Array Structure
'	0	Item ID
'	1	ParentID
'	2	Name
'	3	Path
'	4	Date

Call GetTreeStructure("\\Sumter\c$\WINNT\Profiles\Administrator\Personal")

Function GetTreeStructure(RootFolder)

	
	
	Dim LoopCounter, InnnerLoopCounter, BranchStructure(), WorkingStructure()
	ReDim Preserve WorkingStructure(4,0)
	
	'Reset path array and Get Folder list
		ReDim Preserve BranchStructure(CountFolders(RootFolder))
		Call GetFolders(RootFolder, BranchStructure)
		
		For LoopCounter = 0 to Ubound(BranchStructure)
			IF NOT ISEMPTY(BranchStructure(LoopCounter)) THEN
				Call GetFiles(BranchStructure(LoopCounter), LoopCounter, WorkingStructure)
			END IF
		Next
	stop

End Function

Function GetFolders(FolderSpec, BranchStructure)

	Dim fso, f, f1, fc, InnerLoop
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.GetFolder(FolderSpec)
  Set fc = f.SubFolders
  
  'Reset path array
  'ReDim Preserve BranchStructure(Ubound(BranchStructure) + fc.count)
  
  For Each f1 in fc
   
		FOR InnerLoop = 0 TO Ubound(BranchStructure)
			IF IsEmpty(BranchStructure(InnerLoop))THEN
				BranchStructure(InnerLoop)= f1.path & "\"	
				EXIT FOR
			END IF
		NEXT
		
		
		Call GetFolders(BranchStructure(InnerLoop), BranchStructure)
       
  Next
  
End Function

Function CountFolders(FolderSpec)

	Dim fso, f, f1, fc, InnerLoop
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.GetFolder(FolderSpec)
  Set fc = f.SubFolders
  
  FolderCount = FolderCount + fc.count
  
    For Each f1 in fc
		Call CountFolders(f1.path)
	NEXT
	  
	CountFolders = FolderCount
	   
End Function  


Function GetFiles(FolderSpec, ParentID, WorkingStructure)


	Dim fso, f, f1, fc, LoopCounter
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.GetFolder(FolderSpec)
  Set fc = f.Files
  
  'Reset path array
  ReDim Preserve WorkingStructure(4, Ubound(WorkingStructure) + fc.count)
  
  For Each f1 in fc
   
		For LoopCounter = 0 to Ubound(WorkingStructure,2)
			IF IsEmpty(WorkingStructure(0,LoopCounter)) Then
				WorkingStructure(0, LoopCounter ) = LoopCounter
				WorkingStructure(1, LoopCounter ) = ParentID
				WorkingStructure(2, LoopCounter ) = f1.name
				WorkingStructure(3, LoopCounter ) = f1.path
				WorkingStructure(4, LoopCounter ) = f1.DateLastModified	
			END IF
		
		Next    
  Next
  
End Function