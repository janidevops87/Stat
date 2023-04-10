<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmReferralDonorList
#Region "Windows Form Designer generated code "

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
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmReferralDonorList))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmdSelect = New System.Windows.Forms.Button()
        Me.cmdCancel = New System.Windows.Forms.Button()
        Me.donorsDataGridView = New System.Windows.Forms.DataGridView()
        Me.FirstName = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.MiddleName = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Address = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.City = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.State = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Zip = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.LicenseNo = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DateEntered = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Registry = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Status = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.instancesFoundLabel = New System.Windows.Forms.Label()
        CType(Me.donorsDataGridView, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'cmdSelect
        '
        Me.cmdSelect.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cmdSelect.AutoSize = True
        Me.cmdSelect.BackColor = System.Drawing.SystemColors.Control
        Me.cmdSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdSelect.DialogResult = System.Windows.Forms.DialogResult.OK
        Me.cmdSelect.Enabled = False
        Me.cmdSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSelect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSelect.Location = New System.Drawing.Point(974, 402)
        Me.cmdSelect.Name = "cmdSelect"
        Me.cmdSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSelect.Size = New System.Drawing.Size(75, 24)
        Me.cmdSelect.TabIndex = 18
        Me.cmdSelect.Text = "Select"
        Me.cmdSelect.UseVisualStyleBackColor = False
        '
        'cmdCancel
        '
        Me.cmdCancel.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cmdCancel.AutoSize = True
        Me.cmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancel.Location = New System.Drawing.Point(1055, 402)
        Me.cmdCancel.Name = "cmdCancel"
        Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancel.Size = New System.Drawing.Size(75, 24)
        Me.cmdCancel.TabIndex = 19
        Me.cmdCancel.Text = "Cancel"
        Me.cmdCancel.UseVisualStyleBackColor = False
        '
        'donorsDataGridView
        '
        Me.donorsDataGridView.AllowUserToAddRows = False
        Me.donorsDataGridView.AllowUserToDeleteRows = False
        Me.donorsDataGridView.AllowUserToResizeRows = False
        Me.donorsDataGridView.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.donorsDataGridView.CausesValidation = False
        Me.donorsDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.donorsDataGridView.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.FirstName, Me.MiddleName, Me.Address, Me.City, Me.State, Me.Zip, Me.LicenseNo, Me.DateEntered, Me.Registry, Me.Status})
        Me.donorsDataGridView.Location = New System.Drawing.Point(12, 38)
        Me.donorsDataGridView.MultiSelect = False
        Me.donorsDataGridView.Name = "donorsDataGridView"
        Me.donorsDataGridView.ReadOnly = True
        Me.donorsDataGridView.RowHeadersVisible = False
        Me.donorsDataGridView.RowHeadersWidth = 92
        Me.donorsDataGridView.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing
        Me.donorsDataGridView.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.donorsDataGridView.ShowCellErrors = False
        Me.donorsDataGridView.ShowEditingIcon = False
        Me.donorsDataGridView.ShowRowErrors = False
        Me.donorsDataGridView.Size = New System.Drawing.Size(1118, 358)
        Me.donorsDataGridView.TabIndex = 24
        '
        'FirstName
        '
        Me.FirstName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.FirstName.HeaderText = "First Name"
        Me.FirstName.MinimumWidth = 11
        Me.FirstName.Name = "FirstName"
        Me.FirstName.ReadOnly = True
        '
        'MiddleName
        '
        Me.MiddleName.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.MiddleName.FillWeight = 83.0!
        Me.MiddleName.HeaderText = "Middle Name"
        Me.MiddleName.MinimumWidth = 11
        Me.MiddleName.Name = "MiddleName"
        Me.MiddleName.ReadOnly = True
        '
        'Address
        '
        Me.Address.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.Address.FillWeight = 250.0!
        Me.Address.HeaderText = "Address"
        Me.Address.MinimumWidth = 11
        Me.Address.Name = "Address"
        Me.Address.ReadOnly = True
        '
        'City
        '
        Me.City.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.City.FillWeight = 125.0!
        Me.City.HeaderText = "City"
        Me.City.MinimumWidth = 11
        Me.City.Name = "City"
        Me.City.ReadOnly = True
        '
        'State
        '
        Me.State.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.State.FillWeight = 46.0!
        Me.State.HeaderText = "State"
        Me.State.MinimumWidth = 11
        Me.State.Name = "State"
        Me.State.ReadOnly = True
        '
        'Zip
        '
        Me.Zip.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.Zip.FillWeight = 50.0!
        Me.Zip.HeaderText = "Zip"
        Me.Zip.MinimumWidth = 11
        Me.Zip.Name = "Zip"
        Me.Zip.ReadOnly = True
        '
        'LicenseNo
        '
        Me.LicenseNo.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.LicenseNo.FillWeight = 83.0!
        Me.LicenseNo.HeaderText = "License#"
        Me.LicenseNo.MinimumWidth = 11
        Me.LicenseNo.Name = "LicenseNo"
        Me.LicenseNo.ReadOnly = True
        '
        'DateEntered
        '
        Me.DateEntered.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.DateEntered.FillWeight = 90.0!
        Me.DateEntered.HeaderText = "Date Entered"
        Me.DateEntered.MinimumWidth = 11
        Me.DateEntered.Name = "DateEntered"
        Me.DateEntered.ReadOnly = True
        '
        'Registry
        '
        Me.Registry.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.Registry.FillWeight = 67.0!
        Me.Registry.HeaderText = "Registry"
        Me.Registry.MinimumWidth = 11
        Me.Registry.Name = "Registry"
        Me.Registry.ReadOnly = True
        '
        'Status
        '
        Me.Status.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill
        Me.Status.FillWeight = 125.0!
        Me.Status.HeaderText = "Status"
        Me.Status.MinimumWidth = 11
        Me.Status.Name = "Status"
        Me.Status.ReadOnly = True
        '
        'instancesFoundLabel
        '
        Me.instancesFoundLabel.AutoSize = True
        Me.instancesFoundLabel.Location = New System.Drawing.Point(12, 9)
        Me.instancesFoundLabel.Name = "instancesFoundLabel"
        Me.instancesFoundLabel.Size = New System.Drawing.Size(87, 14)
        Me.instancesFoundLabel.TabIndex = 26
        Me.instancesFoundLabel.Text = "Instances Found"
        '
        'FrmReferralDonorList
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(1145, 438)
        Me.Controls.Add(Me.instancesFoundLabel)
        Me.Controls.Add(Me.donorsDataGridView)
        Me.Controls.Add(Me.cmdSelect)
        Me.Controls.Add(Me.cmdCancel)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(175, 252)
        Me.Name = "FrmReferralDonorList"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        CType(Me.donorsDataGridView, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Private WithEvents cmdSelect As Button
    Private WithEvents cmdCancel As Button
    Private WithEvents donorsDataGridView As DataGridView
    Private WithEvents FirstName As DataGridViewTextBoxColumn
    Private WithEvents MiddleName As DataGridViewTextBoxColumn
    Private WithEvents Address As DataGridViewTextBoxColumn
    Private WithEvents City As DataGridViewTextBoxColumn
    Private WithEvents State As DataGridViewTextBoxColumn
    Private WithEvents Zip As DataGridViewTextBoxColumn
    Private WithEvents LicenseNo As DataGridViewTextBoxColumn
    Private WithEvents DateEntered As DataGridViewTextBoxColumn
    Private WithEvents Registry As DataGridViewTextBoxColumn
    Private WithEvents Status As DataGridViewTextBoxColumn
    Private WithEvents instancesFoundLabel As Label
#End Region
End Class