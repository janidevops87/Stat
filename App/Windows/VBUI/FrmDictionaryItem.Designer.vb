<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmDictionaryItem
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents CmdTest As System.Windows.Forms.Button
	Public WithEvents CmdAdd As System.Windows.Forms.Button
	Public WithEvents CmdEdit As System.Windows.Forms.Button
	Public WithEvents CmdOK As System.Windows.Forms.Button
	Public WithEvents CmdCancel As System.Windows.Forms.Button
	Public WithEvents LstMisspellings As System.Windows.Forms.ListBox
	Public WithEvents TxtName As System.Windows.Forms.TextBox
	Public WithEvents TxtCorrect As System.Windows.Forms.RichTextBox
	Public WithEvents _Lable_2 As System.Windows.Forms.Label
	Public WithEvents _Lable_1 As System.Windows.Forms.Label
	Public WithEvents _Lable_0 As System.Windows.Forms.Label
	Public WithEvents Frame As System.Windows.Forms.GroupBox
	Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmDictionaryItem))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.CmdTest = New System.Windows.Forms.Button
        Me.CmdAdd = New System.Windows.Forms.Button
        Me.CmdEdit = New System.Windows.Forms.Button
        Me.CmdOK = New System.Windows.Forms.Button
        Me.CmdCancel = New System.Windows.Forms.Button
        Me.Frame = New System.Windows.Forms.GroupBox
        Me.LstMisspellings = New System.Windows.Forms.ListBox
        Me.TxtName = New System.Windows.Forms.TextBox
        Me.TxtCorrect = New System.Windows.Forms.RichTextBox
        Me._Lable_2 = New System.Windows.Forms.Label
        Me._Lable_1 = New System.Windows.Forms.Label
        Me._Lable_0 = New System.Windows.Forms.Label
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.Frame.SuspendLayout()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmdTest
        '
        Me.CmdTest.BackColor = System.Drawing.SystemColors.Control
        Me.CmdTest.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdTest.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdTest.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdTest.Location = New System.Drawing.Point(296, 46)
        Me.CmdTest.Name = "CmdTest"
        Me.CmdTest.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdTest.Size = New System.Drawing.Size(80, 21)
        Me.CmdTest.TabIndex = 6
        Me.CmdTest.Text = "&Test"
        Me.CmdTest.UseVisualStyleBackColor = False
        '
        'CmdAdd
        '
        Me.CmdAdd.BackColor = System.Drawing.SystemColors.Control
        Me.CmdAdd.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdAdd.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdAdd.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdAdd.Location = New System.Drawing.Point(296, 104)
        Me.CmdAdd.Name = "CmdAdd"
        Me.CmdAdd.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdAdd.Size = New System.Drawing.Size(80, 21)
        Me.CmdAdd.TabIndex = 3
        Me.CmdAdd.Text = "&Add..."
        Me.CmdAdd.UseVisualStyleBackColor = False
        '
        'CmdEdit
        '
        Me.CmdEdit.BackColor = System.Drawing.SystemColors.Control
        Me.CmdEdit.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdEdit.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdEdit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdEdit.Location = New System.Drawing.Point(296, 128)
        Me.CmdEdit.Name = "CmdEdit"
        Me.CmdEdit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdEdit.Size = New System.Drawing.Size(80, 21)
        Me.CmdEdit.TabIndex = 4
        Me.CmdEdit.Text = "&Edit..."
        Me.CmdEdit.UseVisualStyleBackColor = False
        '
        'CmdOK
        '
        Me.CmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.CmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdOK.Location = New System.Drawing.Point(296, 8)
        Me.CmdOK.Name = "CmdOK"
        Me.CmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdOK.Size = New System.Drawing.Size(80, 21)
        Me.CmdOK.TabIndex = 1
        Me.CmdOK.Text = "&Save"
        Me.CmdOK.UseVisualStyleBackColor = False
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(296, 182)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(80, 21)
        Me.CmdCancel.TabIndex = 2
        Me.CmdCancel.Text = "C&ancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'Frame
        '
        Me.Frame.BackColor = System.Drawing.SystemColors.Control
        Me.Frame.Controls.Add(Me.LstMisspellings)
        Me.Frame.Controls.Add(Me.TxtName)
        Me.Frame.Controls.Add(Me.TxtCorrect)
        Me.Frame.Controls.Add(Me._Lable_2)
        Me.Frame.Controls.Add(Me._Lable_1)
        Me.Frame.Controls.Add(Me._Lable_0)
        Me.Frame.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.Location = New System.Drawing.Point(2, 0)
        Me.Frame.Name = "Frame"
        Me.Frame.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame.Size = New System.Drawing.Size(289, 205)
        Me.Frame.TabIndex = 8
        Me.Frame.TabStop = False
        '
        'LstMisspellings
        '
        Me.LstMisspellings.BackColor = System.Drawing.SystemColors.Window
        Me.LstMisspellings.Cursor = System.Windows.Forms.Cursors.Default
        Me.LstMisspellings.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstMisspellings.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstMisspellings.ItemHeight = 14
        Me.LstMisspellings.Location = New System.Drawing.Point(78, 72)
        Me.LstMisspellings.Name = "LstMisspellings"
        Me.LstMisspellings.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LstMisspellings.Size = New System.Drawing.Size(199, 116)
        Me.LstMisspellings.Sorted = True
        Me.LstMisspellings.TabIndex = 5
        '
        'TxtName
        '
        Me.TxtName.AcceptsReturn = True
        Me.TxtName.BackColor = System.Drawing.SystemColors.Window
        Me.TxtName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtName.Location = New System.Drawing.Point(78, 20)
        Me.TxtName.MaxLength = 80
        Me.TxtName.Name = "TxtName"
        Me.TxtName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtName.Size = New System.Drawing.Size(200, 21)
        Me.TxtName.TabIndex = 0
        '
        'TxtCorrect
        '
        Me.TxtCorrect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCorrect.Location = New System.Drawing.Point(78, 44)
        Me.TxtCorrect.MaxLength = 80
        Me.TxtCorrect.Multiline = False
        Me.TxtCorrect.Name = "TxtCorrect"
        Me.TxtCorrect.RightMargin = 177
        Me.TxtCorrect.Size = New System.Drawing.Size(199, 23)
        Me.TxtCorrect.TabIndex = 7
        Me.TxtCorrect.Text = ""
        '
        '_Lable_2
        '
        Me._Lable_2.AutoSize = True
        Me._Lable_2.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_2, CType(2, Short))
        Me._Lable_2.Location = New System.Drawing.Point(18, 50)
        Me._Lable_2.Name = "_Lable_2"
        Me._Lable_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_2.Size = New System.Drawing.Size(55, 14)
        Me._Lable_2.TabIndex = 11
        Me._Lable_2.Text = "Corrected"
        '
        '_Lable_1
        '
        Me._Lable_1.AutoSize = True
        Me._Lable_1.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_1, CType(1, Short))
        Me._Lable_1.Location = New System.Drawing.Point(13, 74)
        Me._Lable_1.Name = "_Lable_1"
        Me._Lable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_1.Size = New System.Drawing.Size(65, 14)
        Me._Lable_1.TabIndex = 10
        Me._Lable_1.Text = "Misspellings"
        '
        '_Lable_0
        '
        Me._Lable_0.AutoSize = True
        Me._Lable_0.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_0, CType(0, Short))
        Me._Lable_0.Location = New System.Drawing.Point(41, 24)
        Me._Lable_0.Name = "_Lable_0"
        Me._Lable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_0.Size = New System.Drawing.Size(33, 14)
        Me._Lable_0.TabIndex = 9
        Me._Lable_0.Text = "Word"
        '
        'FrmDictionaryItem
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(380, 210)
        Me.Controls.Add(Me.CmdTest)
        Me.Controls.Add(Me.CmdAdd)
        Me.Controls.Add(Me.CmdEdit)
        Me.Controls.Add(Me.CmdOK)
        Me.Controls.Add(Me.CmdCancel)
        Me.Controls.Add(Me.Frame)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(163, 147)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmDictionaryItem"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Dictionary Item"
        Me.Frame.ResumeLayout(False)
        Me.Frame.PerformLayout()
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class