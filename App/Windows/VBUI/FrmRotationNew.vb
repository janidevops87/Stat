Option Strict Off
Option Explicit On
Friend Class FrmRotationNew
	Inherits System.Windows.Forms.Form
	Public RotationGroupID As Short
	Public RotationName As String
    Public RotationID As Object
    Public ModalParent As Object
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		Me.Close()
	End Sub
	
	Private Sub CmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdOK.Click
		
		'*********************************************************************************
		'Name: cmdOK_Click
		'Date Created: 11/30/2004                          Created By: T.T 11/30/2004
		'Release #: [Release Sub Was Created For  ex: 7.7.3]    Task: [Task created for]
		'Description: This function is the ok button
		'Returns: N/A
		'Params:
		'Stored Procedures: N/A
		'=================================================================================
		
        Dim vRS As New Object
        Dim vReturn As New Object
        Dim vQuery As String
		Dim vRot As Object
        Me.RotationGroupID = ModalParent.RotationGroupID
        If Me.RotationName <> "" Then
            vQuery = "Update Rotation set RotationName = '" & Me.TxtRotationName.Text & "' Where RotationGroupID = " & Me.RotationGroupID & " and RotationID = " & Me.RotationID
            Call modODBC.Exec(vQuery)
            Me.Close()
            Exit Sub
        End If


        vQuery = "select  max (rotationid) from Rotation where RotationGroupID = " & RotationGroupID
        Call modODBC.Exec(vQuery, vReturn,  ,  , vRS)
        If vReturn(0, 0) = "" Then
            'New RotationGroup Detected. add a first Rotation
            vQuery = "Insert into Rotation (RotationName,RotationID,RotationGroupID,RotationSequence) values ('" & Me.TxtRotationName.Text & "',1," & RotationGroupID & "," & vReturn(0, 0) & ")"
            Call modODBC.Exec(vQuery)

        Else
            vQuery = "Insert into Rotation(RotationName,RotationID,RotationGroupID,RotationSequence) values('" & Me.TxtRotationName.Text & "'," & vReturn(0, 0) + 1 & "," & RotationGroupID & "," & vReturn(0, 0) + 1 & ")"
            Call modODBC.Exec(vQuery)

            vRot = ModalParent.AdvanceRotationArray(modConv.TextToInt(vReturn(0, 0))) 'modConv.TextToInt(vReturn(0, 0))

            ModalParent.RotationNextID = vRot
            ModalParent.lblRotationNext.Text = vRot

        End If
        Call ModalParent.CboRotationGroup_SelectedIndexChanged(Nothing, New System.EventArgs())
		Me.Close()
	End Sub
	Public Function Display() As Object
		
        Dim dialogResult As DialogResult = Me.ShowDialog()
		
	End Function
	
	Private Sub FrmRotationNew_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		If Me.RotationName <> "" Then
			Me.TxtRotationName.Text = Me.RotationName
			Me.Text = "Rename Rotation"
		End If
		
	End Sub
End Class