Option Strict Off
Option Explicit On
Friend Class FrmDynamicDonorCategory
	Inherits System.Windows.Forms.Form
	
	'Form Variables
	Dim fvCriteriaGroupID As Integer
	Dim fvDynamicCategoryID As Integer
    Dim fvDonorCategoryName As String = ""
	Dim fvVerified As Short
	Dim fvSaved As Short
    '03/2010 bret 
    Private frmEditDynamicDonorCategory As FrmEditDynamicDonorCategory
	
	Private Sub CmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdCancel.Click
		Me.Close()
	End Sub
	
	
	
	Private Sub CmdEditDynamicDonorCategory_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles CmdEditDynamicDonorCategory.Click
		
		Dim vDynamicDonorCategoryID As Integer
        Dim vReturn As New Object
        frmEditDynamicDonorCategory = New FrmEditDynamicDonorCategory

		'Set the Dynamic Donor Criteria ID on form FrmEditDynamicDonorCategory
		vDynamicDonorCategoryID = modControl.GetID(CboDynamicCategory)
		If vDynamicDonorCategoryID > 0 And vDynamicDonorCategoryID < 8 Then
			Exit Sub
		End If
        frmEditDynamicDonorCategory.DynamicDonorCategoryID = vDynamicDonorCategoryID
		
        vDynamicDonorCategoryID = frmEditDynamicDonorCategory.Display
		
		If vDynamicDonorCategoryID = 0 Then
			'Do Nothing edit was cancelled
		Else
			'Refill the combo box with the new (or updated)
			'CriteriaGroup id and name
			Call modStatRefQuery.RefQueryDynamicDonorCategory(vReturn)
			Call modControl.SetTextID(CboDynamicCategory, vReturn)
			Call modControl.SelectID(CboDynamicCategory, vDynamicDonorCategoryID)
			'add a blank Category for adding new Dynamic Categories
            CboDynamicCategory.Items.Add(New ValueDescriptionPair(0, ""))
		End If
	End Sub
	
	Private Sub cmdSave_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSave.Click
		Dim vReturn As Short
		
		'Make sure the user wants to save
		vReturn = modMsgForm.FormSave
		
		If vReturn = MsgBoxResult.Cancel Then
			Exit Sub
		End If
		
		'Set the data to unverified
		Me.Verified = False
		
		fvDynamicCategoryID = modControl.GetID(CboDynamicCategory)
		'Validate the data
		If fvDynamicCategoryID <= 0 Then
			Exit Sub
		End If
		
		'Create a new record and
		'get the ID
		Call modStatSave.SaveCriteriaDynamicDonorCategory(Me)
		Me.Saved = True
		
		Me.Close()
		
	End Sub
	
	Private Sub FrmDynamicDonorCategory_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        Dim lvParams As New Object
		Dim lvResult As Short
		'Center form
		Call modUtility.CenterForm()
		
		'Set lable text for current criteria ID
		LblDynamicCategory.Text = fvDonorCategoryName
		
		'Requirements to load CriteriaGroupID
		'Build Dynamic Donor Categories and fill combo box
		Call modStatRefQuery.ListRefQueryDynamicDonorCategory(CboDynamicCategory)
		
		'add a blank Category for adding new Dynamic Categories
        CboDynamicCategory.Items.Add(New ValueDescriptionPair(0, ""))
		
		'check for a criteria group and set selected values for combo box
		lvResult = modStatRefQuery.RefQueryDynamicDonorCategory(lvParams, fvCriteriaGroupID)
		Call modControl.SelectID(CboDynamicCategory, CInt(lvParams(0, 0)))
		'DonorCategoryName
	End Sub
	
	Public Property DonorCategoryName() As Object
		Get

            DonorCategoryName = fvDonorCategoryName

        End Get
        Set(ByVal Value As Object)

            fvDonorCategoryName = Value

        End Set
    End Property

    Public Property DynamicCategoryID() As Object
        Get

            DynamicCategoryID = fvDynamicCategoryID

        End Get
        Set(ByVal Value As Object)

            fvDynamicCategoryID = Value

        End Set
    End Property

    Public Property CriteriaGroupID() As Object
        Get

            CriteriaGroupID = fvCriteriaGroupID

        End Get
        Set(ByVal Value As Object)

            fvCriteriaGroupID = Value

        End Set
    End Property

    Public Property Verified() As Object
        Get

            Verified = fvVerified

        End Get
        Set(ByVal Value As Object)

            fvVerified = modConv.TextToInt(Value)

        End Set
    End Property

    Public Property Saved() As Object
        Get

            Saved = fvSaved

        End Get
        Set(ByVal Value As Object)

            fvSaved = Value

        End Set
    End Property
    Public Function Display() As Integer

        Dim dialogResult As DialogResult = Me.ShowDialog()

    End Function


    Private Sub FrmDynamicDonorCategory_FormClosing(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Dim vReturn As Short

        If Me.Saved = True Then
            'The message was saved so just unload
            eventArgs.Cancel = False

        Else
            'The message was cancelled or closed so confirm cancellation
            vReturn = modMsgForm.FormCancel
            If vReturn = MsgBoxResult.Yes Then
                eventArgs.Cancel = False

            Else
                eventArgs.Cancel = True
                Exit Sub
            End If
        End If
        'Me.Dispose()
    End Sub

End Class