<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FrmReferralView
#Region "Windows Form Designer generated code "
    <System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        ''bret 1/4/2010 dll conversion Me.MdiParent = AppMain.ParentForm
        ''bret 1/4/2010 dll conversion MdiParent.Show()
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
    Public WithEvents Cmdactivate As System.Windows.Forms.Button
    Public WithEvents cmdVerify As System.Windows.Forms.Button
    Public WithEvents tvTreeView As System.Windows.Forms.TreeView
    Public WithEvents Check25 As System.Windows.Forms.CheckBox
    Public WithEvents Check24 As System.Windows.Forms.CheckBox
    Public WithEvents Check23 As System.Windows.Forms.CheckBox
    Public WithEvents Check22 As System.Windows.Forms.CheckBox
    Public WithEvents Check21 As System.Windows.Forms.CheckBox
    Public WithEvents Picture4 As System.Windows.Forms.PictureBox
    Public WithEvents Label20 As System.Windows.Forms.Label
    Public WithEvents cmdCallSheet As System.Windows.Forms.Button
    Public WithEvents _fmDataFrame_13 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_166 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_167 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_72 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_84 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_12 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_16 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_15 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_14 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_17 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_82 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_83 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_224 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_225 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_237 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_241 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_28 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_29 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_27 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_26 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_30 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_248 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_249 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_6 As System.Windows.Forms.GroupBox
    Public WithEvents cmdCreateMedication As System.Windows.Forms.Button
    Public WithEvents txtMedicationName As System.Windows.Forms.TextBox
    Public WithEvents lblCreateMedication As System.Windows.Forms.Label
    Public WithEvents fmCreateMedication As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_15 As System.Windows.Forms.ComboBox
    Public WithEvents lstSelectedMeds As System.Windows.Forms.ListBox
    Public WithEvents lstAvailableMeds As System.Windows.Forms.ListBox
    Public WithEvents cmdAddMedication As System.Windows.Forms.Button
    Public WithEvents cmdRemoveMedication As System.Windows.Forms.Button
    Public WithEvents _DataRTFArray_6 As System.Windows.Forms.RichTextBox
    Public WithEvents lblSecondaryAdditionalMedications As System.Windows.Forms.Label
    Public WithEvents Label17 As System.Windows.Forms.Label
    Public WithEvents Label18 As System.Windows.Forms.Label
    Public WithEvents _DataFrameArray_0 As System.Windows.Forms.GroupBox
    Public WithEvents _DataLabelArray_42 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_23 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_85 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_74 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_242 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_238 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_30 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_8 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_9 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_71 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_70 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_19 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_20 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_94 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_82 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_16 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_20 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_36 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_35 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_105 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_104 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_103 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_101 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_100 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_99 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_142 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_141 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_140 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_139 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_138 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_137 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_136 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_135 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_134 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_15 As System.Windows.Forms.GroupBox
    Public WithEvents chkSecondaryTBINotNeeded As System.Windows.Forms.CheckBox
    Public WithEvents txtSecondaryTBIComment As System.Windows.Forms.TextBox
    Public WithEvents cmdGenerateTBI As System.Windows.Forms.Button
    Public WithEvents _DataTextArray_36 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_174 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_169 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_172 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_171 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_170 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_173 As System.Windows.Forms.TextBox
    Public WithEvents lblTBIComment As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_64 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_233 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_232 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_231 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_230 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_229 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_228 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_11 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_28 As System.Windows.Forms.TextBox
    Public WithEvents _DataCheckboxArray_0 As System.Windows.Forms.CheckBox
    Public WithEvents rtfOrgSpecialNotes As System.Windows.Forms.RichTextBox
    Public WithEvents lblOrgSpecialNotes As System.Windows.Forms.Label
    Public WithEvents fmOrgSpecialNotes As System.Windows.Forms.GroupBox
    Public WithEvents Command1 As System.Windows.Forms.Button
    Public WithEvents rtfClientEyeCareReminder As System.Windows.Forms.RichTextBox
    Public WithEvents _fmEyeCareInstructions_1 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_27 As System.Windows.Forms.TextBox
    Public WithEvents cmdCreateCOP As System.Windows.Forms.Button
    Public WithEvents _DataTextArray_10 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_9 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_8 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_164 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_58 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_165 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_168 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_73 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_51 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_50 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_49 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_227 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_226 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_223 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_222 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_10 As System.Windows.Forms.GroupBox
    Public WithEvents cmdFuneralHome As System.Windows.Forms.Button
    Public WithEvents _DataComboArray_83 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_68 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_163 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_57 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_56 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_55 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_160 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_159 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_158 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_157 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_54 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_240 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_236 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_221 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_220 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_219 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_218 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_217 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_216 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_215 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_208 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_207 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_9 As System.Windows.Forms.GroupBox
    Public WithEvents cmdCoroner As System.Windows.Forms.Button
    Public WithEvents _DataComboArray_44 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_4 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_156 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_49 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_155 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_151 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_48 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_150 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_46 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_169 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_206 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_205 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_204 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_202 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_200 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_198 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_197 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_196 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_8 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_7 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_35 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_34 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_33 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_32 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_31 As System.Windows.Forms.TextBox
    Public WithEvents cmdNOK As System.Windows.Forms.Button
    Public WithEvents _DataComboArray_86 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_45 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_146 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_145 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_144 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_43 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_143 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_62 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_61 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_57 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_54 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_53 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_247 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_193 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_191 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_186 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_185 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_184 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_183 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_7 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_71 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_10 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_82 As System.Windows.Forms.ComboBox
    Public WithEvents _DataRTFArray_0 As System.Windows.Forms.RichTextBox
    Public WithEvents _DataRTFArray_1 As System.Windows.Forms.RichTextBox
    Public WithEvents _DataRTFArray_2 As System.Windows.Forms.RichTextBox
    Public WithEvents _DataRTFArray_3 As System.Windows.Forms.RichTextBox
    Public WithEvents _DataRTFArray_4 As System.Windows.Forms.RichTextBox
    Public WithEvents _DataRTFArray_5 As System.Windows.Forms.RichTextBox
    Public WithEvents _DataLabelArray_47 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_46 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_21 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_234 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_75 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_16 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_17 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_18 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_15 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_5 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_78 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_76 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_75 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_1 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_2 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_3 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_0 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_0 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_3 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_1 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_2 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_245 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_244 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_243 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_5 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_6 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_7 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_4 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_3 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_1 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_2 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_0 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_4 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_110 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_117 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_116 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_115 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_114 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_113 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_112 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_111 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_118 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_156 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_155 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_154 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_153 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_152 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_151 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_150 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_149 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_144 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_1 As System.Windows.Forms.GroupBox
    Public WithEvents cmdContactDetail As System.Windows.Forms.Button
    Public WithEvents cmdHospital As System.Windows.Forms.Button
    Public WithEvents _DataTextArray_7 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_251 As System.Windows.Forms.TextBox
    Public WithEvents cmdOrganizationDetail As System.Windows.Forms.Button
    Public WithEvents _DataTextArray_30 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_6 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_6 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_5 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_4 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_250 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_44 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_14 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_13 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_12 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_11 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_9 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_8 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_250 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_0 As System.Windows.Forms.GroupBox
    Public WithEvents _tbReferralData_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents _DataComboArray_72 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_38 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_39 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_42 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_41 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_18 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_40 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_80 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_20 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_12 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_11 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_48 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_55 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_56 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_60 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_58 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_59 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_33 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_23 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_22 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_12 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_75 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_74 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_73 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_64 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_63 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_62 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_26 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_25 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_24 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_81 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_77 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_73 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_23 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_107 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_106 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_105 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_104 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_103 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_102 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_101 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_100 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_99 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_98 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_97 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_96 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_95 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_17 As System.Windows.Forms.GroupBox
    Public WithEvents cmdeventrecievedFound As System.Windows.Forms.Button
    Public WithEvents cmdEventRecieved As System.Windows.Forms.Button
    Public WithEvents cboRegistryStatusFS As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_60 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_5 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_53 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_51 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_50 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_52 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_88 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_26 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_25 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_24 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_22 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_21 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_13 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_14 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_23 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_63 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_45 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_10 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_74 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_72 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_71 As System.Windows.Forms.Label
    Public WithEvents Label2 As System.Windows.Forms.Label
    Public WithEvents lblWeight As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Public WithEvents Label6 As System.Windows.Forms.Label
    Public WithEvents Label3 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_41 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_38 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_37 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_35 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_34 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_39 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_40 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_36 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_20 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_109 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_108 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_107 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_106 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_37 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_148 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_147 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_146 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_145 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_143 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_26 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_127 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_126 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_125 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_124 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_123 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_122 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_121 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_120 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_119 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_165 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_164 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_163 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_162 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_161 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_160 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_159 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_158 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_157 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_3 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_153 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_154 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_203 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_201 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_27 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_39 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_66 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_53 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_51 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_162 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_50 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_161 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_52 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_239 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_235 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_214 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_213 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_212 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_211 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_210 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_209 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_29 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_22 As System.Windows.Forms.ComboBox
    Public _DataItemListArray_1 As ctlItemList
    Public WithEvents _DataLabelArray_91 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_24 As System.Windows.Forms.GroupBox
    Public WithEvents _tbReferralData_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents _DataComboArray_59 As System.Windows.Forms.ComboBox
    Public _DataItemListArray_0 As ctlItemList
    Public WithEvents _DataLabelArray_43 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_22 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_47 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_149 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_199 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_195 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_28 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_64 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_41 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_40 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_138 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_137 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_136 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_128 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_38 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_134 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_133 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_178 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_177 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_176 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_175 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_170 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_168 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_167 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_166 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_172 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_171 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_2 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_78 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_77 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_76 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_67 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_66 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_65 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_27 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_88 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_85 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_79 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_29 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_28 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_30 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_120 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_119 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_118 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_117 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_116 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_115 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_114 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_113 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_112 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_111 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_110 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_109 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_108 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_18 As System.Windows.Forms.GroupBox
    Public WithEvents _DataTextArray_29 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_61 As System.Windows.Forms.ComboBox
    Public WithEvents cmdPhysicianDetail As System.Windows.Forms.Button
    Public WithEvents _DataTextArray_60 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_61 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_69 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_13 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_18 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_19 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_11 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_54 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_55 As System.Windows.Forms.TextBox
    Public WithEvents _DataLabelArray_52 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_83 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_84 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_92 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_93 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_24 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_25 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_31 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_32 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_76 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_77 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_21 As System.Windows.Forms.GroupBox
    Public WithEvents _tbReferralData_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents _DataTextArray_140 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_139 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_132 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_130 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_142 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_141 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_42 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_182 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_181 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_180 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_179 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_190 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_189 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_188 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_14 As System.Windows.Forms.GroupBox
    Public WithEvents _DataComboArray_81 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_80 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_79 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_70 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_69 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_68 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_34 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_33 As System.Windows.Forms.ComboBox
    Public WithEvents _DataComboArray_32 As System.Windows.Forms.ComboBox
    Public WithEvents _DataTextArray_97 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_94 As System.Windows.Forms.TextBox
    Public WithEvents _DataTextArray_91 As System.Windows.Forms.TextBox
    Public WithEvents _DataComboArray_31 As System.Windows.Forms.ComboBox
    Public WithEvents _DataLabelArray_133 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_132 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_131 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_130 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_129 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_128 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_127 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_126 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_125 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_124 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_123 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_122 As System.Windows.Forms.Label
    Public WithEvents _DataLabelArray_121 As System.Windows.Forms.Label
    Public WithEvents _fmDataFrame_19 As System.Windows.Forms.GroupBox
    Public WithEvents _tbReferralData_TabPage3 As System.Windows.Forms.TabPage
    Public WithEvents _tbReferralData_TabPage4 As System.Windows.Forms.TabPage
    Public WithEvents _tbReferralData_TabPage5 As System.Windows.Forms.TabPage
    Public WithEvents _tbReferralData_TabPage6 As System.Windows.Forms.TabPage
    Public WithEvents _tbReferralData_TabPage7 As System.Windows.Forms.TabPage
    Public WithEvents tbReferralData As System.Windows.Forms.TabControl
    Public WithEvents Picture2 As System.Windows.Forms.Panel
    Public WithEvents SubForm1 As System.Windows.Forms.GroupBox
    Public WithEvents _TabDonor_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents CmdDelete As System.Windows.Forms.Button
    Public WithEvents chkViewLogEventDeleted As System.Windows.Forms.CheckBox
    Public WithEvents CmdColorKey As System.Windows.Forms.Button
    Public WithEvents CboCallByEmployee As System.Windows.Forms.ComboBox
    Public WithEvents TxtTotalTimeCounter As System.Windows.Forms.TextBox
    Public WithEvents TxtCallDate As System.Windows.Forms.TextBox
    Public WithEvents _LblReferral_28 As System.Windows.Forms.Label
    Public WithEvents _LblReferral_27 As System.Windows.Forms.Label
    Public WithEvents _LblReferral_20 As System.Windows.Forms.Label
    Public WithEvents _Frame_1 As System.Windows.Forms.GroupBox
    Public WithEvents CmdReferral As System.Windows.Forms.Button
    Public WithEvents CmdNewEvent As System.Windows.Forms.Button
    Public WithEvents LstViewLogEvent As System.Windows.Forms.ListView
    Public WithEvents LstViewPending As System.Windows.Forms.ListView
    Public WithEvents _Lable_19 As System.Windows.Forms.Label
    Public WithEvents _TabDonor_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents chkCaseOpen As System.Windows.Forms.CheckBox
    Public WithEvents chkSystemEvents As System.Windows.Forms.CheckBox
    Public WithEvents chkSecondaryComplete As System.Windows.Forms.CheckBox
    Public WithEvents chkApproached As System.Windows.Forms.CheckBox
    Public WithEvents chkFinal As System.Windows.Forms.CheckBox
    Public WithEvents cmdDonorTrac As System.Windows.Forms.Button
    Public WithEvents lblCaseOpenPersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblSystemEventsPersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblSecondaryCompletePersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblApproachedPersonDateTime As System.Windows.Forms.Label
    Public WithEvents lblFinalPersonDateTime As System.Windows.Forms.Label
    Public WithEvents fmSecondaryStatus As System.Windows.Forms.GroupBox
    Public WithEvents chkSecondaryOTE As System.Windows.Forms.CheckBox
    Public WithEvents cboSecondaryCryolifeFormCompleted As System.Windows.Forms.ComboBox
    Public WithEvents cboSecondaryMedSoc As System.Windows.Forms.ComboBox
    Public WithEvents cboSecondaryFamilyApproach As System.Windows.Forms.ComboBox
    Public WithEvents chkSecondaryCryolifeFormCompleted As System.Windows.Forms.CheckBox
    Public WithEvents chkSecondaryFamilyUnavailable As System.Windows.Forms.CheckBox
    Public WithEvents chkSecondaryMedSoc As System.Windows.Forms.CheckBox
    Public WithEvents chkSecondaryFamilyApproach As System.Windows.Forms.CheckBox
    Public WithEvents chkSecondaryBillable As System.Windows.Forms.CheckBox
    Public WithEvents lblSecondaryOTE As System.Windows.Forms.Label
    Public WithEvents lblSecondaryCryolifeFormCompleted As System.Windows.Forms.Label
    Public WithEvents lblSecondaryFamilyUnavailable As System.Windows.Forms.Label
    Public WithEvents lblSecondaryMedSoc As System.Windows.Forms.Label
    Public WithEvents lblSecondaryFamilyApproach As System.Windows.Forms.Label
    Public WithEvents lblSecondaryBillable As System.Windows.Forms.Label
    Public WithEvents _Frame_0 As System.Windows.Forms.GroupBox
    Public WithEvents _TabDonor_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents cmdInformedApproachPersonDetail As System.Windows.Forms.Button
    Public WithEvents cboApproachReason As System.Windows.Forms.ComboBox
    Public WithEvents cboApproachOutcome As System.Windows.Forms.ComboBox
    Public WithEvents cboApproachType As System.Windows.Forms.ComboBox
    Public WithEvents cboApproachedBy As System.Windows.Forms.ComboBox
    Public WithEvents cboApproached As System.Windows.Forms.ComboBox
    Public WithEvents Label11 As System.Windows.Forms.Label
    Public WithEvents Label10 As System.Windows.Forms.Label
    Public WithEvents Label9 As System.Windows.Forms.Label
    Public WithEvents Label8 As System.Windows.Forms.Label
    Public WithEvents Label7 As System.Windows.Forms.Label
    Public WithEvents fmeApproach As System.Windows.Forms.GroupBox
    Public WithEvents cboHospitalApproachOutcome As System.Windows.Forms.ComboBox
    Public WithEvents cmdHospitalApproachPersonDetail As System.Windows.Forms.Button
    Public WithEvents cboHospitalApproachedBy As System.Windows.Forms.ComboBox
    Public WithEvents cboHospitalApproachType As System.Windows.Forms.ComboBox
    Public WithEvents Label21 As System.Windows.Forms.Label
    Public WithEvents Label19 As System.Windows.Forms.Label
    Public WithEvents Label1 As System.Windows.Forms.Label
    Public WithEvents Frame1 As System.Windows.Forms.GroupBox
    Public WithEvents _SSTab1_TabPage0 As System.Windows.Forms.TabPage
    Public WithEvents cmdConsentMedSocPersonDetail As System.Windows.Forms.Button
    Public WithEvents cboConsentMedSocObtainedBy As System.Windows.Forms.ComboBox
    Public WithEvents cboConsentMedSocPaperwork As System.Windows.Forms.ComboBox
    Public WithEvents cmdConsentPaperworkPersonDetail As System.Windows.Forms.Button
    Public WithEvents cboConsent As System.Windows.Forms.ComboBox
    Public WithEvents cboConsentBy As System.Windows.Forms.ComboBox
    Public WithEvents Label23 As System.Windows.Forms.Label
    Public WithEvents Label22 As System.Windows.Forms.Label
    Public WithEvents Label12 As System.Windows.Forms.Label
    Public WithEvents Label13 As System.Windows.Forms.Label
    Public WithEvents fmeConsent As System.Windows.Forms.GroupBox
    Public WithEvents cboConsentLongSleeves As System.Windows.Forms.ComboBox
    Public WithEvents cboConsentFuneralPlan As System.Windows.Forms.ComboBox
    Public WithEvents cboConsentResearch As System.Windows.Forms.ComboBox
    Public WithEvents Label25 As System.Windows.Forms.Label
    Public WithEvents Label24 As System.Windows.Forms.Label
    Public WithEvents Label15 As System.Windows.Forms.Label
    Public WithEvents Frame2 As System.Windows.Forms.GroupBox
    Public WithEvents _SSTab1_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents SSTab1 As System.Windows.Forms.TabControl
    Public WithEvents _TabDonor_TabPage3 As System.Windows.Forms.TabPage
    Public WithEvents TabDonor As System.Windows.Forms.TabControl
    Public WithEvents CmdCancel As System.Windows.Forms.Button
    Public WithEvents btnSaveAndClose As System.Windows.Forms.Button
    Public WithEvents ChkTemp As System.Windows.Forms.CheckBox
    Public WithEvents ChkExclusive As System.Windows.Forms.CheckBox
    Public WithEvents txtHospitalName As System.Windows.Forms.TextBox
    Public WithEvents _Lable_8 As System.Windows.Forms.Label
    Public WithEvents Picture1 As System.Windows.Forms.Panel
    Public WithEvents ImageList1 As System.Windows.Forms.ImageList
    Public WithEvents TimerTotalTime As System.Windows.Forms.Timer
    Public WithEvents VP_Timer As System.Windows.Forms.Timer
    Public WithEvents DataCheckboxArray As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
    Public WithEvents DataComboArray As Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray
    Public WithEvents DataFrameArray As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents DataLabelArray As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents DataRTFArray As Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray
    Public WithEvents DataTextArray As Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray
    Public WithEvents Frame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents Lable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents LblReferral As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
    Public WithEvents fmDataFrame As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    Public WithEvents fmEyeCareInstructions As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim TreeNode2 As System.Windows.Forms.TreeNode = New System.Windows.Forms.TreeNode("Sample")
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmReferralView))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.chkCaseOpen = New System.Windows.Forms.CheckBox()
        Me.chkSystemEvents = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryComplete = New System.Windows.Forms.CheckBox()
        Me.chkApproached = New System.Windows.Forms.CheckBox()
        Me.chkFinal = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryOTE = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryCryolifeFormCompleted = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryFamilyUnavailable = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryMedSoc = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryFamilyApproach = New System.Windows.Forms.CheckBox()
        Me.chkSecondaryBillable = New System.Windows.Forms.CheckBox()
        Me.Cmdactivate = New System.Windows.Forms.Button()
        Me.cmdVerify = New System.Windows.Forms.Button()
        Me.TabDonor = New System.Windows.Forms.TabControl()
        Me._TabDonor_TabPage0 = New System.Windows.Forms.TabPage()
        Me.tvTreeView = New System.Windows.Forms.TreeView()
        Me.ImageList1 = New System.Windows.Forms.ImageList(Me.components)
        Me.SubForm1 = New System.Windows.Forms.GroupBox()
        Me.Picture2 = New System.Windows.Forms.Panel()
        Me.tbReferralData = New System.Windows.Forms.TabControl()
        Me._tbReferralData_TabPage0 = New System.Windows.Forms.TabPage()
        Me._fmDataFrame_8 = New System.Windows.Forms.GroupBox()
        Me.cmdCoroner = New System.Windows.Forms.Button()
        Me._DataComboArray_44 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_4 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_156 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_49 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_155 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_151 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_48 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_150 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_46 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_169 = New System.Windows.Forms.Label()
        Me._DataLabelArray_206 = New System.Windows.Forms.Label()
        Me._DataLabelArray_205 = New System.Windows.Forms.Label()
        Me._DataLabelArray_204 = New System.Windows.Forms.Label()
        Me._DataLabelArray_202 = New System.Windows.Forms.Label()
        Me._DataLabelArray_200 = New System.Windows.Forms.Label()
        Me._DataLabelArray_198 = New System.Windows.Forms.Label()
        Me._DataLabelArray_197 = New System.Windows.Forms.Label()
        Me._DataLabelArray_196 = New System.Windows.Forms.Label()
        Me._fmDataFrame_4 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_78 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_76 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_75 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_1 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_2 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_3 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_0 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_0 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_3 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_1 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_2 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_245 = New System.Windows.Forms.Label()
        Me._DataLabelArray_244 = New System.Windows.Forms.Label()
        Me._DataLabelArray_243 = New System.Windows.Forms.Label()
        Me._DataLabelArray_5 = New System.Windows.Forms.Label()
        Me._DataLabelArray_6 = New System.Windows.Forms.Label()
        Me._DataLabelArray_7 = New System.Windows.Forms.Label()
        Me._DataLabelArray_4 = New System.Windows.Forms.Label()
        Me._DataLabelArray_3 = New System.Windows.Forms.Label()
        Me._DataLabelArray_1 = New System.Windows.Forms.Label()
        Me._DataLabelArray_2 = New System.Windows.Forms.Label()
        Me._DataLabelArray_0 = New System.Windows.Forms.Label()
        Me._fmDataFrame_5 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_71 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_10 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_82 = New System.Windows.Forms.ComboBox()
        Me._DataRTFArray_0 = New System.Windows.Forms.RichTextBox()
        Me._DataRTFArray_1 = New System.Windows.Forms.RichTextBox()
        Me._DataRTFArray_2 = New System.Windows.Forms.RichTextBox()
        Me._DataRTFArray_3 = New System.Windows.Forms.RichTextBox()
        Me._DataRTFArray_4 = New System.Windows.Forms.RichTextBox()
        Me._DataRTFArray_5 = New System.Windows.Forms.RichTextBox()
        Me._DataLabelArray_47 = New System.Windows.Forms.Label()
        Me._DataLabelArray_46 = New System.Windows.Forms.Label()
        Me._DataLabelArray_21 = New System.Windows.Forms.Label()
        Me._DataLabelArray_234 = New System.Windows.Forms.Label()
        Me._DataLabelArray_75 = New System.Windows.Forms.Label()
        Me._DataLabelArray_16 = New System.Windows.Forms.Label()
        Me._DataLabelArray_17 = New System.Windows.Forms.Label()
        Me._DataLabelArray_18 = New System.Windows.Forms.Label()
        Me._DataLabelArray_15 = New System.Windows.Forms.Label()
        Me._fmDataFrame_7 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_7 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_35 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_34 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_33 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_32 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_31 = New System.Windows.Forms.TextBox()
        Me.cmdNOK = New System.Windows.Forms.Button()
        Me._DataComboArray_86 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_45 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_146 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_145 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_144 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_43 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_143 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_62 = New System.Windows.Forms.Label()
        Me._DataLabelArray_61 = New System.Windows.Forms.Label()
        Me._DataLabelArray_57 = New System.Windows.Forms.Label()
        Me._DataLabelArray_54 = New System.Windows.Forms.Label()
        Me._DataLabelArray_53 = New System.Windows.Forms.Label()
        Me._DataLabelArray_247 = New System.Windows.Forms.Label()
        Me._DataLabelArray_193 = New System.Windows.Forms.Label()
        Me._DataLabelArray_191 = New System.Windows.Forms.Label()
        Me._DataLabelArray_186 = New System.Windows.Forms.Label()
        Me._DataLabelArray_185 = New System.Windows.Forms.Label()
        Me._DataLabelArray_184 = New System.Windows.Forms.Label()
        Me._DataLabelArray_183 = New System.Windows.Forms.Label()
        Me._fmDataFrame_11 = New System.Windows.Forms.GroupBox()
        Me.chkSecondaryTBINotNeeded = New System.Windows.Forms.CheckBox()
        Me.txtSecondaryTBIComment = New System.Windows.Forms.TextBox()
        Me.cmdGenerateTBI = New System.Windows.Forms.Button()
        Me._DataTextArray_36 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_174 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_169 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_172 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_171 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_170 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_173 = New System.Windows.Forms.TextBox()
        Me.lblTBIComment = New System.Windows.Forms.Label()
        Me._DataLabelArray_64 = New System.Windows.Forms.Label()
        Me._DataLabelArray_233 = New System.Windows.Forms.Label()
        Me._DataLabelArray_232 = New System.Windows.Forms.Label()
        Me._DataLabelArray_231 = New System.Windows.Forms.Label()
        Me._DataLabelArray_230 = New System.Windows.Forms.Label()
        Me._DataLabelArray_229 = New System.Windows.Forms.Label()
        Me._DataLabelArray_228 = New System.Windows.Forms.Label()
        Me._fmDataFrame_16 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_8 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_9 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_71 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_70 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_19 = New System.Windows.Forms.Label()
        Me._DataLabelArray_20 = New System.Windows.Forms.Label()
        Me._DataLabelArray_94 = New System.Windows.Forms.Label()
        Me._DataLabelArray_82 = New System.Windows.Forms.Label()
        Me._fmDataFrame_30 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_85 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_74 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_242 = New System.Windows.Forms.Label()
        Me._DataLabelArray_238 = New System.Windows.Forms.Label()
        Me._fmDataFrame_15 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_20 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_36 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_35 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_105 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_104 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_103 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_101 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_100 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_99 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_142 = New System.Windows.Forms.Label()
        Me._DataLabelArray_141 = New System.Windows.Forms.Label()
        Me._DataLabelArray_140 = New System.Windows.Forms.Label()
        Me._DataLabelArray_139 = New System.Windows.Forms.Label()
        Me._DataLabelArray_138 = New System.Windows.Forms.Label()
        Me._DataLabelArray_137 = New System.Windows.Forms.Label()
        Me._DataLabelArray_136 = New System.Windows.Forms.Label()
        Me._DataLabelArray_135 = New System.Windows.Forms.Label()
        Me._DataLabelArray_134 = New System.Windows.Forms.Label()
        Me._fmDataFrame_13 = New System.Windows.Forms.GroupBox()
        Me.cmdCallSheet = New System.Windows.Forms.Button()
        Me._fmDataFrame_6 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_166 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_167 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_72 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_84 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_12 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_16 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_15 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_14 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_17 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_82 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_83 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_224 = New System.Windows.Forms.Label()
        Me._DataLabelArray_225 = New System.Windows.Forms.Label()
        Me._DataLabelArray_237 = New System.Windows.Forms.Label()
        Me._DataLabelArray_241 = New System.Windows.Forms.Label()
        Me._DataLabelArray_28 = New System.Windows.Forms.Label()
        Me._DataLabelArray_29 = New System.Windows.Forms.Label()
        Me._DataLabelArray_27 = New System.Windows.Forms.Label()
        Me._DataLabelArray_26 = New System.Windows.Forms.Label()
        Me._DataLabelArray_30 = New System.Windows.Forms.Label()
        Me._DataLabelArray_248 = New System.Windows.Forms.Label()
        Me._DataLabelArray_249 = New System.Windows.Forms.Label()
        Me._fmDataFrame_23 = New System.Windows.Forms.GroupBox()
        Me.fmCreateMedication = New System.Windows.Forms.GroupBox()
        Me.cmdCreateMedication = New System.Windows.Forms.Button()
        Me.txtMedicationName = New System.Windows.Forms.TextBox()
        Me.lblCreateMedication = New System.Windows.Forms.Label()
        Me._DataComboArray_15 = New System.Windows.Forms.ComboBox()
        Me._DataFrameArray_0 = New System.Windows.Forms.GroupBox()
        Me.lstSelectedMeds = New System.Windows.Forms.ListBox()
        Me.lstAvailableMeds = New System.Windows.Forms.ListBox()
        Me.cmdAddMedication = New System.Windows.Forms.Button()
        Me.cmdRemoveMedication = New System.Windows.Forms.Button()
        Me._DataRTFArray_6 = New System.Windows.Forms.RichTextBox()
        Me.lblSecondaryAdditionalMedications = New System.Windows.Forms.Label()
        Me.Label17 = New System.Windows.Forms.Label()
        Me.Label18 = New System.Windows.Forms.Label()
        Me._DataLabelArray_42 = New System.Windows.Forms.Label()
        Me._fmDataFrame_1 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_110 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_117 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_116 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_115 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_114 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_113 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_112 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_111 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_118 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_156 = New System.Windows.Forms.Label()
        Me._DataLabelArray_155 = New System.Windows.Forms.Label()
        Me._DataLabelArray_154 = New System.Windows.Forms.Label()
        Me._DataLabelArray_153 = New System.Windows.Forms.Label()
        Me._DataLabelArray_152 = New System.Windows.Forms.Label()
        Me._DataLabelArray_151 = New System.Windows.Forms.Label()
        Me._DataLabelArray_150 = New System.Windows.Forms.Label()
        Me._DataLabelArray_149 = New System.Windows.Forms.Label()
        Me._DataLabelArray_144 = New System.Windows.Forms.Label()
        Me._fmDataFrame_0 = New System.Windows.Forms.GroupBox()
        Me.cmdContactDetail = New System.Windows.Forms.Button()
        Me.cmdHospital = New System.Windows.Forms.Button()
        Me._DataTextArray_7 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_251 = New System.Windows.Forms.TextBox()
        Me.cmdOrganizationDetail = New System.Windows.Forms.Button()
        Me._DataTextArray_30 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_6 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_6 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_5 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_4 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_250 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_44 = New System.Windows.Forms.Label()
        Me._DataLabelArray_14 = New System.Windows.Forms.Label()
        Me._DataLabelArray_13 = New System.Windows.Forms.Label()
        Me._DataLabelArray_12 = New System.Windows.Forms.Label()
        Me._DataLabelArray_11 = New System.Windows.Forms.Label()
        Me._DataLabelArray_9 = New System.Windows.Forms.Label()
        Me._DataLabelArray_250 = New System.Windows.Forms.Label()
        Me._DataLabelArray_8 = New System.Windows.Forms.Label()
        Me._fmDataFrame_9 = New System.Windows.Forms.GroupBox()
        Me.cmdFuneralHome = New System.Windows.Forms.Button()
        Me._DataComboArray_83 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_68 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_163 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_57 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_56 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_55 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_160 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_159 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_158 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_157 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_54 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_240 = New System.Windows.Forms.Label()
        Me._DataLabelArray_236 = New System.Windows.Forms.Label()
        Me._DataLabelArray_221 = New System.Windows.Forms.Label()
        Me._DataLabelArray_220 = New System.Windows.Forms.Label()
        Me._DataLabelArray_219 = New System.Windows.Forms.Label()
        Me._DataLabelArray_218 = New System.Windows.Forms.Label()
        Me._DataLabelArray_217 = New System.Windows.Forms.Label()
        Me._DataLabelArray_216 = New System.Windows.Forms.Label()
        Me._DataLabelArray_215 = New System.Windows.Forms.Label()
        Me._DataLabelArray_208 = New System.Windows.Forms.Label()
        Me._DataLabelArray_207 = New System.Windows.Forms.Label()
        Me._fmDataFrame_10 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_28 = New System.Windows.Forms.TextBox()
        Me._DataCheckboxArray_0 = New System.Windows.Forms.CheckBox()
        Me.fmOrgSpecialNotes = New System.Windows.Forms.GroupBox()
        Me.rtfOrgSpecialNotes = New System.Windows.Forms.RichTextBox()
        Me.lblOrgSpecialNotes = New System.Windows.Forms.Label()
        Me._fmEyeCareInstructions_1 = New System.Windows.Forms.GroupBox()
        Me.Command1 = New System.Windows.Forms.Button()
        Me.rtfClientEyeCareReminder = New System.Windows.Forms.RichTextBox()
        Me._DataTextArray_27 = New System.Windows.Forms.TextBox()
        Me.cmdCreateCOP = New System.Windows.Forms.Button()
        Me._DataTextArray_10 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_9 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_8 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_164 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_58 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_165 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_168 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_73 = New System.Windows.Forms.Label()
        Me._DataLabelArray_51 = New System.Windows.Forms.Label()
        Me._DataLabelArray_50 = New System.Windows.Forms.Label()
        Me._DataLabelArray_49 = New System.Windows.Forms.Label()
        Me._DataLabelArray_227 = New System.Windows.Forms.Label()
        Me._DataLabelArray_226 = New System.Windows.Forms.Label()
        Me._DataLabelArray_223 = New System.Windows.Forms.Label()
        Me._DataLabelArray_222 = New System.Windows.Forms.Label()
        Me._tbReferralData_TabPage1 = New System.Windows.Forms.TabPage()
        Me._fmDataFrame_20 = New System.Windows.Forms.GroupBox()
        Me.cmdeventrecievedFound = New System.Windows.Forms.Button()
        Me.cmdEventRecieved = New System.Windows.Forms.Button()
        Me.cboRegistryStatusFS = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_60 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_5 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_53 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_51 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_50 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_52 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_88 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_26 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_25 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_24 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_22 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_21 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_13 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_14 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_23 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_63 = New System.Windows.Forms.Label()
        Me._DataLabelArray_45 = New System.Windows.Forms.Label()
        Me._DataLabelArray_10 = New System.Windows.Forms.Label()
        Me._DataLabelArray_74 = New System.Windows.Forms.Label()
        Me._DataLabelArray_72 = New System.Windows.Forms.Label()
        Me._DataLabelArray_71 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.lblWeight = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me._DataLabelArray_41 = New System.Windows.Forms.Label()
        Me._DataLabelArray_38 = New System.Windows.Forms.Label()
        Me._DataLabelArray_37 = New System.Windows.Forms.Label()
        Me._DataLabelArray_35 = New System.Windows.Forms.Label()
        Me._DataLabelArray_34 = New System.Windows.Forms.Label()
        Me._DataLabelArray_39 = New System.Windows.Forms.Label()
        Me._DataLabelArray_40 = New System.Windows.Forms.Label()
        Me._DataLabelArray_36 = New System.Windows.Forms.Label()
        Me._fmDataFrame_24 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_22 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_91 = New System.Windows.Forms.Label()
        Me._DataItemListArray_1 = New ctlItemList()
        Me._fmDataFrame_12 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_72 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_38 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_39 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_42 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_41 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_18 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_40 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_80 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_20 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_12 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_11 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_48 = New System.Windows.Forms.Label()
        Me._DataLabelArray_55 = New System.Windows.Forms.Label()
        Me._DataLabelArray_56 = New System.Windows.Forms.Label()
        Me._DataLabelArray_60 = New System.Windows.Forms.Label()
        Me._DataLabelArray_58 = New System.Windows.Forms.Label()
        Me._DataLabelArray_59 = New System.Windows.Forms.Label()
        Me._DataLabelArray_33 = New System.Windows.Forms.Label()
        Me._DataLabelArray_23 = New System.Windows.Forms.Label()
        Me._DataLabelArray_22 = New System.Windows.Forms.Label()
        Me._fmDataFrame_26 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_109 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_108 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_107 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_106 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_37 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_148 = New System.Windows.Forms.Label()
        Me._DataLabelArray_147 = New System.Windows.Forms.Label()
        Me._DataLabelArray_146 = New System.Windows.Forms.Label()
        Me._DataLabelArray_145 = New System.Windows.Forms.Label()
        Me._DataLabelArray_143 = New System.Windows.Forms.Label()
        Me._fmDataFrame_17 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_75 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_74 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_73 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_64 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_63 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_62 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_26 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_25 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_24 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_81 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_77 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_73 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_23 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_107 = New System.Windows.Forms.Label()
        Me._DataLabelArray_106 = New System.Windows.Forms.Label()
        Me._DataLabelArray_105 = New System.Windows.Forms.Label()
        Me._DataLabelArray_104 = New System.Windows.Forms.Label()
        Me._DataLabelArray_103 = New System.Windows.Forms.Label()
        Me._DataLabelArray_102 = New System.Windows.Forms.Label()
        Me._DataLabelArray_101 = New System.Windows.Forms.Label()
        Me._DataLabelArray_100 = New System.Windows.Forms.Label()
        Me._DataLabelArray_99 = New System.Windows.Forms.Label()
        Me._DataLabelArray_98 = New System.Windows.Forms.Label()
        Me._DataLabelArray_97 = New System.Windows.Forms.Label()
        Me._DataLabelArray_96 = New System.Windows.Forms.Label()
        Me._DataLabelArray_95 = New System.Windows.Forms.Label()
        Me._fmDataFrame_3 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_127 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_126 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_125 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_124 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_123 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_122 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_121 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_120 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_119 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_165 = New System.Windows.Forms.Label()
        Me._DataLabelArray_164 = New System.Windows.Forms.Label()
        Me._DataLabelArray_163 = New System.Windows.Forms.Label()
        Me._DataLabelArray_162 = New System.Windows.Forms.Label()
        Me._DataLabelArray_161 = New System.Windows.Forms.Label()
        Me._DataLabelArray_160 = New System.Windows.Forms.Label()
        Me._DataLabelArray_159 = New System.Windows.Forms.Label()
        Me._DataLabelArray_158 = New System.Windows.Forms.Label()
        Me._DataLabelArray_157 = New System.Windows.Forms.Label()
        Me._fmDataFrame_27 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_153 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_154 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_203 = New System.Windows.Forms.Label()
        Me._DataLabelArray_201 = New System.Windows.Forms.Label()
        Me._fmDataFrame_29 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_39 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_66 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_53 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_51 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_162 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_50 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_161 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_52 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_239 = New System.Windows.Forms.Label()
        Me._DataLabelArray_235 = New System.Windows.Forms.Label()
        Me._DataLabelArray_214 = New System.Windows.Forms.Label()
        Me._DataLabelArray_213 = New System.Windows.Forms.Label()
        Me._DataLabelArray_212 = New System.Windows.Forms.Label()
        Me._DataLabelArray_211 = New System.Windows.Forms.Label()
        Me._DataLabelArray_210 = New System.Windows.Forms.Label()
        Me._DataLabelArray_209 = New System.Windows.Forms.Label()
        Me._tbReferralData_TabPage2 = New System.Windows.Forms.TabPage()
        Me._fmDataFrame_28 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_47 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_149 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_199 = New System.Windows.Forms.Label()
        Me._DataLabelArray_195 = New System.Windows.Forms.Label()
        Me._fmDataFrame_21 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_29 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_61 = New System.Windows.Forms.ComboBox()
        Me.cmdPhysicianDetail = New System.Windows.Forms.Button()
        Me._DataTextArray_60 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_61 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_69 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_13 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_18 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_19 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_11 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_54 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_55 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_52 = New System.Windows.Forms.Label()
        Me._DataLabelArray_83 = New System.Windows.Forms.Label()
        Me._DataLabelArray_84 = New System.Windows.Forms.Label()
        Me._DataLabelArray_92 = New System.Windows.Forms.Label()
        Me._DataLabelArray_93 = New System.Windows.Forms.Label()
        Me._DataLabelArray_24 = New System.Windows.Forms.Label()
        Me._DataLabelArray_25 = New System.Windows.Forms.Label()
        Me._DataLabelArray_31 = New System.Windows.Forms.Label()
        Me._DataLabelArray_32 = New System.Windows.Forms.Label()
        Me._DataLabelArray_76 = New System.Windows.Forms.Label()
        Me._DataLabelArray_77 = New System.Windows.Forms.Label()
        Me._fmDataFrame_18 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_78 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_77 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_76 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_67 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_66 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_65 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_27 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_88 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_85 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_79 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_29 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_28 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_30 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_120 = New System.Windows.Forms.Label()
        Me._DataLabelArray_119 = New System.Windows.Forms.Label()
        Me._DataLabelArray_118 = New System.Windows.Forms.Label()
        Me._DataLabelArray_117 = New System.Windows.Forms.Label()
        Me._DataLabelArray_116 = New System.Windows.Forms.Label()
        Me._DataLabelArray_115 = New System.Windows.Forms.Label()
        Me._DataLabelArray_114 = New System.Windows.Forms.Label()
        Me._DataLabelArray_113 = New System.Windows.Forms.Label()
        Me._DataLabelArray_112 = New System.Windows.Forms.Label()
        Me._DataLabelArray_111 = New System.Windows.Forms.Label()
        Me._DataLabelArray_110 = New System.Windows.Forms.Label()
        Me._DataLabelArray_109 = New System.Windows.Forms.Label()
        Me._DataLabelArray_108 = New System.Windows.Forms.Label()
        Me._fmDataFrame_2 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_64 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_41 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_40 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_138 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_137 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_136 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_128 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_38 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_134 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_133 = New System.Windows.Forms.TextBox()
        Me._DataLabelArray_178 = New System.Windows.Forms.Label()
        Me._DataLabelArray_177 = New System.Windows.Forms.Label()
        Me._DataLabelArray_176 = New System.Windows.Forms.Label()
        Me._DataLabelArray_175 = New System.Windows.Forms.Label()
        Me._DataLabelArray_170 = New System.Windows.Forms.Label()
        Me._DataLabelArray_168 = New System.Windows.Forms.Label()
        Me._DataLabelArray_167 = New System.Windows.Forms.Label()
        Me._DataLabelArray_166 = New System.Windows.Forms.Label()
        Me._DataLabelArray_172 = New System.Windows.Forms.Label()
        Me._DataLabelArray_171 = New System.Windows.Forms.Label()
        Me._fmDataFrame_22 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_59 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_43 = New System.Windows.Forms.Label()
        Me._DataItemListArray_0 = New ctlItemList()
        Me._tbReferralData_TabPage3 = New System.Windows.Forms.TabPage()
        Me._fmDataFrame_14 = New System.Windows.Forms.GroupBox()
        Me._DataTextArray_140 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_139 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_132 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_130 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_142 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_141 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_42 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_182 = New System.Windows.Forms.Label()
        Me._DataLabelArray_181 = New System.Windows.Forms.Label()
        Me._DataLabelArray_180 = New System.Windows.Forms.Label()
        Me._DataLabelArray_179 = New System.Windows.Forms.Label()
        Me._DataLabelArray_190 = New System.Windows.Forms.Label()
        Me._DataLabelArray_189 = New System.Windows.Forms.Label()
        Me._DataLabelArray_188 = New System.Windows.Forms.Label()
        Me._fmDataFrame_19 = New System.Windows.Forms.GroupBox()
        Me._DataComboArray_81 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_80 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_79 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_70 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_69 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_68 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_34 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_33 = New System.Windows.Forms.ComboBox()
        Me._DataComboArray_32 = New System.Windows.Forms.ComboBox()
        Me._DataTextArray_97 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_94 = New System.Windows.Forms.TextBox()
        Me._DataTextArray_91 = New System.Windows.Forms.TextBox()
        Me._DataComboArray_31 = New System.Windows.Forms.ComboBox()
        Me._DataLabelArray_133 = New System.Windows.Forms.Label()
        Me._DataLabelArray_132 = New System.Windows.Forms.Label()
        Me._DataLabelArray_131 = New System.Windows.Forms.Label()
        Me._DataLabelArray_130 = New System.Windows.Forms.Label()
        Me._DataLabelArray_129 = New System.Windows.Forms.Label()
        Me._DataLabelArray_128 = New System.Windows.Forms.Label()
        Me._DataLabelArray_127 = New System.Windows.Forms.Label()
        Me._DataLabelArray_126 = New System.Windows.Forms.Label()
        Me._DataLabelArray_125 = New System.Windows.Forms.Label()
        Me._DataLabelArray_124 = New System.Windows.Forms.Label()
        Me._DataLabelArray_123 = New System.Windows.Forms.Label()
        Me._DataLabelArray_122 = New System.Windows.Forms.Label()
        Me._DataLabelArray_121 = New System.Windows.Forms.Label()
        Me._tbReferralData_TabPage4 = New System.Windows.Forms.TabPage()
        Me._tbReferralData_TabPage5 = New System.Windows.Forms.TabPage()
        Me._tbReferralData_TabPage6 = New System.Windows.Forms.TabPage()
        Me._tbReferralData_TabPage7 = New System.Windows.Forms.TabPage()
        Me._TabDonor_TabPage1 = New System.Windows.Forms.TabPage()
        Me.lblScheduleAlert = New System.Windows.Forms.Label()
        Me.rtbScheduleAlert = New Statline.Stattrac.Windows.Forms.RichTextBox()
        Me.CmdDelete = New System.Windows.Forms.Button()
        Me._Frame_1 = New System.Windows.Forms.GroupBox()
        Me.chkViewLogEventDeleted = New System.Windows.Forms.CheckBox()
        Me.CmdColorKey = New System.Windows.Forms.Button()
        Me.CboCallByEmployee = New System.Windows.Forms.ComboBox()
        Me.TxtTotalTimeCounter = New System.Windows.Forms.TextBox()
        Me.TxtCallDate = New System.Windows.Forms.TextBox()
        Me._LblReferral_28 = New System.Windows.Forms.Label()
        Me._LblReferral_27 = New System.Windows.Forms.Label()
        Me._LblReferral_20 = New System.Windows.Forms.Label()
        Me.CmdReferral = New System.Windows.Forms.Button()
        Me.CmdNewEvent = New System.Windows.Forms.Button()
        Me.LstViewLogEvent = New System.Windows.Forms.ListView()
        Me.LstViewPending = New System.Windows.Forms.ListView()
        Me._Lable_19 = New System.Windows.Forms.Label()
        Me._TabDonor_TabPage2 = New System.Windows.Forms.TabPage()
        Me.fmSecondaryStatus = New System.Windows.Forms.GroupBox()
        Me.cmdDonorTrac = New System.Windows.Forms.Button()
        Me.lblCaseOpenPersonDateTime = New System.Windows.Forms.Label()
        Me.lblSystemEventsPersonDateTime = New System.Windows.Forms.Label()
        Me.lblSecondaryCompletePersonDateTime = New System.Windows.Forms.Label()
        Me.lblApproachedPersonDateTime = New System.Windows.Forms.Label()
        Me.lblFinalPersonDateTime = New System.Windows.Forms.Label()
        Me._Frame_0 = New System.Windows.Forms.GroupBox()
        Me.cboSecondaryCryolifeFormCompleted = New System.Windows.Forms.ComboBox()
        Me.cboSecondaryMedSoc = New System.Windows.Forms.ComboBox()
        Me.cboSecondaryFamilyApproach = New System.Windows.Forms.ComboBox()
        Me.lblSecondaryOTE = New System.Windows.Forms.Label()
        Me.lblSecondaryCryolifeFormCompleted = New System.Windows.Forms.Label()
        Me.lblSecondaryFamilyUnavailable = New System.Windows.Forms.Label()
        Me.lblSecondaryMedSoc = New System.Windows.Forms.Label()
        Me.lblSecondaryFamilyApproach = New System.Windows.Forms.Label()
        Me.lblSecondaryBillable = New System.Windows.Forms.Label()
        Me._TabDonor_TabPage3 = New System.Windows.Forms.TabPage()
        Me.SSTab1 = New System.Windows.Forms.TabControl()
        Me._SSTab1_TabPage0 = New System.Windows.Forms.TabPage()
        Me.fmeApproach = New System.Windows.Forms.GroupBox()
        Me.cmdInformedApproachPersonDetail = New System.Windows.Forms.Button()
        Me.cboApproachReason = New System.Windows.Forms.ComboBox()
        Me.cboApproachOutcome = New System.Windows.Forms.ComboBox()
        Me.cboApproachType = New System.Windows.Forms.ComboBox()
        Me.cboApproachedBy = New System.Windows.Forms.ComboBox()
        Me.cboApproached = New System.Windows.Forms.ComboBox()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Frame1 = New System.Windows.Forms.GroupBox()
        Me.cboHospitalApproachOutcome = New System.Windows.Forms.ComboBox()
        Me.cmdHospitalApproachPersonDetail = New System.Windows.Forms.Button()
        Me.cboHospitalApproachedBy = New System.Windows.Forms.ComboBox()
        Me.cboHospitalApproachType = New System.Windows.Forms.ComboBox()
        Me.Label21 = New System.Windows.Forms.Label()
        Me.Label19 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me._SSTab1_TabPage1 = New System.Windows.Forms.TabPage()
        Me.fmeConsent = New System.Windows.Forms.GroupBox()
        Me.cmdConsentMedSocPersonDetail = New System.Windows.Forms.Button()
        Me.cboConsentMedSocObtainedBy = New System.Windows.Forms.ComboBox()
        Me.cboConsentMedSocPaperwork = New System.Windows.Forms.ComboBox()
        Me.cmdConsentPaperworkPersonDetail = New System.Windows.Forms.Button()
        Me.cboConsent = New System.Windows.Forms.ComboBox()
        Me.cboConsentBy = New System.Windows.Forms.ComboBox()
        Me.Label23 = New System.Windows.Forms.Label()
        Me.Label22 = New System.Windows.Forms.Label()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.Label13 = New System.Windows.Forms.Label()
        Me.Frame2 = New System.Windows.Forms.GroupBox()
        Me.cboConsentLongSleeves = New System.Windows.Forms.ComboBox()
        Me.cboConsentFuneralPlan = New System.Windows.Forms.ComboBox()
        Me.cboConsentResearch = New System.Windows.Forms.ComboBox()
        Me.Label25 = New System.Windows.Forms.Label()
        Me.Label24 = New System.Windows.Forms.Label()
        Me.Label15 = New System.Windows.Forms.Label()
        Me.Check25 = New System.Windows.Forms.CheckBox()
        Me.Check24 = New System.Windows.Forms.CheckBox()
        Me.Check23 = New System.Windows.Forms.CheckBox()
        Me.Check22 = New System.Windows.Forms.CheckBox()
        Me.Check21 = New System.Windows.Forms.CheckBox()
        Me.Picture4 = New System.Windows.Forms.PictureBox()
        Me.Label20 = New System.Windows.Forms.Label()
        Me.CmdCancel = New System.Windows.Forms.Button()
        Me.btnSaveAndClose = New System.Windows.Forms.Button()
        Me.ChkTemp = New System.Windows.Forms.CheckBox()
        Me.ChkExclusive = New System.Windows.Forms.CheckBox()
        Me.Picture1 = New System.Windows.Forms.Panel()
        Me.txtHospitalName = New System.Windows.Forms.TextBox()
        Me._Lable_8 = New System.Windows.Forms.Label()
        Me.TimerTotalTime = New System.Windows.Forms.Timer(Me.components)
        Me.VP_Timer = New System.Windows.Forms.Timer(Me.components)
        Me.DataCheckboxArray = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.DataComboArray = New Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray(Me.components)
        Me.DataFrameArray = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.DataLabelArray = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.DataRTFArray = New Microsoft.VisualBasic.Compatibility.VB6.RichTextBoxArray(Me.components)
        Me.DataTextArray = New Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray(Me.components)
        Me.Frame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.Lable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.LblReferral = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.fmDataFrame = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.fmEyeCareInstructions = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(Me.components)
        Me.ctlSecondaryDisposition1 = New CtlSecondaryDisposition()
        Me.SplitContainer1 = New System.Windows.Forms.SplitContainer()
        Me.btnSave = New System.Windows.Forms.Button()
        Me.TabDonor.SuspendLayout
        Me._TabDonor_TabPage0.SuspendLayout
        Me.SubForm1.SuspendLayout
        Me.Picture2.SuspendLayout
        Me.tbReferralData.SuspendLayout
        Me._tbReferralData_TabPage0.SuspendLayout
        Me._fmDataFrame_8.SuspendLayout
        Me._fmDataFrame_4.SuspendLayout
        Me._fmDataFrame_5.SuspendLayout
        Me._fmDataFrame_7.SuspendLayout
        Me._fmDataFrame_11.SuspendLayout
        Me._fmDataFrame_16.SuspendLayout
        Me._fmDataFrame_30.SuspendLayout
        Me._fmDataFrame_15.SuspendLayout
        Me._fmDataFrame_13.SuspendLayout
        Me._fmDataFrame_6.SuspendLayout
        Me._fmDataFrame_23.SuspendLayout
        Me.fmCreateMedication.SuspendLayout
        Me._DataFrameArray_0.SuspendLayout
        Me._fmDataFrame_1.SuspendLayout
        Me._fmDataFrame_0.SuspendLayout
        Me._fmDataFrame_9.SuspendLayout
        Me._fmDataFrame_10.SuspendLayout
        Me.fmOrgSpecialNotes.SuspendLayout
        Me._fmEyeCareInstructions_1.SuspendLayout
        Me._tbReferralData_TabPage1.SuspendLayout
        Me._fmDataFrame_20.SuspendLayout
        Me._fmDataFrame_24.SuspendLayout
        Me._fmDataFrame_12.SuspendLayout
        Me._fmDataFrame_26.SuspendLayout
        Me._fmDataFrame_17.SuspendLayout
        Me._fmDataFrame_3.SuspendLayout
        Me._fmDataFrame_27.SuspendLayout
        Me._fmDataFrame_29.SuspendLayout
        Me._tbReferralData_TabPage2.SuspendLayout
        Me._fmDataFrame_28.SuspendLayout
        Me._fmDataFrame_21.SuspendLayout
        Me._fmDataFrame_18.SuspendLayout
        Me._fmDataFrame_2.SuspendLayout
        Me._fmDataFrame_22.SuspendLayout
        Me._tbReferralData_TabPage3.SuspendLayout
        Me._fmDataFrame_14.SuspendLayout
        Me._fmDataFrame_19.SuspendLayout
        Me._TabDonor_TabPage1.SuspendLayout
        Me._Frame_1.SuspendLayout
        Me._TabDonor_TabPage2.SuspendLayout
        Me.fmSecondaryStatus.SuspendLayout
        Me._Frame_0.SuspendLayout
        Me._TabDonor_TabPage3.SuspendLayout
        Me.SSTab1.SuspendLayout
        Me._SSTab1_TabPage0.SuspendLayout
        Me.fmeApproach.SuspendLayout
        Me.Frame1.SuspendLayout
        Me._SSTab1_TabPage1.SuspendLayout
        Me.fmeConsent.SuspendLayout
        Me.Frame2.SuspendLayout
        CType(Me.Picture4, System.ComponentModel.ISupportInitialize).BeginInit
        Me.Picture1.SuspendLayout
        CType(Me.DataCheckboxArray, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.DataComboArray, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.DataFrameArray, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.DataLabelArray, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.DataRTFArray, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.DataTextArray, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.LblReferral, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.fmDataFrame, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.fmEyeCareInstructions, System.ComponentModel.ISupportInitialize).BeginInit
        CType(Me.SplitContainer1, System.ComponentModel.ISupportInitialize).BeginInit
        Me.SplitContainer1.Panel1.SuspendLayout
        Me.SplitContainer1.Panel2.SuspendLayout
        Me.SplitContainer1.SuspendLayout
        Me.SuspendLayout
        '
        'chkCaseOpen
        '
        Me.chkCaseOpen.AutoSize = True
        Me.chkCaseOpen.BackColor = System.Drawing.SystemColors.Control
        Me.chkCaseOpen.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkCaseOpen.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkCaseOpen.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkCaseOpen.Location = New System.Drawing.Point(8, 24)
        Me.chkCaseOpen.Name = "chkCaseOpen"
        Me.chkCaseOpen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkCaseOpen.Size = New System.Drawing.Size(80, 18)
        Me.chkCaseOpen.TabIndex = 19
        Me.chkCaseOpen.Tag = "1"
        Me.chkCaseOpen.Text = "Case Open"
        Me.ToolTip1.SetToolTip(Me.chkCaseOpen, "Case Open")
        Me.chkCaseOpen.UseVisualStyleBackColor = False
        '
        'chkSystemEvents
        '
        Me.chkSystemEvents.AutoSize = True
        Me.chkSystemEvents.BackColor = System.Drawing.SystemColors.Control
        Me.chkSystemEvents.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSystemEvents.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSystemEvents.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSystemEvents.Location = New System.Drawing.Point(8, 48)
        Me.chkSystemEvents.Name = "chkSystemEvents"
        Me.chkSystemEvents.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSystemEvents.Size = New System.Drawing.Size(98, 18)
        Me.chkSystemEvents.TabIndex = 20
        Me.chkSystemEvents.Tag = "2"
        Me.chkSystemEvents.Text = "System Events"
        Me.ToolTip1.SetToolTip(Me.chkSystemEvents, "System Events")
        Me.chkSystemEvents.UseVisualStyleBackColor = False
        '
        'chkSecondaryComplete
        '
        Me.chkSecondaryComplete.AutoSize = True
        Me.chkSecondaryComplete.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryComplete.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryComplete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryComplete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryComplete.Location = New System.Drawing.Point(8, 72)
        Me.chkSecondaryComplete.Name = "chkSecondaryComplete"
        Me.chkSecondaryComplete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryComplete.Size = New System.Drawing.Size(126, 18)
        Me.chkSecondaryComplete.TabIndex = 21
        Me.chkSecondaryComplete.Tag = "3"
        Me.chkSecondaryComplete.Text = "Secondary Complete"
        Me.ToolTip1.SetToolTip(Me.chkSecondaryComplete, "Secondary Complete")
        Me.chkSecondaryComplete.UseVisualStyleBackColor = False
        '
        'chkApproached
        '
        Me.chkApproached.AutoSize = True
        Me.chkApproached.BackColor = System.Drawing.SystemColors.Control
        Me.chkApproached.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkApproached.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkApproached.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkApproached.Location = New System.Drawing.Point(8, 96)
        Me.chkApproached.Name = "chkApproached"
        Me.chkApproached.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkApproached.Size = New System.Drawing.Size(86, 18)
        Me.chkApproached.TabIndex = 22
        Me.chkApproached.Tag = "4"
        Me.chkApproached.Text = "Approached"
        Me.ToolTip1.SetToolTip(Me.chkApproached, "Approached")
        Me.chkApproached.UseVisualStyleBackColor = False
        '
        'chkFinal
        '
        Me.chkFinal.AutoSize = True
        Me.chkFinal.BackColor = System.Drawing.SystemColors.Control
        Me.chkFinal.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkFinal.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkFinal.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkFinal.Location = New System.Drawing.Point(8, 120)
        Me.chkFinal.Name = "chkFinal"
        Me.chkFinal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkFinal.Size = New System.Drawing.Size(48, 18)
        Me.chkFinal.TabIndex = 23
        Me.chkFinal.Tag = "5"
        Me.chkFinal.Text = "Final"
        Me.ToolTip1.SetToolTip(Me.chkFinal, "Final")
        Me.chkFinal.UseVisualStyleBackColor = False
        '
        'chkSecondaryOTE
        '
        Me.chkSecondaryOTE.AutoSize = True
        Me.chkSecondaryOTE.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryOTE.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryOTE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryOTE.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryOTE.Location = New System.Drawing.Point(8, 48)
        Me.chkSecondaryOTE.Name = "chkSecondaryOTE"
        Me.chkSecondaryOTE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryOTE.Size = New System.Drawing.Size(46, 18)
        Me.chkSecondaryOTE.TabIndex = 629
        Me.chkSecondaryOTE.Tag = "1"
        Me.chkSecondaryOTE.Text = "OTE"
        Me.ToolTip1.SetToolTip(Me.chkSecondaryOTE, "Secondary Billable")
        Me.chkSecondaryOTE.UseVisualStyleBackColor = False
        '
        'chkSecondaryCryolifeFormCompleted
        '
        Me.chkSecondaryCryolifeFormCompleted.AutoSize = True
        Me.chkSecondaryCryolifeFormCompleted.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryCryolifeFormCompleted.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryCryolifeFormCompleted.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryCryolifeFormCompleted.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryCryolifeFormCompleted.Location = New System.Drawing.Point(8, 144)
        Me.chkSecondaryCryolifeFormCompleted.Name = "chkSecondaryCryolifeFormCompleted"
        Me.chkSecondaryCryolifeFormCompleted.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryCryolifeFormCompleted.Size = New System.Drawing.Size(143, 18)
        Me.chkSecondaryCryolifeFormCompleted.TabIndex = 30
        Me.chkSecondaryCryolifeFormCompleted.Tag = "3"
        Me.chkSecondaryCryolifeFormCompleted.Text = "Cryolife Form Completed"
        Me.ToolTip1.SetToolTip(Me.chkSecondaryCryolifeFormCompleted, "Cryolife Form Completed")
        Me.chkSecondaryCryolifeFormCompleted.UseVisualStyleBackColor = False
        '
        'chkSecondaryFamilyUnavailable
        '
        Me.chkSecondaryFamilyUnavailable.AutoSize = True
        Me.chkSecondaryFamilyUnavailable.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryFamilyUnavailable.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryFamilyUnavailable.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryFamilyUnavailable.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryFamilyUnavailable.Location = New System.Drawing.Point(8, 72)
        Me.chkSecondaryFamilyUnavailable.Name = "chkSecondaryFamilyUnavailable"
        Me.chkSecondaryFamilyUnavailable.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryFamilyUnavailable.Size = New System.Drawing.Size(114, 18)
        Me.chkSecondaryFamilyUnavailable.TabIndex = 25
        Me.chkSecondaryFamilyUnavailable.Tag = "2"
        Me.chkSecondaryFamilyUnavailable.Text = "Family Unavailable"
        Me.ToolTip1.SetToolTip(Me.chkSecondaryFamilyUnavailable, "Family Unavailable")
        Me.chkSecondaryFamilyUnavailable.UseVisualStyleBackColor = False
        '
        'chkSecondaryMedSoc
        '
        Me.chkSecondaryMedSoc.AutoSize = True
        Me.chkSecondaryMedSoc.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryMedSoc.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryMedSoc.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryMedSoc.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryMedSoc.Location = New System.Drawing.Point(8, 120)
        Me.chkSecondaryMedSoc.Name = "chkSecondaryMedSoc"
        Me.chkSecondaryMedSoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryMedSoc.Size = New System.Drawing.Size(68, 18)
        Me.chkSecondaryMedSoc.TabIndex = 28
        Me.chkSecondaryMedSoc.Tag = "3"
        Me.chkSecondaryMedSoc.Text = "Med/Soc"
        Me.ToolTip1.SetToolTip(Me.chkSecondaryMedSoc, "Med/Soc")
        Me.chkSecondaryMedSoc.UseVisualStyleBackColor = False
        '
        'chkSecondaryFamilyApproach
        '
        Me.chkSecondaryFamilyApproach.AutoSize = True
        Me.chkSecondaryFamilyApproach.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryFamilyApproach.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryFamilyApproach.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryFamilyApproach.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryFamilyApproach.Location = New System.Drawing.Point(8, 96)
        Me.chkSecondaryFamilyApproach.Name = "chkSecondaryFamilyApproach"
        Me.chkSecondaryFamilyApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryFamilyApproach.Size = New System.Drawing.Size(106, 18)
        Me.chkSecondaryFamilyApproach.TabIndex = 26
        Me.chkSecondaryFamilyApproach.Tag = "2"
        Me.chkSecondaryFamilyApproach.Text = "Family Approach"
        Me.ToolTip1.SetToolTip(Me.chkSecondaryFamilyApproach, "Family Approach")
        Me.chkSecondaryFamilyApproach.UseVisualStyleBackColor = False
        '
        'chkSecondaryBillable
        '
        Me.chkSecondaryBillable.AutoSize = True
        Me.chkSecondaryBillable.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryBillable.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryBillable.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryBillable.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryBillable.Location = New System.Drawing.Point(8, 24)
        Me.chkSecondaryBillable.Name = "chkSecondaryBillable"
        Me.chkSecondaryBillable.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryBillable.Size = New System.Drawing.Size(115, 18)
        Me.chkSecondaryBillable.TabIndex = 24
        Me.chkSecondaryBillable.Tag = "1"
        Me.chkSecondaryBillable.Text = "Secondary Billable"
        Me.ToolTip1.SetToolTip(Me.chkSecondaryBillable, "Secondary Billable")
        Me.chkSecondaryBillable.UseVisualStyleBackColor = False
        '
        'Cmdactivate
        '
        Me.Cmdactivate.BackColor = System.Drawing.SystemColors.Control
        Me.Cmdactivate.Cursor = System.Windows.Forms.Cursors.Default
        Me.Cmdactivate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Cmdactivate.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Cmdactivate.Location = New System.Drawing.Point(1252, 118)
        Me.Cmdactivate.Name = "Cmdactivate"
        Me.Cmdactivate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Cmdactivate.Size = New System.Drawing.Size(83, 21)
        Me.Cmdactivate.TabIndex = 632
        Me.Cmdactivate.Text = "Activate"
        Me.Cmdactivate.UseVisualStyleBackColor = False
        Me.Cmdactivate.Visible = False
        '
        'cmdVerify
        '
        Me.cmdVerify.BackColor = System.Drawing.SystemColors.Control
        Me.cmdVerify.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdVerify.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdVerify.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdVerify.Location = New System.Drawing.Point(1252, 422)
        Me.cmdVerify.Name = "cmdVerify"
        Me.cmdVerify.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdVerify.Size = New System.Drawing.Size(83, 21)
        Me.cmdVerify.TabIndex = 51
        Me.cmdVerify.Text = "Disposition"
        Me.cmdVerify.UseVisualStyleBackColor = False
        '
        'TabDonor
        '
        Me.TabDonor.Alignment = System.Windows.Forms.TabAlignment.Right
        Me.TabDonor.Controls.Add(Me._TabDonor_TabPage0)
        Me.TabDonor.Controls.Add(Me._TabDonor_TabPage1)
        Me.TabDonor.Controls.Add(Me._TabDonor_TabPage2)
        Me.TabDonor.Controls.Add(Me._TabDonor_TabPage3)
        Me.TabDonor.Font = New System.Drawing.Font("Arial", 11.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TabDonor.ItemSize = New System.Drawing.Size(42, 18)
        Me.TabDonor.Location = New System.Drawing.Point(4, 54)
        Me.TabDonor.Multiline = True
        Me.TabDonor.Name = "TabDonor"
        Me.TabDonor.SelectedIndex = 2
        Me.TabDonor.Size = New System.Drawing.Size(1227, 401)
        Me.TabDonor.TabIndex = 7
        '
        '_TabDonor_TabPage0
        '
        Me._TabDonor_TabPage0.Controls.Add(Me.tvTreeView)
        Me._TabDonor_TabPage0.Controls.Add(Me.SubForm1)
        Me._TabDonor_TabPage0.Location = New System.Drawing.Point(4, 4)
        Me._TabDonor_TabPage0.Name = "_TabDonor_TabPage0"
        Me._TabDonor_TabPage0.Size = New System.Drawing.Size(1201, 393)
        Me._TabDonor_TabPage0.TabIndex = 0
        Me._TabDonor_TabPage0.Text = "Secondary"
        '
        'tvTreeView
        '
        Me.tvTreeView.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.tvTreeView.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.tvTreeView.ImageIndex = 0
        Me.tvTreeView.ImageList = Me.ImageList1
        Me.tvTreeView.Indent = 24
        Me.tvTreeView.Location = New System.Drawing.Point(0, 0)
        Me.tvTreeView.Name = "tvTreeView"
        TreeNode2.Name = "Node0"
        TreeNode2.Text = "Sample"
        Me.tvTreeView.Nodes.AddRange(New System.Windows.Forms.TreeNode() {TreeNode2})
        Me.tvTreeView.SelectedImageIndex = 0
        Me.tvTreeView.Size = New System.Drawing.Size(156, 400)
        Me.tvTreeView.TabIndex = 8
        '
        'ImageList1
        '
        Me.ImageList1.ImageStream = CType(resources.GetObject("ImageList1.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageList1.TransparentColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ImageList1.Images.SetKeyName(0, "image_blue")
        Me.ImageList1.Images.SetKeyName(1, "status_red")
        Me.ImageList1.Images.SetKeyName(2, "status_green")
        Me.ImageList1.Images.SetKeyName(3, "image_a")
        Me.ImageList1.Images.SetKeyName(4, "image_b")
        Me.ImageList1.Images.SetKeyName(5, "image_bell")
        '
        'SubForm1
        '
        Me.SubForm1.BackColor = System.Drawing.SystemColors.Control
        Me.SubForm1.Controls.Add(Me.Picture2)
        Me.SubForm1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SubForm1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.SubForm1.Location = New System.Drawing.Point(156, 2)
        Me.SubForm1.Name = "SubForm1"
        Me.SubForm1.Padding = New System.Windows.Forms.Padding(0)
        Me.SubForm1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SubForm1.Size = New System.Drawing.Size(633, 401)
        Me.SubForm1.TabIndex = 10
        Me.SubForm1.TabStop = False
        '
        'Picture2
        '
        Me.Picture2.BackColor = System.Drawing.SystemColors.Control
        Me.Picture2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Picture2.Controls.Add(Me.tbReferralData)
        Me.Picture2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Picture2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Picture2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Picture2.Location = New System.Drawing.Point(-1, 0)
        Me.Picture2.Name = "Picture2"
        Me.Picture2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture2.Size = New System.Drawing.Size(615, 601)
        Me.Picture2.TabIndex = 11
        Me.Picture2.TabStop = True
        '
        'tbReferralData
        '
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage0)
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage1)
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage2)
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage3)
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage4)
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage5)
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage6)
        Me.tbReferralData.Controls.Add(Me._tbReferralData_TabPage7)
        Me.tbReferralData.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.tbReferralData.ItemSize = New System.Drawing.Size(42, 18)
        Me.tbReferralData.Location = New System.Drawing.Point(3, -2)
        Me.tbReferralData.Name = "tbReferralData"
        Me.tbReferralData.SelectedIndex = 1
        Me.tbReferralData.Size = New System.Drawing.Size(609, 601)
        Me.tbReferralData.TabIndex = 9
        '
        '_tbReferralData_TabPage0
        '
        Me._tbReferralData_TabPage0.AutoScroll = True
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_8)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_4)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_5)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_7)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_11)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_16)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_30)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_15)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_13)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_6)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_23)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_1)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_0)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_9)
        Me._tbReferralData_TabPage0.Controls.Add(Me._fmDataFrame_10)
        Me._tbReferralData_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage0.Name = "_tbReferralData_TabPage0"
        Me._tbReferralData_TabPage0.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage0.TabIndex = 0
        Me._tbReferralData_TabPage0.Text = "Tab 0"
        '
        '_fmDataFrame_8
        '
        Me._fmDataFrame_8.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_8.Controls.Add(Me.cmdCoroner)
        Me._fmDataFrame_8.Controls.Add(Me._DataComboArray_44)
        Me._fmDataFrame_8.Controls.Add(Me._DataComboArray_4)
        Me._fmDataFrame_8.Controls.Add(Me._DataTextArray_156)
        Me._fmDataFrame_8.Controls.Add(Me._DataComboArray_49)
        Me._fmDataFrame_8.Controls.Add(Me._DataTextArray_155)
        Me._fmDataFrame_8.Controls.Add(Me._DataTextArray_151)
        Me._fmDataFrame_8.Controls.Add(Me._DataComboArray_48)
        Me._fmDataFrame_8.Controls.Add(Me._DataTextArray_150)
        Me._fmDataFrame_8.Controls.Add(Me._DataComboArray_46)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_169)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_206)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_205)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_204)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_202)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_200)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_198)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_197)
        Me._fmDataFrame_8.Controls.Add(Me._DataLabelArray_196)
        Me._fmDataFrame_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_8, CType(8, Short))
        Me._fmDataFrame_8.Location = New System.Drawing.Point(400, 135)
        Me._fmDataFrame_8.Name = "_fmDataFrame_8"
        Me._fmDataFrame_8.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_8.Size = New System.Drawing.Size(425, 321)
        Me._fmDataFrame_8.TabIndex = 66
        Me._fmDataFrame_8.TabStop = False
        Me._fmDataFrame_8.Tag = "t0Coroner"
        Me._fmDataFrame_8.Text = "Coroner - Tab 0"
        '
        'cmdCoroner
        '
        Me.cmdCoroner.AutoSize = True
        Me.cmdCoroner.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCoroner.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCoroner.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCoroner.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCoroner.Location = New System.Drawing.Point(176, 16)
        Me.cmdCoroner.Name = "cmdCoroner"
        Me.cmdCoroner.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCoroner.Size = New System.Drawing.Size(96, 24)
        Me.cmdCoroner.TabIndex = 445
        Me.cmdCoroner.Text = "Contact Coroner"
        Me.cmdCoroner.UseVisualStyleBackColor = False
        '
        '_DataComboArray_44
        '
        Me._DataComboArray_44.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_44.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_44.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_44.Enabled = False
        Me._DataComboArray_44.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_44.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_44, CType(44, Short))
        Me._DataComboArray_44.Location = New System.Drawing.Point(104, 64)
        Me._DataComboArray_44.Name = "_DataComboArray_44"
        Me._DataComboArray_44.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_44.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_44.TabIndex = 394
        Me._DataComboArray_44.Tag = "SecondaryCoronerState"
        '
        '_DataComboArray_4
        '
        Me._DataComboArray_4.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_4.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_4.Enabled = False
        Me._DataComboArray_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_4, CType(4, Short))
        Me._DataComboArray_4.Location = New System.Drawing.Point(104, 136)
        Me._DataComboArray_4.Name = "_DataComboArray_4"
        Me._DataComboArray_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_4.Size = New System.Drawing.Size(273, 22)
        Me._DataComboArray_4.TabIndex = 397
        Me._DataComboArray_4.Tag = "SecondaryCoronerInvestigatorName"
        '
        '_DataTextArray_156
        '
        Me._DataTextArray_156.AcceptsReturn = True
        Me._DataTextArray_156.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_156.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_156.Enabled = False
        Me._DataTextArray_156.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_156.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_156, CType(156, Short))
        Me._DataTextArray_156.Location = New System.Drawing.Point(104, 208)
        Me._DataTextArray_156.MaxLength = 255
        Me._DataTextArray_156.Multiline = True
        Me._DataTextArray_156.Name = "_DataTextArray_156"
        Me._DataTextArray_156.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_156.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_156.Size = New System.Drawing.Size(273, 51)
        Me._DataTextArray_156.TabIndex = 400
        Me._DataTextArray_156.Tag = "SecondaryCoronerReleasedStipulations"
        '
        '_DataComboArray_49
        '
        Me._DataComboArray_49.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_49.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_49.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_49.Enabled = False
        Me._DataComboArray_49.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_49.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_49, CType(49, Short))
        Me._DataComboArray_49.Location = New System.Drawing.Point(104, 184)
        Me._DataComboArray_49.Name = "_DataComboArray_49"
        Me._DataComboArray_49.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_49.Size = New System.Drawing.Size(145, 22)
        Me._DataComboArray_49.TabIndex = 399
        Me._DataComboArray_49.Tag = "SecondaryCoronerReleased"
        '
        '_DataTextArray_155
        '
        Me._DataTextArray_155.AcceptsReturn = True
        Me._DataTextArray_155.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_155.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_155.Enabled = False
        Me._DataTextArray_155.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_155.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_155, CType(155, Short))
        Me._DataTextArray_155.Location = New System.Drawing.Point(104, 160)
        Me._DataTextArray_155.MaxLength = 0
        Me._DataTextArray_155.Name = "_DataTextArray_155"
        Me._DataTextArray_155.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_155.Size = New System.Drawing.Size(145, 20)
        Me._DataTextArray_155.TabIndex = 398
        Me._DataTextArray_155.Tag = "SecondaryCoronerInvestigatorPhone"
        '
        '_DataTextArray_151
        '
        Me._DataTextArray_151.AcceptsReturn = True
        Me._DataTextArray_151.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_151.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_151.Enabled = False
        Me._DataTextArray_151.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_151.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_151, CType(151, Short))
        Me._DataTextArray_151.Location = New System.Drawing.Point(104, 112)
        Me._DataTextArray_151.MaxLength = 25
        Me._DataTextArray_151.Name = "_DataTextArray_151"
        Me._DataTextArray_151.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_151.Size = New System.Drawing.Size(273, 20)
        Me._DataTextArray_151.TabIndex = 396
        Me._DataTextArray_151.Tag = "SecondaryCoronerCounty"
        '
        '_DataComboArray_48
        '
        Me._DataComboArray_48.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_48.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_48.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_48.Enabled = False
        Me._DataComboArray_48.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_48.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_48, CType(48, Short))
        Me._DataComboArray_48.Location = New System.Drawing.Point(104, 88)
        Me._DataComboArray_48.Name = "_DataComboArray_48"
        Me._DataComboArray_48.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_48.Size = New System.Drawing.Size(273, 22)
        Me._DataComboArray_48.TabIndex = 395
        Me._DataComboArray_48.Tag = "SecondaryCoronerOrganization"
        '
        '_DataTextArray_150
        '
        Me._DataTextArray_150.AcceptsReturn = True
        Me._DataTextArray_150.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_150.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_150.Enabled = False
        Me._DataTextArray_150.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_150.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_150, CType(150, Short))
        Me._DataTextArray_150.Location = New System.Drawing.Point(104, 40)
        Me._DataTextArray_150.MaxLength = 25
        Me._DataTextArray_150.Name = "_DataTextArray_150"
        Me._DataTextArray_150.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_150.Size = New System.Drawing.Size(161, 20)
        Me._DataTextArray_150.TabIndex = 393
        Me._DataTextArray_150.Tag = "SecondaryCoronerCaseNumber"
        '
        '_DataComboArray_46
        '
        Me._DataComboArray_46.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_46.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_46.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_46.Enabled = False
        Me._DataComboArray_46.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_46.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_46, CType(46, Short))
        Me._DataComboArray_46.Location = New System.Drawing.Point(104, 16)
        Me._DataComboArray_46.Name = "_DataComboArray_46"
        Me._DataComboArray_46.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_46.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_46.TabIndex = 392
        Me._DataComboArray_46.Tag = "SecondaryCoronerCase"
        '
        '_DataLabelArray_169
        '
        Me._DataLabelArray_169.AutoSize = True
        Me._DataLabelArray_169.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_169.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_169.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_169.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_169, CType(169, Short))
        Me._DataLabelArray_169.Location = New System.Drawing.Point(72, 64)
        Me._DataLabelArray_169.Name = "_DataLabelArray_169"
        Me._DataLabelArray_169.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_169.Size = New System.Drawing.Size(35, 14)
        Me._DataLabelArray_169.TabIndex = 442
        Me._DataLabelArray_169.Tag = "lblSecondaryCoronerOrganization"
        Me._DataLabelArray_169.Text = "State:"
        '
        '_DataLabelArray_206
        '
        Me._DataLabelArray_206.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_206.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_206.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_206.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_206, CType(206, Short))
        Me._DataLabelArray_206.Location = New System.Drawing.Point(32, 207)
        Me._DataLabelArray_206.Name = "_DataLabelArray_206"
        Me._DataLabelArray_206.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_206.Size = New System.Drawing.Size(70, 30)
        Me._DataLabelArray_206.TabIndex = 229
        Me._DataLabelArray_206.Tag = "lblSecondaryCoronerReleasedStipulations"
        Me._DataLabelArray_206.Text = "Release Stipulations:"
        '
        '_DataLabelArray_205
        '
        Me._DataLabelArray_205.AutoSize = True
        Me._DataLabelArray_205.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_205.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_205.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_205.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_205, CType(205, Short))
        Me._DataLabelArray_205.Location = New System.Drawing.Point(48, 184)
        Me._DataLabelArray_205.Name = "_DataLabelArray_205"
        Me._DataLabelArray_205.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_205.Size = New System.Drawing.Size(58, 14)
        Me._DataLabelArray_205.TabIndex = 228
        Me._DataLabelArray_205.Tag = "lblSecondaryCoronerReleased"
        Me._DataLabelArray_205.Text = "Released?"
        '
        '_DataLabelArray_204
        '
        Me._DataLabelArray_204.AutoSize = True
        Me._DataLabelArray_204.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_204.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_204.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_204.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_204, CType(204, Short))
        Me._DataLabelArray_204.Location = New System.Drawing.Point(8, 160)
        Me._DataLabelArray_204.Name = "_DataLabelArray_204"
        Me._DataLabelArray_204.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_204.Size = New System.Drawing.Size(99, 14)
        Me._DataLabelArray_204.TabIndex = 227
        Me._DataLabelArray_204.Tag = "lblSecondaryCoronerInvestigatorPhone"
        Me._DataLabelArray_204.Text = "Investigator Phone:"
        '
        '_DataLabelArray_202
        '
        Me._DataLabelArray_202.AutoSize = True
        Me._DataLabelArray_202.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_202.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_202.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_202.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_202, CType(202, Short))
        Me._DataLabelArray_202.Location = New System.Drawing.Point(8, 136)
        Me._DataLabelArray_202.Name = "_DataLabelArray_202"
        Me._DataLabelArray_202.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_202.Size = New System.Drawing.Size(96, 14)
        Me._DataLabelArray_202.TabIndex = 226
        Me._DataLabelArray_202.Tag = "lblSecondaryCoronerInvestigatorName"
        Me._DataLabelArray_202.Text = "Investigator Name:"
        '
        '_DataLabelArray_200
        '
        Me._DataLabelArray_200.AutoSize = True
        Me._DataLabelArray_200.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_200.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_200.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_200.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_200, CType(200, Short))
        Me._DataLabelArray_200.Location = New System.Drawing.Point(64, 112)
        Me._DataLabelArray_200.Name = "_DataLabelArray_200"
        Me._DataLabelArray_200.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_200.Size = New System.Drawing.Size(44, 14)
        Me._DataLabelArray_200.TabIndex = 225
        Me._DataLabelArray_200.Tag = "lblSecondaryCoronerCounty"
        Me._DataLabelArray_200.Text = "County:"
        '
        '_DataLabelArray_198
        '
        Me._DataLabelArray_198.AutoSize = True
        Me._DataLabelArray_198.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_198.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_198.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_198.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_198, CType(198, Short))
        Me._DataLabelArray_198.Location = New System.Drawing.Point(40, 88)
        Me._DataLabelArray_198.Name = "_DataLabelArray_198"
        Me._DataLabelArray_198.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_198.Size = New System.Drawing.Size(71, 14)
        Me._DataLabelArray_198.TabIndex = 224
        Me._DataLabelArray_198.Tag = "lblSecondaryCoronerOrganization"
        Me._DataLabelArray_198.Text = "Organization:"
        '
        '_DataLabelArray_197
        '
        Me._DataLabelArray_197.AutoSize = True
        Me._DataLabelArray_197.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_197.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_197.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_197.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_197, CType(197, Short))
        Me._DataLabelArray_197.Location = New System.Drawing.Point(32, 40)
        Me._DataLabelArray_197.Name = "_DataLabelArray_197"
        Me._DataLabelArray_197.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_197.Size = New System.Drawing.Size(75, 14)
        Me._DataLabelArray_197.TabIndex = 223
        Me._DataLabelArray_197.Tag = "lblSecondaryCoronerCaseNumber"
        Me._DataLabelArray_197.Text = "Case Number:"
        '
        '_DataLabelArray_196
        '
        Me._DataLabelArray_196.AutoSize = True
        Me._DataLabelArray_196.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_196.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_196.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_196.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_196, CType(196, Short))
        Me._DataLabelArray_196.Location = New System.Drawing.Point(24, 16)
        Me._DataLabelArray_196.Name = "_DataLabelArray_196"
        Me._DataLabelArray_196.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_196.Size = New System.Drawing.Size(80, 14)
        Me._DataLabelArray_196.TabIndex = 222
        Me._DataLabelArray_196.Tag = "lblSecondaryCoronerCase"
        Me._DataLabelArray_196.Text = "Coroner Case?"
        '
        '_fmDataFrame_4
        '
        Me._fmDataFrame_4.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_4.Controls.Add(Me._DataTextArray_78)
        Me._fmDataFrame_4.Controls.Add(Me._DataTextArray_76)
        Me._fmDataFrame_4.Controls.Add(Me._DataTextArray_75)
        Me._fmDataFrame_4.Controls.Add(Me._DataTextArray_1)
        Me._fmDataFrame_4.Controls.Add(Me._DataTextArray_2)
        Me._fmDataFrame_4.Controls.Add(Me._DataTextArray_3)
        Me._fmDataFrame_4.Controls.Add(Me._DataTextArray_0)
        Me._fmDataFrame_4.Controls.Add(Me._DataComboArray_0)
        Me._fmDataFrame_4.Controls.Add(Me._DataComboArray_3)
        Me._fmDataFrame_4.Controls.Add(Me._DataComboArray_1)
        Me._fmDataFrame_4.Controls.Add(Me._DataComboArray_2)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_245)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_244)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_243)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_5)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_6)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_7)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_4)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_3)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_1)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_2)
        Me._fmDataFrame_4.Controls.Add(Me._DataLabelArray_0)
        Me._fmDataFrame_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_4, CType(4, Short))
        Me._fmDataFrame_4.Location = New System.Drawing.Point(399, 184)
        Me._fmDataFrame_4.Name = "_fmDataFrame_4"
        Me._fmDataFrame_4.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_4.Size = New System.Drawing.Size(441, 305)
        Me._fmDataFrame_4.TabIndex = 63
        Me._fmDataFrame_4.TabStop = False
        Me._fmDataFrame_4.Tag = "t0Case Info"
        Me._fmDataFrame_4.Text = "Case Info - Tab 0"
        '
        '_DataTextArray_78
        '
        Me._DataTextArray_78.AcceptsReturn = True
        Me._DataTextArray_78.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_78.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_78.Enabled = False
        Me._DataTextArray_78.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_78.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_78, CType(78, Short))
        Me._DataTextArray_78.Location = New System.Drawing.Point(160, 88)
        Me._DataTextArray_78.MaxLength = 0
        Me._DataTextArray_78.Name = "_DataTextArray_78"
        Me._DataTextArray_78.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_78.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_78.TabIndex = 212
        Me._DataTextArray_78.Tag = "SecondaryNOKNotifiedTime"
        '
        '_DataTextArray_76
        '
        Me._DataTextArray_76.AcceptsReturn = True
        Me._DataTextArray_76.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_76.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_76.Enabled = False
        Me._DataTextArray_76.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_76.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_76, CType(76, Short))
        Me._DataTextArray_76.Location = New System.Drawing.Point(160, 64)
        Me._DataTextArray_76.MaxLength = 0
        Me._DataTextArray_76.Name = "_DataTextArray_76"
        Me._DataTextArray_76.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_76.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_76.TabIndex = 211
        Me._DataTextArray_76.Tag = "SecondaryNOKNotifiedDate"
        '
        '_DataTextArray_75
        '
        Me._DataTextArray_75.AcceptsReturn = True
        Me._DataTextArray_75.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_75.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_75.Enabled = False
        Me._DataTextArray_75.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_75.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_75, CType(75, Short))
        Me._DataTextArray_75.Location = New System.Drawing.Point(160, 40)
        Me._DataTextArray_75.MaxLength = 50
        Me._DataTextArray_75.Name = "_DataTextArray_75"
        Me._DataTextArray_75.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_75.Size = New System.Drawing.Size(193, 20)
        Me._DataTextArray_75.TabIndex = 210
        Me._DataTextArray_75.Tag = "SecondaryNOKNotifiedBy"
        '
        '_DataTextArray_1
        '
        Me._DataTextArray_1.AcceptsReturn = True
        Me._DataTextArray_1.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_1.Enabled = False
        Me._DataTextArray_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_1, CType(1, Short))
        Me._DataTextArray_1.Location = New System.Drawing.Point(160, 232)
        Me._DataTextArray_1.MaxLength = 0
        Me._DataTextArray_1.Name = "_DataTextArray_1"
        Me._DataTextArray_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_1.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_1.TabIndex = 217
        Me._DataTextArray_1.Tag = "SecondaryTimeLeftInMT"
        '
        '_DataTextArray_2
        '
        Me._DataTextArray_2.AcceptsReturn = True
        Me._DataTextArray_2.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_2.Enabled = False
        Me._DataTextArray_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_2, CType(2, Short))
        Me._DataTextArray_2.Location = New System.Drawing.Point(160, 256)
        Me._DataTextArray_2.MaxLength = 25
        Me._DataTextArray_2.Name = "_DataTextArray_2"
        Me._DataTextArray_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_2.Size = New System.Drawing.Size(201, 20)
        Me._DataTextArray_2.TabIndex = 218
        Me._DataTextArray_2.Tag = "SecondaryNOKNextDest"
        '
        '_DataTextArray_3
        '
        Me._DataTextArray_3.AcceptsReturn = True
        Me._DataTextArray_3.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_3.Enabled = False
        Me._DataTextArray_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_3, CType(3, Short))
        Me._DataTextArray_3.Location = New System.Drawing.Point(160, 280)
        Me._DataTextArray_3.MaxLength = 0
        Me._DataTextArray_3.Name = "_DataTextArray_3"
        Me._DataTextArray_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_3.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_3.TabIndex = 219
        Me._DataTextArray_3.Tag = "SecondaryNOKETA"
        '
        '_DataTextArray_0
        '
        Me._DataTextArray_0.AcceptsReturn = True
        Me._DataTextArray_0.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_0.Enabled = False
        Me._DataTextArray_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_0, CType(0, Short))
        Me._DataTextArray_0.Location = New System.Drawing.Point(160, 208)
        Me._DataTextArray_0.MaxLength = 0
        Me._DataTextArray_0.Name = "_DataTextArray_0"
        Me._DataTextArray_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_0.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_0.TabIndex = 216
        Me._DataTextArray_0.Tag = "SecondaryEstTimeSinceLeft"
        '
        '_DataComboArray_0
        '
        Me._DataComboArray_0.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_0.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_0.Enabled = False
        Me._DataComboArray_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_0, CType(0, Short))
        Me._DataComboArray_0.Location = New System.Drawing.Point(160, 16)
        Me._DataComboArray_0.Name = "_DataComboArray_0"
        Me._DataComboArray_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_0.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_0.TabIndex = 209
        Me._DataComboArray_0.Tag = "SecondaryNOKaware"
        '
        '_DataComboArray_3
        '
        Me._DataComboArray_3.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_3.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_3.Enabled = False
        Me._DataComboArray_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_3, CType(3, Short))
        Me._DataComboArray_3.Location = New System.Drawing.Point(160, 168)
        Me._DataComboArray_3.Name = "_DataComboArray_3"
        Me._DataComboArray_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_3.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_3.TabIndex = 215
        Me._DataComboArray_3.Tag = "SecondaryNOKatHospital"
        '
        '_DataComboArray_1
        '
        Me._DataComboArray_1.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_1.Enabled = False
        Me._DataComboArray_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_1, CType(1, Short))
        Me._DataComboArray_1.Location = New System.Drawing.Point(160, 120)
        Me._DataComboArray_1.Name = "_DataComboArray_1"
        Me._DataComboArray_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_1.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_1.TabIndex = 213
        Me._DataComboArray_1.Tag = "SecondaryFamilyInterested"
        '
        '_DataComboArray_2
        '
        Me._DataComboArray_2.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_2.Enabled = False
        Me._DataComboArray_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_2, CType(2, Short))
        Me._DataComboArray_2.Location = New System.Drawing.Point(160, 144)
        Me._DataComboArray_2.Name = "_DataComboArray_2"
        Me._DataComboArray_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_2.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_2.TabIndex = 214
        Me._DataComboArray_2.Tag = "SecondaryFamilyConsent"
        '
        '_DataLabelArray_245
        '
        Me._DataLabelArray_245.AutoSize = True
        Me._DataLabelArray_245.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_245.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_245.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_245.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_245, CType(245, Short))
        Me._DataLabelArray_245.Location = New System.Drawing.Point(88, 88)
        Me._DataLabelArray_245.Name = "_DataLabelArray_245"
        Me._DataLabelArray_245.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_245.Size = New System.Drawing.Size(71, 14)
        Me._DataLabelArray_245.TabIndex = 440
        Me._DataLabelArray_245.Tag = "lblSecondaryEstTimeSinceLeft"
        Me._DataLabelArray_245.Text = "Notified Time:"
        '
        '_DataLabelArray_244
        '
        Me._DataLabelArray_244.AutoSize = True
        Me._DataLabelArray_244.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_244.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_244.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_244.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_244, CType(244, Short))
        Me._DataLabelArray_244.Location = New System.Drawing.Point(88, 64)
        Me._DataLabelArray_244.Name = "_DataLabelArray_244"
        Me._DataLabelArray_244.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_244.Size = New System.Drawing.Size(71, 14)
        Me._DataLabelArray_244.TabIndex = 439
        Me._DataLabelArray_244.Tag = "lblSecondaryEstTimeSinceLeft"
        Me._DataLabelArray_244.Text = "Notified Date:"
        '
        '_DataLabelArray_243
        '
        Me._DataLabelArray_243.AutoSize = True
        Me._DataLabelArray_243.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_243.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_243.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_243.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_243, CType(243, Short))
        Me._DataLabelArray_243.Location = New System.Drawing.Point(64, 40)
        Me._DataLabelArray_243.Name = "_DataLabelArray_243"
        Me._DataLabelArray_243.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_243.Size = New System.Drawing.Size(95, 14)
        Me._DataLabelArray_243.TabIndex = 438
        Me._DataLabelArray_243.Tag = "lblSecondaryEstTimeSinceLeft"
        Me._DataLabelArray_243.Text = "Notified By Whom:"
        '
        '_DataLabelArray_5
        '
        Me._DataLabelArray_5.AutoSize = True
        Me._DataLabelArray_5.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_5, CType(5, Short))
        Me._DataLabelArray_5.Location = New System.Drawing.Point(64, 232)
        Me._DataLabelArray_5.Name = "_DataLabelArray_5"
        Me._DataLabelArray_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_5.Size = New System.Drawing.Size(103, 14)
        Me._DataLabelArray_5.TabIndex = 81
        Me._DataLabelArray_5.Tag = "lblSecondaryTimeLeftInMT"
        Me._DataLabelArray_5.Text = "Time NOK left (MT): "
        '
        '_DataLabelArray_6
        '
        Me._DataLabelArray_6.AutoSize = True
        Me._DataLabelArray_6.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_6, CType(6, Short))
        Me._DataLabelArray_6.Location = New System.Drawing.Point(56, 256)
        Me._DataLabelArray_6.Name = "_DataLabelArray_6"
        Me._DataLabelArray_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_6.Size = New System.Drawing.Size(102, 14)
        Me._DataLabelArray_6.TabIndex = 80
        Me._DataLabelArray_6.Tag = "lblSecondaryNOKNextDest"
        Me._DataLabelArray_6.Text = "Where did NOK go?"
        '
        '_DataLabelArray_7
        '
        Me._DataLabelArray_7.AutoSize = True
        Me._DataLabelArray_7.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_7, CType(7, Short))
        Me._DataLabelArray_7.Location = New System.Drawing.Point(72, 280)
        Me._DataLabelArray_7.Name = "_DataLabelArray_7"
        Me._DataLabelArray_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_7.Size = New System.Drawing.Size(89, 14)
        Me._DataLabelArray_7.TabIndex = 79
        Me._DataLabelArray_7.Tag = "lblSecondaryNOKETA"
        Me._DataLabelArray_7.Text = "NOK Return ETA:"
        '
        '_DataLabelArray_4
        '
        Me._DataLabelArray_4.AutoSize = True
        Me._DataLabelArray_4.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_4, CType(4, Short))
        Me._DataLabelArray_4.Location = New System.Drawing.Point(88, 208)
        Me._DataLabelArray_4.Name = "_DataLabelArray_4"
        Me._DataLabelArray_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_4.Size = New System.Drawing.Size(75, 14)
        Me._DataLabelArray_4.TabIndex = 78
        Me._DataLabelArray_4.Tag = "lblSecondaryEstTimeSinceLeft"
        Me._DataLabelArray_4.Text = "Time NOK left:"
        '
        '_DataLabelArray_3
        '
        Me._DataLabelArray_3.AutoSize = True
        Me._DataLabelArray_3.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_3, CType(3, Short))
        Me._DataLabelArray_3.Location = New System.Drawing.Point(64, 168)
        Me._DataLabelArray_3.Name = "_DataLabelArray_3"
        Me._DataLabelArray_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_3.Size = New System.Drawing.Size(88, 14)
        Me._DataLabelArray_3.TabIndex = 77
        Me._DataLabelArray_3.Tag = "lblSecondaryNOKatHospital"
        Me._DataLabelArray_3.Text = "NOK at Hospital?"
        '
        '_DataLabelArray_1
        '
        Me._DataLabelArray_1.AutoSize = True
        Me._DataLabelArray_1.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_1, CType(1, Short))
        Me._DataLabelArray_1.Location = New System.Drawing.Point(64, 120)
        Me._DataLabelArray_1.Name = "_DataLabelArray_1"
        Me._DataLabelArray_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_1.Size = New System.Drawing.Size(94, 14)
        Me._DataLabelArray_1.TabIndex = 76
        Me._DataLabelArray_1.Tag = "lblSecondaryFamilyInteresed"
        Me._DataLabelArray_1.Text = "Family Interested?"
        '
        '_DataLabelArray_2
        '
        Me._DataLabelArray_2.AutoSize = True
        Me._DataLabelArray_2.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_2, CType(2, Short))
        Me._DataLabelArray_2.Location = New System.Drawing.Point(64, 144)
        Me._DataLabelArray_2.Name = "_DataLabelArray_2"
        Me._DataLabelArray_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_2.Size = New System.Drawing.Size(98, 14)
        Me._DataLabelArray_2.TabIndex = 75
        Me._DataLabelArray_2.Tag = "lblSecondaryFamilyConsent"
        Me._DataLabelArray_2.Text = "Family Consented?"
        '
        '_DataLabelArray_0
        '
        Me._DataLabelArray_0.AutoSize = True
        Me._DataLabelArray_0.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_0, CType(0, Short))
        Me._DataLabelArray_0.Location = New System.Drawing.Point(16, 16)
        Me._DataLabelArray_0.Name = "_DataLabelArray_0"
        Me._DataLabelArray_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_0.Size = New System.Drawing.Size(143, 14)
        Me._DataLabelArray_0.TabIndex = 74
        Me._DataLabelArray_0.Tag = "lblSecondaryNOKaware"
        Me._DataLabelArray_0.Text = "NOK been notified of death?"
        '
        '_fmDataFrame_5
        '
        Me._fmDataFrame_5.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_5.Controls.Add(Me._DataComboArray_71)
        Me._fmDataFrame_5.Controls.Add(Me._DataComboArray_10)
        Me._fmDataFrame_5.Controls.Add(Me._DataComboArray_82)
        Me._fmDataFrame_5.Controls.Add(Me._DataRTFArray_0)
        Me._fmDataFrame_5.Controls.Add(Me._DataRTFArray_1)
        Me._fmDataFrame_5.Controls.Add(Me._DataRTFArray_2)
        Me._fmDataFrame_5.Controls.Add(Me._DataRTFArray_3)
        Me._fmDataFrame_5.Controls.Add(Me._DataRTFArray_4)
        Me._fmDataFrame_5.Controls.Add(Me._DataRTFArray_5)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_47)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_46)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_21)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_234)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_75)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_16)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_17)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_18)
        Me._fmDataFrame_5.Controls.Add(Me._DataLabelArray_15)
        Me._fmDataFrame_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_5, CType(5, Short))
        Me._fmDataFrame_5.Location = New System.Drawing.Point(9, 12)
        Me._fmDataFrame_5.Name = "_fmDataFrame_5"
        Me._fmDataFrame_5.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_5.Size = New System.Drawing.Size(441, 441)
        Me._fmDataFrame_5.TabIndex = 64
        Me._fmDataFrame_5.TabStop = False
        Me._fmDataFrame_5.Tag = "t0Medical/Treatment Info"
        Me._fmDataFrame_5.Text = "Medical/Treatment Info - Tab 0"
        '
        '_DataComboArray_71
        '
        Me._DataComboArray_71.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_71.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_71.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_71.Enabled = False
        Me._DataComboArray_71.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_71.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_71, CType(71, Short))
        Me._DataComboArray_71.Location = New System.Drawing.Point(114, 64)
        Me._DataComboArray_71.Name = "_DataComboArray_71"
        Me._DataComboArray_71.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_71.Size = New System.Drawing.Size(121, 22)
        Me._DataComboArray_71.TabIndex = 232
        Me._DataComboArray_71.Tag = "SecondaryPatientVentilated"
        '
        '_DataComboArray_10
        '
        Me._DataComboArray_10.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_10.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_10.Enabled = False
        Me._DataComboArray_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_10.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_10, CType(10, Short))
        Me._DataComboArray_10.Location = New System.Drawing.Point(114, 136)
        Me._DataComboArray_10.Name = "_DataComboArray_10"
        Me._DataComboArray_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_10.Size = New System.Drawing.Size(57, 22)
        Me._DataComboArray_10.TabIndex = 234
        Me._DataComboArray_10.Tag = "SecondarySignOfInfection"
        '
        '_DataComboArray_82
        '
        Me._DataComboArray_82.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_82.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_82.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_82.Enabled = False
        Me._DataComboArray_82.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_82.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_82, CType(82, Short))
        Me._DataComboArray_82.Location = New System.Drawing.Point(114, 256)
        Me._DataComboArray_82.Name = "_DataComboArray_82"
        Me._DataComboArray_82.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_82.Size = New System.Drawing.Size(57, 22)
        Me._DataComboArray_82.TabIndex = 237
        Me._DataComboArray_82.Tag = "SecondaryHistorySubstanceAbuse"
        '
        '_DataRTFArray_0
        '
        Me._DataRTFArray_0.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataRTFArray_0.Enabled = False
        Me._DataRTFArray_0.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataRTFArray.SetIndex(Me._DataRTFArray_0, CType(0, Short))
        Me._DataRTFArray_0.Location = New System.Drawing.Point(114, 16)
        Me._DataRTFArray_0.MaxLength = 254
        Me._DataRTFArray_0.Name = "_DataRTFArray_0"
        Me._DataRTFArray_0.ReadOnly = True
        Me._DataRTFArray_0.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._DataRTFArray_0.Size = New System.Drawing.Size(319, 47)
        Me._DataRTFArray_0.TabIndex = 231
        Me._DataRTFArray_0.Tag = "SecondaryTriageHX"
        Me._DataRTFArray_0.Text = ""
        '
        '_DataRTFArray_1
        '
        Me._DataRTFArray_1.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataRTFArray_1.Enabled = False
        Me._DataRTFArray_1.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataRTFArray.SetIndex(Me._DataRTFArray_1, CType(1, Short))
        Me._DataRTFArray_1.Location = New System.Drawing.Point(114, 88)
        Me._DataRTFArray_1.MaxLength = 1000
        Me._DataRTFArray_1.Name = "_DataRTFArray_1"
        Me._DataRTFArray_1.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._DataRTFArray_1.Size = New System.Drawing.Size(319, 47)
        Me._DataRTFArray_1.TabIndex = 233
        Me._DataRTFArray_1.Tag = "SecondaryCircumstanceOfDeath"
        Me._DataRTFArray_1.Text = ""
        '
        '_DataRTFArray_2
        '
        Me._DataRTFArray_2.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataRTFArray_2.Enabled = False
        Me._DataRTFArray_2.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataRTFArray.SetIndex(Me._DataRTFArray_2, CType(2, Short))
        Me._DataRTFArray_2.Location = New System.Drawing.Point(114, 160)
        Me._DataRTFArray_2.MaxLength = 1000
        Me._DataRTFArray_2.Name = "_DataRTFArray_2"
        Me._DataRTFArray_2.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._DataRTFArray_2.Size = New System.Drawing.Size(319, 47)
        Me._DataRTFArray_2.TabIndex = 235
        Me._DataRTFArray_2.Tag = "SecondaryMedicalHistory"
        Me._DataRTFArray_2.Text = ""
        '
        '_DataRTFArray_3
        '
        Me._DataRTFArray_3.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataRTFArray_3.Enabled = False
        Me._DataRTFArray_3.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataRTFArray.SetIndex(Me._DataRTFArray_3, CType(3, Short))
        Me._DataRTFArray_3.Location = New System.Drawing.Point(114, 208)
        Me._DataRTFArray_3.MaxLength = 1000
        Me._DataRTFArray_3.Name = "_DataRTFArray_3"
        Me._DataRTFArray_3.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._DataRTFArray_3.Size = New System.Drawing.Size(319, 47)
        Me._DataRTFArray_3.TabIndex = 236
        Me._DataRTFArray_3.Tag = "SecondaryPhysicalAppearance"
        Me._DataRTFArray_3.Text = ""
        '
        '_DataRTFArray_4
        '
        Me._DataRTFArray_4.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataRTFArray_4.Enabled = False
        Me._DataRTFArray_4.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataRTFArray.SetIndex(Me._DataRTFArray_4, CType(4, Short))
        Me._DataRTFArray_4.Location = New System.Drawing.Point(218, 256)
        Me._DataRTFArray_4.MaxLength = 1000
        Me._DataRTFArray_4.Name = "_DataRTFArray_4"
        Me._DataRTFArray_4.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._DataRTFArray_4.Size = New System.Drawing.Size(215, 47)
        Me._DataRTFArray_4.TabIndex = 238
        Me._DataRTFArray_4.Tag = "SecondarySubstanceAbuseDetail"
        Me._DataRTFArray_4.Text = ""
        '
        '_DataRTFArray_5
        '
        Me._DataRTFArray_5.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataRTFArray_5.Enabled = False
        Me._DataRTFArray_5.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataRTFArray.SetIndex(Me._DataRTFArray_5, CType(5, Short))
        Me._DataRTFArray_5.Location = New System.Drawing.Point(114, 304)
        Me._DataRTFArray_5.MaxLength = 255
        Me._DataRTFArray_5.Name = "_DataRTFArray_5"
        Me._DataRTFArray_5.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._DataRTFArray_5.Size = New System.Drawing.Size(319, 47)
        Me._DataRTFArray_5.TabIndex = 239
        Me._DataRTFArray_5.Tag = "SecondaryAdditionalComments"
        Me._DataRTFArray_5.Text = ""
        '
        '_DataLabelArray_47
        '
        Me._DataLabelArray_47.AutoSize = True
        Me._DataLabelArray_47.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_47.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_47.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_47.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_47, CType(47, Short))
        Me._DataLabelArray_47.Location = New System.Drawing.Point(7, 304)
        Me._DataLabelArray_47.Name = "_DataLabelArray_47"
        Me._DataLabelArray_47.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_47.Size = New System.Drawing.Size(110, 14)
        Me._DataLabelArray_47.TabIndex = 561
        Me._DataLabelArray_47.Tag = "lblSecondaryAdditionalComments"
        Me._DataLabelArray_47.Text = "Additional Comments:"
        '
        '_DataLabelArray_46
        '
        Me._DataLabelArray_46.AutoSize = True
        Me._DataLabelArray_46.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_46.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_46.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_46.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_46, CType(46, Short))
        Me._DataLabelArray_46.Location = New System.Drawing.Point(44, 66)
        Me._DataLabelArray_46.Name = "_DataLabelArray_46"
        Me._DataLabelArray_46.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_46.Size = New System.Drawing.Size(72, 14)
        Me._DataLabelArray_46.TabIndex = 560
        Me._DataLabelArray_46.Tag = "lblSecondaryPatientVentilated"
        Me._DataLabelArray_46.Text = "Pt. Ventilated:"
        '
        '_DataLabelArray_21
        '
        Me._DataLabelArray_21.AutoSize = True
        Me._DataLabelArray_21.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_21, CType(21, Short))
        Me._DataLabelArray_21.Location = New System.Drawing.Point(20, 136)
        Me._DataLabelArray_21.Name = "_DataLabelArray_21"
        Me._DataLabelArray_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_21.Size = New System.Drawing.Size(97, 14)
        Me._DataLabelArray_21.TabIndex = 507
        Me._DataLabelArray_21.Tag = "lblSecondarySignOfInfection"
        Me._DataLabelArray_21.Text = "Signs of Infection?"
        '
        '_DataLabelArray_234
        '
        Me._DataLabelArray_234.AutoSize = True
        Me._DataLabelArray_234.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_234.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_234.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_234.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_234, CType(234, Short))
        Me._DataLabelArray_234.Location = New System.Drawing.Point(178, 260)
        Me._DataLabelArray_234.Name = "_DataLabelArray_234"
        Me._DataLabelArray_234.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_234.Size = New System.Drawing.Size(42, 14)
        Me._DataLabelArray_234.TabIndex = 430
        Me._DataLabelArray_234.Tag = "lblSecondaryPhysicalAppearance"
        Me._DataLabelArray_234.Text = "Details:"
        '
        '_DataLabelArray_75
        '
        Me._DataLabelArray_75.AutoSize = True
        Me._DataLabelArray_75.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_75.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_75.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_75.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_75, CType(75, Short))
        Me._DataLabelArray_75.Location = New System.Drawing.Point(17, 256)
        Me._DataLabelArray_75.Name = "_DataLabelArray_75"
        Me._DataLabelArray_75.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_75.Size = New System.Drawing.Size(99, 14)
        Me._DataLabelArray_75.TabIndex = 429
        Me._DataLabelArray_75.Tag = "lblSecondaryPhysicalAppearance"
        Me._DataLabelArray_75.Text = "Substance Abuse?"
        '
        '_DataLabelArray_16
        '
        Me._DataLabelArray_16.AutoSize = True
        Me._DataLabelArray_16.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_16, CType(16, Short))
        Me._DataLabelArray_16.Location = New System.Drawing.Point(4, 88)
        Me._DataLabelArray_16.Name = "_DataLabelArray_16"
        Me._DataLabelArray_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_16.Size = New System.Drawing.Size(113, 14)
        Me._DataLabelArray_16.TabIndex = 99
        Me._DataLabelArray_16.Tag = "lblSecondaryCircumstanceOfDeath"
        Me._DataLabelArray_16.Text = "Death Circumstances:"
        '
        '_DataLabelArray_17
        '
        Me._DataLabelArray_17.AutoSize = True
        Me._DataLabelArray_17.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_17.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_17, CType(17, Short))
        Me._DataLabelArray_17.Location = New System.Drawing.Point(34, 160)
        Me._DataLabelArray_17.Name = "_DataLabelArray_17"
        Me._DataLabelArray_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_17.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_17.TabIndex = 98
        Me._DataLabelArray_17.Tag = "lblSecondaryMedicalHistory"
        Me._DataLabelArray_17.Text = "Medical History:"
        '
        '_DataLabelArray_18
        '
        Me._DataLabelArray_18.AutoSize = True
        Me._DataLabelArray_18.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_18, CType(18, Short))
        Me._DataLabelArray_18.Location = New System.Drawing.Point(4, 208)
        Me._DataLabelArray_18.Name = "_DataLabelArray_18"
        Me._DataLabelArray_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_18.Size = New System.Drawing.Size(112, 14)
        Me._DataLabelArray_18.TabIndex = 97
        Me._DataLabelArray_18.Tag = "lblSecondaryPhysicalAppearance"
        Me._DataLabelArray_18.Text = "Physical Appearance:"
        '
        '_DataLabelArray_15
        '
        Me._DataLabelArray_15.AutoSize = True
        Me._DataLabelArray_15.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_15, CType(15, Short))
        Me._DataLabelArray_15.Location = New System.Drawing.Point(40, 16)
        Me._DataLabelArray_15.Name = "_DataLabelArray_15"
        Me._DataLabelArray_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_15.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_15.TabIndex = 96
        Me._DataLabelArray_15.Tag = "lblSecondaryTriageHX"
        Me._DataLabelArray_15.Text = "Triage History:"
        '
        '_fmDataFrame_7
        '
        Me._fmDataFrame_7.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_7.Controls.Add(Me._DataComboArray_7)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_35)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_34)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_33)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_32)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_31)
        Me._fmDataFrame_7.Controls.Add(Me.cmdNOK)
        Me._fmDataFrame_7.Controls.Add(Me._DataComboArray_86)
        Me._fmDataFrame_7.Controls.Add(Me._DataComboArray_45)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_146)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_145)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_144)
        Me._fmDataFrame_7.Controls.Add(Me._DataComboArray_43)
        Me._fmDataFrame_7.Controls.Add(Me._DataTextArray_143)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_62)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_61)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_57)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_54)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_53)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_247)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_193)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_191)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_186)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_185)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_184)
        Me._fmDataFrame_7.Controls.Add(Me._DataLabelArray_183)
        Me._fmDataFrame_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_7, CType(7, Short))
        Me._fmDataFrame_7.Location = New System.Drawing.Point(400, 150)
        Me._fmDataFrame_7.Name = "_fmDataFrame_7"
        Me._fmDataFrame_7.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_7.Size = New System.Drawing.Size(441, 337)
        Me._fmDataFrame_7.TabIndex = 65
        Me._fmDataFrame_7.TabStop = False
        Me._fmDataFrame_7.Tag = "t0Next Of Kin"
        Me._fmDataFrame_7.Text = "Next Of Kin - Tab 0"
        '
        '_DataComboArray_7
        '
        Me._DataComboArray_7.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_7.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_7.Enabled = False
        Me._DataComboArray_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_7, CType(7, Short))
        Me._DataComboArray_7.Location = New System.Drawing.Point(210, 162)
        Me._DataComboArray_7.Name = "_DataComboArray_7"
        Me._DataComboArray_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_7.Size = New System.Drawing.Size(41, 22)
        Me._DataComboArray_7.TabIndex = 628
        Me._DataComboArray_7.Tag = "SecondaryNOKState"
        '
        '_DataTextArray_35
        '
        Me._DataTextArray_35.AcceptsReturn = True
        Me._DataTextArray_35.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_35.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_35.Enabled = False
        Me._DataTextArray_35.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_35.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_35, CType(35, Short))
        Me._DataTextArray_35.Location = New System.Drawing.Point(69, 138)
        Me._DataTextArray_35.MaxLength = 50
        Me._DataTextArray_35.Name = "_DataTextArray_35"
        Me._DataTextArray_35.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_35.Size = New System.Drawing.Size(281, 20)
        Me._DataTextArray_35.TabIndex = 624
        Me._DataTextArray_35.Tag = "SecondaryNOKStreetAddress"
        '
        '_DataTextArray_34
        '
        Me._DataTextArray_34.AcceptsReturn = True
        Me._DataTextArray_34.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_34.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_34.Enabled = False
        Me._DataTextArray_34.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_34.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_34, CType(34, Short))
        Me._DataTextArray_34.Location = New System.Drawing.Point(276, 162)
        Me._DataTextArray_34.MaxLength = 10
        Me._DataTextArray_34.Name = "_DataTextArray_34"
        Me._DataTextArray_34.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_34.Size = New System.Drawing.Size(74, 20)
        Me._DataTextArray_34.TabIndex = 623
        Me._DataTextArray_34.Tag = "SecondaryNOKZip"
        '
        '_DataTextArray_33
        '
        Me._DataTextArray_33.AcceptsReturn = True
        Me._DataTextArray_33.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_33.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_33.Enabled = False
        Me._DataTextArray_33.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_33.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_33, CType(33, Short))
        Me._DataTextArray_33.Location = New System.Drawing.Point(69, 162)
        Me._DataTextArray_33.MaxLength = 50
        Me._DataTextArray_33.Name = "_DataTextArray_33"
        Me._DataTextArray_33.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_33.Size = New System.Drawing.Size(104, 20)
        Me._DataTextArray_33.TabIndex = 622
        Me._DataTextArray_33.Tag = "SecondaryNOKCity"
        '
        '_DataTextArray_32
        '
        Me._DataTextArray_32.AcceptsReturn = True
        Me._DataTextArray_32.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_32.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_32.Enabled = False
        Me._DataTextArray_32.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_32.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_32, CType(32, Short))
        Me._DataTextArray_32.Location = New System.Drawing.Point(246, 16)
        Me._DataTextArray_32.MaxLength = 50
        Me._DataTextArray_32.Name = "_DataTextArray_32"
        Me._DataTextArray_32.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_32.Size = New System.Drawing.Size(104, 20)
        Me._DataTextArray_32.TabIndex = 619
        Me._DataTextArray_32.Tag = "SecondaryNOKLastName"
        '
        '_DataTextArray_31
        '
        Me._DataTextArray_31.AcceptsReturn = True
        Me._DataTextArray_31.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_31.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_31.Enabled = False
        Me._DataTextArray_31.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_31.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_31, CType(31, Short))
        Me._DataTextArray_31.Location = New System.Drawing.Point(69, 16)
        Me._DataTextArray_31.MaxLength = 50
        Me._DataTextArray_31.Name = "_DataTextArray_31"
        Me._DataTextArray_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_31.Size = New System.Drawing.Size(113, 20)
        Me._DataTextArray_31.TabIndex = 618
        Me._DataTextArray_31.Tag = "SecondaryNOKFirstName"
        '
        'cmdNOK
        '
        Me.cmdNOK.BackColor = System.Drawing.SystemColors.Control
        Me.cmdNOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdNOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdNOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdNOK.Location = New System.Drawing.Point(354, 15)
        Me.cmdNOK.Name = "cmdNOK"
        Me.cmdNOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdNOK.Size = New System.Drawing.Size(81, 20)
        Me.cmdNOK.TabIndex = 447
        Me.cmdNOK.Text = "Contact NOK"
        Me.cmdNOK.UseVisualStyleBackColor = False
        '
        '_DataComboArray_86
        '
        Me._DataComboArray_86.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_86.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_86.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_86.Enabled = False
        Me._DataComboArray_86.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_86.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_86, CType(86, Short))
        Me._DataComboArray_86.Location = New System.Drawing.Point(69, 112)
        Me._DataComboArray_86.Name = "_DataComboArray_86"
        Me._DataComboArray_86.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_86.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_86.TabIndex = 385
        Me._DataComboArray_86.Tag = "SecondaryNOKGender"
        '
        '_DataComboArray_45
        '
        Me._DataComboArray_45.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_45.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_45.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_45.Enabled = False
        Me._DataComboArray_45.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_45.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_45, CType(45, Short))
        Me._DataComboArray_45.Location = New System.Drawing.Point(69, 191)
        Me._DataComboArray_45.Name = "_DataComboArray_45"
        Me._DataComboArray_45.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_45.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_45.TabIndex = 387
        Me._DataComboArray_45.Tag = "SecondaryNOKLegal"
        '
        '_DataTextArray_146
        '
        Me._DataTextArray_146.AcceptsReturn = True
        Me._DataTextArray_146.BackColor = System.Drawing.SystemColors.Control
        Me._DataTextArray_146.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_146.Enabled = False
        Me._DataTextArray_146.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_146.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_146, CType(146, Short))
        Me._DataTextArray_146.Location = New System.Drawing.Point(69, 138)
        Me._DataTextArray_146.MaxLength = 255
        Me._DataTextArray_146.Multiline = True
        Me._DataTextArray_146.Name = "_DataTextArray_146"
        Me._DataTextArray_146.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_146.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_146.Size = New System.Drawing.Size(283, 48)
        Me._DataTextArray_146.TabIndex = 386
        Me._DataTextArray_146.Tag = "SecondaryNOKAddress"
        '
        '_DataTextArray_145
        '
        Me._DataTextArray_145.AcceptsReturn = True
        Me._DataTextArray_145.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_145.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_145.Enabled = False
        Me._DataTextArray_145.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_145.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_145, CType(145, Short))
        Me._DataTextArray_145.Location = New System.Drawing.Point(69, 61)
        Me._DataTextArray_145.MaxLength = 0
        Me._DataTextArray_145.Name = "_DataTextArray_145"
        Me._DataTextArray_145.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_145.Size = New System.Drawing.Size(113, 20)
        Me._DataTextArray_145.TabIndex = 383
        Me._DataTextArray_145.Tag = "SecondaryNOKAltPhone"
        '
        '_DataTextArray_144
        '
        Me._DataTextArray_144.AcceptsReturn = True
        Me._DataTextArray_144.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_144.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_144.Enabled = False
        Me._DataTextArray_144.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_144.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_144, CType(144, Short))
        Me._DataTextArray_144.Location = New System.Drawing.Point(69, 38)
        Me._DataTextArray_144.MaxLength = 0
        Me._DataTextArray_144.Name = "_DataTextArray_144"
        Me._DataTextArray_144.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_144.Size = New System.Drawing.Size(113, 20)
        Me._DataTextArray_144.TabIndex = 382
        Me._DataTextArray_144.Tag = "SecondaryNOKPhone"
        '
        '_DataComboArray_43
        '
        Me._DataComboArray_43.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_43.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_43.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_43.Enabled = False
        Me._DataComboArray_43.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_43.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_43, CType(43, Short))
        Me._DataComboArray_43.Location = New System.Drawing.Point(69, 85)
        Me._DataComboArray_43.Name = "_DataComboArray_43"
        Me._DataComboArray_43.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_43.Size = New System.Drawing.Size(113, 22)
        Me._DataComboArray_43.TabIndex = 384
        Me._DataComboArray_43.Tag = "SecondaryNOKRelation"
        '
        '_DataTextArray_143
        '
        Me._DataTextArray_143.AcceptsReturn = True
        Me._DataTextArray_143.BackColor = System.Drawing.SystemColors.Control
        Me._DataTextArray_143.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_143.Enabled = False
        Me._DataTextArray_143.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_143.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_143, CType(143, Short))
        Me._DataTextArray_143.Location = New System.Drawing.Point(69, 15)
        Me._DataTextArray_143.MaxLength = 50
        Me._DataTextArray_143.Name = "_DataTextArray_143"
        Me._DataTextArray_143.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_143.Size = New System.Drawing.Size(278, 20)
        Me._DataTextArray_143.TabIndex = 381
        Me._DataTextArray_143.Tag = "SecondaryNOKName"
        '
        '_DataLabelArray_62
        '
        Me._DataLabelArray_62.AutoSize = True
        Me._DataLabelArray_62.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_62.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_62.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_62.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_62, CType(62, Short))
        Me._DataLabelArray_62.Location = New System.Drawing.Point(255, 165)
        Me._DataLabelArray_62.Name = "_DataLabelArray_62"
        Me._DataLabelArray_62.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_62.Size = New System.Drawing.Size(25, 14)
        Me._DataLabelArray_62.TabIndex = 627
        Me._DataLabelArray_62.Tag = "lblSecondaryNOKZip"
        Me._DataLabelArray_62.Text = "Zip:"
        '
        '_DataLabelArray_61
        '
        Me._DataLabelArray_61.AutoSize = True
        Me._DataLabelArray_61.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_61.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_61.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_61.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_61, CType(61, Short))
        Me._DataLabelArray_61.Location = New System.Drawing.Point(180, 165)
        Me._DataLabelArray_61.Name = "_DataLabelArray_61"
        Me._DataLabelArray_61.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_61.Size = New System.Drawing.Size(35, 14)
        Me._DataLabelArray_61.TabIndex = 626
        Me._DataLabelArray_61.Tag = "lblSecondaryNOKState"
        Me._DataLabelArray_61.Text = "State:"
        '
        '_DataLabelArray_57
        '
        Me._DataLabelArray_57.AutoSize = True
        Me._DataLabelArray_57.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_57.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_57.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_57.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_57, CType(57, Short))
        Me._DataLabelArray_57.Location = New System.Drawing.Point(45, 165)
        Me._DataLabelArray_57.Name = "_DataLabelArray_57"
        Me._DataLabelArray_57.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_57.Size = New System.Drawing.Size(28, 14)
        Me._DataLabelArray_57.TabIndex = 625
        Me._DataLabelArray_57.Tag = "lblSecondaryNOKCity"
        Me._DataLabelArray_57.Text = "City:"
        '
        '_DataLabelArray_54
        '
        Me._DataLabelArray_54.AutoSize = True
        Me._DataLabelArray_54.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_54.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_54.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_54.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_54, CType(54, Short))
        Me._DataLabelArray_54.Location = New System.Drawing.Point(189, 15)
        Me._DataLabelArray_54.Name = "_DataLabelArray_54"
        Me._DataLabelArray_54.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_54.Size = New System.Drawing.Size(61, 14)
        Me._DataLabelArray_54.TabIndex = 621
        Me._DataLabelArray_54.Tag = "lblSecondaryNOKLastName"
        Me._DataLabelArray_54.Text = "Last Name:"
        '
        '_DataLabelArray_53
        '
        Me._DataLabelArray_53.AutoSize = True
        Me._DataLabelArray_53.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_53.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_53.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_53.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_53, CType(53, Short))
        Me._DataLabelArray_53.Location = New System.Drawing.Point(12, 18)
        Me._DataLabelArray_53.Name = "_DataLabelArray_53"
        Me._DataLabelArray_53.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_53.Size = New System.Drawing.Size(61, 14)
        Me._DataLabelArray_53.TabIndex = 620
        Me._DataLabelArray_53.Tag = "lblSecondaryNOKFirstName"
        Me._DataLabelArray_53.Text = "First Name:"
        '
        '_DataLabelArray_247
        '
        Me._DataLabelArray_247.AutoSize = True
        Me._DataLabelArray_247.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_247.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_247.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_247.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_247, CType(247, Short))
        Me._DataLabelArray_247.Location = New System.Drawing.Point(2, 115)
        Me._DataLabelArray_247.Name = "_DataLabelArray_247"
        Me._DataLabelArray_247.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_247.Size = New System.Drawing.Size(71, 14)
        Me._DataLabelArray_247.TabIndex = 441
        Me._DataLabelArray_247.Tag = "lblSecondaryNOKGender"
        Me._DataLabelArray_247.Text = "NOK Gender:"
        '
        '_DataLabelArray_193
        '
        Me._DataLabelArray_193.AutoSize = True
        Me._DataLabelArray_193.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_193.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_193.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_193.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_193, CType(193, Short))
        Me._DataLabelArray_193.Location = New System.Drawing.Point(9, 194)
        Me._DataLabelArray_193.Name = "_DataLabelArray_193"
        Me._DataLabelArray_193.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_193.Size = New System.Drawing.Size(64, 14)
        Me._DataLabelArray_193.TabIndex = 204
        Me._DataLabelArray_193.Tag = "lblSecondaryNOKLegal"
        Me._DataLabelArray_193.Text = "Legal NOK?"
        '
        '_DataLabelArray_191
        '
        Me._DataLabelArray_191.AutoSize = True
        Me._DataLabelArray_191.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_191.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_191.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_191.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_191, CType(191, Short))
        Me._DataLabelArray_191.Location = New System.Drawing.Point(21, 142)
        Me._DataLabelArray_191.Name = "_DataLabelArray_191"
        Me._DataLabelArray_191.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_191.Size = New System.Drawing.Size(52, 14)
        Me._DataLabelArray_191.TabIndex = 203
        Me._DataLabelArray_191.Tag = "lblSecondaryNOKAddress"
        Me._DataLabelArray_191.Text = "Address:"
        '
        '_DataLabelArray_186
        '
        Me._DataLabelArray_186.AutoSize = True
        Me._DataLabelArray_186.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_186.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_186.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_186.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_186, CType(186, Short))
        Me._DataLabelArray_186.Location = New System.Drawing.Point(17, 64)
        Me._DataLabelArray_186.Name = "_DataLabelArray_186"
        Me._DataLabelArray_186.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_186.Size = New System.Drawing.Size(56, 14)
        Me._DataLabelArray_186.TabIndex = 202
        Me._DataLabelArray_186.Tag = "lblSecondaryNOKAltPhone"
        Me._DataLabelArray_186.Text = "Alt Phone:"
        '
        '_DataLabelArray_185
        '
        Me._DataLabelArray_185.AutoSize = True
        Me._DataLabelArray_185.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_185.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_185.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_185.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_185, CType(185, Short))
        Me._DataLabelArray_185.Location = New System.Drawing.Point(33, 41)
        Me._DataLabelArray_185.Name = "_DataLabelArray_185"
        Me._DataLabelArray_185.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_185.Size = New System.Drawing.Size(40, 14)
        Me._DataLabelArray_185.TabIndex = 201
        Me._DataLabelArray_185.Tag = "lblSecondaryNOKPhone"
        Me._DataLabelArray_185.Text = "Phone:"
        '
        '_DataLabelArray_184
        '
        Me._DataLabelArray_184.AutoSize = True
        Me._DataLabelArray_184.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_184.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_184.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_184.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_184, CType(184, Short))
        Me._DataLabelArray_184.Location = New System.Drawing.Point(25, 88)
        Me._DataLabelArray_184.Name = "_DataLabelArray_184"
        Me._DataLabelArray_184.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_184.Size = New System.Drawing.Size(48, 14)
        Me._DataLabelArray_184.TabIndex = 200
        Me._DataLabelArray_184.Tag = "lblSecondaryNOKRelation"
        Me._DataLabelArray_184.Text = "Relation:"
        '
        '_DataLabelArray_183
        '
        Me._DataLabelArray_183.AutoSize = True
        Me._DataLabelArray_183.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_183.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_183.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_183.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_183, CType(183, Short))
        Me._DataLabelArray_183.Location = New System.Drawing.Point(30, 16)
        Me._DataLabelArray_183.Name = "_DataLabelArray_183"
        Me._DataLabelArray_183.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_183.Size = New System.Drawing.Size(37, 14)
        Me._DataLabelArray_183.TabIndex = 199
        Me._DataLabelArray_183.Tag = "lblSecondaryNOKName"
        Me._DataLabelArray_183.Text = "Name:"
        '
        '_fmDataFrame_11
        '
        Me._fmDataFrame_11.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_11.Controls.Add(Me.chkSecondaryTBINotNeeded)
        Me._fmDataFrame_11.Controls.Add(Me.txtSecondaryTBIComment)
        Me._fmDataFrame_11.Controls.Add(Me.cmdGenerateTBI)
        Me._fmDataFrame_11.Controls.Add(Me._DataTextArray_36)
        Me._fmDataFrame_11.Controls.Add(Me._DataTextArray_174)
        Me._fmDataFrame_11.Controls.Add(Me._DataTextArray_169)
        Me._fmDataFrame_11.Controls.Add(Me._DataTextArray_172)
        Me._fmDataFrame_11.Controls.Add(Me._DataTextArray_171)
        Me._fmDataFrame_11.Controls.Add(Me._DataTextArray_170)
        Me._fmDataFrame_11.Controls.Add(Me._DataTextArray_173)
        Me._fmDataFrame_11.Controls.Add(Me.lblTBIComment)
        Me._fmDataFrame_11.Controls.Add(Me._DataLabelArray_64)
        Me._fmDataFrame_11.Controls.Add(Me._DataLabelArray_233)
        Me._fmDataFrame_11.Controls.Add(Me._DataLabelArray_232)
        Me._fmDataFrame_11.Controls.Add(Me._DataLabelArray_231)
        Me._fmDataFrame_11.Controls.Add(Me._DataLabelArray_230)
        Me._fmDataFrame_11.Controls.Add(Me._DataLabelArray_229)
        Me._fmDataFrame_11.Controls.Add(Me._DataLabelArray_228)
        Me._fmDataFrame_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_11, CType(11, Short))
        Me._fmDataFrame_11.Location = New System.Drawing.Point(364, 218)
        Me._fmDataFrame_11.Name = "_fmDataFrame_11"
        Me._fmDataFrame_11.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_11.Size = New System.Drawing.Size(441, 305)
        Me._fmDataFrame_11.TabIndex = 69
        Me._fmDataFrame_11.TabStop = False
        Me._fmDataFrame_11.Tag = "t0Case Numbers"
        Me._fmDataFrame_11.Text = "Case Numbers - Tab 0"
        '
        'chkSecondaryTBINotNeeded
        '
        Me.chkSecondaryTBINotNeeded.BackColor = System.Drawing.SystemColors.Control
        Me.chkSecondaryTBINotNeeded.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkSecondaryTBINotNeeded.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkSecondaryTBINotNeeded.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkSecondaryTBINotNeeded.Location = New System.Drawing.Point(63, 158)
        Me.chkSecondaryTBINotNeeded.Name = "chkSecondaryTBINotNeeded"
        Me.chkSecondaryTBINotNeeded.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkSecondaryTBINotNeeded.Size = New System.Drawing.Size(222, 17)
        Me.chkSecondaryTBINotNeeded.TabIndex = 644
        Me.chkSecondaryTBINotNeeded.Text = "CTDN - Assignment Not Needed"
        Me.chkSecondaryTBINotNeeded.UseVisualStyleBackColor = False
        '
        'txtSecondaryTBIComment
        '
        Me.txtSecondaryTBIComment.AcceptsReturn = True
        Me.txtSecondaryTBIComment.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me.txtSecondaryTBIComment.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtSecondaryTBIComment.Enabled = False
        Me.txtSecondaryTBIComment.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSecondaryTBIComment.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtSecondaryTBIComment.Location = New System.Drawing.Point(158, 177)
        Me.txtSecondaryTBIComment.MaxLength = 255
        Me.txtSecondaryTBIComment.Multiline = True
        Me.txtSecondaryTBIComment.Name = "txtSecondaryTBIComment"
        Me.txtSecondaryTBIComment.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtSecondaryTBIComment.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtSecondaryTBIComment.Size = New System.Drawing.Size(268, 42)
        Me.txtSecondaryTBIComment.TabIndex = 642
        Me.txtSecondaryTBIComment.Tag = "SecondaryTBIComment"
        '
        'cmdGenerateTBI
        '
        Me.cmdGenerateTBI.BackColor = System.Drawing.SystemColors.Control
        Me.cmdGenerateTBI.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdGenerateTBI.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdGenerateTBI.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdGenerateTBI.Location = New System.Drawing.Point(216, 135)
        Me.cmdGenerateTBI.Name = "cmdGenerateTBI"
        Me.cmdGenerateTBI.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdGenerateTBI.Size = New System.Drawing.Size(107, 20)
        Me.cmdGenerateTBI.TabIndex = 641
        Me.cmdGenerateTBI.Text = "Generate CTDN #"
        Me.cmdGenerateTBI.UseVisualStyleBackColor = False
        '
        '_DataTextArray_36
        '
        Me._DataTextArray_36.AcceptsReturn = True
        Me._DataTextArray_36.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_36.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_36.Enabled = False
        Me._DataTextArray_36.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_36.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_36, CType(36, Short))
        Me._DataTextArray_36.Location = New System.Drawing.Point(65, 135)
        Me._DataTextArray_36.MaxLength = 25
        Me._DataTextArray_36.Name = "_DataTextArray_36"
        Me._DataTextArray_36.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_36.Size = New System.Drawing.Size(145, 20)
        Me._DataTextArray_36.TabIndex = 639
        Me._DataTextArray_36.Tag = "SecondaryTBINumber"
        '
        '_DataTextArray_174
        '
        Me._DataTextArray_174.AcceptsReturn = True
        Me._DataTextArray_174.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_174.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_174.Enabled = False
        Me._DataTextArray_174.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_174.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_174, CType(174, Short))
        Me._DataTextArray_174.Location = New System.Drawing.Point(65, 228)
        Me._DataTextArray_174.MaxLength = 255
        Me._DataTextArray_174.Multiline = True
        Me._DataTextArray_174.Name = "_DataTextArray_174"
        Me._DataTextArray_174.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_174.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_174.Size = New System.Drawing.Size(361, 67)
        Me._DataTextArray_174.TabIndex = 425
        Me._DataTextArray_174.Tag = "SecondaryFreeText"
        '
        '_DataTextArray_169
        '
        Me._DataTextArray_169.AcceptsReturn = True
        Me._DataTextArray_169.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_169.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_169.Enabled = False
        Me._DataTextArray_169.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_169.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_169, CType(169, Short))
        Me._DataTextArray_169.Location = New System.Drawing.Point(64, 16)
        Me._DataTextArray_169.MaxLength = 25
        Me._DataTextArray_169.Name = "_DataTextArray_169"
        Me._DataTextArray_169.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_169.Size = New System.Drawing.Size(145, 20)
        Me._DataTextArray_169.TabIndex = 420
        Me._DataTextArray_169.Tag = "SecondaryUNOSNumber"
        '
        '_DataTextArray_172
        '
        Me._DataTextArray_172.AcceptsReturn = True
        Me._DataTextArray_172.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_172.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_172.Enabled = False
        Me._DataTextArray_172.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_172.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_172, CType(172, Short))
        Me._DataTextArray_172.Location = New System.Drawing.Point(64, 112)
        Me._DataTextArray_172.MaxLength = 25
        Me._DataTextArray_172.Name = "_DataTextArray_172"
        Me._DataTextArray_172.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_172.Size = New System.Drawing.Size(145, 20)
        Me._DataTextArray_172.TabIndex = 424
        Me._DataTextArray_172.Tag = "SecondaryLifeNetNumber"
        '
        '_DataTextArray_171
        '
        Me._DataTextArray_171.AcceptsReturn = True
        Me._DataTextArray_171.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_171.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_171.Enabled = False
        Me._DataTextArray_171.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_171.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_171, CType(171, Short))
        Me._DataTextArray_171.Location = New System.Drawing.Point(64, 88)
        Me._DataTextArray_171.MaxLength = 25
        Me._DataTextArray_171.Name = "_DataTextArray_171"
        Me._DataTextArray_171.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_171.Size = New System.Drawing.Size(145, 20)
        Me._DataTextArray_171.TabIndex = 423
        Me._DataTextArray_171.Tag = "SecondaryMTFNumber"
        '
        '_DataTextArray_170
        '
        Me._DataTextArray_170.AcceptsReturn = True
        Me._DataTextArray_170.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_170.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_170.Enabled = False
        Me._DataTextArray_170.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_170.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_170, CType(170, Short))
        Me._DataTextArray_170.Location = New System.Drawing.Point(64, 64)
        Me._DataTextArray_170.MaxLength = 25
        Me._DataTextArray_170.Name = "_DataTextArray_170"
        Me._DataTextArray_170.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_170.Size = New System.Drawing.Size(145, 20)
        Me._DataTextArray_170.TabIndex = 422
        Me._DataTextArray_170.Tag = "SecondaryCryolifeNumber"
        '
        '_DataTextArray_173
        '
        Me._DataTextArray_173.AcceptsReturn = True
        Me._DataTextArray_173.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_173.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_173.Enabled = False
        Me._DataTextArray_173.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_173.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_173, CType(173, Short))
        Me._DataTextArray_173.Location = New System.Drawing.Point(64, 40)
        Me._DataTextArray_173.MaxLength = 25
        Me._DataTextArray_173.Name = "_DataTextArray_173"
        Me._DataTextArray_173.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_173.Size = New System.Drawing.Size(145, 20)
        Me._DataTextArray_173.TabIndex = 421
        Me._DataTextArray_173.Tag = "SecondaryClientNumber"
        '
        'lblTBIComment
        '
        Me.lblTBIComment.AutoSize = True
        Me.lblTBIComment.BackColor = System.Drawing.SystemColors.Control
        Me.lblTBIComment.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTBIComment.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTBIComment.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblTBIComment.Location = New System.Drawing.Point(102, 177)
        Me.lblTBIComment.Name = "lblTBIComment"
        Me.lblTBIComment.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTBIComment.Size = New System.Drawing.Size(54, 14)
        Me.lblTBIComment.TabIndex = 643
        Me.lblTBIComment.Tag = "lblSecondaryTBIComment"
        Me.lblTBIComment.Text = "Comment:"
        '
        '_DataLabelArray_64
        '
        Me._DataLabelArray_64.AutoSize = True
        Me._DataLabelArray_64.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_64.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_64.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_64.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_64, CType(64, Short))
        Me._DataLabelArray_64.Location = New System.Drawing.Point(20, 136)
        Me._DataLabelArray_64.Name = "_DataLabelArray_64"
        Me._DataLabelArray_64.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_64.Size = New System.Drawing.Size(46, 14)
        Me._DataLabelArray_64.TabIndex = 640
        Me._DataLabelArray_64.Tag = "lblSecondaryTBINumber"
        Me._DataLabelArray_64.Text = "CTDN #:"
        '
        '_DataLabelArray_233
        '
        Me._DataLabelArray_233.AutoSize = True
        Me._DataLabelArray_233.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_233.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_233.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_233.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_233, CType(233, Short))
        Me._DataLabelArray_233.Location = New System.Drawing.Point(17, 228)
        Me._DataLabelArray_233.Name = "_DataLabelArray_233"
        Me._DataLabelArray_233.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_233.Size = New System.Drawing.Size(46, 14)
        Me._DataLabelArray_233.TabIndex = 290
        Me._DataLabelArray_233.Tag = "lblSecondaryFreeText"
        Me._DataLabelArray_233.Text = "Other #:"
        '
        '_DataLabelArray_232
        '
        Me._DataLabelArray_232.AutoSize = True
        Me._DataLabelArray_232.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_232.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_232.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_232.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_232, CType(232, Short))
        Me._DataLabelArray_232.Location = New System.Drawing.Point(18, 16)
        Me._DataLabelArray_232.Name = "_DataLabelArray_232"
        Me._DataLabelArray_232.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_232.Size = New System.Drawing.Size(48, 14)
        Me._DataLabelArray_232.TabIndex = 289
        Me._DataLabelArray_232.Tag = "lblSecondaryUNOSNumber"
        Me._DataLabelArray_232.Text = "UNOS #:"
        '
        '_DataLabelArray_231
        '
        Me._DataLabelArray_231.AutoSize = True
        Me._DataLabelArray_231.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_231.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_231.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_231.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_231, CType(231, Short))
        Me._DataLabelArray_231.Location = New System.Drawing.Point(13, 112)
        Me._DataLabelArray_231.Name = "_DataLabelArray_231"
        Me._DataLabelArray_231.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_231.Size = New System.Drawing.Size(53, 14)
        Me._DataLabelArray_231.TabIndex = 288
        Me._DataLabelArray_231.Tag = "lblSecondaryLifeNetNumber"
        Me._DataLabelArray_231.Text = "LifeNet #:"
        '
        '_DataLabelArray_230
        '
        Me._DataLabelArray_230.AutoSize = True
        Me._DataLabelArray_230.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_230.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_230.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_230.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_230, CType(230, Short))
        Me._DataLabelArray_230.Location = New System.Drawing.Point(27, 88)
        Me._DataLabelArray_230.Name = "_DataLabelArray_230"
        Me._DataLabelArray_230.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_230.Size = New System.Drawing.Size(39, 14)
        Me._DataLabelArray_230.TabIndex = 287
        Me._DataLabelArray_230.Tag = "lblSecondaryMTFNumber"
        Me._DataLabelArray_230.Text = "MTF #:"
        '
        '_DataLabelArray_229
        '
        Me._DataLabelArray_229.AutoSize = True
        Me._DataLabelArray_229.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_229.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_229.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_229.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_229, CType(229, Short))
        Me._DataLabelArray_229.Location = New System.Drawing.Point(10, 64)
        Me._DataLabelArray_229.Name = "_DataLabelArray_229"
        Me._DataLabelArray_229.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_229.Size = New System.Drawing.Size(56, 14)
        Me._DataLabelArray_229.TabIndex = 286
        Me._DataLabelArray_229.Tag = "lblSecondaryCryolifeNumber"
        Me._DataLabelArray_229.Text = "Cryolife #:"
        '
        '_DataLabelArray_228
        '
        Me._DataLabelArray_228.AutoSize = True
        Me._DataLabelArray_228.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_228.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_228.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_228.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_228, CType(228, Short))
        Me._DataLabelArray_228.Location = New System.Drawing.Point(21, 40)
        Me._DataLabelArray_228.Name = "_DataLabelArray_228"
        Me._DataLabelArray_228.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_228.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_228.TabIndex = 285
        Me._DataLabelArray_228.Tag = "lblSecondaryClientNumber"
        Me._DataLabelArray_228.Text = "Client #:"
        '
        '_fmDataFrame_16
        '
        Me._fmDataFrame_16.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_16.Controls.Add(Me._DataComboArray_8)
        Me._fmDataFrame_16.Controls.Add(Me._DataComboArray_9)
        Me._fmDataFrame_16.Controls.Add(Me._DataTextArray_71)
        Me._fmDataFrame_16.Controls.Add(Me._DataTextArray_70)
        Me._fmDataFrame_16.Controls.Add(Me._DataLabelArray_19)
        Me._fmDataFrame_16.Controls.Add(Me._DataLabelArray_20)
        Me._fmDataFrame_16.Controls.Add(Me._DataLabelArray_94)
        Me._fmDataFrame_16.Controls.Add(Me._DataLabelArray_82)
        Me._fmDataFrame_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_16, CType(16, Short))
        Me._fmDataFrame_16.Location = New System.Drawing.Point(400, 105)
        Me._fmDataFrame_16.Name = "_fmDataFrame_16"
        Me._fmDataFrame_16.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_16.Size = New System.Drawing.Size(409, 305)
        Me._fmDataFrame_16.TabIndex = 72
        Me._fmDataFrame_16.TabStop = False
        Me._fmDataFrame_16.Tag = "t0Fluids"
        Me._fmDataFrame_16.Text = "Fluids - Tab 0"
        '
        '_DataComboArray_8
        '
        Me._DataComboArray_8.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_8.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_8.Enabled = False
        Me._DataComboArray_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_8.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_8, CType(8, Short))
        Me._DataComboArray_8.Location = New System.Drawing.Point(80, 80)
        Me._DataComboArray_8.Name = "_DataComboArray_8"
        Me._DataComboArray_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_8.Size = New System.Drawing.Size(57, 22)
        Me._DataComboArray_8.TabIndex = 523
        Me._DataComboArray_8.Tag = "SecondaryFluidsGiven"
        Me._DataComboArray_8.Visible = False
        '
        '_DataComboArray_9
        '
        Me._DataComboArray_9.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_9.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_9.Enabled = False
        Me._DataComboArray_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_9.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_9, CType(9, Short))
        Me._DataComboArray_9.Location = New System.Drawing.Point(80, 104)
        Me._DataComboArray_9.Name = "_DataComboArray_9"
        Me._DataComboArray_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_9.Size = New System.Drawing.Size(57, 22)
        Me._DataComboArray_9.TabIndex = 522
        Me._DataComboArray_9.Tag = "SecondaryBloodLoss"
        Me._DataComboArray_9.Visible = False
        '
        '_DataTextArray_71
        '
        Me._DataTextArray_71.AcceptsReturn = True
        Me._DataTextArray_71.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_71.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_71.Enabled = False
        Me._DataTextArray_71.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_71.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_71, CType(71, Short))
        Me._DataTextArray_71.Location = New System.Drawing.Point(128, 40)
        Me._DataTextArray_71.MaxLength = 10
        Me._DataTextArray_71.Name = "_DataTextArray_71"
        Me._DataTextArray_71.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_71.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_71.TabIndex = 292
        Me._DataTextArray_71.Tag = "SecondaryExternalBloodLossCC"
        '
        '_DataTextArray_70
        '
        Me._DataTextArray_70.AcceptsReturn = True
        Me._DataTextArray_70.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_70.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_70.Enabled = False
        Me._DataTextArray_70.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_70.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_70, CType(70, Short))
        Me._DataTextArray_70.Location = New System.Drawing.Point(128, 16)
        Me._DataTextArray_70.MaxLength = 10
        Me._DataTextArray_70.Name = "_DataTextArray_70"
        Me._DataTextArray_70.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_70.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_70.TabIndex = 291
        Me._DataTextArray_70.Tag = "SecondaryInternalBloodLossCC"
        '
        '_DataLabelArray_19
        '
        Me._DataLabelArray_19.AutoSize = True
        Me._DataLabelArray_19.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_19, CType(19, Short))
        Me._DataLabelArray_19.Location = New System.Drawing.Point(8, 80)
        Me._DataLabelArray_19.Name = "_DataLabelArray_19"
        Me._DataLabelArray_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_19.Size = New System.Drawing.Size(72, 14)
        Me._DataLabelArray_19.TabIndex = 525
        Me._DataLabelArray_19.Tag = "lblSecondaryFluidsGiven"
        Me._DataLabelArray_19.Text = "Fluids Given?"
        Me._DataLabelArray_19.Visible = False
        '
        '_DataLabelArray_20
        '
        Me._DataLabelArray_20.AutoSize = True
        Me._DataLabelArray_20.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_20, CType(20, Short))
        Me._DataLabelArray_20.Location = New System.Drawing.Point(8, 104)
        Me._DataLabelArray_20.Name = "_DataLabelArray_20"
        Me._DataLabelArray_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_20.Size = New System.Drawing.Size(67, 14)
        Me._DataLabelArray_20.TabIndex = 524
        Me._DataLabelArray_20.Tag = "lblSecondaryBloodLoss"
        Me._DataLabelArray_20.Text = "Blood Loss?"
        Me._DataLabelArray_20.Visible = False
        '
        '_DataLabelArray_94
        '
        Me._DataLabelArray_94.AutoSize = True
        Me._DataLabelArray_94.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_94.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_94.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_94.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_94, CType(94, Short))
        Me._DataLabelArray_94.Location = New System.Drawing.Point(8, 40)
        Me._DataLabelArray_94.Name = "_DataLabelArray_94"
        Me._DataLabelArray_94.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_94.Size = New System.Drawing.Size(123, 14)
        Me._DataLabelArray_94.TabIndex = 104
        Me._DataLabelArray_94.Tag = "lblSecondaryExternalBloodLossCC"
        Me._DataLabelArray_94.Text = "External CC Blood Loss:"
        '
        '_DataLabelArray_82
        '
        Me._DataLabelArray_82.AutoSize = True
        Me._DataLabelArray_82.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_82.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_82.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_82.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_82, CType(82, Short))
        Me._DataLabelArray_82.Location = New System.Drawing.Point(8, 16)
        Me._DataLabelArray_82.Name = "_DataLabelArray_82"
        Me._DataLabelArray_82.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_82.Size = New System.Drawing.Size(119, 14)
        Me._DataLabelArray_82.TabIndex = 103
        Me._DataLabelArray_82.Tag = "lblSecondaryInternalBloodLossCC"
        Me._DataLabelArray_82.Text = "Internal CC Blood Loss:"
        '
        '_fmDataFrame_30
        '
        Me._fmDataFrame_30.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_30.Controls.Add(Me._DataComboArray_85)
        Me._fmDataFrame_30.Controls.Add(Me._DataTextArray_74)
        Me._fmDataFrame_30.Controls.Add(Me._DataLabelArray_242)
        Me._fmDataFrame_30.Controls.Add(Me._DataLabelArray_238)
        Me._fmDataFrame_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_30.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_30, CType(30, Short))
        Me._fmDataFrame_30.Location = New System.Drawing.Point(400, 90)
        Me._fmDataFrame_30.Name = "_fmDataFrame_30"
        Me._fmDataFrame_30.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_30.Size = New System.Drawing.Size(441, 297)
        Me._fmDataFrame_30.TabIndex = 433
        Me._fmDataFrame_30.TabStop = False
        Me._fmDataFrame_30.Tag = "t0Wrap-Up Items"
        Me._fmDataFrame_30.Text = "Wrap-Up Items  - Tab 0"
        '
        '_DataComboArray_85
        '
        Me._DataComboArray_85.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_85.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_85.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_85.Enabled = False
        Me._DataComboArray_85.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_85.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_85, CType(85, Short))
        Me._DataComboArray_85.Location = New System.Drawing.Point(88, 80)
        Me._DataComboArray_85.Name = "_DataComboArray_85"
        Me._DataComboArray_85.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_85.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_85.TabIndex = 427
        Me._DataComboArray_85.Tag = "SecondaryWrapUpReminderYN"
        '
        '_DataTextArray_74
        '
        Me._DataTextArray_74.AcceptsReturn = True
        Me._DataTextArray_74.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_74.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_74.Enabled = False
        Me._DataTextArray_74.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_74.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_74, CType(74, Short))
        Me._DataTextArray_74.Location = New System.Drawing.Point(88, 16)
        Me._DataTextArray_74.MaxLength = 0
        Me._DataTextArray_74.Multiline = True
        Me._DataTextArray_74.Name = "_DataTextArray_74"
        Me._DataTextArray_74.ReadOnly = True
        Me._DataTextArray_74.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_74.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_74.Size = New System.Drawing.Size(337, 59)
        Me._DataTextArray_74.TabIndex = 426
        Me._DataTextArray_74.Tag = "SecondaryWrapUpReminder"
        '
        '_DataLabelArray_242
        '
        Me._DataLabelArray_242.AutoSize = True
        Me._DataLabelArray_242.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_242.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_242.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_242.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_242, CType(242, Short))
        Me._DataLabelArray_242.Location = New System.Drawing.Point(8, 84)
        Me._DataLabelArray_242.Name = "_DataLabelArray_242"
        Me._DataLabelArray_242.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_242.Size = New System.Drawing.Size(84, 14)
        Me._DataLabelArray_242.TabIndex = 437
        Me._DataLabelArray_242.Tag = "lblSecondaryWrapUpReminderYN"
        Me._DataLabelArray_242.Text = "Reminder (Y/N):"
        '
        '_DataLabelArray_238
        '
        Me._DataLabelArray_238.AutoSize = True
        Me._DataLabelArray_238.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_238.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_238.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_238.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_238, CType(238, Short))
        Me._DataLabelArray_238.Location = New System.Drawing.Point(32, 16)
        Me._DataLabelArray_238.Name = "_DataLabelArray_238"
        Me._DataLabelArray_238.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_238.Size = New System.Drawing.Size(55, 14)
        Me._DataLabelArray_238.TabIndex = 434
        Me._DataLabelArray_238.Tag = "lblSecondaryWrapUpReminder"
        Me._DataLabelArray_238.Text = "Reminder:"
        '
        '_fmDataFrame_15
        '
        Me._fmDataFrame_15.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_15.Controls.Add(Me._DataComboArray_20)
        Me._fmDataFrame_15.Controls.Add(Me._DataComboArray_36)
        Me._fmDataFrame_15.Controls.Add(Me._DataComboArray_35)
        Me._fmDataFrame_15.Controls.Add(Me._DataTextArray_105)
        Me._fmDataFrame_15.Controls.Add(Me._DataTextArray_104)
        Me._fmDataFrame_15.Controls.Add(Me._DataTextArray_103)
        Me._fmDataFrame_15.Controls.Add(Me._DataTextArray_101)
        Me._fmDataFrame_15.Controls.Add(Me._DataTextArray_100)
        Me._fmDataFrame_15.Controls.Add(Me._DataTextArray_99)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_142)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_141)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_140)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_139)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_138)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_137)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_136)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_135)
        Me._fmDataFrame_15.Controls.Add(Me._DataLabelArray_134)
        Me._fmDataFrame_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_15, CType(15, Short))
        Me._fmDataFrame_15.Location = New System.Drawing.Point(400, 75)
        Me._fmDataFrame_15.Name = "_fmDataFrame_15"
        Me._fmDataFrame_15.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_15.Size = New System.Drawing.Size(417, 313)
        Me._fmDataFrame_15.TabIndex = 71
        Me._fmDataFrame_15.TabStop = False
        Me._fmDataFrame_15.Tag = "t0Blood Sample"
        Me._fmDataFrame_15.Text = "Blood Sample - Tab 0"
        '
        '_DataComboArray_20
        '
        Me._DataComboArray_20.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_20.Enabled = False
        Me._DataComboArray_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_20.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_20, CType(20, Short))
        Me._DataComboArray_20.Location = New System.Drawing.Point(104, 136)
        Me._DataComboArray_20.Name = "_DataComboArray_20"
        Me._DataComboArray_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_20.Size = New System.Drawing.Size(129, 22)
        Me._DataComboArray_20.TabIndex = 337
        Me._DataComboArray_20.Tag = "SecondaryPreTransfusionSampleHeldAt"
        Me._DataComboArray_20.Text = "DataComboArray"
        '
        '_DataComboArray_36
        '
        Me._DataComboArray_36.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_36.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_36.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_36.Enabled = False
        Me._DataComboArray_36.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_36.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_36, CType(36, Short))
        Me._DataComboArray_36.Location = New System.Drawing.Point(104, 40)
        Me._DataComboArray_36.Name = "_DataComboArray_36"
        Me._DataComboArray_36.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_36.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_36.TabIndex = 333
        Me._DataComboArray_36.Tag = "SecondaryPreTransfusionSampleAvailable"
        '
        '_DataComboArray_35
        '
        Me._DataComboArray_35.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_35.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_35.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_35.Enabled = False
        Me._DataComboArray_35.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_35.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_35, CType(35, Short))
        Me._DataComboArray_35.Location = New System.Drawing.Point(104, 16)
        Me._DataComboArray_35.Name = "_DataComboArray_35"
        Me._DataComboArray_35.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_35.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_35.TabIndex = 332
        Me._DataComboArray_35.Tag = "SecondaryPreTransfusionSampleRequired"
        '
        '_DataTextArray_105
        '
        Me._DataTextArray_105.AcceptsReturn = True
        Me._DataTextArray_105.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_105.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_105.Enabled = False
        Me._DataTextArray_105.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_105.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_105, CType(105, Short))
        Me._DataTextArray_105.Location = New System.Drawing.Point(104, 64)
        Me._DataTextArray_105.MaxLength = 0
        Me._DataTextArray_105.Name = "_DataTextArray_105"
        Me._DataTextArray_105.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_105.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_105.TabIndex = 334
        Me._DataTextArray_105.Tag = "SecondaryPreTransfusionSampleDrawnDate"
        '
        '_DataTextArray_104
        '
        Me._DataTextArray_104.AcceptsReturn = True
        Me._DataTextArray_104.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_104.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_104.Enabled = False
        Me._DataTextArray_104.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_104.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_104, CType(104, Short))
        Me._DataTextArray_104.Location = New System.Drawing.Point(104, 88)
        Me._DataTextArray_104.MaxLength = 0
        Me._DataTextArray_104.Name = "_DataTextArray_104"
        Me._DataTextArray_104.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_104.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_104.TabIndex = 335
        Me._DataTextArray_104.Tag = "SecondaryPreTransfusionSampleDrawnTime"
        '
        '_DataTextArray_103
        '
        Me._DataTextArray_103.AcceptsReturn = True
        Me._DataTextArray_103.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_103.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_103.Enabled = False
        Me._DataTextArray_103.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_103.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_103, CType(103, Short))
        Me._DataTextArray_103.Location = New System.Drawing.Point(104, 112)
        Me._DataTextArray_103.MaxLength = 10
        Me._DataTextArray_103.Name = "_DataTextArray_103"
        Me._DataTextArray_103.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_103.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_103.TabIndex = 336
        Me._DataTextArray_103.Tag = "SecondaryPreTransfusionSampleQuantity"
        '
        '_DataTextArray_101
        '
        Me._DataTextArray_101.AcceptsReturn = True
        Me._DataTextArray_101.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_101.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_101.Enabled = False
        Me._DataTextArray_101.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_101.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_101, CType(101, Short))
        Me._DataTextArray_101.Location = New System.Drawing.Point(104, 160)
        Me._DataTextArray_101.MaxLength = 0
        Me._DataTextArray_101.Name = "_DataTextArray_101"
        Me._DataTextArray_101.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_101.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_101.TabIndex = 338
        Me._DataTextArray_101.Tag = "SecondaryPreTransfusionSampleHeldDate"
        '
        '_DataTextArray_100
        '
        Me._DataTextArray_100.AcceptsReturn = True
        Me._DataTextArray_100.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_100.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_100.Enabled = False
        Me._DataTextArray_100.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_100.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_100, CType(100, Short))
        Me._DataTextArray_100.Location = New System.Drawing.Point(104, 184)
        Me._DataTextArray_100.MaxLength = 0
        Me._DataTextArray_100.Name = "_DataTextArray_100"
        Me._DataTextArray_100.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_100.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_100.TabIndex = 339
        Me._DataTextArray_100.Tag = "SecondaryPreTransfusionSampleHeldTime"
        '
        '_DataTextArray_99
        '
        Me._DataTextArray_99.AcceptsReturn = True
        Me._DataTextArray_99.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_99.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_99.Enabled = False
        Me._DataTextArray_99.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_99.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_99, CType(99, Short))
        Me._DataTextArray_99.Location = New System.Drawing.Point(104, 208)
        Me._DataTextArray_99.MaxLength = 25
        Me._DataTextArray_99.Name = "_DataTextArray_99"
        Me._DataTextArray_99.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_99.Size = New System.Drawing.Size(193, 20)
        Me._DataTextArray_99.TabIndex = 340
        Me._DataTextArray_99.Tag = "SecondaryPreTransfusionSampleHeldTechnician"
        '
        '_DataLabelArray_142
        '
        Me._DataLabelArray_142.AutoSize = True
        Me._DataLabelArray_142.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_142.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_142.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_142.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_142, CType(142, Short))
        Me._DataLabelArray_142.Location = New System.Drawing.Point(8, 40)
        Me._DataLabelArray_142.Name = "_DataLabelArray_142"
        Me._DataLabelArray_142.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_142.Size = New System.Drawing.Size(94, 14)
        Me._DataLabelArray_142.TabIndex = 154
        Me._DataLabelArray_142.Tag = "lblSecondaryPreTransfusionSampleAvailable"
        Me._DataLabelArray_142.Text = "Sample Available?"
        '
        '_DataLabelArray_141
        '
        Me._DataLabelArray_141.AutoSize = True
        Me._DataLabelArray_141.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_141.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_141.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_141.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_141, CType(141, Short))
        Me._DataLabelArray_141.Location = New System.Drawing.Point(8, 16)
        Me._DataLabelArray_141.Name = "_DataLabelArray_141"
        Me._DataLabelArray_141.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_141.Size = New System.Drawing.Size(94, 14)
        Me._DataLabelArray_141.TabIndex = 153
        Me._DataLabelArray_141.Tag = "lblSecondaryPreTransfusionSampleRequired"
        Me._DataLabelArray_141.Text = "Sample Required?"
        '
        '_DataLabelArray_140
        '
        Me._DataLabelArray_140.AutoSize = True
        Me._DataLabelArray_140.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_140.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_140.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_140.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_140, CType(140, Short))
        Me._DataLabelArray_140.Location = New System.Drawing.Point(40, 64)
        Me._DataLabelArray_140.Name = "_DataLabelArray_140"
        Me._DataLabelArray_140.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_140.Size = New System.Drawing.Size(68, 14)
        Me._DataLabelArray_140.TabIndex = 152
        Me._DataLabelArray_140.Tag = "lblSecondaryPreTransfusionSampleDrawnDate"
        Me._DataLabelArray_140.Text = "Date Drawn:"
        '
        '_DataLabelArray_139
        '
        Me._DataLabelArray_139.AutoSize = True
        Me._DataLabelArray_139.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_139.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_139.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_139.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_139, CType(139, Short))
        Me._DataLabelArray_139.Location = New System.Drawing.Point(40, 88)
        Me._DataLabelArray_139.Name = "_DataLabelArray_139"
        Me._DataLabelArray_139.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_139.Size = New System.Drawing.Size(68, 14)
        Me._DataLabelArray_139.TabIndex = 151
        Me._DataLabelArray_139.Tag = "lbSecondaryPreTransfusionSampleDrawnTime"
        Me._DataLabelArray_139.Text = "Time Drawn:"
        '
        '_DataLabelArray_138
        '
        Me._DataLabelArray_138.AutoSize = True
        Me._DataLabelArray_138.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_138.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_138.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_138.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_138, CType(138, Short))
        Me._DataLabelArray_138.Location = New System.Drawing.Point(56, 112)
        Me._DataLabelArray_138.Name = "_DataLabelArray_138"
        Me._DataLabelArray_138.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_138.Size = New System.Drawing.Size(50, 14)
        Me._DataLabelArray_138.TabIndex = 150
        Me._DataLabelArray_138.Tag = "lblSecondaryPreTransfusionSampleQuantity"
        Me._DataLabelArray_138.Text = "Quantity:"
        '
        '_DataLabelArray_137
        '
        Me._DataLabelArray_137.AutoSize = True
        Me._DataLabelArray_137.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_137.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_137.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_137.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_137, CType(137, Short))
        Me._DataLabelArray_137.Location = New System.Drawing.Point(56, 136)
        Me._DataLabelArray_137.Name = "_DataLabelArray_137"
        Me._DataLabelArray_137.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_137.Size = New System.Drawing.Size(44, 14)
        Me._DataLabelArray_137.TabIndex = 149
        Me._DataLabelArray_137.Tag = "lblSecondaryPreTransfusionSampleHeldAt"
        Me._DataLabelArray_137.Text = "Held At:"
        '
        '_DataLabelArray_136
        '
        Me._DataLabelArray_136.AutoSize = True
        Me._DataLabelArray_136.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_136.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_136.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_136.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_136, CType(136, Short))
        Me._DataLabelArray_136.Location = New System.Drawing.Point(48, 160)
        Me._DataLabelArray_136.Name = "_DataLabelArray_136"
        Me._DataLabelArray_136.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_136.Size = New System.Drawing.Size(56, 14)
        Me._DataLabelArray_136.TabIndex = 148
        Me._DataLabelArray_136.Tag = "lblSecondaryPreTransfusionSampleHeldDate"
        Me._DataLabelArray_136.Text = "Held Date:"
        '
        '_DataLabelArray_135
        '
        Me._DataLabelArray_135.AutoSize = True
        Me._DataLabelArray_135.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_135.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_135.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_135.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_135, CType(135, Short))
        Me._DataLabelArray_135.Location = New System.Drawing.Point(48, 184)
        Me._DataLabelArray_135.Name = "_DataLabelArray_135"
        Me._DataLabelArray_135.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_135.Size = New System.Drawing.Size(56, 14)
        Me._DataLabelArray_135.TabIndex = 147
        Me._DataLabelArray_135.Tag = "lblSecondaryPreTransfusionSampleHeldTime"
        Me._DataLabelArray_135.Text = "Held Time:"
        '
        '_DataLabelArray_134
        '
        Me._DataLabelArray_134.AutoSize = True
        Me._DataLabelArray_134.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_134.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_134.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_134.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_134, CType(134, Short))
        Me._DataLabelArray_134.Location = New System.Drawing.Point(48, 208)
        Me._DataLabelArray_134.Name = "_DataLabelArray_134"
        Me._DataLabelArray_134.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_134.Size = New System.Drawing.Size(57, 14)
        Me._DataLabelArray_134.TabIndex = 146
        Me._DataLabelArray_134.Tag = "lblSecondaryPreTransfusionSampleHeldTechnician"
        Me._DataLabelArray_134.Text = "Held Tech:"
        '
        '_fmDataFrame_13
        '
        Me._fmDataFrame_13.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_13.Controls.Add(Me.cmdCallSheet)
        Me._fmDataFrame_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_13, CType(13, Short))
        Me._fmDataFrame_13.Location = New System.Drawing.Point(400, 60)
        Me._fmDataFrame_13.Name = "_fmDataFrame_13"
        Me._fmDataFrame_13.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_13.Size = New System.Drawing.Size(441, 497)
        Me._fmDataFrame_13.TabIndex = 613
        Me._fmDataFrame_13.TabStop = False
        Me._fmDataFrame_13.Tag = "t0NDRI Data"
        Me._fmDataFrame_13.Text = "NDRI Data - Tab 0"
        '
        'cmdCallSheet
        '
        Me.cmdCallSheet.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCallSheet.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCallSheet.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCallSheet.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCallSheet.Location = New System.Drawing.Point(16, 24)
        Me.cmdCallSheet.Name = "cmdCallSheet"
        Me.cmdCallSheet.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCallSheet.Size = New System.Drawing.Size(97, 25)
        Me.cmdCallSheet.TabIndex = 614
        Me.cmdCallSheet.Text = "Call Sheet"
        Me.cmdCallSheet.UseVisualStyleBackColor = False
        '
        '_fmDataFrame_6
        '
        Me._fmDataFrame_6.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_166)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_167)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_72)
        Me._fmDataFrame_6.Controls.Add(Me._DataComboArray_84)
        Me._fmDataFrame_6.Controls.Add(Me._DataComboArray_12)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_16)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_15)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_14)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_17)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_82)
        Me._fmDataFrame_6.Controls.Add(Me._DataTextArray_83)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_224)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_225)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_237)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_241)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_28)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_29)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_27)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_26)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_30)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_248)
        Me._fmDataFrame_6.Controls.Add(Me._DataLabelArray_249)
        Me._fmDataFrame_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_6, CType(6, Short))
        Me._fmDataFrame_6.Location = New System.Drawing.Point(400, 45)
        Me._fmDataFrame_6.Name = "_fmDataFrame_6"
        Me._fmDataFrame_6.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_6.Size = New System.Drawing.Size(441, 497)
        Me._fmDataFrame_6.TabIndex = 565
        Me._fmDataFrame_6.TabStop = False
        Me._fmDataFrame_6.Tag = "t0Unused"
        Me._fmDataFrame_6.Text = "Unused - Tab 0"
        '
        '_DataTextArray_166
        '
        Me._DataTextArray_166.AcceptsReturn = True
        Me._DataTextArray_166.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_166.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_166.Enabled = False
        Me._DataTextArray_166.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_166.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_166, CType(166, Short))
        Me._DataTextArray_166.Location = New System.Drawing.Point(112, 256)
        Me._DataTextArray_166.MaxLength = 25
        Me._DataTextArray_166.Name = "_DataTextArray_166"
        Me._DataTextArray_166.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_166.Size = New System.Drawing.Size(305, 20)
        Me._DataTextArray_166.TabIndex = 587
        Me._DataTextArray_166.Tag = "SecondaryBodyMedicalChartLocation"
        '
        '_DataTextArray_167
        '
        Me._DataTextArray_167.AcceptsReturn = True
        Me._DataTextArray_167.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_167.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_167.Enabled = False
        Me._DataTextArray_167.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_167.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_167, CType(167, Short))
        Me._DataTextArray_167.Location = New System.Drawing.Point(112, 280)
        Me._DataTextArray_167.MaxLength = 25
        Me._DataTextArray_167.Name = "_DataTextArray_167"
        Me._DataTextArray_167.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_167.Size = New System.Drawing.Size(305, 20)
        Me._DataTextArray_167.TabIndex = 586
        Me._DataTextArray_167.Tag = "SecondaryBodyIDTagLocation"
        '
        '_DataTextArray_72
        '
        Me._DataTextArray_72.AcceptsReturn = True
        Me._DataTextArray_72.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_72.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_72.Enabled = False
        Me._DataTextArray_72.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_72.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_72, CType(72, Short))
        Me._DataTextArray_72.Location = New System.Drawing.Point(112, 328)
        Me._DataTextArray_72.MaxLength = 0
        Me._DataTextArray_72.Multiline = True
        Me._DataTextArray_72.Name = "_DataTextArray_72"
        Me._DataTextArray_72.ReadOnly = True
        Me._DataTextArray_72.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_72.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_72.Size = New System.Drawing.Size(305, 59)
        Me._DataTextArray_72.TabIndex = 585
        Me._DataTextArray_72.Tag = "SecondaryBodyCareReminder"
        '
        '_DataComboArray_84
        '
        Me._DataComboArray_84.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_84.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_84.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_84.Enabled = False
        Me._DataComboArray_84.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_84.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_84, CType(84, Short))
        Me._DataComboArray_84.Location = New System.Drawing.Point(112, 392)
        Me._DataComboArray_84.Name = "_DataComboArray_84"
        Me._DataComboArray_84.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_84.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_84.TabIndex = 584
        Me._DataComboArray_84.Tag = "SecondaryBodyCareReminderYN"
        '
        '_DataComboArray_12
        '
        Me._DataComboArray_12.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_12.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_12.Enabled = False
        Me._DataComboArray_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_12.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_12, CType(12, Short))
        Me._DataComboArray_12.Location = New System.Drawing.Point(136, 72)
        Me._DataComboArray_12.Name = "_DataComboArray_12"
        Me._DataComboArray_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_12.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_12.TabIndex = 572
        Me._DataComboArray_12.Tag = "SecondaryPatientVent"
        '
        '_DataTextArray_16
        '
        Me._DataTextArray_16.AcceptsReturn = True
        Me._DataTextArray_16.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_16.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_16.Enabled = False
        Me._DataTextArray_16.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_16.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_16, CType(16, Short))
        Me._DataTextArray_16.Location = New System.Drawing.Point(136, 96)
        Me._DataTextArray_16.MaxLength = 0
        Me._DataTextArray_16.Name = "_DataTextArray_16"
        Me._DataTextArray_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_16.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_16.TabIndex = 571
        Me._DataTextArray_16.Tag = "SecondaryIntubationDate"
        '
        '_DataTextArray_15
        '
        Me._DataTextArray_15.AcceptsReturn = True
        Me._DataTextArray_15.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_15.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_15.Enabled = False
        Me._DataTextArray_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_15.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_15, CType(15, Short))
        Me._DataTextArray_15.Location = New System.Drawing.Point(136, 48)
        Me._DataTextArray_15.MaxLength = 25
        Me._DataTextArray_15.Name = "_DataTextArray_15"
        Me._DataTextArray_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_15.Size = New System.Drawing.Size(201, 20)
        Me._DataTextArray_15.TabIndex = 570
        Me._DataTextArray_15.Tag = "SecondaryCODSignedBy"
        '
        '_DataTextArray_14
        '
        Me._DataTextArray_14.AcceptsReturn = True
        Me._DataTextArray_14.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_14.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_14.Enabled = False
        Me._DataTextArray_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_14.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_14, CType(14, Short))
        Me._DataTextArray_14.Location = New System.Drawing.Point(136, 24)
        Me._DataTextArray_14.MaxLength = 0
        Me._DataTextArray_14.Name = "_DataTextArray_14"
        Me._DataTextArray_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_14.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_14.TabIndex = 569
        Me._DataTextArray_14.Tag = "SecondaryCODTime"
        '
        '_DataTextArray_17
        '
        Me._DataTextArray_17.AcceptsReturn = True
        Me._DataTextArray_17.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_17.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_17.Enabled = False
        Me._DataTextArray_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_17.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_17, CType(17, Short))
        Me._DataTextArray_17.Location = New System.Drawing.Point(136, 120)
        Me._DataTextArray_17.MaxLength = 0
        Me._DataTextArray_17.Name = "_DataTextArray_17"
        Me._DataTextArray_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_17.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_17.TabIndex = 568
        Me._DataTextArray_17.Tag = "SecondaryIntubationTime"
        '
        '_DataTextArray_82
        '
        Me._DataTextArray_82.AcceptsReturn = True
        Me._DataTextArray_82.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_82.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_82.Enabled = False
        Me._DataTextArray_82.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_82.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_82, CType(82, Short))
        Me._DataTextArray_82.Location = New System.Drawing.Point(136, 144)
        Me._DataTextArray_82.MaxLength = 0
        Me._DataTextArray_82.Name = "_DataTextArray_82"
        Me._DataTextArray_82.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_82.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_82.TabIndex = 567
        Me._DataTextArray_82.Tag = "SecondaryExtubationDate"
        '
        '_DataTextArray_83
        '
        Me._DataTextArray_83.AcceptsReturn = True
        Me._DataTextArray_83.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_83.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_83.Enabled = False
        Me._DataTextArray_83.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_83.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_83, CType(83, Short))
        Me._DataTextArray_83.Location = New System.Drawing.Point(136, 168)
        Me._DataTextArray_83.MaxLength = 0
        Me._DataTextArray_83.Name = "_DataTextArray_83"
        Me._DataTextArray_83.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_83.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_83.TabIndex = 566
        Me._DataTextArray_83.Tag = "SecondaryExtubationTime"
        '
        '_DataLabelArray_224
        '
        Me._DataLabelArray_224.AutoSize = True
        Me._DataLabelArray_224.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_224.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_224.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_224.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_224, CType(224, Short))
        Me._DataLabelArray_224.Location = New System.Drawing.Point(8, 256)
        Me._DataLabelArray_224.Name = "_DataLabelArray_224"
        Me._DataLabelArray_224.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_224.Size = New System.Drawing.Size(103, 14)
        Me._DataLabelArray_224.TabIndex = 591
        Me._DataLabelArray_224.Tag = "lblSecondaryBodyMedicalChartLocation"
        Me._DataLabelArray_224.Text = "Med Chart Location:"
        '
        '_DataLabelArray_225
        '
        Me._DataLabelArray_225.AutoSize = True
        Me._DataLabelArray_225.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_225.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_225.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_225.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_225, CType(225, Short))
        Me._DataLabelArray_225.Location = New System.Drawing.Point(24, 280)
        Me._DataLabelArray_225.Name = "_DataLabelArray_225"
        Me._DataLabelArray_225.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_225.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_225.TabIndex = 590
        Me._DataLabelArray_225.Tag = "lblSecondaryBodyIDTagLocation"
        Me._DataLabelArray_225.Text = "ID Tag Location:"
        '
        '_DataLabelArray_237
        '
        Me._DataLabelArray_237.AutoSize = True
        Me._DataLabelArray_237.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_237.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_237.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_237.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_237, CType(237, Short))
        Me._DataLabelArray_237.Location = New System.Drawing.Point(56, 328)
        Me._DataLabelArray_237.Name = "_DataLabelArray_237"
        Me._DataLabelArray_237.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_237.Size = New System.Drawing.Size(55, 14)
        Me._DataLabelArray_237.TabIndex = 589
        Me._DataLabelArray_237.Tag = "lblSecondaryBodyCareReminder"
        Me._DataLabelArray_237.Text = "Reminder:"
        '
        '_DataLabelArray_241
        '
        Me._DataLabelArray_241.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_241.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_241.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_241.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_241, CType(241, Short))
        Me._DataLabelArray_241.Location = New System.Drawing.Point(32, 392)
        Me._DataLabelArray_241.Name = "_DataLabelArray_241"
        Me._DataLabelArray_241.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_241.Size = New System.Drawing.Size(81, 17)
        Me._DataLabelArray_241.TabIndex = 588
        Me._DataLabelArray_241.Tag = "lblSecondaryBodyCareReminderYN"
        Me._DataLabelArray_241.Text = "Reminder (Y/N):"
        '
        '_DataLabelArray_28
        '
        Me._DataLabelArray_28.AutoSize = True
        Me._DataLabelArray_28.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_28.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_28, CType(28, Short))
        Me._DataLabelArray_28.Location = New System.Drawing.Point(43, 74)
        Me._DataLabelArray_28.Name = "_DataLabelArray_28"
        Me._DataLabelArray_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_28.Size = New System.Drawing.Size(95, 14)
        Me._DataLabelArray_28.TabIndex = 579
        Me._DataLabelArray_28.Tag = "lblSecondaryVentilated"
        Me._DataLabelArray_28.Text = "Patient Ventilated?"
        '
        '_DataLabelArray_29
        '
        Me._DataLabelArray_29.AutoSize = True
        Me._DataLabelArray_29.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_29.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_29, CType(29, Short))
        Me._DataLabelArray_29.Location = New System.Drawing.Point(58, 98)
        Me._DataLabelArray_29.Name = "_DataLabelArray_29"
        Me._DataLabelArray_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_29.Size = New System.Drawing.Size(81, 14)
        Me._DataLabelArray_29.TabIndex = 578
        Me._DataLabelArray_29.Tag = "lblSecondaryIntubationDate"
        Me._DataLabelArray_29.Text = "Intubation Date:"
        '
        '_DataLabelArray_27
        '
        Me._DataLabelArray_27.AutoSize = True
        Me._DataLabelArray_27.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_27.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_27, CType(27, Short))
        Me._DataLabelArray_27.Location = New System.Drawing.Point(45, 50)
        Me._DataLabelArray_27.Name = "_DataLabelArray_27"
        Me._DataLabelArray_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_27.Size = New System.Drawing.Size(94, 14)
        Me._DataLabelArray_27.TabIndex = 577
        Me._DataLabelArray_27.Tag = "lblSecondaryCODSignedBy"
        Me._DataLabelArray_27.Text = "Who will sign DC?"
        '
        '_DataLabelArray_26
        '
        Me._DataLabelArray_26.AutoSize = True
        Me._DataLabelArray_26.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_26.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_26, CType(26, Short))
        Me._DataLabelArray_26.Location = New System.Drawing.Point(16, 26)
        Me._DataLabelArray_26.Name = "_DataLabelArray_26"
        Me._DataLabelArray_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_26.Size = New System.Drawing.Size(123, 14)
        Me._DataLabelArray_26.TabIndex = 576
        Me._DataLabelArray_26.Tag = "lblSecondaryCODTime"
        Me._DataLabelArray_26.Text = "When COD Determined?"
        '
        '_DataLabelArray_30
        '
        Me._DataLabelArray_30.AutoSize = True
        Me._DataLabelArray_30.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_30.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_30, CType(30, Short))
        Me._DataLabelArray_30.Location = New System.Drawing.Point(58, 122)
        Me._DataLabelArray_30.Name = "_DataLabelArray_30"
        Me._DataLabelArray_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_30.Size = New System.Drawing.Size(81, 14)
        Me._DataLabelArray_30.TabIndex = 575
        Me._DataLabelArray_30.Tag = "lblSecondaryIntubationTime"
        Me._DataLabelArray_30.Text = "Intubation Time:"
        '
        '_DataLabelArray_248
        '
        Me._DataLabelArray_248.AutoSize = True
        Me._DataLabelArray_248.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_248.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_248.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_248.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_248, CType(248, Short))
        Me._DataLabelArray_248.Location = New System.Drawing.Point(54, 146)
        Me._DataLabelArray_248.Name = "_DataLabelArray_248"
        Me._DataLabelArray_248.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_248.Size = New System.Drawing.Size(85, 14)
        Me._DataLabelArray_248.TabIndex = 574
        Me._DataLabelArray_248.Tag = "lblSecondaryExtubationDate"
        Me._DataLabelArray_248.Text = "Extubation Date:"
        '
        '_DataLabelArray_249
        '
        Me._DataLabelArray_249.AutoSize = True
        Me._DataLabelArray_249.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_249.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_249.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_249.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_249, CType(249, Short))
        Me._DataLabelArray_249.Location = New System.Drawing.Point(54, 170)
        Me._DataLabelArray_249.Name = "_DataLabelArray_249"
        Me._DataLabelArray_249.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_249.Size = New System.Drawing.Size(85, 14)
        Me._DataLabelArray_249.TabIndex = 573
        Me._DataLabelArray_249.Tag = "lblSecondaryExtubationTime"
        Me._DataLabelArray_249.Text = "Extubation Time:"
        '
        '_fmDataFrame_23
        '
        Me._fmDataFrame_23.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_23.Controls.Add(Me.fmCreateMedication)
        Me._fmDataFrame_23.Controls.Add(Me._DataComboArray_15)
        Me._fmDataFrame_23.Controls.Add(Me._DataFrameArray_0)
        Me._fmDataFrame_23.Controls.Add(Me._DataLabelArray_42)
        Me._fmDataFrame_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_23, CType(23, Short))
        Me._fmDataFrame_23.Location = New System.Drawing.Point(400, 15)
        Me._fmDataFrame_23.Name = "_fmDataFrame_23"
        Me._fmDataFrame_23.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_23.Size = New System.Drawing.Size(441, 561)
        Me._fmDataFrame_23.TabIndex = 526
        Me._fmDataFrame_23.TabStop = False
        Me._fmDataFrame_23.Tag = "t0Medications"
        Me._fmDataFrame_23.Text = "Medications - Tab 0"
        '
        'fmCreateMedication
        '
        Me.fmCreateMedication.BackColor = System.Drawing.SystemColors.Control
        Me.fmCreateMedication.Controls.Add(Me.cmdCreateMedication)
        Me.fmCreateMedication.Controls.Add(Me.txtMedicationName)
        Me.fmCreateMedication.Controls.Add(Me.lblCreateMedication)
        Me.fmCreateMedication.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmCreateMedication.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmCreateMedication.Location = New System.Drawing.Point(8, 304)
        Me.fmCreateMedication.Name = "fmCreateMedication"
        Me.fmCreateMedication.Padding = New System.Windows.Forms.Padding(0)
        Me.fmCreateMedication.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmCreateMedication.Size = New System.Drawing.Size(409, 41)
        Me.fmCreateMedication.TabIndex = 582
        Me.fmCreateMedication.TabStop = False
        '
        'cmdCreateMedication
        '
        Me.cmdCreateMedication.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCreateMedication.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCreateMedication.Enabled = False
        Me.cmdCreateMedication.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCreateMedication.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCreateMedication.Location = New System.Drawing.Point(344, 16)
        Me.cmdCreateMedication.Name = "cmdCreateMedication"
        Me.cmdCreateMedication.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCreateMedication.Size = New System.Drawing.Size(57, 19)
        Me.cmdCreateMedication.TabIndex = 547
        Me.cmdCreateMedication.Text = "Create"
        Me.cmdCreateMedication.UseVisualStyleBackColor = False
        '
        'txtMedicationName
        '
        Me.txtMedicationName.AcceptsReturn = True
        Me.txtMedicationName.BackColor = System.Drawing.SystemColors.Window
        Me.txtMedicationName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMedicationName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtMedicationName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtMedicationName.Location = New System.Drawing.Point(112, 16)
        Me.txtMedicationName.MaxLength = 25
        Me.txtMedicationName.Name = "txtMedicationName"
        Me.txtMedicationName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMedicationName.Size = New System.Drawing.Size(225, 20)
        Me.txtMedicationName.TabIndex = 546
        '
        'lblCreateMedication
        '
        Me.lblCreateMedication.AutoSize = True
        Me.lblCreateMedication.BackColor = System.Drawing.SystemColors.Control
        Me.lblCreateMedication.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCreateMedication.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCreateMedication.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblCreateMedication.Location = New System.Drawing.Point(8, 16)
        Me.lblCreateMedication.Name = "lblCreateMedication"
        Me.lblCreateMedication.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCreateMedication.Size = New System.Drawing.Size(91, 14)
        Me.lblCreateMedication.TabIndex = 583
        Me.lblCreateMedication.Text = "Medication Name:"
        '
        '_DataComboArray_15
        '
        Me._DataComboArray_15.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_15.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_15.Enabled = False
        Me._DataComboArray_15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_15.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_15, CType(15, Short))
        Me._DataComboArray_15.Location = New System.Drawing.Point(88, 24)
        Me._DataComboArray_15.Name = "_DataComboArray_15"
        Me._DataComboArray_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_15.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_15.TabIndex = 540
        Me._DataComboArray_15.Tag = "SecondaryMedication"
        '
        '_DataFrameArray_0
        '
        Me._DataFrameArray_0.BackColor = System.Drawing.SystemColors.Control
        Me._DataFrameArray_0.Controls.Add(Me.lstSelectedMeds)
        Me._DataFrameArray_0.Controls.Add(Me.lstAvailableMeds)
        Me._DataFrameArray_0.Controls.Add(Me.cmdAddMedication)
        Me._DataFrameArray_0.Controls.Add(Me.cmdRemoveMedication)
        Me._DataFrameArray_0.Controls.Add(Me._DataRTFArray_6)
        Me._DataFrameArray_0.Controls.Add(Me.lblSecondaryAdditionalMedications)
        Me._DataFrameArray_0.Controls.Add(Me.Label17)
        Me._DataFrameArray_0.Controls.Add(Me.Label18)
        Me._DataFrameArray_0.Enabled = False
        Me._DataFrameArray_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataFrameArray_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataFrameArray.SetIndex(Me._DataFrameArray_0, CType(0, Short))
        Me._DataFrameArray_0.Location = New System.Drawing.Point(8, 48)
        Me._DataFrameArray_0.Name = "_DataFrameArray_0"
        Me._DataFrameArray_0.Padding = New System.Windows.Forms.Padding(0)
        Me._DataFrameArray_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataFrameArray_0.Size = New System.Drawing.Size(409, 257)
        Me._DataFrameArray_0.TabIndex = 548
        Me._DataFrameArray_0.TabStop = False
        Me._DataFrameArray_0.Tag = "SecondaryMedicationList"
        '
        'lstSelectedMeds
        '
        Me.lstSelectedMeds.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me.lstSelectedMeds.Cursor = System.Windows.Forms.Cursors.Default
        Me.lstSelectedMeds.Enabled = False
        Me.lstSelectedMeds.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lstSelectedMeds.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lstSelectedMeds.ItemHeight = 14
        Me.lstSelectedMeds.Location = New System.Drawing.Point(240, 32)
        Me.lstSelectedMeds.Name = "lstSelectedMeds"
        Me.lstSelectedMeds.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lstSelectedMeds.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lstSelectedMeds.Size = New System.Drawing.Size(161, 144)
        Me.lstSelectedMeds.Sorted = True
        Me.lstSelectedMeds.TabIndex = 544
        '
        'lstAvailableMeds
        '
        Me.lstAvailableMeds.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me.lstAvailableMeds.Cursor = System.Windows.Forms.Cursors.Default
        Me.lstAvailableMeds.Enabled = False
        Me.lstAvailableMeds.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lstAvailableMeds.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lstAvailableMeds.ItemHeight = 14
        Me.lstAvailableMeds.Location = New System.Drawing.Point(8, 32)
        Me.lstAvailableMeds.Name = "lstAvailableMeds"
        Me.lstAvailableMeds.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lstAvailableMeds.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lstAvailableMeds.Size = New System.Drawing.Size(153, 214)
        Me.lstAvailableMeds.Sorted = True
        Me.lstAvailableMeds.TabIndex = 541
        '
        'cmdAddMedication
        '
        Me.cmdAddMedication.BackColor = System.Drawing.SystemColors.Control
        Me.cmdAddMedication.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdAddMedication.Enabled = False
        Me.cmdAddMedication.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdAddMedication.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdAddMedication.Location = New System.Drawing.Point(164, 64)
        Me.cmdAddMedication.Name = "cmdAddMedication"
        Me.cmdAddMedication.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdAddMedication.Size = New System.Drawing.Size(71, 25)
        Me.cmdAddMedication.TabIndex = 542
        Me.cmdAddMedication.Text = "Add >>"
        Me.cmdAddMedication.UseVisualStyleBackColor = False
        '
        'cmdRemoveMedication
        '
        Me.cmdRemoveMedication.AutoSize = True
        Me.cmdRemoveMedication.BackColor = System.Drawing.SystemColors.Control
        Me.cmdRemoveMedication.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdRemoveMedication.Enabled = False
        Me.cmdRemoveMedication.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdRemoveMedication.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdRemoveMedication.Location = New System.Drawing.Point(164, 96)
        Me.cmdRemoveMedication.Name = "cmdRemoveMedication"
        Me.cmdRemoveMedication.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdRemoveMedication.Size = New System.Drawing.Size(71, 25)
        Me.cmdRemoveMedication.TabIndex = 543
        Me.cmdRemoveMedication.Text = "<< Remove"
        Me.cmdRemoveMedication.UseVisualStyleBackColor = False
        '
        '_DataRTFArray_6
        '
        Me._DataRTFArray_6.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataRTFArray_6.Enabled = False
        Me._DataRTFArray_6.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DataRTFArray.SetIndex(Me._DataRTFArray_6, CType(6, Short))
        Me._DataRTFArray_6.Location = New System.Drawing.Point(240, 184)
        Me._DataRTFArray_6.MaxLength = 150
        Me._DataRTFArray_6.Name = "_DataRTFArray_6"
        Me._DataRTFArray_6.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me._DataRTFArray_6.Size = New System.Drawing.Size(161, 63)
        Me._DataRTFArray_6.TabIndex = 545
        Me._DataRTFArray_6.Tag = "SecondaryAdditionalMedications"
        Me._DataRTFArray_6.Text = ""
        '
        'lblSecondaryAdditionalMedications
        '
        Me.lblSecondaryAdditionalMedications.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryAdditionalMedications.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryAdditionalMedications.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryAdditionalMedications.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryAdditionalMedications.Location = New System.Drawing.Point(176, 184)
        Me.lblSecondaryAdditionalMedications.Name = "lblSecondaryAdditionalMedications"
        Me.lblSecondaryAdditionalMedications.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryAdditionalMedications.Size = New System.Drawing.Size(65, 33)
        Me.lblSecondaryAdditionalMedications.TabIndex = 581
        Me.lblSecondaryAdditionalMedications.Text = "Additional Medications:"
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.BackColor = System.Drawing.SystemColors.Control
        Me.Label17.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label17.Location = New System.Drawing.Point(8, 16)
        Me.Label17.Name = "Label17"
        Me.Label17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label17.Size = New System.Drawing.Size(114, 14)
        Me.Label17.TabIndex = 539
        Me.Label17.Text = "Available Medications:"
        '
        'Label18
        '
        Me.Label18.AutoSize = True
        Me.Label18.BackColor = System.Drawing.SystemColors.Control
        Me.Label18.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label18.Location = New System.Drawing.Point(240, 16)
        Me.Label18.Name = "Label18"
        Me.Label18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label18.Size = New System.Drawing.Size(112, 14)
        Me.Label18.TabIndex = 538
        Me.Label18.Text = "Selected Medications:"
        '
        '_DataLabelArray_42
        '
        Me._DataLabelArray_42.AutoSize = True
        Me._DataLabelArray_42.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_42.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_42.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_42.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_42, CType(42, Short))
        Me._DataLabelArray_42.Location = New System.Drawing.Point(16, 27)
        Me._DataLabelArray_42.Name = "_DataLabelArray_42"
        Me._DataLabelArray_42.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_42.Size = New System.Drawing.Size(70, 14)
        Me._DataLabelArray_42.TabIndex = 549
        Me._DataLabelArray_42.Tag = "lblSecondaryMedication"
        Me._DataLabelArray_42.Text = "Medications?"
        '
        '_fmDataFrame_1
        '
        Me._fmDataFrame_1.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_110)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_117)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_116)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_115)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_114)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_113)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_112)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_111)
        Me._fmDataFrame_1.Controls.Add(Me._DataTextArray_118)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_156)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_155)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_154)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_153)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_152)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_151)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_150)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_149)
        Me._fmDataFrame_1.Controls.Add(Me._DataLabelArray_144)
        Me._fmDataFrame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_1, CType(1, Short))
        Me._fmDataFrame_1.Location = New System.Drawing.Point(480, 93)
        Me._fmDataFrame_1.Name = "_fmDataFrame_1"
        Me._fmDataFrame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_1.Size = New System.Drawing.Size(441, 297)
        Me._fmDataFrame_1.TabIndex = 60
        Me._fmDataFrame_1.TabStop = False
        Me._fmDataFrame_1.Tag = "t0Labs"
        Me._fmDataFrame_1.Text = "Labs - Tab 0"
        Me._fmDataFrame_1.Visible = False
        '
        '_DataTextArray_110
        '
        Me._DataTextArray_110.AcceptsReturn = True
        Me._DataTextArray_110.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_110.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_110.Enabled = False
        Me._DataTextArray_110.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_110.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_110, CType(110, Short))
        Me._DataTextArray_110.Location = New System.Drawing.Point(88, 16)
        Me._DataTextArray_110.MaxLength = 25
        Me._DataTextArray_110.Name = "_DataTextArray_110"
        Me._DataTextArray_110.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_110.Size = New System.Drawing.Size(169, 20)
        Me._DataTextArray_110.TabIndex = 346
        Me._DataTextArray_110.Tag = "SecondaryWBC1"
        '
        '_DataTextArray_117
        '
        Me._DataTextArray_117.AcceptsReturn = True
        Me._DataTextArray_117.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_117.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_117.Enabled = False
        Me._DataTextArray_117.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_117.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_117, CType(117, Short))
        Me._DataTextArray_117.Location = New System.Drawing.Point(88, 40)
        Me._DataTextArray_117.MaxLength = 0
        Me._DataTextArray_117.Name = "_DataTextArray_117"
        Me._DataTextArray_117.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_117.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_117.TabIndex = 347
        Me._DataTextArray_117.Tag = "SecondaryWBC1Date"
        '
        '_DataTextArray_116
        '
        Me._DataTextArray_116.AcceptsReturn = True
        Me._DataTextArray_116.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_116.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_116.Enabled = False
        Me._DataTextArray_116.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_116.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_116, CType(116, Short))
        Me._DataTextArray_116.Location = New System.Drawing.Point(88, 64)
        Me._DataTextArray_116.MaxLength = 25
        Me._DataTextArray_116.Name = "_DataTextArray_116"
        Me._DataTextArray_116.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_116.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_116.TabIndex = 348
        Me._DataTextArray_116.Tag = "SecondaryWBC1Bands"
        '
        '_DataTextArray_115
        '
        Me._DataTextArray_115.AcceptsReturn = True
        Me._DataTextArray_115.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_115.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_115.Enabled = False
        Me._DataTextArray_115.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_115.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_115, CType(115, Short))
        Me._DataTextArray_115.Location = New System.Drawing.Point(88, 88)
        Me._DataTextArray_115.MaxLength = 25
        Me._DataTextArray_115.Name = "_DataTextArray_115"
        Me._DataTextArray_115.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_115.Size = New System.Drawing.Size(169, 20)
        Me._DataTextArray_115.TabIndex = 349
        Me._DataTextArray_115.Tag = "SecondaryWBC2"
        '
        '_DataTextArray_114
        '
        Me._DataTextArray_114.AcceptsReturn = True
        Me._DataTextArray_114.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_114.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_114.Enabled = False
        Me._DataTextArray_114.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_114.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_114, CType(114, Short))
        Me._DataTextArray_114.Location = New System.Drawing.Point(88, 112)
        Me._DataTextArray_114.MaxLength = 0
        Me._DataTextArray_114.Name = "_DataTextArray_114"
        Me._DataTextArray_114.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_114.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_114.TabIndex = 350
        Me._DataTextArray_114.Tag = "SecondaryWBC2Date"
        '
        '_DataTextArray_113
        '
        Me._DataTextArray_113.AcceptsReturn = True
        Me._DataTextArray_113.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_113.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_113.Enabled = False
        Me._DataTextArray_113.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_113.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_113, CType(113, Short))
        Me._DataTextArray_113.Location = New System.Drawing.Point(88, 136)
        Me._DataTextArray_113.MaxLength = 25
        Me._DataTextArray_113.Name = "_DataTextArray_113"
        Me._DataTextArray_113.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_113.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_113.TabIndex = 351
        Me._DataTextArray_113.Tag = "SecondaryWBC2Bands"
        '
        '_DataTextArray_112
        '
        Me._DataTextArray_112.AcceptsReturn = True
        Me._DataTextArray_112.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_112.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_112.Enabled = False
        Me._DataTextArray_112.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_112.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_112, CType(112, Short))
        Me._DataTextArray_112.Location = New System.Drawing.Point(88, 160)
        Me._DataTextArray_112.MaxLength = 25
        Me._DataTextArray_112.Name = "_DataTextArray_112"
        Me._DataTextArray_112.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_112.Size = New System.Drawing.Size(169, 20)
        Me._DataTextArray_112.TabIndex = 352
        Me._DataTextArray_112.Tag = "SecondaryWBC3"
        '
        '_DataTextArray_111
        '
        Me._DataTextArray_111.AcceptsReturn = True
        Me._DataTextArray_111.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_111.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_111.Enabled = False
        Me._DataTextArray_111.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_111.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_111, CType(111, Short))
        Me._DataTextArray_111.Location = New System.Drawing.Point(88, 184)
        Me._DataTextArray_111.MaxLength = 0
        Me._DataTextArray_111.Name = "_DataTextArray_111"
        Me._DataTextArray_111.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_111.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_111.TabIndex = 353
        Me._DataTextArray_111.Tag = "SecondaryWBC3Date"
        '
        '_DataTextArray_118
        '
        Me._DataTextArray_118.AcceptsReturn = True
        Me._DataTextArray_118.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_118.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_118.Enabled = False
        Me._DataTextArray_118.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_118.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_118, CType(118, Short))
        Me._DataTextArray_118.Location = New System.Drawing.Point(88, 208)
        Me._DataTextArray_118.MaxLength = 25
        Me._DataTextArray_118.Name = "_DataTextArray_118"
        Me._DataTextArray_118.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_118.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_118.TabIndex = 354
        Me._DataTextArray_118.Tag = "SecondaryWBC3Bands"
        '
        '_DataLabelArray_156
        '
        Me._DataLabelArray_156.AutoSize = True
        Me._DataLabelArray_156.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_156.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_156.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_156.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_156, CType(156, Short))
        Me._DataLabelArray_156.Location = New System.Drawing.Point(40, 16)
        Me._DataLabelArray_156.Name = "_DataLabelArray_156"
        Me._DataLabelArray_156.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_156.Size = New System.Drawing.Size(43, 14)
        Me._DataLabelArray_156.TabIndex = 169
        Me._DataLabelArray_156.Tag = "lblSecondaryWBC1"
        Me._DataLabelArray_156.Text = "WBC 1:"
        '
        '_DataLabelArray_155
        '
        Me._DataLabelArray_155.AutoSize = True
        Me._DataLabelArray_155.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_155.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_155.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_155.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_155, CType(155, Short))
        Me._DataLabelArray_155.Location = New System.Drawing.Point(16, 40)
        Me._DataLabelArray_155.Name = "_DataLabelArray_155"
        Me._DataLabelArray_155.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_155.Size = New System.Drawing.Size(68, 14)
        Me._DataLabelArray_155.TabIndex = 168
        Me._DataLabelArray_155.Tag = "lblSecondaryWBC1Date"
        Me._DataLabelArray_155.Text = "WBC 1 Date:"
        '
        '_DataLabelArray_154
        '
        Me._DataLabelArray_154.AutoSize = True
        Me._DataLabelArray_154.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_154.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_154.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_154.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_154, CType(154, Short))
        Me._DataLabelArray_154.Location = New System.Drawing.Point(16, 64)
        Me._DataLabelArray_154.Name = "_DataLabelArray_154"
        Me._DataLabelArray_154.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_154.Size = New System.Drawing.Size(68, 14)
        Me._DataLabelArray_154.TabIndex = 167
        Me._DataLabelArray_154.Tag = "lblSecondaryWBC1Bands"
        Me._DataLabelArray_154.Text = "WBC Bands:"
        '
        '_DataLabelArray_153
        '
        Me._DataLabelArray_153.AutoSize = True
        Me._DataLabelArray_153.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_153.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_153.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_153.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_153, CType(153, Short))
        Me._DataLabelArray_153.Location = New System.Drawing.Point(8, 88)
        Me._DataLabelArray_153.Name = "_DataLabelArray_153"
        Me._DataLabelArray_153.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_153.Size = New System.Drawing.Size(73, 14)
        Me._DataLabelArray_153.TabIndex = 166
        Me._DataLabelArray_153.Tag = "lblSecondaryWBC2"
        Me._DataLabelArray_153.Text = "WBC 2 Name:"
        '
        '_DataLabelArray_152
        '
        Me._DataLabelArray_152.AutoSize = True
        Me._DataLabelArray_152.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_152.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_152.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_152.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_152, CType(152, Short))
        Me._DataLabelArray_152.Location = New System.Drawing.Point(16, 112)
        Me._DataLabelArray_152.Name = "_DataLabelArray_152"
        Me._DataLabelArray_152.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_152.Size = New System.Drawing.Size(68, 14)
        Me._DataLabelArray_152.TabIndex = 165
        Me._DataLabelArray_152.Tag = "lblSecondaryWBC2Date"
        Me._DataLabelArray_152.Text = "WBC 2 Date:"
        '
        '_DataLabelArray_151
        '
        Me._DataLabelArray_151.AutoSize = True
        Me._DataLabelArray_151.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_151.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_151.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_151.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_151, CType(151, Short))
        Me._DataLabelArray_151.Location = New System.Drawing.Point(8, 136)
        Me._DataLabelArray_151.Name = "_DataLabelArray_151"
        Me._DataLabelArray_151.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_151.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_151.TabIndex = 164
        Me._DataLabelArray_151.Tag = "lblSecondaryWBC2Bands"
        Me._DataLabelArray_151.Text = "WBC 2 Bands:"
        '
        '_DataLabelArray_150
        '
        Me._DataLabelArray_150.AutoSize = True
        Me._DataLabelArray_150.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_150.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_150.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_150.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_150, CType(150, Short))
        Me._DataLabelArray_150.Location = New System.Drawing.Point(40, 160)
        Me._DataLabelArray_150.Name = "_DataLabelArray_150"
        Me._DataLabelArray_150.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_150.Size = New System.Drawing.Size(43, 14)
        Me._DataLabelArray_150.TabIndex = 163
        Me._DataLabelArray_150.Tag = "lblSecondaryWBC3"
        Me._DataLabelArray_150.Text = "WBC 3:"
        '
        '_DataLabelArray_149
        '
        Me._DataLabelArray_149.AutoSize = True
        Me._DataLabelArray_149.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_149.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_149.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_149.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_149, CType(149, Short))
        Me._DataLabelArray_149.Location = New System.Drawing.Point(16, 184)
        Me._DataLabelArray_149.Name = "_DataLabelArray_149"
        Me._DataLabelArray_149.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_149.Size = New System.Drawing.Size(68, 14)
        Me._DataLabelArray_149.TabIndex = 162
        Me._DataLabelArray_149.Tag = "lblSecondaryWBC3Date"
        Me._DataLabelArray_149.Text = "WBC 3 Date:"
        '
        '_DataLabelArray_144
        '
        Me._DataLabelArray_144.AutoSize = True
        Me._DataLabelArray_144.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_144.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_144.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_144.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_144, CType(144, Short))
        Me._DataLabelArray_144.Location = New System.Drawing.Point(8, 208)
        Me._DataLabelArray_144.Name = "_DataLabelArray_144"
        Me._DataLabelArray_144.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_144.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_144.TabIndex = 161
        Me._DataLabelArray_144.Tag = "lblSecondaryWBC3Bands"
        Me._DataLabelArray_144.Text = "WBC 3 Bands:"
        '
        '_fmDataFrame_0
        '
        Me._fmDataFrame_0.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_0.Controls.Add(Me.cmdContactDetail)
        Me._fmDataFrame_0.Controls.Add(Me.cmdHospital)
        Me._fmDataFrame_0.Controls.Add(Me._DataTextArray_7)
        Me._fmDataFrame_0.Controls.Add(Me._DataTextArray_251)
        Me._fmDataFrame_0.Controls.Add(Me.cmdOrganizationDetail)
        Me._fmDataFrame_0.Controls.Add(Me._DataTextArray_30)
        Me._fmDataFrame_0.Controls.Add(Me._DataTextArray_6)
        Me._fmDataFrame_0.Controls.Add(Me._DataComboArray_6)
        Me._fmDataFrame_0.Controls.Add(Me._DataComboArray_5)
        Me._fmDataFrame_0.Controls.Add(Me._DataTextArray_4)
        Me._fmDataFrame_0.Controls.Add(Me._DataTextArray_250)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_44)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_14)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_13)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_12)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_11)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_9)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_250)
        Me._fmDataFrame_0.Controls.Add(Me._DataLabelArray_8)
        Me._fmDataFrame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_0, CType(0, Short))
        Me._fmDataFrame_0.Location = New System.Drawing.Point(480, 272)
        Me._fmDataFrame_0.Name = "_fmDataFrame_0"
        Me._fmDataFrame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_0.Size = New System.Drawing.Size(441, 305)
        Me._fmDataFrame_0.TabIndex = 59
        Me._fmDataFrame_0.TabStop = False
        Me._fmDataFrame_0.Tag = "t0Patient Info"
        Me._fmDataFrame_0.Text = "Patient Info - Tab 0"
        Me._fmDataFrame_0.Visible = False
        '
        'cmdContactDetail
        '
        Me.cmdContactDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdContactDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdContactDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdContactDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdContactDetail.Location = New System.Drawing.Point(408, 88)
        Me.cmdContactDetail.Name = "cmdContactDetail"
        Me.cmdContactDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdContactDetail.Size = New System.Drawing.Size(25, 19)
        Me.cmdContactDetail.TabIndex = 521
        Me.cmdContactDetail.Text = "..."
        Me.cmdContactDetail.UseVisualStyleBackColor = False
        '
        'cmdHospital
        '
        Me.cmdHospital.BackColor = System.Drawing.SystemColors.Control
        Me.cmdHospital.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdHospital.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdHospital.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdHospital.Location = New System.Drawing.Point(338, 40)
        Me.cmdHospital.Name = "cmdHospital"
        Me.cmdHospital.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdHospital.Size = New System.Drawing.Size(95, 20)
        Me.cmdHospital.TabIndex = 520
        Me.cmdHospital.Text = "Contact Hospital"
        Me.cmdHospital.UseVisualStyleBackColor = False
        '
        '_DataTextArray_7
        '
        Me._DataTextArray_7.AcceptsReturn = True
        Me._DataTextArray_7.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_7.Enabled = False
        Me._DataTextArray_7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_7, CType(7, Short))
        Me._DataTextArray_7.Location = New System.Drawing.Point(104, 16)
        Me._DataTextArray_7.MaxLength = 0
        Me._DataTextArray_7.Name = "_DataTextArray_7"
        Me._DataTextArray_7.ReadOnly = True
        Me._DataTextArray_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_7.Size = New System.Drawing.Size(257, 20)
        Me._DataTextArray_7.TabIndex = 512
        Me._DataTextArray_7.Tag = "SecondaryPatientHospitalName"
        '
        '_DataTextArray_251
        '
        Me._DataTextArray_251.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_251.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_251.Enabled = True
        Me._DataTextArray_251.BackColor = System.Drawing.ColorTranslator.FromOle(&H80000005)
        Me._DataTextArray_251.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_251.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_251, CType(251, Short))
        Me._DataTextArray_251.Location = New System.Drawing.Point(304, 64)
        Me._DataTextArray_251.Name = "_DataTextArray_251"
        Me._DataTextArray_251.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_251.Size = New System.Drawing.Size(57, 22)
        Me._DataTextArray_251.TabIndex = 515
        Me._DataTextArray_251.Tag = "SecondaryPatientHospitalFloor"
        '
        'cmdOrganizationDetail
        '
        Me.cmdOrganizationDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdOrganizationDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdOrganizationDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdOrganizationDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOrganizationDetail.Location = New System.Drawing.Point(366, 16)
        Me.cmdOrganizationDetail.Name = "cmdOrganizationDetail"
        Me.cmdOrganizationDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOrganizationDetail.Size = New System.Drawing.Size(22, 19)
        Me.cmdOrganizationDetail.TabIndex = 519
        Me.cmdOrganizationDetail.Text = "..."
        Me.cmdOrganizationDetail.UseVisualStyleBackColor = False
        '
        '_DataTextArray_30
        '
        Me._DataTextArray_30.AcceptsReturn = True
        Me._DataTextArray_30.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_30.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_30.Enabled = False
        Me._DataTextArray_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_30.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_30, CType(30, Short))
        Me._DataTextArray_30.Location = New System.Drawing.Point(304, 88)
        Me._DataTextArray_30.MaxLength = 0
        Me._DataTextArray_30.Name = "_DataTextArray_30"
        Me._DataTextArray_30.ReadOnly = True
        Me._DataTextArray_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_30.Size = New System.Drawing.Size(97, 20)
        Me._DataTextArray_30.TabIndex = 517
        Me._DataTextArray_30.Tag = "SecondaryPatientContactTitle"
        '
        '_DataTextArray_6
        '
        Me._DataTextArray_6.AcceptsReturn = True
        Me._DataTextArray_6.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_6.Enabled = False
        Me._DataTextArray_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_6, CType(6, Short))
        Me._DataTextArray_6.Location = New System.Drawing.Point(104, 112)
        Me._DataTextArray_6.MaxLength = 30
        Me._DataTextArray_6.Name = "_DataTextArray_6"
        Me._DataTextArray_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_6.Size = New System.Drawing.Size(161, 20)
        Me._DataTextArray_6.TabIndex = 518
        Me._DataTextArray_6.Tag = "SecondaryPatientMedicalRecordNumber"
        '
        '_DataComboArray_6
        '
        Me._DataComboArray_6.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_6.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_6.Enabled = False
        Me._DataComboArray_6.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_6, CType(6, Short))
        Me._DataComboArray_6.Location = New System.Drawing.Point(104, 88)
        Me._DataComboArray_6.Name = "_DataComboArray_6"
        Me._DataComboArray_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_6.Size = New System.Drawing.Size(161, 22)
        Me._DataComboArray_6.TabIndex = 516
        Me._DataComboArray_6.Tag = "SecondaryPatientContactName"
        '
        '_DataComboArray_5
        '
        Me._DataComboArray_5.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_5.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_5.Enabled = False
        Me._DataComboArray_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_5, CType(5, Short))
        Me._DataComboArray_5.Location = New System.Drawing.Point(104, 64)
        Me._DataComboArray_5.Name = "_DataComboArray_5"
        Me._DataComboArray_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_5.Size = New System.Drawing.Size(161, 22)
        Me._DataComboArray_5.TabIndex = 514
        Me._DataComboArray_5.Tag = "SecondaryPatientHospitalUnit"
        '
        '_DataTextArray_4
        '
        Me._DataTextArray_4.AcceptsReturn = True
        Me._DataTextArray_4.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_4.Enabled = False
        Me._DataTextArray_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_4, CType(4, Short))
        Me._DataTextArray_4.Location = New System.Drawing.Point(104, 40)
        Me._DataTextArray_4.MaxLength = 0
        Me._DataTextArray_4.Name = "_DataTextArray_4"
        Me._DataTextArray_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_4.Size = New System.Drawing.Size(131, 20)
        Me._DataTextArray_4.TabIndex = 513
        Me._DataTextArray_4.Tag = "SecondaryPatientPhone"
        '
        '_DataTextArray_250
        '
        Me._DataTextArray_250.AcceptsReturn = True
        Me._DataTextArray_250.BackColor = System.Drawing.Color.White
        Me._DataTextArray_250.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_250.Enabled = False
        Me._DataTextArray_250.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_250.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_250, CType(250, Short))
        Me._DataTextArray_250.Location = New System.Drawing.Point(270, 40)
        Me._DataTextArray_250.MaxLength = 0
        Me._DataTextArray_250.Name = "_DataTextArray_250"
        Me._DataTextArray_250.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_250.Size = New System.Drawing.Size(60, 20)
        Me._DataTextArray_250.TabIndex = 514
        Me._DataTextArray_250.Tag = "SecondaryPatientPhoneExt"
        '
        '_DataLabelArray_44
        '
        Me._DataLabelArray_44.AutoSize = True
        Me._DataLabelArray_44.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_44.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_44.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_44.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_44, CType(44, Short))
        Me._DataLabelArray_44.Location = New System.Drawing.Point(272, 67)
        Me._DataLabelArray_44.Name = "_DataLabelArray_44"
        Me._DataLabelArray_44.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_44.Size = New System.Drawing.Size(34, 14)
        Me._DataLabelArray_44.TabIndex = 511
        Me._DataLabelArray_44.Tag = "lblSecondaryPatientHospitalFloor"
        Me._DataLabelArray_44.Text = "Floor:"
        '
        '_DataLabelArray_14
        '
        Me._DataLabelArray_14.AutoSize = True
        Me._DataLabelArray_14.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_14, CType(14, Short))
        Me._DataLabelArray_14.Location = New System.Drawing.Point(8, 112)
        Me._DataLabelArray_14.Name = "_DataLabelArray_14"
        Me._DataLabelArray_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_14.Size = New System.Drawing.Size(93, 14)
        Me._DataLabelArray_14.TabIndex = 85
        Me._DataLabelArray_14.Tag = "lblSecondaryPatientMedicalRecordNumber"
        Me._DataLabelArray_14.Text = "Medical Record #:"
        '
        '_DataLabelArray_13
        '
        Me._DataLabelArray_13.AutoSize = True
        Me._DataLabelArray_13.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_13, CType(13, Short))
        Me._DataLabelArray_13.Location = New System.Drawing.Point(272, 91)
        Me._DataLabelArray_13.Name = "_DataLabelArray_13"
        Me._DataLabelArray_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_13.Size = New System.Drawing.Size(29, 14)
        Me._DataLabelArray_13.TabIndex = 84
        Me._DataLabelArray_13.Tag = "lblSecondaryPatientContactTitle"
        Me._DataLabelArray_13.Text = "Title:"
        '
        '_DataLabelArray_12
        '
        Me._DataLabelArray_12.AutoSize = True
        Me._DataLabelArray_12.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_12, CType(12, Short))
        Me._DataLabelArray_12.Location = New System.Drawing.Point(24, 91)
        Me._DataLabelArray_12.Name = "_DataLabelArray_12"
        Me._DataLabelArray_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_12.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_12.TabIndex = 83
        Me._DataLabelArray_12.Tag = "lblSecondaryPatientContactName"
        Me._DataLabelArray_12.Text = "Contact Name:"
        '
        '_DataLabelArray_11
        '
        Me._DataLabelArray_11.AutoSize = True
        Me._DataLabelArray_11.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_11, CType(11, Short))
        Me._DataLabelArray_11.Location = New System.Drawing.Point(72, 67)
        Me._DataLabelArray_11.Name = "_DataLabelArray_11"
        Me._DataLabelArray_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_11.Size = New System.Drawing.Size(28, 14)
        Me._DataLabelArray_11.TabIndex = 82
        Me._DataLabelArray_11.Tag = "lblSecondaryPatientHospitalUnit"
        Me._DataLabelArray_11.Text = "Unit:"
        '
        '_DataLabelArray_9
        '
        Me._DataLabelArray_9.AutoSize = True
        Me._DataLabelArray_9.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_9, CType(9, Short))
        Me._DataLabelArray_9.Location = New System.Drawing.Point(16, 40)
        Me._DataLabelArray_9.Name = "_DataLabelArray_9"
        Me._DataLabelArray_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_9.Size = New System.Drawing.Size(80, 14)
        Me._DataLabelArray_9.TabIndex = 62
        Me._DataLabelArray_9.Tag = "lblSecondaryPatientPhone"
        Me._DataLabelArray_9.Text = "Given Phone #:"
        '
        '_DataLabelArray_250
        '
        Me._DataLabelArray_250.AutoSize = True
        Me._DataLabelArray_250.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_250.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_250.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_250.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_250, CType(250, Short))
        Me._DataLabelArray_250.Location = New System.Drawing.Point(242, 40)
        Me._DataLabelArray_250.Name = "_DataLabelArray_250"
        Me._DataLabelArray_250.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_250.Size = New System.Drawing.Size(25, 14)
        Me._DataLabelArray_250.TabIndex = 70
        Me._DataLabelArray_250.Tag = "lblSecondaryPatientPhoneExt"
        Me._DataLabelArray_250.Text = "Ext:"
        '
        '_DataLabelArray_8
        '
        Me._DataLabelArray_8.AutoSize = True
        Me._DataLabelArray_8.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_8, CType(8, Short))
        Me._DataLabelArray_8.Location = New System.Drawing.Point(24, 16)
        Me._DataLabelArray_8.Name = "_DataLabelArray_8"
        Me._DataLabelArray_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_8.Size = New System.Drawing.Size(78, 14)
        Me._DataLabelArray_8.TabIndex = 61
        Me._DataLabelArray_8.Tag = "lblSecondaryHospitalName"
        Me._DataLabelArray_8.Text = "Hospital Name:"
        '
        '_fmDataFrame_9
        '
        Me._fmDataFrame_9.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_9.Controls.Add(Me.cmdFuneralHome)
        Me._fmDataFrame_9.Controls.Add(Me._DataComboArray_83)
        Me._fmDataFrame_9.Controls.Add(Me._DataTextArray_68)
        Me._fmDataFrame_9.Controls.Add(Me._DataTextArray_163)
        Me._fmDataFrame_9.Controls.Add(Me._DataComboArray_57)
        Me._fmDataFrame_9.Controls.Add(Me._DataComboArray_56)
        Me._fmDataFrame_9.Controls.Add(Me._DataComboArray_55)
        Me._fmDataFrame_9.Controls.Add(Me._DataTextArray_160)
        Me._fmDataFrame_9.Controls.Add(Me._DataTextArray_159)
        Me._fmDataFrame_9.Controls.Add(Me._DataTextArray_158)
        Me._fmDataFrame_9.Controls.Add(Me._DataTextArray_157)
        Me._fmDataFrame_9.Controls.Add(Me._DataComboArray_54)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_240)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_236)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_221)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_220)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_219)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_218)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_217)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_216)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_215)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_208)
        Me._fmDataFrame_9.Controls.Add(Me._DataLabelArray_207)
        Me._fmDataFrame_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_9, CType(9, Short))
        Me._fmDataFrame_9.Location = New System.Drawing.Point(400, 3)
        Me._fmDataFrame_9.Name = "_fmDataFrame_9"
        Me._fmDataFrame_9.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_9.Size = New System.Drawing.Size(409, 337)
        Me._fmDataFrame_9.TabIndex = 67
        Me._fmDataFrame_9.TabStop = False
        Me._fmDataFrame_9.Tag = "t0Funeral Home"
        Me._fmDataFrame_9.Text = "Funeral Home - Tab 0"
        '
        'cmdFuneralHome
        '
        Me.cmdFuneralHome.AutoSize = True
        Me.cmdFuneralHome.BackColor = System.Drawing.SystemColors.Control
        Me.cmdFuneralHome.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdFuneralHome.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdFuneralHome.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdFuneralHome.Location = New System.Drawing.Point(208, 16)
        Me.cmdFuneralHome.Name = "cmdFuneralHome"
        Me.cmdFuneralHome.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdFuneralHome.Size = New System.Drawing.Size(123, 24)
        Me.cmdFuneralHome.TabIndex = 446
        Me.cmdFuneralHome.Text = "Contact Funeral Home"
        Me.cmdFuneralHome.UseVisualStyleBackColor = False
        '
        '_DataComboArray_83
        '
        Me._DataComboArray_83.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_83.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_83.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_83.Enabled = False
        Me._DataComboArray_83.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_83.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_83, CType(83, Short))
        Me._DataComboArray_83.Location = New System.Drawing.Point(88, 296)
        Me._DataComboArray_83.Name = "_DataComboArray_83"
        Me._DataComboArray_83.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_83.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_83.TabIndex = 419
        Me._DataComboArray_83.Tag = "SecondaryFHReminderYN"
        '
        '_DataTextArray_68
        '
        Me._DataTextArray_68.AcceptsReturn = True
        Me._DataTextArray_68.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_68.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_68.Enabled = False
        Me._DataTextArray_68.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_68.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_68, CType(68, Short))
        Me._DataTextArray_68.Location = New System.Drawing.Point(88, 232)
        Me._DataTextArray_68.MaxLength = 0
        Me._DataTextArray_68.Multiline = True
        Me._DataTextArray_68.Name = "_DataTextArray_68"
        Me._DataTextArray_68.ReadOnly = True
        Me._DataTextArray_68.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_68.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_68.Size = New System.Drawing.Size(297, 59)
        Me._DataTextArray_68.TabIndex = 418
        Me._DataTextArray_68.Tag = "SecondaryFHReminder"
        '
        '_DataTextArray_163
        '
        Me._DataTextArray_163.AcceptsReturn = True
        Me._DataTextArray_163.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_163.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_163.Enabled = False
        Me._DataTextArray_163.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_163.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_163, CType(163, Short))
        Me._DataTextArray_163.Location = New System.Drawing.Point(136, 208)
        Me._DataTextArray_163.MaxLength = 25
        Me._DataTextArray_163.Name = "_DataTextArray_163"
        Me._DataTextArray_163.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_163.Size = New System.Drawing.Size(249, 20)
        Me._DataTextArray_163.TabIndex = 417
        Me._DataTextArray_163.Tag = "SecondaryHoldOnBodyTag"
        '
        '_DataComboArray_57
        '
        Me._DataComboArray_57.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_57.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_57.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_57.Enabled = False
        Me._DataComboArray_57.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_57.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_57, CType(57, Short))
        Me._DataComboArray_57.Location = New System.Drawing.Point(136, 184)
        Me._DataComboArray_57.Name = "_DataComboArray_57"
        Me._DataComboArray_57.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_57.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_57.TabIndex = 416
        Me._DataComboArray_57.Tag = "SecondaryHoldOnBody"
        '
        '_DataComboArray_56
        '
        Me._DataComboArray_56.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_56.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_56.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_56.Enabled = False
        Me._DataComboArray_56.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_56.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_56, CType(56, Short))
        Me._DataComboArray_56.Location = New System.Drawing.Point(136, 160)
        Me._DataComboArray_56.Name = "_DataComboArray_56"
        Me._DataComboArray_56.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_56.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_56.TabIndex = 415
        Me._DataComboArray_56.Tag = "SecondaryFuneralHomeMorgueCooled"
        '
        '_DataComboArray_55
        '
        Me._DataComboArray_55.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_55.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_55.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_55.Enabled = False
        Me._DataComboArray_55.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_55.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_55, CType(55, Short))
        Me._DataComboArray_55.Location = New System.Drawing.Point(136, 136)
        Me._DataComboArray_55.Name = "_DataComboArray_55"
        Me._DataComboArray_55.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_55.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_55.TabIndex = 414
        Me._DataComboArray_55.Tag = "SecondaryFuneralHomeNotified"
        '
        '_DataTextArray_160
        '
        Me._DataTextArray_160.AcceptsReturn = True
        Me._DataTextArray_160.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_160.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_160.Enabled = False
        Me._DataTextArray_160.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_160.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_160, CType(160, Short))
        Me._DataTextArray_160.Location = New System.Drawing.Point(56, 112)
        Me._DataTextArray_160.MaxLength = 25
        Me._DataTextArray_160.Name = "_DataTextArray_160"
        Me._DataTextArray_160.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_160.Size = New System.Drawing.Size(209, 20)
        Me._DataTextArray_160.TabIndex = 413
        Me._DataTextArray_160.Tag = "SecondaryFuneralHomeContact"
        '
        '_DataTextArray_159
        '
        Me._DataTextArray_159.AcceptsReturn = True
        Me._DataTextArray_159.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_159.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_159.Enabled = False
        Me._DataTextArray_159.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_159.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_159, CType(159, Short))
        Me._DataTextArray_159.Location = New System.Drawing.Point(56, 88)
        Me._DataTextArray_159.MaxLength = 25
        Me._DataTextArray_159.Name = "_DataTextArray_159"
        Me._DataTextArray_159.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_159.Size = New System.Drawing.Size(329, 20)
        Me._DataTextArray_159.TabIndex = 412
        Me._DataTextArray_159.Tag = "SecondaryFuneralHomeAddress"
        '
        '_DataTextArray_158
        '
        Me._DataTextArray_158.AcceptsReturn = True
        Me._DataTextArray_158.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_158.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_158.Enabled = False
        Me._DataTextArray_158.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_158.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_158, CType(158, Short))
        Me._DataTextArray_158.Location = New System.Drawing.Point(56, 64)
        Me._DataTextArray_158.MaxLength = 0
        Me._DataTextArray_158.Name = "_DataTextArray_158"
        Me._DataTextArray_158.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_158.Size = New System.Drawing.Size(113, 20)
        Me._DataTextArray_158.TabIndex = 411
        Me._DataTextArray_158.Tag = "SecondaryFuneralHomePhone"
        '
        '_DataTextArray_157
        '
        Me._DataTextArray_157.AcceptsReturn = True
        Me._DataTextArray_157.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_157.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_157.Enabled = False
        Me._DataTextArray_157.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_157.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_157, CType(157, Short))
        Me._DataTextArray_157.Location = New System.Drawing.Point(56, 40)
        Me._DataTextArray_157.MaxLength = 50
        Me._DataTextArray_157.Name = "_DataTextArray_157"
        Me._DataTextArray_157.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_157.Size = New System.Drawing.Size(329, 20)
        Me._DataTextArray_157.TabIndex = 410
        Me._DataTextArray_157.Tag = "SecondaryFuneralHomeName"
        '
        '_DataComboArray_54
        '
        Me._DataComboArray_54.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_54.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_54.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_54.Enabled = False
        Me._DataComboArray_54.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_54.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_54, CType(54, Short))
        Me._DataComboArray_54.Location = New System.Drawing.Point(136, 16)
        Me._DataComboArray_54.Name = "_DataComboArray_54"
        Me._DataComboArray_54.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_54.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_54.TabIndex = 409
        Me._DataComboArray_54.Tag = "SecondaryFuneralHomeSelected"
        '
        '_DataLabelArray_240
        '
        Me._DataLabelArray_240.AutoSize = True
        Me._DataLabelArray_240.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_240.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_240.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_240.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_240, CType(240, Short))
        Me._DataLabelArray_240.Location = New System.Drawing.Point(8, 300)
        Me._DataLabelArray_240.Name = "_DataLabelArray_240"
        Me._DataLabelArray_240.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_240.Size = New System.Drawing.Size(84, 14)
        Me._DataLabelArray_240.TabIndex = 436
        Me._DataLabelArray_240.Tag = "lblSecondaryFHReminderYN"
        Me._DataLabelArray_240.Text = "Reminder (Y/N):"
        '
        '_DataLabelArray_236
        '
        Me._DataLabelArray_236.AutoSize = True
        Me._DataLabelArray_236.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_236.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_236.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_236.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_236, CType(236, Short))
        Me._DataLabelArray_236.Location = New System.Drawing.Point(32, 232)
        Me._DataLabelArray_236.Name = "_DataLabelArray_236"
        Me._DataLabelArray_236.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_236.Size = New System.Drawing.Size(55, 14)
        Me._DataLabelArray_236.TabIndex = 432
        Me._DataLabelArray_236.Tag = "lblSecondaryFHReminder"
        Me._DataLabelArray_236.Text = "Reminder:"
        '
        '_DataLabelArray_221
        '
        Me._DataLabelArray_221.AutoSize = True
        Me._DataLabelArray_221.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_221.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_221.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_221.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_221, CType(221, Short))
        Me._DataLabelArray_221.Location = New System.Drawing.Point(8, 208)
        Me._DataLabelArray_221.Name = "_DataLabelArray_221"
        Me._DataLabelArray_221.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_221.Size = New System.Drawing.Size(127, 14)
        Me._DataLabelArray_221.TabIndex = 280
        Me._DataLabelArray_221.Tag = "lblSecondaryHoldOnBodyTag"
        Me._DataLabelArray_221.Text = "Date/Time/Person Stamp:"
        '
        '_DataLabelArray_220
        '
        Me._DataLabelArray_220.AutoSize = True
        Me._DataLabelArray_220.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_220.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_220.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_220.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_220, CType(220, Short))
        Me._DataLabelArray_220.Location = New System.Drawing.Point(56, 184)
        Me._DataLabelArray_220.Name = "_DataLabelArray_220"
        Me._DataLabelArray_220.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_220.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_220.TabIndex = 279
        Me._DataLabelArray_220.Tag = "lblSecondaryHoldOnBody"
        Me._DataLabelArray_220.Text = "Hold on Body?"
        '
        '_DataLabelArray_219
        '
        Me._DataLabelArray_219.AutoSize = True
        Me._DataLabelArray_219.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_219.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_219.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_219.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_219, CType(219, Short))
        Me._DataLabelArray_219.Location = New System.Drawing.Point(8, 160)
        Me._DataLabelArray_219.Name = "_DataLabelArray_219"
        Me._DataLabelArray_219.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_219.Size = New System.Drawing.Size(129, 14)
        Me._DataLabelArray_219.TabIndex = 278
        Me._DataLabelArray_219.Tag = "lblSecondaryFuneralHomeMorgueCooled"
        Me._DataLabelArray_219.Text = "FH Have Cooled Morgue?"
        '
        '_DataLabelArray_218
        '
        Me._DataLabelArray_218.AutoSize = True
        Me._DataLabelArray_218.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_218.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_218.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_218.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_218, CType(218, Short))
        Me._DataLabelArray_218.Location = New System.Drawing.Point(32, 136)
        Me._DataLabelArray_218.Name = "_DataLabelArray_218"
        Me._DataLabelArray_218.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_218.Size = New System.Drawing.Size(106, 14)
        Me._DataLabelArray_218.TabIndex = 277
        Me._DataLabelArray_218.Tag = "lblSecondaryFuneralHomeNotified"
        Me._DataLabelArray_218.Text = "FH Notified of Case?"
        '
        '_DataLabelArray_217
        '
        Me._DataLabelArray_217.AutoSize = True
        Me._DataLabelArray_217.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_217.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_217.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_217.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_217, CType(217, Short))
        Me._DataLabelArray_217.Location = New System.Drawing.Point(8, 112)
        Me._DataLabelArray_217.Name = "_DataLabelArray_217"
        Me._DataLabelArray_217.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_217.Size = New System.Drawing.Size(47, 14)
        Me._DataLabelArray_217.TabIndex = 276
        Me._DataLabelArray_217.Tag = "lblSecondaryFuneralHomeContact"
        Me._DataLabelArray_217.Text = "Contact:"
        '
        '_DataLabelArray_216
        '
        Me._DataLabelArray_216.AutoSize = True
        Me._DataLabelArray_216.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_216.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_216.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_216.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_216, CType(216, Short))
        Me._DataLabelArray_216.Location = New System.Drawing.Point(8, 88)
        Me._DataLabelArray_216.Name = "_DataLabelArray_216"
        Me._DataLabelArray_216.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_216.Size = New System.Drawing.Size(52, 14)
        Me._DataLabelArray_216.TabIndex = 275
        Me._DataLabelArray_216.Tag = "lblSecondaryFuneralHomeAddress"
        Me._DataLabelArray_216.Text = "Address:"
        '
        '_DataLabelArray_215
        '
        Me._DataLabelArray_215.AutoSize = True
        Me._DataLabelArray_215.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_215.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_215.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_215.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_215, CType(215, Short))
        Me._DataLabelArray_215.Location = New System.Drawing.Point(16, 64)
        Me._DataLabelArray_215.Name = "_DataLabelArray_215"
        Me._DataLabelArray_215.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_215.Size = New System.Drawing.Size(40, 14)
        Me._DataLabelArray_215.TabIndex = 274
        Me._DataLabelArray_215.Tag = "lblSecondaryFuneralHomePhone"
        Me._DataLabelArray_215.Text = "Phone:"
        '
        '_DataLabelArray_208
        '
        Me._DataLabelArray_208.AutoSize = True
        Me._DataLabelArray_208.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_208.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_208.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_208.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_208, CType(208, Short))
        Me._DataLabelArray_208.Location = New System.Drawing.Point(16, 40)
        Me._DataLabelArray_208.Name = "_DataLabelArray_208"
        Me._DataLabelArray_208.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_208.Size = New System.Drawing.Size(37, 14)
        Me._DataLabelArray_208.TabIndex = 273
        Me._DataLabelArray_208.Tag = "lblSecondaryFuneralHomeName"
        Me._DataLabelArray_208.Text = "Name:"
        '
        '_DataLabelArray_207
        '
        Me._DataLabelArray_207.AutoSize = True
        Me._DataLabelArray_207.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_207.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_207.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_207.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_207, CType(207, Short))
        Me._DataLabelArray_207.Location = New System.Drawing.Point(8, 16)
        Me._DataLabelArray_207.Name = "_DataLabelArray_207"
        Me._DataLabelArray_207.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_207.Size = New System.Drawing.Size(124, 14)
        Me._DataLabelArray_207.TabIndex = 272
        Me._DataLabelArray_207.Tag = "lblSecondaryFuneralHomeSelected"
        Me._DataLabelArray_207.Text = "Funeral Home Selected?"
        '
        '_fmDataFrame_10
        '
        Me._fmDataFrame_10.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_28)
        Me._fmDataFrame_10.Controls.Add(Me._DataCheckboxArray_0)
        Me._fmDataFrame_10.Controls.Add(Me.fmOrgSpecialNotes)
        Me._fmDataFrame_10.Controls.Add(Me._fmEyeCareInstructions_1)
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_27)
        Me._fmDataFrame_10.Controls.Add(Me.cmdCreateCOP)
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_10)
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_9)
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_8)
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_164)
        Me._fmDataFrame_10.Controls.Add(Me._DataComboArray_58)
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_165)
        Me._fmDataFrame_10.Controls.Add(Me._DataTextArray_168)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_73)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_51)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_50)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_49)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_227)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_226)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_223)
        Me._fmDataFrame_10.Controls.Add(Me._DataLabelArray_222)
        Me._fmDataFrame_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_10, CType(10, Short))
        Me._fmDataFrame_10.Location = New System.Drawing.Point(364, 30)
        Me._fmDataFrame_10.Name = "_fmDataFrame_10"
        Me._fmDataFrame_10.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_10.Size = New System.Drawing.Size(437, 345)
        Me._fmDataFrame_10.TabIndex = 68
        Me._fmDataFrame_10.TabStop = False
        Me._fmDataFrame_10.Tag = "t0Body Care"
        Me._fmDataFrame_10.Text = "Body Care - Tab 0"
        '
        '_DataTextArray_28
        '
        Me._DataTextArray_28.AcceptsReturn = True
        Me._DataTextArray_28.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_28.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_28.Enabled = False
        Me._DataTextArray_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_28.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_28, CType(28, Short))
        Me._DataTextArray_28.Location = New System.Drawing.Point(228, 24)
        Me._DataTextArray_28.MaxLength = 14
        Me._DataTextArray_28.Name = "_DataTextArray_28"
        Me._DataTextArray_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_28.Size = New System.Drawing.Size(50, 20)
        Me._DataTextArray_28.TabIndex = 593
        Me._DataTextArray_28.Tag = "SecondaryBodyHoldPlacedTime"
        '
        '_DataCheckboxArray_0
        '
        Me._DataCheckboxArray_0.BackColor = System.Drawing.SystemColors.ActiveBorder
        Me._DataCheckboxArray_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataCheckboxArray_0.Enabled = False
        Me._DataCheckboxArray_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataCheckboxArray_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataCheckboxArray.SetIndex(Me._DataCheckboxArray_0, CType(0, Short))
        Me._DataCheckboxArray_0.Location = New System.Drawing.Point(24, 234)
        Me._DataCheckboxArray_0.Name = "_DataCheckboxArray_0"
        Me._DataCheckboxArray_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataCheckboxArray_0.Size = New System.Drawing.Size(161, 17)
        Me._DataCheckboxArray_0.TabIndex = 601
        Me._DataCheckboxArray_0.Tag = "SecondaryBodyHoldInstructionsGiven"
        Me._DataCheckboxArray_0.Text = "Eye Care Instructions Given"
        Me._DataCheckboxArray_0.UseVisualStyleBackColor = False
        '
        'fmOrgSpecialNotes
        '
        Me.fmOrgSpecialNotes.BackColor = System.Drawing.SystemColors.Control
        Me.fmOrgSpecialNotes.Controls.Add(Me.rtfOrgSpecialNotes)
        Me.fmOrgSpecialNotes.Controls.Add(Me.lblOrgSpecialNotes)
        Me.fmOrgSpecialNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmOrgSpecialNotes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmOrgSpecialNotes.Location = New System.Drawing.Point(224, 224)
        Me.fmOrgSpecialNotes.Name = "fmOrgSpecialNotes"
        Me.fmOrgSpecialNotes.Padding = New System.Windows.Forms.Padding(0)
        Me.fmOrgSpecialNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmOrgSpecialNotes.Size = New System.Drawing.Size(207, 113)
        Me.fmOrgSpecialNotes.TabIndex = 603
        Me.fmOrgSpecialNotes.TabStop = False
        '
        'rtfOrgSpecialNotes
        '
        Me.rtfOrgSpecialNotes.BackColor = System.Drawing.SystemColors.HighlightText
        Me.rtfOrgSpecialNotes.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.rtfOrgSpecialNotes.Location = New System.Drawing.Point(8, 24)
        Me.rtfOrgSpecialNotes.MaxLength = 1000
        Me.rtfOrgSpecialNotes.Name = "rtfOrgSpecialNotes"
        Me.rtfOrgSpecialNotes.ReadOnly = True
        Me.rtfOrgSpecialNotes.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.rtfOrgSpecialNotes.Size = New System.Drawing.Size(191, 81)
        Me.rtfOrgSpecialNotes.TabIndex = 611
        Me.rtfOrgSpecialNotes.Text = ""
        '
        'lblOrgSpecialNotes
        '
        Me.lblOrgSpecialNotes.AutoSize = True
        Me.lblOrgSpecialNotes.BackColor = System.Drawing.SystemColors.Control
        Me.lblOrgSpecialNotes.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOrgSpecialNotes.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblOrgSpecialNotes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblOrgSpecialNotes.Location = New System.Drawing.Point(8, 8)
        Me.lblOrgSpecialNotes.Name = "lblOrgSpecialNotes"
        Me.lblOrgSpecialNotes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOrgSpecialNotes.Size = New System.Drawing.Size(140, 14)
        Me.lblOrgSpecialNotes.TabIndex = 612
        Me.lblOrgSpecialNotes.Text = "Organization Special Notes:"
        '
        '_fmEyeCareInstructions_1
        '
        Me._fmEyeCareInstructions_1.BackColor = System.Drawing.SystemColors.Control
        Me._fmEyeCareInstructions_1.Controls.Add(Me.Command1)
        Me._fmEyeCareInstructions_1.Controls.Add(Me.rtfClientEyeCareReminder)
        Me._fmEyeCareInstructions_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmEyeCareInstructions_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmEyeCareInstructions.SetIndex(Me._fmEyeCareInstructions_1, CType(1, Short))
        Me._fmEyeCareInstructions_1.Location = New System.Drawing.Point(8, 224)
        Me._fmEyeCareInstructions_1.Name = "_fmEyeCareInstructions_1"
        Me._fmEyeCareInstructions_1.Padding = New System.Windows.Forms.Padding(0)
        Me._fmEyeCareInstructions_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmEyeCareInstructions_1.Size = New System.Drawing.Size(207, 113)
        Me._fmEyeCareInstructions_1.TabIndex = 602
        Me._fmEyeCareInstructions_1.TabStop = False
        '
        'Command1
        '
        Me.Command1.AutoSize = True
        Me.Command1.BackColor = System.Drawing.SystemColors.Control
        Me.Command1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Command1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Command1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Command1.Location = New System.Drawing.Point(8, 88)
        Me.Command1.Name = "Command1"
        Me.Command1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Command1.Size = New System.Drawing.Size(89, 24)
        Me.Command1.TabIndex = 610
        Me.Command1.Text = "Create EB COP"
        Me.Command1.UseVisualStyleBackColor = False
        '
        'rtfClientEyeCareReminder
        '
        Me.rtfClientEyeCareReminder.BackColor = System.Drawing.SystemColors.HighlightText
        Me.rtfClientEyeCareReminder.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.rtfClientEyeCareReminder.Location = New System.Drawing.Point(8, 32)
        Me.rtfClientEyeCareReminder.MaxLength = 255
        Me.rtfClientEyeCareReminder.Name = "rtfClientEyeCareReminder"
        Me.rtfClientEyeCareReminder.ReadOnly = True
        Me.rtfClientEyeCareReminder.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical
        Me.rtfClientEyeCareReminder.Size = New System.Drawing.Size(191, 53)
        Me.rtfClientEyeCareReminder.TabIndex = 609
        Me.rtfClientEyeCareReminder.Text = ""
        '
        '_DataTextArray_27
        '
        Me._DataTextArray_27.AcceptsReturn = True
        Me._DataTextArray_27.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_27.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_27.Enabled = False
        Me._DataTextArray_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_27.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_27, CType(27, Short))
        Me._DataTextArray_27.Location = New System.Drawing.Point(176, 96)
        Me._DataTextArray_27.MaxLength = 14
        Me._DataTextArray_27.Name = "_DataTextArray_27"
        Me._DataTextArray_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_27.Size = New System.Drawing.Size(105, 20)
        Me._DataTextArray_27.TabIndex = 596
        Me._DataTextArray_27.Tag = "SecondaryBodyHoldPhone"
        '
        'cmdCreateCOP
        '
        Me.cmdCreateCOP.BackColor = System.Drawing.SystemColors.Control
        Me.cmdCreateCOP.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCreateCOP.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCreateCOP.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCreateCOP.Location = New System.Drawing.Point(328, 24)
        Me.cmdCreateCOP.Name = "cmdCreateCOP"
        Me.cmdCreateCOP.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCreateCOP.Size = New System.Drawing.Size(89, 19)
        Me.cmdCreateCOP.TabIndex = 607
        Me.cmdCreateCOP.Text = "Create COP"
        Me.cmdCreateCOP.UseVisualStyleBackColor = False
        '
        '_DataTextArray_10
        '
        Me._DataTextArray_10.AcceptsReturn = True
        Me._DataTextArray_10.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_10.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_10.Enabled = False
        Me._DataTextArray_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_10.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_10, CType(10, Short))
        Me._DataTextArray_10.Location = New System.Drawing.Point(176, 72)
        Me._DataTextArray_10.MaxLength = 25
        Me._DataTextArray_10.Name = "_DataTextArray_10"
        Me._DataTextArray_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_10.Size = New System.Drawing.Size(241, 20)
        Me._DataTextArray_10.TabIndex = 595
        Me._DataTextArray_10.Tag = "SecondaryBodyFutureContact"
        '
        '_DataTextArray_9
        '
        Me._DataTextArray_9.AcceptsReturn = True
        Me._DataTextArray_9.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_9.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_9.Enabled = False
        Me._DataTextArray_9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_9.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_9, CType(9, Short))
        Me._DataTextArray_9.Location = New System.Drawing.Point(176, 48)
        Me._DataTextArray_9.MaxLength = 25
        Me._DataTextArray_9.Name = "_DataTextArray_9"
        Me._DataTextArray_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_9.Size = New System.Drawing.Size(241, 20)
        Me._DataTextArray_9.TabIndex = 594
        Me._DataTextArray_9.Tag = "SecondaryBodyHoldPlacedWith"
        '
        '_DataTextArray_8
        '
        Me._DataTextArray_8.AcceptsReturn = True
        Me._DataTextArray_8.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_8.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_8.Enabled = False
        Me._DataTextArray_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_8.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_8, CType(8, Short))
        Me._DataTextArray_8.Location = New System.Drawing.Point(176, 24)
        Me._DataTextArray_8.MaxLength = 14
        Me._DataTextArray_8.Name = "_DataTextArray_8"
        Me._DataTextArray_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_8.Size = New System.Drawing.Size(54, 20)
        Me._DataTextArray_8.TabIndex = 592
        Me._DataTextArray_8.Tag = "SecondaryBodyHoldPlaced"
        '
        '_DataTextArray_164
        '
        Me._DataTextArray_164.AcceptsReturn = True
        Me._DataTextArray_164.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_164.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_164.Enabled = False
        Me._DataTextArray_164.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_164.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_164, CType(164, Short))
        Me._DataTextArray_164.Location = New System.Drawing.Point(176, 120)
        Me._DataTextArray_164.MaxLength = 0
        Me._DataTextArray_164.Name = "_DataTextArray_164"
        Me._DataTextArray_164.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_164.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_164.TabIndex = 597
        Me._DataTextArray_164.Tag = "SecondaryBodyRefrigerationDate"
        '
        '_DataComboArray_58
        '
        Me._DataComboArray_58.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_58.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_58.Enabled = False
        Me._DataComboArray_58.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_58.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_58, CType(58, Short))
        Me._DataComboArray_58.Location = New System.Drawing.Point(176, 192)
        Me._DataComboArray_58.Name = "_DataComboArray_58"
        Me._DataComboArray_58.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_58.Size = New System.Drawing.Size(161, 22)
        Me._DataComboArray_58.TabIndex = 600
        Me._DataComboArray_58.Tag = "SecondaryBodyCoolingMethod"
        Me._DataComboArray_58.Text = "DataComboArray"
        '
        '_DataTextArray_165
        '
        Me._DataTextArray_165.AcceptsReturn = True
        Me._DataTextArray_165.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_165.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_165.Enabled = False
        Me._DataTextArray_165.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_165.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_165, CType(165, Short))
        Me._DataTextArray_165.Location = New System.Drawing.Point(176, 168)
        Me._DataTextArray_165.MaxLength = 25
        Me._DataTextArray_165.Name = "_DataTextArray_165"
        Me._DataTextArray_165.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_165.Size = New System.Drawing.Size(241, 20)
        Me._DataTextArray_165.TabIndex = 599
        Me._DataTextArray_165.Tag = "SecondaryBodyLocation"
        '
        '_DataTextArray_168
        '
        Me._DataTextArray_168.AcceptsReturn = True
        Me._DataTextArray_168.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_168.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_168.Enabled = False
        Me._DataTextArray_168.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_168.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_168, CType(168, Short))
        Me._DataTextArray_168.Location = New System.Drawing.Point(176, 144)
        Me._DataTextArray_168.MaxLength = 0
        Me._DataTextArray_168.Name = "_DataTextArray_168"
        Me._DataTextArray_168.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_168.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_168.TabIndex = 598
        Me._DataTextArray_168.Tag = "SecondaryBodyRefrigerationTime"
        '
        '_DataLabelArray_73
        '
        Me._DataLabelArray_73.AutoSize = True
        Me._DataLabelArray_73.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_73.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_73.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_73.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_73, CType(73, Short))
        Me._DataLabelArray_73.Location = New System.Drawing.Point(96, 96)
        Me._DataLabelArray_73.Name = "_DataLabelArray_73"
        Me._DataLabelArray_73.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_73.Size = New System.Drawing.Size(80, 14)
        Me._DataLabelArray_73.TabIndex = 608
        Me._DataLabelArray_73.Tag = "lblSecondaryBodyHoldPlaced"
        Me._DataLabelArray_73.Text = "Phone Number:"
        '
        '_DataLabelArray_51
        '
        Me._DataLabelArray_51.AutoSize = True
        Me._DataLabelArray_51.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_51.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_51.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_51.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_51, CType(51, Short))
        Me._DataLabelArray_51.Location = New System.Drawing.Point(8, 72)
        Me._DataLabelArray_51.Name = "_DataLabelArray_51"
        Me._DataLabelArray_51.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_51.Size = New System.Drawing.Size(172, 14)
        Me._DataLabelArray_51.TabIndex = 606
        Me._DataLabelArray_51.Tag = "lblSecondaryBodyFutureContact"
        Me._DataLabelArray_51.Text = "Future contact for update/release:"
        '
        '_DataLabelArray_50
        '
        Me._DataLabelArray_50.AutoSize = True
        Me._DataLabelArray_50.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_50.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_50.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_50.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_50, CType(50, Short))
        Me._DataLabelArray_50.Location = New System.Drawing.Point(80, 48)
        Me._DataLabelArray_50.Name = "_DataLabelArray_50"
        Me._DataLabelArray_50.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_50.Size = New System.Drawing.Size(90, 14)
        Me._DataLabelArray_50.TabIndex = 605
        Me._DataLabelArray_50.Tag = "lblSecondaryBodyHoldPlacedWith"
        Me._DataLabelArray_50.Text = "Hold Placed With:"
        '
        '_DataLabelArray_49
        '
        Me._DataLabelArray_49.AutoSize = True
        Me._DataLabelArray_49.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_49.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_49.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_49.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_49, CType(49, Short))
        Me._DataLabelArray_49.Location = New System.Drawing.Point(64, 24)
        Me._DataLabelArray_49.Name = "_DataLabelArray_49"
        Me._DataLabelArray_49.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_49.Size = New System.Drawing.Size(109, 14)
        Me._DataLabelArray_49.TabIndex = 604
        Me._DataLabelArray_49.Tag = "lblSecondaryBodyHoldPlaced"
        Me._DataLabelArray_49.Text = "Hold on Body Placed:"
        '
        '_DataLabelArray_227
        '
        Me._DataLabelArray_227.AutoSize = True
        Me._DataLabelArray_227.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_227.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_227.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_227.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_227, CType(227, Short))
        Me._DataLabelArray_227.Location = New System.Drawing.Point(80, 120)
        Me._DataLabelArray_227.Name = "_DataLabelArray_227"
        Me._DataLabelArray_227.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_227.Size = New System.Drawing.Size(97, 14)
        Me._DataLabelArray_227.TabIndex = 284
        Me._DataLabelArray_227.Tag = "lblSecondaryBodyRefrigerationDate"
        Me._DataLabelArray_227.Text = "Refrigeration Date:"
        '
        '_DataLabelArray_226
        '
        Me._DataLabelArray_226.AutoSize = True
        Me._DataLabelArray_226.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_226.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_226.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_226.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_226, CType(226, Short))
        Me._DataLabelArray_226.Location = New System.Drawing.Point(88, 192)
        Me._DataLabelArray_226.Name = "_DataLabelArray_226"
        Me._DataLabelArray_226.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_226.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_226.TabIndex = 283
        Me._DataLabelArray_226.Tag = "lblSecondaryBodyCoolingMethod"
        Me._DataLabelArray_226.Text = "Cooling Method:"
        '
        '_DataLabelArray_223
        '
        Me._DataLabelArray_223.AutoSize = True
        Me._DataLabelArray_223.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_223.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_223.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_223.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_223, CType(223, Short))
        Me._DataLabelArray_223.Location = New System.Drawing.Point(96, 168)
        Me._DataLabelArray_223.Name = "_DataLabelArray_223"
        Me._DataLabelArray_223.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_223.Size = New System.Drawing.Size(79, 14)
        Me._DataLabelArray_223.TabIndex = 282
        Me._DataLabelArray_223.Tag = "lblSecondaryBodyLocation"
        Me._DataLabelArray_223.Text = "Body Location:"
        '
        '_DataLabelArray_222
        '
        Me._DataLabelArray_222.AutoSize = True
        Me._DataLabelArray_222.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_222.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_222.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_222.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_222, CType(222, Short))
        Me._DataLabelArray_222.Location = New System.Drawing.Point(80, 144)
        Me._DataLabelArray_222.Name = "_DataLabelArray_222"
        Me._DataLabelArray_222.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_222.Size = New System.Drawing.Size(97, 14)
        Me._DataLabelArray_222.TabIndex = 281
        Me._DataLabelArray_222.Tag = "lblSecondaryBodyRefrigerationTime"
        Me._DataLabelArray_222.Text = "Refrigeration Time:"
        '
        '_tbReferralData_TabPage1
        '
        Me._tbReferralData_TabPage1.AutoScroll = True
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_20)
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_24)
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_12)
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_26)
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_17)
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_3)
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_27)
        Me._tbReferralData_TabPage1.Controls.Add(Me._fmDataFrame_29)
        Me._tbReferralData_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage1.Name = "_tbReferralData_TabPage1"
        Me._tbReferralData_TabPage1.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage1.TabIndex = 1
        Me._tbReferralData_TabPage1.Text = "Tab 1"
        '
        '_fmDataFrame_20
        '
        Me._fmDataFrame_20.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_20.Controls.Add(Me.cmdeventrecievedFound)
        Me._fmDataFrame_20.Controls.Add(Me.cmdEventRecieved)
        Me._fmDataFrame_20.Controls.Add(Me.cboRegistryStatusFS)
        Me._fmDataFrame_20.Controls.Add(Me._DataComboArray_60)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_5)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_53)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_51)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_50)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_52)
        Me._fmDataFrame_20.Controls.Add(Me._DataComboArray_88)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_26)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_25)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_24)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_22)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_21)
        Me._fmDataFrame_20.Controls.Add(Me._DataComboArray_13)
        Me._fmDataFrame_20.Controls.Add(Me._DataComboArray_14)
        Me._fmDataFrame_20.Controls.Add(Me._DataTextArray_23)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_63)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_45)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_10)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_74)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_72)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_71)
        Me._fmDataFrame_20.Controls.Add(Me.Label2)
        Me._fmDataFrame_20.Controls.Add(Me.lblWeight)
        Me._fmDataFrame_20.Controls.Add(Me.Label5)
        Me._fmDataFrame_20.Controls.Add(Me.Label6)
        Me._fmDataFrame_20.Controls.Add(Me.Label3)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_41)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_38)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_37)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_35)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_34)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_39)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_40)
        Me._fmDataFrame_20.Controls.Add(Me._DataLabelArray_36)
        Me._fmDataFrame_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_20, CType(20, Short))
        Me._fmDataFrame_20.Location = New System.Drawing.Point(469, 12)
        Me._fmDataFrame_20.Name = "_fmDataFrame_20"
        Me._fmDataFrame_20.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_20.Size = New System.Drawing.Size(441, 345)
        Me._fmDataFrame_20.TabIndex = 86
        Me._fmDataFrame_20.TabStop = False
        Me._fmDataFrame_20.Tag = "t1Patient Info"
        Me._fmDataFrame_20.Text = "Patient Info - Tab 1"
        Me._fmDataFrame_20.Visible = False
        '
        'cmdeventrecievedFound
        '
        Me.cmdeventrecievedFound.BackColor = System.Drawing.SystemColors.Control
        Me.cmdeventrecievedFound.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdeventrecievedFound.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdeventrecievedFound.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdeventrecievedFound.Location = New System.Drawing.Point(320, 272)
        Me.cmdeventrecievedFound.Name = "cmdeventrecievedFound"
        Me.cmdeventrecievedFound.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdeventrecievedFound.Size = New System.Drawing.Size(65, 25)
        Me.cmdeventrecievedFound.TabIndex = 638
        Me.cmdeventrecievedFound.Text = "Found"
        Me.cmdeventrecievedFound.UseVisualStyleBackColor = False
        Me.cmdeventrecievedFound.Visible = False
        '
        'cmdEventRecieved
        '
        Me.cmdEventRecieved.BackColor = System.Drawing.SystemColors.Control
        Me.cmdEventRecieved.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdEventRecieved.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdEventRecieved.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEventRecieved.Location = New System.Drawing.Point(320, 240)
        Me.cmdEventRecieved.Name = "cmdEventRecieved"
        Me.cmdEventRecieved.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEventRecieved.Size = New System.Drawing.Size(65, 25)
        Me.cmdEventRecieved.TabIndex = 637
        Me.cmdEventRecieved.Text = "warning"
        Me.cmdEventRecieved.UseVisualStyleBackColor = False
        Me.cmdEventRecieved.Visible = False
        '
        'cboRegistryStatusFS
        '
        Me.cboRegistryStatusFS.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboRegistryStatusFS.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboRegistryStatusFS.BackColor = System.Drawing.SystemColors.Window
        Me.cboRegistryStatusFS.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboRegistryStatusFS.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboRegistryStatusFS.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboRegistryStatusFS.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboRegistryStatusFS.Location = New System.Drawing.Point(80, 264)
        Me.cboRegistryStatusFS.Name = "cboRegistryStatusFS"
        Me.cboRegistryStatusFS.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboRegistryStatusFS.Size = New System.Drawing.Size(113, 22)
        Me.cboRegistryStatusFS.TabIndex = 633
        '
        '_DataComboArray_60
        '
        Me._DataComboArray_60.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_60.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_60.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_60.Enabled = False
        Me._DataComboArray_60.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_60.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_60, CType(60, Short))
        Me._DataComboArray_60.Location = New System.Drawing.Point(80, 232)
        Me._DataComboArray_60.Name = "_DataComboArray_60"
        Me._DataComboArray_60.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_60.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_60.TabIndex = 265
        Me._DataComboArray_60.Tag = "SecondaryPatientABO"
        '
        '_DataTextArray_5
        '
        Me._DataTextArray_5.AcceptsReturn = True
        Me._DataTextArray_5.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_5.Enabled = False
        Me._DataTextArray_5.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_5.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_5, CType(5, Short))
        Me._DataTextArray_5.Location = New System.Drawing.Point(80, 88)
        Me._DataTextArray_5.MaxLength = 10
        Me._DataTextArray_5.Name = "_DataTextArray_5"
        Me._DataTextArray_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_5.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_5.TabIndex = 254
        Me._DataTextArray_5.Tag = "SecondaryPatientSuffix"
        '
        '_DataTextArray_53
        '
        Me._DataTextArray_53.AcceptsReturn = True
        Me._DataTextArray_53.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_53.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_53.Enabled = False
        Me._DataTextArray_53.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_53.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_53, CType(53, Short))
        Me._DataTextArray_53.Location = New System.Drawing.Point(81, 208)
        Me._DataTextArray_53.MaxLength = 10
        Me._DataTextArray_53.Name = "_DataTextArray_53"
        Me._DataTextArray_53.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_53.Size = New System.Drawing.Size(73, 20)
        Me._DataTextArray_53.TabIndex = 264
        Me._DataTextArray_53.Tag = "SecondaryPatientBMICalc"
        '
        '_DataTextArray_51
        '
        Me._DataTextArray_51.AcceptsReturn = True
        Me._DataTextArray_51.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_51.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_51.Enabled = False
        Me._DataTextArray_51.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_51.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_51, CType(51, Short))
        Me._DataTextArray_51.Location = New System.Drawing.Point(203, 184)
        Me._DataTextArray_51.MaxLength = 0
        Me._DataTextArray_51.Name = "_DataTextArray_51"
        Me._DataTextArray_51.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_51.Size = New System.Drawing.Size(33, 20)
        Me._DataTextArray_51.TabIndex = 262
        Me._DataTextArray_51.Tag = "SecondaryPatientHeightFeet"
        '
        '_DataTextArray_50
        '
        Me._DataTextArray_50.AcceptsReturn = True
        Me._DataTextArray_50.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_50.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_50.Enabled = False
        Me._DataTextArray_50.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_50.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_50, CType(50, Short))
        Me._DataTextArray_50.Location = New System.Drawing.Point(80, 184)
        Me._DataTextArray_50.MaxLength = 7
        Me._DataTextArray_50.Name = "_DataTextArray_50"
        Me._DataTextArray_50.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_50.Size = New System.Drawing.Size(49, 20)
        Me._DataTextArray_50.TabIndex = 261
        Me._DataTextArray_50.Tag = "SecondaryPatientWeight"
        '
        '_DataTextArray_52
        '
        Me._DataTextArray_52.AcceptsReturn = True
        Me._DataTextArray_52.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_52.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_52.Enabled = False
        Me._DataTextArray_52.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_52.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_52, CType(52, Short))
        Me._DataTextArray_52.Location = New System.Drawing.Point(267, 184)
        Me._DataTextArray_52.MaxLength = 0
        Me._DataTextArray_52.Name = "_DataTextArray_52"
        Me._DataTextArray_52.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_52.Size = New System.Drawing.Size(33, 20)
        Me._DataTextArray_52.TabIndex = 263
        Me._DataTextArray_52.Tag = "SecondaryPatientHeightInches"
        '
        '_DataComboArray_88
        '
        Me._DataComboArray_88.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_88.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_88.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_88.Enabled = False
        Me._DataComboArray_88.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_88.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_88, CType(88, Short))
        Me._DataComboArray_88.Location = New System.Drawing.Point(256, 136)
        Me._DataComboArray_88.Name = "_DataComboArray_88"
        Me._DataComboArray_88.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_88.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_88.TabIndex = 258
        Me._DataComboArray_88.Tag = "SecondaryPatientAgeUnit"
        '
        '_DataTextArray_26
        '
        Me._DataTextArray_26.AcceptsReturn = True
        Me._DataTextArray_26.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_26.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_26.Enabled = False
        Me._DataTextArray_26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_26.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_26, CType(26, Short))
        Me._DataTextArray_26.Location = New System.Drawing.Point(80, 112)
        Me._DataTextArray_26.MaxLength = 0
        Me._DataTextArray_26.Name = "_DataTextArray_26"
        Me._DataTextArray_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_26.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_26.TabIndex = 255
        Me._DataTextArray_26.Tag = "SecondaryPatientSSN"
        '
        '_DataTextArray_25
        '
        Me._DataTextArray_25.AcceptsReturn = True
        Me._DataTextArray_25.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_25.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_25.Enabled = False
        Me._DataTextArray_25.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_25.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_25, CType(25, Short))
        Me._DataTextArray_25.Location = New System.Drawing.Point(200, 136)
        Me._DataTextArray_25.MaxLength = 0
        Me._DataTextArray_25.Name = "_DataTextArray_25"
        Me._DataTextArray_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_25.Size = New System.Drawing.Size(49, 20)
        Me._DataTextArray_25.TabIndex = 257
        Me._DataTextArray_25.Tag = "SecondaryPatientAge"
        '
        '_DataTextArray_24
        '
        Me._DataTextArray_24.AcceptsReturn = True
        Me._DataTextArray_24.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_24.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_24.Enabled = False
        Me._DataTextArray_24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_24.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_24, CType(24, Short))
        Me._DataTextArray_24.Location = New System.Drawing.Point(80, 136)
        Me._DataTextArray_24.MaxLength = 0
        Me._DataTextArray_24.Name = "_DataTextArray_24"
        Me._DataTextArray_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_24.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_24.TabIndex = 256
        Me._DataTextArray_24.Tag = "SecondaryPatientDOB"
        '
        '_DataTextArray_22
        '
        Me._DataTextArray_22.AcceptsReturn = True
        Me._DataTextArray_22.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_22.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_22.Enabled = False
        Me._DataTextArray_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_22.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_22, CType(22, Short))
        Me._DataTextArray_22.Location = New System.Drawing.Point(80, 40)
        Me._DataTextArray_22.MaxLength = 25
        Me._DataTextArray_22.Name = "_DataTextArray_22"
        Me._DataTextArray_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_22.Size = New System.Drawing.Size(177, 20)
        Me._DataTextArray_22.TabIndex = 252
        Me._DataTextArray_22.Tag = "SecondaryPatientMiddleName"
        '
        '_DataTextArray_21
        '
        Me._DataTextArray_21.AcceptsReturn = True
        Me._DataTextArray_21.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_21.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_21.Enabled = False
        Me._DataTextArray_21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_21.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_21, CType(21, Short))
        Me._DataTextArray_21.Location = New System.Drawing.Point(80, 16)
        Me._DataTextArray_21.MaxLength = 40
        Me._DataTextArray_21.Name = "_DataTextArray_21"
        Me._DataTextArray_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_21.Size = New System.Drawing.Size(177, 20)
        Me._DataTextArray_21.TabIndex = 251
        Me._DataTextArray_21.Tag = "SecondaryPatientLastName"
        '
        '_DataComboArray_13
        '
        Me._DataComboArray_13.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_13.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_13.Enabled = False
        Me._DataComboArray_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_13.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_13, CType(13, Short))
        Me._DataComboArray_13.Location = New System.Drawing.Point(80, 160)
        Me._DataComboArray_13.Name = "_DataComboArray_13"
        Me._DataComboArray_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_13.Size = New System.Drawing.Size(57, 22)
        Me._DataComboArray_13.TabIndex = 259
        Me._DataComboArray_13.Tag = "SecondaryPatientGender"
        '
        '_DataComboArray_14
        '
        Me._DataComboArray_14.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_14.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_14.Enabled = False
        Me._DataComboArray_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_14.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_14, CType(14, Short))
        Me._DataComboArray_14.Location = New System.Drawing.Point(200, 160)
        Me._DataComboArray_14.Name = "_DataComboArray_14"
        Me._DataComboArray_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_14.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_14.TabIndex = 260
        Me._DataComboArray_14.Tag = "SecondaryPatientRace"
        '
        '_DataTextArray_23
        '
        Me._DataTextArray_23.AcceptsReturn = True
        Me._DataTextArray_23.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_23.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_23.Enabled = False
        Me._DataTextArray_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_23.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_23, CType(23, Short))
        Me._DataTextArray_23.Location = New System.Drawing.Point(80, 64)
        Me._DataTextArray_23.MaxLength = 40
        Me._DataTextArray_23.Name = "_DataTextArray_23"
        Me._DataTextArray_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_23.Size = New System.Drawing.Size(177, 20)
        Me._DataTextArray_23.TabIndex = 253
        Me._DataTextArray_23.Tag = "SecondaryPatientFirstName"

        '
        '_DataLabelArray_63
        '
        Me._DataLabelArray_63.AutoSize = True
        Me._DataLabelArray_63.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_63.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_63.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_63.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_63, CType(63, Short))
        Me._DataLabelArray_63.Location = New System.Drawing.Point(11, 267)
        Me._DataLabelArray_63.Name = "_DataLabelArray_63"
        Me._DataLabelArray_63.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_63.Size = New System.Drawing.Size(66, 14)
        Me._DataLabelArray_63.TabIndex = 634
        Me._DataLabelArray_63.Tag = "lblRegStatus"
        Me._DataLabelArray_63.Text = "Reg. Status:"
        '
        '_DataLabelArray_45
        '
        Me._DataLabelArray_45.AutoSize = True
        Me._DataLabelArray_45.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_45.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_45.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_45.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_45, CType(45, Short))
        Me._DataLabelArray_45.Location = New System.Drawing.Point(44, 235)
        Me._DataLabelArray_45.Name = "_DataLabelArray_45"
        Me._DataLabelArray_45.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_45.Size = New System.Drawing.Size(33, 14)
        Me._DataLabelArray_45.TabIndex = 559
        Me._DataLabelArray_45.Tag = "lblSecondaryPatientABO"
        Me._DataLabelArray_45.Text = "ABO:"
        '
        '_DataLabelArray_10
        '
        Me._DataLabelArray_10.AutoSize = True
        Me._DataLabelArray_10.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_10, CType(10, Short))
        Me._DataLabelArray_10.Location = New System.Drawing.Point(38, 91)
        Me._DataLabelArray_10.Name = "_DataLabelArray_10"
        Me._DataLabelArray_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_10.Size = New System.Drawing.Size(39, 14)
        Me._DataLabelArray_10.TabIndex = 558
        Me._DataLabelArray_10.Tag = "lblSecondaryPatientSuffix"
        Me._DataLabelArray_10.Text = "Suffix:"
        '
        '_DataLabelArray_74
        '
        Me._DataLabelArray_74.AutoSize = True
        Me._DataLabelArray_74.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_74.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_74.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_74.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_74, CType(74, Short))
        Me._DataLabelArray_74.Location = New System.Drawing.Point(50, 211)
        Me._DataLabelArray_74.Name = "_DataLabelArray_74"
        Me._DataLabelArray_74.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_74.Size = New System.Drawing.Size(27, 14)
        Me._DataLabelArray_74.TabIndex = 496
        Me._DataLabelArray_74.Tag = "lblSecondaryPatientBMICalc"
        Me._DataLabelArray_74.Text = "BMI:"
        '
        '_DataLabelArray_72
        '
        Me._DataLabelArray_72.AutoSize = True
        Me._DataLabelArray_72.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_72.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_72.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_72.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_72, CType(72, Short))
        Me._DataLabelArray_72.Location = New System.Drawing.Point(184, 187)
        Me._DataLabelArray_72.Name = "_DataLabelArray_72"
        Me._DataLabelArray_72.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_72.Size = New System.Drawing.Size(20, 14)
        Me._DataLabelArray_72.TabIndex = 495
        Me._DataLabelArray_72.Tag = "lblSecondaryPatientHeightFeet"
        Me._DataLabelArray_72.Text = "Ht:"
        '
        '_DataLabelArray_71
        '
        Me._DataLabelArray_71.AutoSize = True
        Me._DataLabelArray_71.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_71.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_71.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_71.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_71, CType(71, Short))
        Me._DataLabelArray_71.Location = New System.Drawing.Point(48, 187)
        Me._DataLabelArray_71.Name = "_DataLabelArray_71"
        Me._DataLabelArray_71.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_71.Size = New System.Drawing.Size(29, 14)
        Me._DataLabelArray_71.TabIndex = 494
        Me._DataLabelArray_71.Tag = "lblSecondaryPatientWeight"
        Me._DataLabelArray_71.Text = "Wgt:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.SystemColors.Control
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label2.Location = New System.Drawing.Point(158, 213)
        Me.Label2.Name = "Label2"
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(32, 12)
        Me.Label2.TabIndex = 493
        Me.Label2.Text = "kg/(m)"
        Me.Label2.Visible = False
        '
        'lblWeight
        '
        Me.lblWeight.AutoSize = True
        Me.lblWeight.BackColor = System.Drawing.SystemColors.Control
        Me.lblWeight.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblWeight.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblWeight.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblWeight.Location = New System.Drawing.Point(135, 191)
        Me.lblWeight.Name = "lblWeight"
        Me.lblWeight.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblWeight.Size = New System.Drawing.Size(15, 12)
        Me.lblWeight.TabIndex = 492
        Me.lblWeight.Text = "kg"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.BackColor = System.Drawing.SystemColors.Control
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label5.Location = New System.Drawing.Point(240, 191)
        Me.Label5.Name = "Label5"
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(12, 12)
        Me.Label5.TabIndex = 491
        Me.Label5.Text = "ft"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.BackColor = System.Drawing.SystemColors.Control
        Me.Label6.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label6.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label6.Location = New System.Drawing.Point(304, 192)
        Me.Label6.Name = "Label6"
        Me.Label6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label6.Size = New System.Drawing.Size(12, 12)
        Me.Label6.TabIndex = 490
        Me.Label6.Text = "in"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.SystemColors.Control
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Font = New System.Drawing.Font("Arial", 5.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label3.Location = New System.Drawing.Point(188, 206)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(8, 7)
        Me.Label3.TabIndex = 489
        Me.Label3.Text = "2"
        Me.Label3.Visible = False
        '
        '_DataLabelArray_41
        '
        Me._DataLabelArray_41.AutoSize = True
        Me._DataLabelArray_41.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_41.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_41.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_41.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_41, CType(41, Short))
        Me._DataLabelArray_41.Location = New System.Drawing.Point(46, 115)
        Me._DataLabelArray_41.Name = "_DataLabelArray_41"
        Me._DataLabelArray_41.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_41.Size = New System.Drawing.Size(31, 14)
        Me._DataLabelArray_41.TabIndex = 94
        Me._DataLabelArray_41.Tag = "lblSecondaryPatientSSN"
        Me._DataLabelArray_41.Text = "SSN:"
        '
        '_DataLabelArray_38
        '
        Me._DataLabelArray_38.AutoSize = True
        Me._DataLabelArray_38.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_38.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_38.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_38.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_38, CType(38, Short))
        Me._DataLabelArray_38.Location = New System.Drawing.Point(168, 139)
        Me._DataLabelArray_38.Name = "_DataLabelArray_38"
        Me._DataLabelArray_38.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_38.Size = New System.Drawing.Size(30, 14)
        Me._DataLabelArray_38.TabIndex = 93
        Me._DataLabelArray_38.Tag = "lblSecondaryPatientAge"
        Me._DataLabelArray_38.Text = "Age:"
        '
        '_DataLabelArray_37
        '
        Me._DataLabelArray_37.AutoSize = True
        Me._DataLabelArray_37.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_37.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_37.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_37.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_37, CType(37, Short))
        Me._DataLabelArray_37.Location = New System.Drawing.Point(45, 139)
        Me._DataLabelArray_37.Name = "_DataLabelArray_37"
        Me._DataLabelArray_37.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_37.Size = New System.Drawing.Size(32, 14)
        Me._DataLabelArray_37.TabIndex = 92
        Me._DataLabelArray_37.Tag = "lblSecondaryPatientDOB"
        Me._DataLabelArray_37.Text = "DOB:"
        '
        '_DataLabelArray_35
        '
        Me._DataLabelArray_35.AutoSize = True
        Me._DataLabelArray_35.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_35.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_35.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_35.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_35, CType(35, Short))
        Me._DataLabelArray_35.Location = New System.Drawing.Point(7, 43)
        Me._DataLabelArray_35.Name = "_DataLabelArray_35"
        Me._DataLabelArray_35.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_35.Size = New System.Drawing.Size(70, 14)
        Me._DataLabelArray_35.TabIndex = 91
        Me._DataLabelArray_35.Tag = "lblSecondaryPatientMiddleName"
        Me._DataLabelArray_35.Text = "Middle Name:"
        '
        '_DataLabelArray_34
        '
        Me._DataLabelArray_34.AutoSize = True
        Me._DataLabelArray_34.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_34.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_34.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_34.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_34, CType(34, Short))
        Me._DataLabelArray_34.Location = New System.Drawing.Point(16, 19)
        Me._DataLabelArray_34.Name = "_DataLabelArray_34"
        Me._DataLabelArray_34.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_34.Size = New System.Drawing.Size(61, 14)
        Me._DataLabelArray_34.TabIndex = 90
        Me._DataLabelArray_34.Tag = "lblSecondaryPatientLastName"
        Me._DataLabelArray_34.Text = "Last Name:"
        '
        '_DataLabelArray_39
        '
        Me._DataLabelArray_39.AutoSize = True
        Me._DataLabelArray_39.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_39.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_39.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_39.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_39, CType(39, Short))
        Me._DataLabelArray_39.Location = New System.Drawing.Point(48, 163)
        Me._DataLabelArray_39.Name = "_DataLabelArray_39"
        Me._DataLabelArray_39.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_39.Size = New System.Drawing.Size(29, 14)
        Me._DataLabelArray_39.TabIndex = 89
        Me._DataLabelArray_39.Tag = "lblSecondaryPatientGender"
        Me._DataLabelArray_39.Text = "Sex:"
        '
        '_DataLabelArray_40
        '
        Me._DataLabelArray_40.AutoSize = True
        Me._DataLabelArray_40.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_40.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_40.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_40.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_40, CType(40, Short))
        Me._DataLabelArray_40.Location = New System.Drawing.Point(163, 164)
        Me._DataLabelArray_40.Name = "_DataLabelArray_40"
        Me._DataLabelArray_40.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_40.Size = New System.Drawing.Size(35, 14)
        Me._DataLabelArray_40.TabIndex = 88
        Me._DataLabelArray_40.Tag = "lblSecondaryPatientRace"
        Me._DataLabelArray_40.Text = "Race:"
        '
        '_DataLabelArray_36
        '
        Me._DataLabelArray_36.AutoSize = True
        Me._DataLabelArray_36.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_36.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_36.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_36.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_36, CType(36, Short))
        Me._DataLabelArray_36.Location = New System.Drawing.Point(16, 67)
        Me._DataLabelArray_36.Name = "_DataLabelArray_36"
        Me._DataLabelArray_36.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_36.Size = New System.Drawing.Size(61, 14)
        Me._DataLabelArray_36.TabIndex = 87
        Me._DataLabelArray_36.Tag = "lblSecondaryPatientFirstName"
        Me._DataLabelArray_36.Text = "First Name:"
        '
        '_fmDataFrame_24
        '
        Me._fmDataFrame_24.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_24.Controls.Add(Me._DataComboArray_22)
        Me._fmDataFrame_24.Controls.Add(Me._DataLabelArray_91)
        Me._fmDataFrame_24.Controls.Add(Me._DataItemListArray_1)
        Me._fmDataFrame_24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_24.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_24, CType(24, Short))
        Me._fmDataFrame_24.Location = New System.Drawing.Point(8, 15)
        Me._fmDataFrame_24.Name = "_fmDataFrame_24"
        Me._fmDataFrame_24.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_24.Size = New System.Drawing.Size(443, 294)
        Me._fmDataFrame_24.TabIndex = 550
        Me._fmDataFrame_24.TabStop = False
        Me._fmDataFrame_24.Tag = "t1Medications"
        Me._fmDataFrame_24.Text = "Medications - Tab 1"
        '
        '_DataComboArray_22
        '
        Me._DataComboArray_22.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_22.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_22.Enabled = False
        Me._DataComboArray_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_22.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_22, CType(22, Short))
        Me._DataComboArray_22.Location = New System.Drawing.Point(67, 15)
        Me._DataComboArray_22.Name = "_DataComboArray_22"
        Me._DataComboArray_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_22.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_22.TabIndex = 551
        Me._DataComboArray_22.Tag = "SecondaryAntibiotic"
        '
        '_DataLabelArray_91
        '
        Me._DataLabelArray_91.AutoSize = True
        Me._DataLabelArray_91.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_91.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_91.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_91.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_91, CType(91, Short))
        Me._DataLabelArray_91.Location = New System.Drawing.Point(3, 18)
        Me._DataLabelArray_91.Name = "_DataLabelArray_91"
        Me._DataLabelArray_91.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_91.Size = New System.Drawing.Size(63, 14)
        Me._DataLabelArray_91.TabIndex = 553
        Me._DataLabelArray_91.Tag = "lblSecondaryAntibiotic"
        Me._DataLabelArray_91.Text = "Antibiotics?"
        '
        '_DataItemListArray_1
        '
        Me._DataItemListArray_1.Enabled = False
        Me._DataItemListArray_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataItemListArray_1.Location = New System.Drawing.Point(0, 37)
        Me._DataItemListArray_1.Name = "_DataItemListArray_1"
        Me._DataItemListArray_1.Size = New System.Drawing.Size(440, 265)
        Me._DataItemListArray_1.TabIndex = 554
        Me._DataItemListArray_1.Tag = "SecondaryAntibioticList"
        '
        '_fmDataFrame_12
        '
        Me._fmDataFrame_12.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_12.Controls.Add(Me._DataComboArray_72)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_38)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_39)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_42)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_41)
        Me._fmDataFrame_12.Controls.Add(Me._DataComboArray_18)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_40)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_80)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_20)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_12)
        Me._fmDataFrame_12.Controls.Add(Me._DataTextArray_11)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_48)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_55)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_56)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_60)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_58)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_59)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_33)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_23)
        Me._fmDataFrame_12.Controls.Add(Me._DataLabelArray_22)
        Me._fmDataFrame_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_12, CType(12, Short))
        Me._fmDataFrame_12.Location = New System.Drawing.Point(469, 12)
        Me._fmDataFrame_12.Name = "_fmDataFrame_12"
        Me._fmDataFrame_12.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_12.Size = New System.Drawing.Size(441, 257)
        Me._fmDataFrame_12.TabIndex = 70
        Me._fmDataFrame_12.TabStop = False
        Me._fmDataFrame_12.Tag = "t1Medical/Treatment Info"
        Me._fmDataFrame_12.Text = "Medical/Treatment Info - Tab 1"
        '
        '_DataComboArray_72
        '
        Me._DataComboArray_72.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_72.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_72.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_72.Enabled = False
        Me._DataComboArray_72.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_72.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_72, CType(72, Short))
        Me._DataComboArray_72.Location = New System.Drawing.Point(128, 136)
        Me._DataComboArray_72.Name = "_DataComboArray_72"
        Me._DataComboArray_72.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_72.Size = New System.Drawing.Size(121, 22)
        Me._DataComboArray_72.Sorted = True
        Me._DataComboArray_72.TabIndex = 246
        Me._DataComboArray_72.Tag = "SecondaryRhythm"
        '
        '_DataTextArray_38
        '
        Me._DataTextArray_38.AcceptsReturn = True
        Me._DataTextArray_38.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_38.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_38.Enabled = False
        Me._DataTextArray_38.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_38.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_38, CType(38, Short))
        Me._DataTextArray_38.Location = New System.Drawing.Point(128, 184)
        Me._DataTextArray_38.MaxLength = 0
        Me._DataTextArray_38.Name = "_DataTextArray_38"
        Me._DataTextArray_38.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_38.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_38.TabIndex = 249
        Me._DataTextArray_38.Tag = "SecondaryEMSArrivalToPatientTime"
        '
        '_DataTextArray_39
        '
        Me._DataTextArray_39.AcceptsReturn = True
        Me._DataTextArray_39.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_39.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_39.Enabled = False
        Me._DataTextArray_39.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_39.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_39, CType(39, Short))
        Me._DataTextArray_39.Location = New System.Drawing.Point(128, 208)
        Me._DataTextArray_39.MaxLength = 0
        Me._DataTextArray_39.Name = "_DataTextArray_39"
        Me._DataTextArray_39.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_39.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_39.TabIndex = 250
        Me._DataTextArray_39.Tag = "SecondaryEMSArrivalToHospitalTime"
        '
        '_DataTextArray_42
        '
        Me._DataTextArray_42.AcceptsReturn = True
        Me._DataTextArray_42.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_42.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_42.Enabled = False
        Me._DataTextArray_42.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_42.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_42, CType(42, Short))
        Me._DataTextArray_42.Location = New System.Drawing.Point(180, 160)
        Me._DataTextArray_42.MaxLength = 0
        Me._DataTextArray_42.Name = "_DataTextArray_42"
        Me._DataTextArray_42.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_42.Size = New System.Drawing.Size(50, 20)
        Me._DataTextArray_42.TabIndex = 248
        Me._DataTextArray_42.Tag = "SecondaryLSATime"
        '
        '_DataTextArray_41
        '
        Me._DataTextArray_41.AcceptsReturn = True
        Me._DataTextArray_41.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_41.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_41.Enabled = False
        Me._DataTextArray_41.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_41.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_41, CType(41, Short))
        Me._DataTextArray_41.Location = New System.Drawing.Point(128, 160)
        Me._DataTextArray_41.MaxLength = 0
        Me._DataTextArray_41.Name = "_DataTextArray_41"
        Me._DataTextArray_41.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_41.Size = New System.Drawing.Size(54, 20)
        Me._DataTextArray_41.TabIndex = 247
        Me._DataTextArray_41.Tag = "SecondaryLSADate"
        '
        '_DataComboArray_18
        '
        Me._DataComboArray_18.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_18.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_18.Enabled = False
        Me._DataComboArray_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_18.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_18, CType(18, Short))
        Me._DataComboArray_18.Location = New System.Drawing.Point(128, 88)
        Me._DataComboArray_18.Name = "_DataComboArray_18"
        Me._DataComboArray_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_18.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_18.TabIndex = 244
        Me._DataComboArray_18.Tag = "SecondaryDeathWitnessed"
        '
        '_DataTextArray_40
        '
        Me._DataTextArray_40.AcceptsReturn = True
        Me._DataTextArray_40.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_40.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_40.Enabled = False
        Me._DataTextArray_40.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_40.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_40, CType(40, Short))
        Me._DataTextArray_40.Location = New System.Drawing.Point(128, 112)
        Me._DataTextArray_40.MaxLength = 25
        Me._DataTextArray_40.Name = "_DataTextArray_40"
        Me._DataTextArray_40.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_40.Size = New System.Drawing.Size(177, 20)
        Me._DataTextArray_40.TabIndex = 245
        Me._DataTextArray_40.Tag = "SecondaryDeathWitnessedBy"
        '
        '_DataTextArray_80
        '
        Me._DataTextArray_80.AcceptsReturn = True
        Me._DataTextArray_80.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_80.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_80.Enabled = False
        Me._DataTextArray_80.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_80.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_80, CType(80, Short))
        Me._DataTextArray_80.Location = New System.Drawing.Point(180, 40)
        Me._DataTextArray_80.MaxLength = 0
        Me._DataTextArray_80.Name = "_DataTextArray_80"
        Me._DataTextArray_80.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_80.Size = New System.Drawing.Size(50, 20)
        Me._DataTextArray_80.TabIndex = 242
        Me._DataTextArray_80.Tag = "SecondaryAdmissionTime"
        '
        '_DataTextArray_20
        '
        Me._DataTextArray_20.AcceptsReturn = True
        Me._DataTextArray_20.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_20.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_20.Enabled = False
        Me._DataTextArray_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_20.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_20, CType(20, Short))
        Me._DataTextArray_20.Location = New System.Drawing.Point(128, 64)
        Me._DataTextArray_20.MaxLength = 0
        Me._DataTextArray_20.Name = "_DataTextArray_20"
        Me._DataTextArray_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_20.Size = New System.Drawing.Size(54, 20)
        Me._DataTextArray_20.TabIndex = 243
        Me._DataTextArray_20.Tag = "SecondaryDNRDate"
        '
        '_DataTextArray_12
        '
        Me._DataTextArray_12.AcceptsReturn = True
        Me._DataTextArray_12.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_12.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_12.Enabled = False
        Me._DataTextArray_12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_12.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_12, CType(12, Short))
        Me._DataTextArray_12.Location = New System.Drawing.Point(128, 40)
        Me._DataTextArray_12.MaxLength = 0
        Me._DataTextArray_12.Name = "_DataTextArray_12"
        Me._DataTextArray_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_12.Size = New System.Drawing.Size(54, 20)
        Me._DataTextArray_12.TabIndex = 241
        Me._DataTextArray_12.Tag = "SecondaryAdmissionDate"
        '
        '_DataTextArray_11
        '
        Me._DataTextArray_11.AcceptsReturn = True
        Me._DataTextArray_11.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_11.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_11.Enabled = False
        Me._DataTextArray_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_11.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_11, CType(11, Short))
        Me._DataTextArray_11.Location = New System.Drawing.Point(128, 16)
        Me._DataTextArray_11.MaxLength = 25
        Me._DataTextArray_11.Name = "_DataTextArray_11"
        Me._DataTextArray_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_11.Size = New System.Drawing.Size(201, 20)
        Me._DataTextArray_11.TabIndex = 240
        Me._DataTextArray_11.Tag = "SecondaryAdmissionDiagnosis"
        '
        '_DataLabelArray_48
        '
        Me._DataLabelArray_48.AutoSize = True
        Me._DataLabelArray_48.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_48.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_48.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_48.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_48, CType(48, Short))
        Me._DataLabelArray_48.Location = New System.Drawing.Point(16, 136)
        Me._DataLabelArray_48.Name = "_DataLabelArray_48"
        Me._DataLabelArray_48.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_48.Size = New System.Drawing.Size(110, 14)
        Me._DataLabelArray_48.TabIndex = 580
        Me._DataLabelArray_48.Tag = "lblSecondaryRhythm"
        Me._DataLabelArray_48.Text = "Rhythm When Found:"
        '
        '_DataLabelArray_55
        '
        Me._DataLabelArray_55.AutoSize = True
        Me._DataLabelArray_55.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_55.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_55.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_55.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_55, CType(55, Short))
        Me._DataLabelArray_55.Location = New System.Drawing.Point(40, 184)
        Me._DataLabelArray_55.Name = "_DataLabelArray_55"
        Me._DataLabelArray_55.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_55.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_55.TabIndex = 564
        Me._DataLabelArray_55.Tag = "lblSecondaryEMSArrivalToPatientTime"
        Me._DataLabelArray_55.Text = "EMS to Pt. Time:"
        '
        '_DataLabelArray_56
        '
        Me._DataLabelArray_56.AutoSize = True
        Me._DataLabelArray_56.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_56.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_56.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_56.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_56, CType(56, Short))
        Me._DataLabelArray_56.Location = New System.Drawing.Point(32, 208)
        Me._DataLabelArray_56.Name = "_DataLabelArray_56"
        Me._DataLabelArray_56.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_56.Size = New System.Drawing.Size(90, 14)
        Me._DataLabelArray_56.TabIndex = 563
        Me._DataLabelArray_56.Tag = "lblSecondaryEMSArrivalToHospitalTime"
        Me._DataLabelArray_56.Text = "EMS to Hsp Time:"
        '
        '_DataLabelArray_60
        '
        Me._DataLabelArray_60.AutoSize = True
        Me._DataLabelArray_60.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_60.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_60.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_60.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_60, CType(60, Short))
        Me._DataLabelArray_60.Location = New System.Drawing.Point(48, 160)
        Me._DataLabelArray_60.Name = "_DataLabelArray_60"
        Me._DataLabelArray_60.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_60.Size = New System.Drawing.Size(80, 14)
        Me._DataLabelArray_60.TabIndex = 562
        Me._DataLabelArray_60.Tag = "lblSecondaryLSADate"
        Me._DataLabelArray_60.Text = "LSA Date/Time:"
        '
        '_DataLabelArray_58
        '
        Me._DataLabelArray_58.AutoSize = True
        Me._DataLabelArray_58.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_58.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_58.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_58.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_58, CType(58, Short))
        Me._DataLabelArray_58.Location = New System.Drawing.Point(64, 88)
        Me._DataLabelArray_58.Name = "_DataLabelArray_58"
        Me._DataLabelArray_58.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_58.Size = New System.Drawing.Size(64, 14)
        Me._DataLabelArray_58.TabIndex = 509
        Me._DataLabelArray_58.Tag = "lblSecondaryDeathWitnessed"
        Me._DataLabelArray_58.Text = "Witnessed?"
        '
        '_DataLabelArray_59
        '
        Me._DataLabelArray_59.AutoSize = True
        Me._DataLabelArray_59.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_59.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_59.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_59.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_59, CType(59, Short))
        Me._DataLabelArray_59.Location = New System.Drawing.Point(56, 112)
        Me._DataLabelArray_59.Name = "_DataLabelArray_59"
        Me._DataLabelArray_59.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_59.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_59.TabIndex = 508
        Me._DataLabelArray_59.Tag = "lblSecondaryDeathWitnessedBy"
        Me._DataLabelArray_59.Text = "Witnessed By:"
        '
        '_DataLabelArray_33
        '
        Me._DataLabelArray_33.AutoSize = True
        Me._DataLabelArray_33.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_33.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_33.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_33.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_33, CType(33, Short))
        Me._DataLabelArray_33.Location = New System.Drawing.Point(72, 64)
        Me._DataLabelArray_33.Name = "_DataLabelArray_33"
        Me._DataLabelArray_33.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_33.Size = New System.Drawing.Size(56, 14)
        Me._DataLabelArray_33.TabIndex = 102
        Me._DataLabelArray_33.Tag = "lblSecondaryDNRDate"
        Me._DataLabelArray_33.Text = "DNR Date:"
        '
        '_DataLabelArray_23
        '
        Me._DataLabelArray_23.AutoSize = True
        Me._DataLabelArray_23.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_23, CType(23, Short))
        Me._DataLabelArray_23.Location = New System.Drawing.Point(40, 40)
        Me._DataLabelArray_23.Name = "_DataLabelArray_23"
        Me._DataLabelArray_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_23.Size = New System.Drawing.Size(87, 14)
        Me._DataLabelArray_23.TabIndex = 101
        Me._DataLabelArray_23.Tag = "lblSecondaryAdmissionDate"
        Me._DataLabelArray_23.Text = "Admit Date/Time:"
        '
        '_DataLabelArray_22
        '
        Me._DataLabelArray_22.AutoSize = True
        Me._DataLabelArray_22.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_22, CType(22, Short))
        Me._DataLabelArray_22.Location = New System.Drawing.Point(48, 16)
        Me._DataLabelArray_22.Name = "_DataLabelArray_22"
        Me._DataLabelArray_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_22.Size = New System.Drawing.Size(87, 14)
        Me._DataLabelArray_22.TabIndex = 100
        Me._DataLabelArray_22.Tag = "lblSecondaryAdmissionDiagnosis"
        Me._DataLabelArray_22.Text = "Admit Diagnosis:"
        '
        '_fmDataFrame_26
        '
        Me._fmDataFrame_26.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_26.Controls.Add(Me._DataTextArray_109)
        Me._fmDataFrame_26.Controls.Add(Me._DataTextArray_108)
        Me._fmDataFrame_26.Controls.Add(Me._DataTextArray_107)
        Me._fmDataFrame_26.Controls.Add(Me._DataTextArray_106)
        Me._fmDataFrame_26.Controls.Add(Me._DataComboArray_37)
        Me._fmDataFrame_26.Controls.Add(Me._DataLabelArray_148)
        Me._fmDataFrame_26.Controls.Add(Me._DataLabelArray_147)
        Me._fmDataFrame_26.Controls.Add(Me._DataLabelArray_146)
        Me._fmDataFrame_26.Controls.Add(Me._DataLabelArray_145)
        Me._fmDataFrame_26.Controls.Add(Me._DataLabelArray_143)
        Me._fmDataFrame_26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_26.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_26, CType(26, Short))
        Me._fmDataFrame_26.Location = New System.Drawing.Point(0, 17)
        Me._fmDataFrame_26.Name = "_fmDataFrame_26"
        Me._fmDataFrame_26.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_26.Size = New System.Drawing.Size(417, 313)
        Me._fmDataFrame_26.TabIndex = 155
        Me._fmDataFrame_26.TabStop = False
        Me._fmDataFrame_26.Tag = "t1Blood Sample"
        Me._fmDataFrame_26.Text = "Blood Sample - Tab 1"
        '
        '_DataTextArray_109
        '
        Me._DataTextArray_109.AcceptsReturn = True
        Me._DataTextArray_109.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_109.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_109.Enabled = False
        Me._DataTextArray_109.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_109.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_109, CType(109, Short))
        Me._DataTextArray_109.Location = New System.Drawing.Point(104, 112)
        Me._DataTextArray_109.MaxLength = 0
        Me._DataTextArray_109.Name = "_DataTextArray_109"
        Me._DataTextArray_109.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_109.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_109.TabIndex = 345
        Me._DataTextArray_109.Tag = "SecondaryPostMordemSampleCollectionTime"
        '
        '_DataTextArray_108
        '
        Me._DataTextArray_108.AcceptsReturn = True
        Me._DataTextArray_108.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_108.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_108.Enabled = False
        Me._DataTextArray_108.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_108.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_108, CType(108, Short))
        Me._DataTextArray_108.Location = New System.Drawing.Point(104, 88)
        Me._DataTextArray_108.MaxLength = 0
        Me._DataTextArray_108.Name = "_DataTextArray_108"
        Me._DataTextArray_108.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_108.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_108.TabIndex = 344
        Me._DataTextArray_108.Tag = "SecondaryPostMordemSampleCollectionDate"
        '
        '_DataTextArray_107
        '
        Me._DataTextArray_107.AcceptsReturn = True
        Me._DataTextArray_107.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_107.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_107.Enabled = False
        Me._DataTextArray_107.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_107.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_107, CType(107, Short))
        Me._DataTextArray_107.Location = New System.Drawing.Point(104, 64)
        Me._DataTextArray_107.MaxLength = 25
        Me._DataTextArray_107.Name = "_DataTextArray_107"
        Me._DataTextArray_107.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_107.Size = New System.Drawing.Size(185, 20)
        Me._DataTextArray_107.TabIndex = 343
        Me._DataTextArray_107.Tag = "SecondaryPostMordemSampleContact"
        '
        '_DataTextArray_106
        '
        Me._DataTextArray_106.AcceptsReturn = True
        Me._DataTextArray_106.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_106.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_106.Enabled = False
        Me._DataTextArray_106.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_106.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_106, CType(106, Short))
        Me._DataTextArray_106.Location = New System.Drawing.Point(104, 40)
        Me._DataTextArray_106.MaxLength = 25
        Me._DataTextArray_106.Name = "_DataTextArray_106"
        Me._DataTextArray_106.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_106.Size = New System.Drawing.Size(185, 20)
        Me._DataTextArray_106.TabIndex = 342
        Me._DataTextArray_106.Tag = "SecondaryPostMordemSampleLocation"
        '
        '_DataComboArray_37
        '
        Me._DataComboArray_37.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_37.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_37.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_37.Enabled = False
        Me._DataComboArray_37.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_37.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_37, CType(37, Short))
        Me._DataComboArray_37.Location = New System.Drawing.Point(104, 16)
        Me._DataComboArray_37.Name = "_DataComboArray_37"
        Me._DataComboArray_37.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_37.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_37.TabIndex = 341
        Me._DataComboArray_37.Tag = "SecondaryPostMordemSampleTestSuitable"
        '
        '_DataLabelArray_148
        '
        Me._DataLabelArray_148.AutoSize = True
        Me._DataLabelArray_148.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_148.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_148.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_148.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_148, CType(148, Short))
        Me._DataLabelArray_148.Location = New System.Drawing.Point(25, 115)
        Me._DataLabelArray_148.Name = "_DataLabelArray_148"
        Me._DataLabelArray_148.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_148.Size = New System.Drawing.Size(81, 14)
        Me._DataLabelArray_148.TabIndex = 160
        Me._DataLabelArray_148.Tag = "lblSecondaryPostMordemSampleCollectionTime"
        Me._DataLabelArray_148.Text = "Collection Time:"
        '
        '_DataLabelArray_147
        '
        Me._DataLabelArray_147.AutoSize = True
        Me._DataLabelArray_147.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_147.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_147.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_147.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_147, CType(147, Short))
        Me._DataLabelArray_147.Location = New System.Drawing.Point(25, 91)
        Me._DataLabelArray_147.Name = "_DataLabelArray_147"
        Me._DataLabelArray_147.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_147.Size = New System.Drawing.Size(81, 14)
        Me._DataLabelArray_147.TabIndex = 159
        Me._DataLabelArray_147.Tag = "lblSecondaryPostMordemSampleCollectionDate"
        Me._DataLabelArray_147.Text = "Collection Date:"
        '
        '_DataLabelArray_146
        '
        Me._DataLabelArray_146.AutoSize = True
        Me._DataLabelArray_146.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_146.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_146.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_146.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_146, CType(146, Short))
        Me._DataLabelArray_146.Location = New System.Drawing.Point(10, 67)
        Me._DataLabelArray_146.Name = "_DataLabelArray_146"
        Me._DataLabelArray_146.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_146.Size = New System.Drawing.Size(96, 14)
        Me._DataLabelArray_146.TabIndex = 158
        Me._DataLabelArray_146.Tag = "lbSecondaryPostMordemSampleContact"
        Me._DataLabelArray_146.Text = "Collection Contact:"
        '
        '_DataLabelArray_145
        '
        Me._DataLabelArray_145.AutoSize = True
        Me._DataLabelArray_145.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_145.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_145.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_145.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_145, CType(145, Short))
        Me._DataLabelArray_145.Location = New System.Drawing.Point(6, 43)
        Me._DataLabelArray_145.Name = "_DataLabelArray_145"
        Me._DataLabelArray_145.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_145.Size = New System.Drawing.Size(100, 14)
        Me._DataLabelArray_145.TabIndex = 157
        Me._DataLabelArray_145.Tag = "lblSecondaryPostMordemSampleLocation"
        Me._DataLabelArray_145.Text = "Collection Location:"
        '
        '_DataLabelArray_143
        '
        Me._DataLabelArray_143.AutoSize = True
        Me._DataLabelArray_143.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_143.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_143.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_143.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_143, CType(143, Short))
        Me._DataLabelArray_143.Location = New System.Drawing.Point(17, 19)
        Me._DataLabelArray_143.Name = "_DataLabelArray_143"
        Me._DataLabelArray_143.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_143.Size = New System.Drawing.Size(89, 14)
        Me._DataLabelArray_143.TabIndex = 156
        Me._DataLabelArray_143.Tag = "lbSecondaryPostMordemSampleTestSuitable"
        Me._DataLabelArray_143.Text = "Sample Suitable?"
        '
        '_fmDataFrame_17
        '
        Me._fmDataFrame_17.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_75)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_74)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_73)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_64)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_63)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_62)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_26)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_25)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_24)
        Me._fmDataFrame_17.Controls.Add(Me._DataTextArray_81)
        Me._fmDataFrame_17.Controls.Add(Me._DataTextArray_77)
        Me._fmDataFrame_17.Controls.Add(Me._DataTextArray_73)
        Me._fmDataFrame_17.Controls.Add(Me._DataComboArray_23)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_107)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_106)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_105)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_104)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_103)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_102)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_101)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_100)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_99)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_98)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_97)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_96)
        Me._fmDataFrame_17.Controls.Add(Me._DataLabelArray_95)
        Me._fmDataFrame_17.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_17, CType(17, Short))
        Me._fmDataFrame_17.Location = New System.Drawing.Point(0, 16)
        Me._fmDataFrame_17.Name = "_fmDataFrame_17"
        Me._fmDataFrame_17.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_17.Size = New System.Drawing.Size(417, 345)
        Me._fmDataFrame_17.TabIndex = 73
        Me._fmDataFrame_17.TabStop = False
        Me._fmDataFrame_17.Tag = "t1Fluids"
        Me._fmDataFrame_17.Text = "Fluids - Tab 1"
        '
        '_DataComboArray_75
        '
        Me._DataComboArray_75.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_75.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_75.Enabled = False
        Me._DataComboArray_75.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_75.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_75, CType(75, Short))
        Me._DataComboArray_75.Location = New System.Drawing.Point(128, 288)
        Me._DataComboArray_75.Name = "_DataComboArray_75"
        Me._DataComboArray_75.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_75.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_75.TabIndex = 304
        Me._DataComboArray_75.Tag = "SecondaryBloodProductsReceived3TypeCC"
        Me._DataComboArray_75.Text = "DataComboArray"
        '
        '_DataComboArray_74
        '
        Me._DataComboArray_74.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_74.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_74.Enabled = False
        Me._DataComboArray_74.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_74.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_74, CType(74, Short))
        Me._DataComboArray_74.Location = New System.Drawing.Point(128, 192)
        Me._DataComboArray_74.Name = "_DataComboArray_74"
        Me._DataComboArray_74.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_74.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_74.TabIndex = 300
        Me._DataComboArray_74.Tag = "SecondaryBloodProductsReceived2TypeCC"
        Me._DataComboArray_74.Text = "DataComboArray"
        '
        '_DataComboArray_73
        '
        Me._DataComboArray_73.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_73.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_73.Enabled = False
        Me._DataComboArray_73.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_73.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_73, CType(73, Short))
        Me._DataComboArray_73.Location = New System.Drawing.Point(128, 96)
        Me._DataComboArray_73.Name = "_DataComboArray_73"
        Me._DataComboArray_73.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_73.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_73.TabIndex = 296
        Me._DataComboArray_73.Tag = "SecondaryBloodProductsReceived1TypeCC"
        Me._DataComboArray_73.Text = "DataComboArray"
        '
        '_DataComboArray_64
        '
        Me._DataComboArray_64.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_64.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_64.Enabled = False
        Me._DataComboArray_64.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_64.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_64, CType(64, Short))
        Me._DataComboArray_64.Location = New System.Drawing.Point(128, 240)
        Me._DataComboArray_64.Name = "_DataComboArray_64"
        Me._DataComboArray_64.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_64.Size = New System.Drawing.Size(281, 22)
        Me._DataComboArray_64.TabIndex = 302
        Me._DataComboArray_64.Tag = "SecondaryBloodProductsReceived3Type"
        Me._DataComboArray_64.Text = "DataComboArray"
        '
        '_DataComboArray_63
        '
        Me._DataComboArray_63.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_63.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_63.Enabled = False
        Me._DataComboArray_63.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_63.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_63, CType(63, Short))
        Me._DataComboArray_63.Location = New System.Drawing.Point(128, 144)
        Me._DataComboArray_63.Name = "_DataComboArray_63"
        Me._DataComboArray_63.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_63.Size = New System.Drawing.Size(281, 22)
        Me._DataComboArray_63.TabIndex = 298
        Me._DataComboArray_63.Tag = "SecondaryBloodProductsReceived2Type"
        Me._DataComboArray_63.Text = "DataComboArray"
        '
        '_DataComboArray_62
        '
        Me._DataComboArray_62.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_62.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_62.Enabled = False
        Me._DataComboArray_62.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_62.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_62, CType(62, Short))
        Me._DataComboArray_62.Location = New System.Drawing.Point(128, 48)
        Me._DataComboArray_62.Name = "_DataComboArray_62"
        Me._DataComboArray_62.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_62.Size = New System.Drawing.Size(281, 22)
        Me._DataComboArray_62.TabIndex = 294
        Me._DataComboArray_62.Tag = "SecondaryBloodProductsReceived1Type"
        Me._DataComboArray_62.Text = "DataComboArray"
        '
        '_DataComboArray_26
        '
        Me._DataComboArray_26.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_26.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_26.Enabled = False
        Me._DataComboArray_26.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_26.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_26, CType(26, Short))
        Me._DataComboArray_26.Location = New System.Drawing.Point(128, 312)
        Me._DataComboArray_26.Name = "_DataComboArray_26"
        Me._DataComboArray_26.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_26.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_26.TabIndex = 305
        Me._DataComboArray_26.Tag = "SecondaryBloodProductsReceived3TypeUnitGiven"
        Me._DataComboArray_26.Text = "DataComboArray"
        '
        '_DataComboArray_25
        '
        Me._DataComboArray_25.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_25.Enabled = False
        Me._DataComboArray_25.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_25.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_25, CType(25, Short))
        Me._DataComboArray_25.Location = New System.Drawing.Point(128, 216)
        Me._DataComboArray_25.Name = "_DataComboArray_25"
        Me._DataComboArray_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_25.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_25.TabIndex = 301
        Me._DataComboArray_25.Tag = "SecondaryBloodProductsReceived2TypeUnitGiven"
        Me._DataComboArray_25.Text = "DataComboArray"
        '
        '_DataComboArray_24
        '
        Me._DataComboArray_24.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_24.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_24.Enabled = False
        Me._DataComboArray_24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_24.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_24, CType(24, Short))
        Me._DataComboArray_24.Location = New System.Drawing.Point(128, 120)
        Me._DataComboArray_24.Name = "_DataComboArray_24"
        Me._DataComboArray_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_24.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_24.TabIndex = 297
        Me._DataComboArray_24.Tag = "SecondaryBloodProductsReceived1TypeUnitGiven"
        Me._DataComboArray_24.Text = "DataComboArray"
        '
        '_DataTextArray_81
        '
        Me._DataTextArray_81.AcceptsReturn = True
        Me._DataTextArray_81.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_81.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_81.Enabled = False
        Me._DataTextArray_81.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_81.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_81, CType(81, Short))
        Me._DataTextArray_81.Location = New System.Drawing.Point(128, 264)
        Me._DataTextArray_81.MaxLength = 25
        Me._DataTextArray_81.Name = "_DataTextArray_81"
        Me._DataTextArray_81.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_81.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_81.TabIndex = 303
        Me._DataTextArray_81.Tag = "SecondaryBloodProductsReceived3Units"
        '
        '_DataTextArray_77
        '
        Me._DataTextArray_77.AcceptsReturn = True
        Me._DataTextArray_77.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_77.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_77.Enabled = False
        Me._DataTextArray_77.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_77.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_77, CType(77, Short))
        Me._DataTextArray_77.Location = New System.Drawing.Point(128, 168)
        Me._DataTextArray_77.MaxLength = 25
        Me._DataTextArray_77.Name = "_DataTextArray_77"
        Me._DataTextArray_77.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_77.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_77.TabIndex = 299
        Me._DataTextArray_77.Tag = "SecondaryBloodProductsReceived2Units"
        '
        '_DataTextArray_73
        '
        Me._DataTextArray_73.AcceptsReturn = True
        Me._DataTextArray_73.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_73.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_73.Enabled = False
        Me._DataTextArray_73.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_73.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_73, CType(73, Short))
        Me._DataTextArray_73.Location = New System.Drawing.Point(128, 72)
        Me._DataTextArray_73.MaxLength = 25
        Me._DataTextArray_73.Name = "_DataTextArray_73"
        Me._DataTextArray_73.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_73.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_73.TabIndex = 295
        Me._DataTextArray_73.Tag = "SecondaryBloodProductsReceived1Units"
        '
        '_DataComboArray_23
        '
        Me._DataComboArray_23.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_23.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_23.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_23.Enabled = False
        Me._DataComboArray_23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_23.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_23, CType(23, Short))
        Me._DataComboArray_23.Location = New System.Drawing.Point(336, 22)
        Me._DataComboArray_23.Name = "_DataComboArray_23"
        Me._DataComboArray_23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_23.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_23.TabIndex = 293
        Me._DataComboArray_23.Tag = "SecondaryBloodProducts"
        '
        '_DataLabelArray_107
        '
        Me._DataLabelArray_107.AutoSize = True
        Me._DataLabelArray_107.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_107.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_107.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_107.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_107, CType(107, Short))
        Me._DataLabelArray_107.Location = New System.Drawing.Point(8, 315)
        Me._DataLabelArray_107.Name = "_DataLabelArray_107"
        Me._DataLabelArray_107.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_107.Size = New System.Drawing.Size(122, 14)
        Me._DataLabelArray_107.TabIndex = 117
        Me._DataLabelArray_107.Tag = "lblSecondaryBloodProductsReceived3TypeUnitGiven"
        Me._DataLabelArray_107.Text = "Product 3 where Given:"
        '
        '_DataLabelArray_106
        '
        Me._DataLabelArray_106.AutoSize = True
        Me._DataLabelArray_106.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_106.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_106.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_106.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_106, CType(106, Short))
        Me._DataLabelArray_106.Location = New System.Drawing.Point(85, 291)
        Me._DataLabelArray_106.Name = "_DataLabelArray_106"
        Me._DataLabelArray_106.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_106.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_106.TabIndex = 116
        Me._DataLabelArray_106.Tag = "lblSecondaryBloodProductsReceived3TypeCC"
        Me._DataLabelArray_106.Text = "CC/Unit:"
        '
        '_DataLabelArray_105
        '
        Me._DataLabelArray_105.AutoSize = True
        Me._DataLabelArray_105.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_105.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_105.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_105.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_105, CType(105, Short))
        Me._DataLabelArray_105.Location = New System.Drawing.Point(47, 267)
        Me._DataLabelArray_105.Name = "_DataLabelArray_105"
        Me._DataLabelArray_105.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_105.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_105.TabIndex = 115
        Me._DataLabelArray_105.Tag = "lblSecondaryBloodProductsReceived3Units"
        Me._DataLabelArray_105.Text = "Product 3 Units:"
        '
        '_DataLabelArray_104
        '
        Me._DataLabelArray_104.AutoSize = True
        Me._DataLabelArray_104.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_104.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_104.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_104.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_104, CType(104, Short))
        Me._DataLabelArray_104.Location = New System.Drawing.Point(47, 243)
        Me._DataLabelArray_104.Name = "_DataLabelArray_104"
        Me._DataLabelArray_104.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_104.Size = New System.Drawing.Size(82, 14)
        Me._DataLabelArray_104.TabIndex = 114
        Me._DataLabelArray_104.Tag = "lblSecondaryBloodProductsReceived3Type"
        Me._DataLabelArray_104.Text = "Product 3 Type:"
        '
        '_DataLabelArray_103
        '
        Me._DataLabelArray_103.AutoSize = True
        Me._DataLabelArray_103.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_103.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_103.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_103.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_103, CType(103, Short))
        Me._DataLabelArray_103.Location = New System.Drawing.Point(8, 219)
        Me._DataLabelArray_103.Name = "_DataLabelArray_103"
        Me._DataLabelArray_103.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_103.Size = New System.Drawing.Size(122, 14)
        Me._DataLabelArray_103.TabIndex = 113
        Me._DataLabelArray_103.Tag = "lblSecondaryBloodProductsReceived2TypeUnitGiven"
        Me._DataLabelArray_103.Text = "Product 2 where Given:"
        '
        '_DataLabelArray_102
        '
        Me._DataLabelArray_102.AutoSize = True
        Me._DataLabelArray_102.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_102.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_102.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_102.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_102, CType(102, Short))
        Me._DataLabelArray_102.Location = New System.Drawing.Point(85, 195)
        Me._DataLabelArray_102.Name = "_DataLabelArray_102"
        Me._DataLabelArray_102.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_102.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_102.TabIndex = 112
        Me._DataLabelArray_102.Tag = "lblSecondaryBloodProductsReceived2TypeCC"
        Me._DataLabelArray_102.Text = "CC/Unit:"
        '
        '_DataLabelArray_101
        '
        Me._DataLabelArray_101.AutoSize = True
        Me._DataLabelArray_101.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_101.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_101.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_101.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_101, CType(101, Short))
        Me._DataLabelArray_101.Location = New System.Drawing.Point(47, 171)
        Me._DataLabelArray_101.Name = "_DataLabelArray_101"
        Me._DataLabelArray_101.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_101.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_101.TabIndex = 111
        Me._DataLabelArray_101.Tag = "lblSecondaryBloodProductsReceived2Units"
        Me._DataLabelArray_101.Text = "Product 2 Units:"
        '
        '_DataLabelArray_100
        '
        Me._DataLabelArray_100.AutoSize = True
        Me._DataLabelArray_100.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_100.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_100.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_100.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_100, CType(100, Short))
        Me._DataLabelArray_100.Location = New System.Drawing.Point(47, 147)
        Me._DataLabelArray_100.Name = "_DataLabelArray_100"
        Me._DataLabelArray_100.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_100.Size = New System.Drawing.Size(82, 14)
        Me._DataLabelArray_100.TabIndex = 110
        Me._DataLabelArray_100.Tag = "lblSecondaryBloodProductsReceived2Type"
        Me._DataLabelArray_100.Text = "Product 2 Type:"
        '
        '_DataLabelArray_99
        '
        Me._DataLabelArray_99.AutoSize = True
        Me._DataLabelArray_99.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_99.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_99.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_99.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_99, CType(99, Short))
        Me._DataLabelArray_99.Location = New System.Drawing.Point(8, 123)
        Me._DataLabelArray_99.Name = "_DataLabelArray_99"
        Me._DataLabelArray_99.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_99.Size = New System.Drawing.Size(122, 14)
        Me._DataLabelArray_99.TabIndex = 109
        Me._DataLabelArray_99.Tag = "lblSecondaryBloodProductsReceived1TypeUnitGiven"
        Me._DataLabelArray_99.Text = "Product 1 where Given:"
        '
        '_DataLabelArray_98
        '
        Me._DataLabelArray_98.AutoSize = True
        Me._DataLabelArray_98.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_98.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_98.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_98.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_98, CType(98, Short))
        Me._DataLabelArray_98.Location = New System.Drawing.Point(85, 99)
        Me._DataLabelArray_98.Name = "_DataLabelArray_98"
        Me._DataLabelArray_98.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_98.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_98.TabIndex = 108
        Me._DataLabelArray_98.Tag = "lblSecondaryBloodProductsReceived1TypeCC"
        Me._DataLabelArray_98.Text = "CC/Unit:"
        '
        '_DataLabelArray_97
        '
        Me._DataLabelArray_97.AutoSize = True
        Me._DataLabelArray_97.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_97.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_97.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_97.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_97, CType(97, Short))
        Me._DataLabelArray_97.Location = New System.Drawing.Point(47, 75)
        Me._DataLabelArray_97.Name = "_DataLabelArray_97"
        Me._DataLabelArray_97.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_97.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_97.TabIndex = 107
        Me._DataLabelArray_97.Tag = "lblSecondaryBloodProductsReceived1Units"
        Me._DataLabelArray_97.Text = "Product 1 Units:"
        '
        '_DataLabelArray_96
        '
        Me._DataLabelArray_96.AutoSize = True
        Me._DataLabelArray_96.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_96.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_96.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_96.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_96, CType(96, Short))
        Me._DataLabelArray_96.Location = New System.Drawing.Point(47, 51)
        Me._DataLabelArray_96.Name = "_DataLabelArray_96"
        Me._DataLabelArray_96.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_96.Size = New System.Drawing.Size(82, 14)
        Me._DataLabelArray_96.TabIndex = 106
        Me._DataLabelArray_96.Tag = "lblSecondaryBloodProductsReceived1Type"
        Me._DataLabelArray_96.Text = "Product 1 Type:"
        '
        '_DataLabelArray_95
        '
        Me._DataLabelArray_95.AutoSize = True
        Me._DataLabelArray_95.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_95.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_95.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_95.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_95, CType(95, Short))
        Me._DataLabelArray_95.Location = New System.Drawing.Point(25, 26)
        Me._DataLabelArray_95.Name = "_DataLabelArray_95"
        Me._DataLabelArray_95.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_95.Size = New System.Drawing.Size(309, 14)
        Me._DataLabelArray_95.TabIndex = 105
        Me._DataLabelArray_95.Tag = "lblSecondaryBloodProducts"
        Me._DataLabelArray_95.Text = "Blood/Blood Products Received in the 48 hours prior to death?:"
        '
        '_fmDataFrame_3
        '
        Me._fmDataFrame_3.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_127)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_126)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_125)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_124)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_123)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_122)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_121)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_120)
        Me._fmDataFrame_3.Controls.Add(Me._DataTextArray_119)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_165)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_164)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_163)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_162)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_161)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_160)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_159)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_158)
        Me._fmDataFrame_3.Controls.Add(Me._DataLabelArray_157)
        Me._fmDataFrame_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_3, CType(3, Short))
        Me._fmDataFrame_3.Location = New System.Drawing.Point(0, 17)
        Me._fmDataFrame_3.Name = "_fmDataFrame_3"
        Me._fmDataFrame_3.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_3.Size = New System.Drawing.Size(441, 297)
        Me._fmDataFrame_3.TabIndex = 170
        Me._fmDataFrame_3.TabStop = False
        Me._fmDataFrame_3.Tag = "t1Labs"
        Me._fmDataFrame_3.Text = "Labs - Tab 1"
        Me._fmDataFrame_3.Visible = False
        '
        '_DataTextArray_127
        '
        Me._DataTextArray_127.AcceptsReturn = True
        Me._DataTextArray_127.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_127.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_127.Enabled = False
        Me._DataTextArray_127.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_127.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_127, CType(127, Short))
        Me._DataTextArray_127.Location = New System.Drawing.Point(88, 208)
        Me._DataTextArray_127.MaxLength = 25
        Me._DataTextArray_127.Name = "_DataTextArray_127"
        Me._DataTextArray_127.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_127.Size = New System.Drawing.Size(121, 20)
        Me._DataTextArray_127.TabIndex = 363
        Me._DataTextArray_127.Tag = "SecondaryLabTemp3"
        '
        '_DataTextArray_126
        '
        Me._DataTextArray_126.AcceptsReturn = True
        Me._DataTextArray_126.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_126.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_126.Enabled = False
        Me._DataTextArray_126.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_126.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_126, CType(126, Short))
        Me._DataTextArray_126.Location = New System.Drawing.Point(88, 184)
        Me._DataTextArray_126.MaxLength = 0
        Me._DataTextArray_126.Name = "_DataTextArray_126"
        Me._DataTextArray_126.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_126.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_126.TabIndex = 362
        Me._DataTextArray_126.Tag = "SecondaryLabTemp3Time"
        '
        '_DataTextArray_125
        '
        Me._DataTextArray_125.AcceptsReturn = True
        Me._DataTextArray_125.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_125.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_125.Enabled = False
        Me._DataTextArray_125.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_125.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_125, CType(125, Short))
        Me._DataTextArray_125.Location = New System.Drawing.Point(88, 160)
        Me._DataTextArray_125.MaxLength = 0
        Me._DataTextArray_125.Name = "_DataTextArray_125"
        Me._DataTextArray_125.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_125.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_125.TabIndex = 361
        Me._DataTextArray_125.Tag = "SecondaryLabTemp3Date"
        '
        '_DataTextArray_124
        '
        Me._DataTextArray_124.AcceptsReturn = True
        Me._DataTextArray_124.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_124.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_124.Enabled = False
        Me._DataTextArray_124.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_124.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_124, CType(124, Short))
        Me._DataTextArray_124.Location = New System.Drawing.Point(88, 136)
        Me._DataTextArray_124.MaxLength = 25
        Me._DataTextArray_124.Name = "_DataTextArray_124"
        Me._DataTextArray_124.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_124.Size = New System.Drawing.Size(121, 20)
        Me._DataTextArray_124.TabIndex = 360
        Me._DataTextArray_124.Tag = "SecondaryLabTemp2"
        '
        '_DataTextArray_123
        '
        Me._DataTextArray_123.AcceptsReturn = True
        Me._DataTextArray_123.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_123.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_123.Enabled = False
        Me._DataTextArray_123.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_123.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_123, CType(123, Short))
        Me._DataTextArray_123.Location = New System.Drawing.Point(88, 112)
        Me._DataTextArray_123.MaxLength = 0
        Me._DataTextArray_123.Name = "_DataTextArray_123"
        Me._DataTextArray_123.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_123.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_123.TabIndex = 359
        Me._DataTextArray_123.Tag = "SecondaryLabTemp2Time"
        '
        '_DataTextArray_122
        '
        Me._DataTextArray_122.AcceptsReturn = True
        Me._DataTextArray_122.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_122.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_122.Enabled = False
        Me._DataTextArray_122.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_122.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_122, CType(122, Short))
        Me._DataTextArray_122.Location = New System.Drawing.Point(88, 88)
        Me._DataTextArray_122.MaxLength = 0
        Me._DataTextArray_122.Name = "_DataTextArray_122"
        Me._DataTextArray_122.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_122.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_122.TabIndex = 358
        Me._DataTextArray_122.Tag = "SecondaryLabTemp2Date"
        '
        '_DataTextArray_121
        '
        Me._DataTextArray_121.AcceptsReturn = True
        Me._DataTextArray_121.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_121.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_121.Enabled = False
        Me._DataTextArray_121.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_121.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_121, CType(121, Short))
        Me._DataTextArray_121.Location = New System.Drawing.Point(88, 64)
        Me._DataTextArray_121.MaxLength = 25
        Me._DataTextArray_121.Name = "_DataTextArray_121"
        Me._DataTextArray_121.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_121.Size = New System.Drawing.Size(121, 20)
        Me._DataTextArray_121.TabIndex = 357
        Me._DataTextArray_121.Tag = "SecondaryLabTemp1"
        '
        '_DataTextArray_120
        '
        Me._DataTextArray_120.AcceptsReturn = True
        Me._DataTextArray_120.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_120.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_120.Enabled = False
        Me._DataTextArray_120.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_120.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_120, CType(120, Short))
        Me._DataTextArray_120.Location = New System.Drawing.Point(88, 40)
        Me._DataTextArray_120.MaxLength = 0
        Me._DataTextArray_120.Name = "_DataTextArray_120"
        Me._DataTextArray_120.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_120.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_120.TabIndex = 356
        Me._DataTextArray_120.Tag = "SecondaryLabTemp1Time"
        '
        '_DataTextArray_119
        '
        Me._DataTextArray_119.AcceptsReturn = True
        Me._DataTextArray_119.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_119.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_119.Enabled = False
        Me._DataTextArray_119.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_119.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_119, CType(119, Short))
        Me._DataTextArray_119.Location = New System.Drawing.Point(88, 16)
        Me._DataTextArray_119.MaxLength = 0
        Me._DataTextArray_119.Name = "_DataTextArray_119"
        Me._DataTextArray_119.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_119.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_119.TabIndex = 355
        Me._DataTextArray_119.Tag = "SecondaryLabTemp1Date"
        '
        '_DataLabelArray_165
        '
        Me._DataLabelArray_165.AutoSize = True
        Me._DataLabelArray_165.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_165.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_165.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_165.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_165, CType(165, Short))
        Me._DataLabelArray_165.Location = New System.Drawing.Point(40, 208)
        Me._DataLabelArray_165.Name = "_DataLabelArray_165"
        Me._DataLabelArray_165.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_165.Size = New System.Drawing.Size(44, 14)
        Me._DataLabelArray_165.TabIndex = 179
        Me._DataLabelArray_165.Tag = "lblSecondaryLabTemp3"
        Me._DataLabelArray_165.Text = "Temp 3:"
        '
        '_DataLabelArray_164
        '
        Me._DataLabelArray_164.AutoSize = True
        Me._DataLabelArray_164.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_164.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_164.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_164.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_164, CType(164, Short))
        Me._DataLabelArray_164.Location = New System.Drawing.Point(16, 184)
        Me._DataLabelArray_164.Name = "_DataLabelArray_164"
        Me._DataLabelArray_164.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_164.Size = New System.Drawing.Size(69, 14)
        Me._DataLabelArray_164.TabIndex = 178
        Me._DataLabelArray_164.Tag = "lblSecondaryLabTemp3Time"
        Me._DataLabelArray_164.Text = "Temp 3 Time:"
        '
        '_DataLabelArray_163
        '
        Me._DataLabelArray_163.AutoSize = True
        Me._DataLabelArray_163.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_163.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_163.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_163.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_163, CType(163, Short))
        Me._DataLabelArray_163.Location = New System.Drawing.Point(16, 160)
        Me._DataLabelArray_163.Name = "_DataLabelArray_163"
        Me._DataLabelArray_163.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_163.Size = New System.Drawing.Size(69, 14)
        Me._DataLabelArray_163.TabIndex = 177
        Me._DataLabelArray_163.Tag = "lblSecondaryLabTemp3Date"
        Me._DataLabelArray_163.Text = "Temp 3 Date:"
        '
        '_DataLabelArray_162
        '
        Me._DataLabelArray_162.AutoSize = True
        Me._DataLabelArray_162.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_162.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_162.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_162.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_162, CType(162, Short))
        Me._DataLabelArray_162.Location = New System.Drawing.Point(40, 136)
        Me._DataLabelArray_162.Name = "_DataLabelArray_162"
        Me._DataLabelArray_162.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_162.Size = New System.Drawing.Size(44, 14)
        Me._DataLabelArray_162.TabIndex = 176
        Me._DataLabelArray_162.Tag = "lblSecondaryLabTemp2"
        Me._DataLabelArray_162.Text = "Temp 2:"
        '
        '_DataLabelArray_161
        '
        Me._DataLabelArray_161.AutoSize = True
        Me._DataLabelArray_161.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_161.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_161.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_161.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_161, CType(161, Short))
        Me._DataLabelArray_161.Location = New System.Drawing.Point(16, 112)
        Me._DataLabelArray_161.Name = "_DataLabelArray_161"
        Me._DataLabelArray_161.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_161.Size = New System.Drawing.Size(69, 14)
        Me._DataLabelArray_161.TabIndex = 175
        Me._DataLabelArray_161.Tag = "lblSecondaryLabTemp2Time"
        Me._DataLabelArray_161.Text = "Temp 2 Time:"
        '
        '_DataLabelArray_160
        '
        Me._DataLabelArray_160.AutoSize = True
        Me._DataLabelArray_160.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_160.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_160.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_160.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_160, CType(160, Short))
        Me._DataLabelArray_160.Location = New System.Drawing.Point(16, 88)
        Me._DataLabelArray_160.Name = "_DataLabelArray_160"
        Me._DataLabelArray_160.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_160.Size = New System.Drawing.Size(69, 14)
        Me._DataLabelArray_160.TabIndex = 174
        Me._DataLabelArray_160.Tag = "lblSecondaryLabTemp2Date"
        Me._DataLabelArray_160.Text = "Temp 2 Date:"
        '
        '_DataLabelArray_159
        '
        Me._DataLabelArray_159.AutoSize = True
        Me._DataLabelArray_159.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_159.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_159.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_159.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_159, CType(159, Short))
        Me._DataLabelArray_159.Location = New System.Drawing.Point(40, 64)
        Me._DataLabelArray_159.Name = "_DataLabelArray_159"
        Me._DataLabelArray_159.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_159.Size = New System.Drawing.Size(44, 14)
        Me._DataLabelArray_159.TabIndex = 173
        Me._DataLabelArray_159.Tag = "lblSecondaryLabTemp1"
        Me._DataLabelArray_159.Text = "Temp 1:"
        '
        '_DataLabelArray_158
        '
        Me._DataLabelArray_158.AutoSize = True
        Me._DataLabelArray_158.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_158.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_158.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_158.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_158, CType(158, Short))
        Me._DataLabelArray_158.Location = New System.Drawing.Point(16, 40)
        Me._DataLabelArray_158.Name = "_DataLabelArray_158"
        Me._DataLabelArray_158.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_158.Size = New System.Drawing.Size(69, 14)
        Me._DataLabelArray_158.TabIndex = 172
        Me._DataLabelArray_158.Tag = "lblSecondaryLabTemp1Time"
        Me._DataLabelArray_158.Text = "Temp 1 Time:"
        '
        '_DataLabelArray_157
        '
        Me._DataLabelArray_157.AutoSize = True
        Me._DataLabelArray_157.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_157.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_157.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_157.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_157, CType(157, Short))
        Me._DataLabelArray_157.Location = New System.Drawing.Point(16, 16)
        Me._DataLabelArray_157.Name = "_DataLabelArray_157"
        Me._DataLabelArray_157.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_157.Size = New System.Drawing.Size(69, 14)
        Me._DataLabelArray_157.TabIndex = 171
        Me._DataLabelArray_157.Tag = "lblSecondaryLabTemp1Date"
        Me._DataLabelArray_157.Text = "Temp 1 Date:"
        '
        '_fmDataFrame_27
        '
        Me._fmDataFrame_27.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_27.Controls.Add(Me._DataTextArray_153)
        Me._fmDataFrame_27.Controls.Add(Me._DataTextArray_154)
        Me._fmDataFrame_27.Controls.Add(Me._DataLabelArray_203)
        Me._fmDataFrame_27.Controls.Add(Me._DataLabelArray_201)
        Me._fmDataFrame_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_27.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_27, CType(27, Short))
        Me._fmDataFrame_27.Location = New System.Drawing.Point(0, 14)
        Me._fmDataFrame_27.Name = "_fmDataFrame_27"
        Me._fmDataFrame_27.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_27.Size = New System.Drawing.Size(441, 281)
        Me._fmDataFrame_27.TabIndex = 205
        Me._fmDataFrame_27.TabStop = False
        Me._fmDataFrame_27.Tag = "t1Next Of Kin"
        Me._fmDataFrame_27.Text = "Next Of Kin - Tab 1"
        '
        '_DataTextArray_153
        '
        Me._DataTextArray_153.AcceptsReturn = True
        Me._DataTextArray_153.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_153.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_153.Enabled = False
        Me._DataTextArray_153.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_153.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_153, CType(153, Short))
        Me._DataTextArray_153.Location = New System.Drawing.Point(104, 16)
        Me._DataTextArray_153.MaxLength = 25
        Me._DataTextArray_153.Name = "_DataTextArray_153"
        Me._DataTextArray_153.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_153.Size = New System.Drawing.Size(201, 20)
        Me._DataTextArray_153.TabIndex = 388
        Me._DataTextArray_153.Tag = "SecondaryNOKAltContact"
        '
        '_DataTextArray_154
        '
        Me._DataTextArray_154.AcceptsReturn = True
        Me._DataTextArray_154.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_154.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_154.Enabled = False
        Me._DataTextArray_154.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_154.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_154, CType(154, Short))
        Me._DataTextArray_154.Location = New System.Drawing.Point(104, 40)
        Me._DataTextArray_154.MaxLength = 0
        Me._DataTextArray_154.Name = "_DataTextArray_154"
        Me._DataTextArray_154.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_154.Size = New System.Drawing.Size(113, 20)
        Me._DataTextArray_154.TabIndex = 389
        Me._DataTextArray_154.Tag = "SecondaryNOKAltContactPhone"
        '
        '_DataLabelArray_203
        '
        Me._DataLabelArray_203.AutoSize = True
        Me._DataLabelArray_203.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_203.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_203.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_203.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_203, CType(203, Short))
        Me._DataLabelArray_203.Location = New System.Drawing.Point(8, 16)
        Me._DataLabelArray_203.Name = "_DataLabelArray_203"
        Me._DataLabelArray_203.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_203.Size = New System.Drawing.Size(93, 14)
        Me._DataLabelArray_203.TabIndex = 207
        Me._DataLabelArray_203.Tag = "lblSecondaryNOKAltContact"
        Me._DataLabelArray_203.Text = "Alt Contact Name:"
        '
        '_DataLabelArray_201
        '
        Me._DataLabelArray_201.AutoSize = True
        Me._DataLabelArray_201.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_201.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_201.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_201.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_201, CType(201, Short))
        Me._DataLabelArray_201.Location = New System.Drawing.Point(8, 40)
        Me._DataLabelArray_201.Name = "_DataLabelArray_201"
        Me._DataLabelArray_201.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_201.Size = New System.Drawing.Size(96, 14)
        Me._DataLabelArray_201.TabIndex = 206
        Me._DataLabelArray_201.Tag = "lblSecondaryNOKAltContactPhone"
        Me._DataLabelArray_201.Text = "Alt Contact Phone:"
        '
        '_fmDataFrame_29
        '
        Me._fmDataFrame_29.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_29.Controls.Add(Me._DataComboArray_39)
        Me._fmDataFrame_29.Controls.Add(Me._DataTextArray_66)
        Me._fmDataFrame_29.Controls.Add(Me._DataComboArray_53)
        Me._fmDataFrame_29.Controls.Add(Me._DataComboArray_51)
        Me._fmDataFrame_29.Controls.Add(Me._DataTextArray_162)
        Me._fmDataFrame_29.Controls.Add(Me._DataComboArray_50)
        Me._fmDataFrame_29.Controls.Add(Me._DataTextArray_161)
        Me._fmDataFrame_29.Controls.Add(Me._DataComboArray_52)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_239)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_235)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_214)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_213)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_212)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_211)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_210)
        Me._fmDataFrame_29.Controls.Add(Me._DataLabelArray_209)
        Me._fmDataFrame_29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_29.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_29, CType(29, Short))
        Me._fmDataFrame_29.Location = New System.Drawing.Point(0, 16)
        Me._fmDataFrame_29.Name = "_fmDataFrame_29"
        Me._fmDataFrame_29.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_29.Size = New System.Drawing.Size(425, 273)
        Me._fmDataFrame_29.TabIndex = 230
        Me._fmDataFrame_29.TabStop = False
        Me._fmDataFrame_29.Tag = "t1Coroner"
        Me._fmDataFrame_29.Text = "Coroner - Tab 1"
        '
        '_DataComboArray_39
        '
        Me._DataComboArray_39.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_39.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_39.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_39.Enabled = False
        Me._DataComboArray_39.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_39.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_39, CType(39, Short))
        Me._DataComboArray_39.Location = New System.Drawing.Point(104, 232)
        Me._DataComboArray_39.Name = "_DataComboArray_39"
        Me._DataComboArray_39.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_39.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_39.TabIndex = 408
        Me._DataComboArray_39.Tag = "SecondaryAutopsyReminderYN"
        '
        '_DataTextArray_66
        '
        Me._DataTextArray_66.AcceptsReturn = True
        Me._DataTextArray_66.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_66.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_66.Enabled = False
        Me._DataTextArray_66.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_66.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_66, CType(66, Short))
        Me._DataTextArray_66.Location = New System.Drawing.Point(104, 168)
        Me._DataTextArray_66.MaxLength = 0
        Me._DataTextArray_66.Multiline = True
        Me._DataTextArray_66.Name = "_DataTextArray_66"
        Me._DataTextArray_66.ReadOnly = True
        Me._DataTextArray_66.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_66.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_66.Size = New System.Drawing.Size(305, 59)
        Me._DataTextArray_66.TabIndex = 407
        Me._DataTextArray_66.Tag = "SecondaryAutopsyReminder"
        '
        '_DataComboArray_53
        '
        Me._DataComboArray_53.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_53.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_53.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_53.Enabled = False
        Me._DataComboArray_53.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_53.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_53, CType(53, Short))
        Me._DataComboArray_53.Location = New System.Drawing.Point(160, 112)
        Me._DataComboArray_53.Name = "_DataComboArray_53"
        Me._DataComboArray_53.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_53.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_53.TabIndex = 405
        Me._DataComboArray_53.Tag = "SecondaryAutopsyBloodRequested"
        '
        '_DataComboArray_51
        '
        Me._DataComboArray_51.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_51.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_51.Enabled = False
        Me._DataComboArray_51.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_51.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_51, CType(51, Short))
        Me._DataComboArray_51.Location = New System.Drawing.Point(104, 88)
        Me._DataComboArray_51.Name = "_DataComboArray_51"
        Me._DataComboArray_51.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_51.Size = New System.Drawing.Size(177, 22)
        Me._DataComboArray_51.TabIndex = 404
        Me._DataComboArray_51.Tag = "SecondaryAutopsyLocation"
        '
        '_DataTextArray_162
        '
        Me._DataTextArray_162.AcceptsReturn = True
        Me._DataTextArray_162.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_162.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_162.Enabled = False
        Me._DataTextArray_162.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_162.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_162, CType(162, Short))
        Me._DataTextArray_162.Location = New System.Drawing.Point(104, 64)
        Me._DataTextArray_162.MaxLength = 0
        Me._DataTextArray_162.Name = "_DataTextArray_162"
        Me._DataTextArray_162.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_162.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_162.TabIndex = 403
        Me._DataTextArray_162.Tag = "SecondaryAutopsyTime"
        '
        '_DataComboArray_50
        '
        Me._DataComboArray_50.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_50.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_50.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_50.Enabled = False
        Me._DataComboArray_50.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_50.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_50, CType(50, Short))
        Me._DataComboArray_50.Location = New System.Drawing.Point(104, 16)
        Me._DataComboArray_50.Name = "_DataComboArray_50"
        Me._DataComboArray_50.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_50.Size = New System.Drawing.Size(65, 22)
        Me._DataComboArray_50.TabIndex = 401
        Me._DataComboArray_50.Tag = "SecondaryAutopsy"
        '
        '_DataTextArray_161
        '
        Me._DataTextArray_161.AcceptsReturn = True
        Me._DataTextArray_161.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_161.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_161.Enabled = False
        Me._DataTextArray_161.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_161.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_161, CType(161, Short))
        Me._DataTextArray_161.Location = New System.Drawing.Point(104, 40)
        Me._DataTextArray_161.MaxLength = 0
        Me._DataTextArray_161.Name = "_DataTextArray_161"
        Me._DataTextArray_161.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_161.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_161.TabIndex = 402
        Me._DataTextArray_161.Tag = "SecondaryAutopsyDate"
        '
        '_DataComboArray_52
        '
        Me._DataComboArray_52.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_52.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_52.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_52.Enabled = False
        Me._DataComboArray_52.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_52.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_52, CType(52, Short))
        Me._DataComboArray_52.Location = New System.Drawing.Point(160, 136)
        Me._DataComboArray_52.Name = "_DataComboArray_52"
        Me._DataComboArray_52.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_52.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_52.TabIndex = 406
        Me._DataComboArray_52.Tag = "SecondaryAutopsyCopyRequested"
        '
        '_DataLabelArray_239
        '
        Me._DataLabelArray_239.AutoSize = True
        Me._DataLabelArray_239.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_239.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_239.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_239.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_239, CType(239, Short))
        Me._DataLabelArray_239.Location = New System.Drawing.Point(17, 236)
        Me._DataLabelArray_239.Name = "_DataLabelArray_239"
        Me._DataLabelArray_239.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_239.Size = New System.Drawing.Size(84, 14)
        Me._DataLabelArray_239.TabIndex = 435
        Me._DataLabelArray_239.Tag = "lblSecondaryAutopsyReminderYN"
        Me._DataLabelArray_239.Text = "Reminder (Y/N):"
        '
        '_DataLabelArray_235
        '
        Me._DataLabelArray_235.AutoSize = True
        Me._DataLabelArray_235.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_235.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_235.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_235.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_235, CType(235, Short))
        Me._DataLabelArray_235.Location = New System.Drawing.Point(43, 169)
        Me._DataLabelArray_235.Name = "_DataLabelArray_235"
        Me._DataLabelArray_235.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_235.Size = New System.Drawing.Size(55, 14)
        Me._DataLabelArray_235.TabIndex = 431
        Me._DataLabelArray_235.Tag = "lblSecondaryAutopsyReminder"
        Me._DataLabelArray_235.Text = "Reminder:"
        '
        '_DataLabelArray_214
        '
        Me._DataLabelArray_214.AutoSize = True
        Me._DataLabelArray_214.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_214.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_214.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_214.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_214, CType(214, Short))
        Me._DataLabelArray_214.Location = New System.Drawing.Point(44, 17)
        Me._DataLabelArray_214.Name = "_DataLabelArray_214"
        Me._DataLabelArray_214.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_214.Size = New System.Drawing.Size(54, 14)
        Me._DataLabelArray_214.TabIndex = 271
        Me._DataLabelArray_214.Tag = "lblSecondaryAutopsy"
        Me._DataLabelArray_214.Text = "Autopsy?"
        '
        '_DataLabelArray_213
        '
        Me._DataLabelArray_213.AutoSize = True
        Me._DataLabelArray_213.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_213.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_213.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_213.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_213, CType(213, Short))
        Me._DataLabelArray_213.Location = New System.Drawing.Point(9, 41)
        Me._DataLabelArray_213.Name = "_DataLabelArray_213"
        Me._DataLabelArray_213.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_213.Size = New System.Drawing.Size(88, 14)
        Me._DataLabelArray_213.TabIndex = 270
        Me._DataLabelArray_213.Tag = "lblSecondaryAutopsyDate"
        Me._DataLabelArray_213.Text = "Date of Autopsy:"
        '
        '_DataLabelArray_212
        '
        Me._DataLabelArray_212.AutoSize = True
        Me._DataLabelArray_212.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_212.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_212.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_212.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_212, CType(212, Short))
        Me._DataLabelArray_212.Location = New System.Drawing.Point(9, 65)
        Me._DataLabelArray_212.Name = "_DataLabelArray_212"
        Me._DataLabelArray_212.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_212.Size = New System.Drawing.Size(88, 14)
        Me._DataLabelArray_212.TabIndex = 269
        Me._DataLabelArray_212.Tag = "lblSecondaryAutopsyTime"
        Me._DataLabelArray_212.Text = "Time of Autopsy:"
        '
        '_DataLabelArray_211
        '
        Me._DataLabelArray_211.AutoSize = True
        Me._DataLabelArray_211.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_211.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_211.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_211.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_211, CType(211, Short))
        Me._DataLabelArray_211.Location = New System.Drawing.Point(47, 89)
        Me._DataLabelArray_211.Name = "_DataLabelArray_211"
        Me._DataLabelArray_211.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_211.Size = New System.Drawing.Size(51, 14)
        Me._DataLabelArray_211.TabIndex = 268
        Me._DataLabelArray_211.Tag = "lblSecondaryAutopsyLocation"
        Me._DataLabelArray_211.Text = "Location:"
        '
        '_DataLabelArray_210
        '
        Me._DataLabelArray_210.AutoSize = True
        Me._DataLabelArray_210.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_210.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_210.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_210.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_210, CType(210, Short))
        Me._DataLabelArray_210.Location = New System.Drawing.Point(8, 116)
        Me._DataLabelArray_210.Name = "_DataLabelArray_210"
        Me._DataLabelArray_210.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_210.Size = New System.Drawing.Size(151, 14)
        Me._DataLabelArray_210.TabIndex = 267
        Me._DataLabelArray_210.Tag = "lblSecondaryAutopsyBloodRequested"
        Me._DataLabelArray_210.Text = "Blood Specimens Requested?"
        '
        '_DataLabelArray_209
        '
        Me._DataLabelArray_209.AutoSize = True
        Me._DataLabelArray_209.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_209.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_209.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_209.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_209, CType(209, Short))
        Me._DataLabelArray_209.Location = New System.Drawing.Point(16, 140)
        Me._DataLabelArray_209.Name = "_DataLabelArray_209"
        Me._DataLabelArray_209.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_209.Size = New System.Drawing.Size(144, 14)
        Me._DataLabelArray_209.TabIndex = 266
        Me._DataLabelArray_209.Tag = "lblSecondaryAutopsyCopyRequested"
        Me._DataLabelArray_209.Text = "Autopsy Report Requested?"
        '
        '_tbReferralData_TabPage2
        '
        Me._tbReferralData_TabPage2.AutoScroll = True
        Me._tbReferralData_TabPage2.Controls.Add(Me._fmDataFrame_28)
        Me._tbReferralData_TabPage2.Controls.Add(Me._fmDataFrame_21)
        Me._tbReferralData_TabPage2.Controls.Add(Me._fmDataFrame_18)
        Me._tbReferralData_TabPage2.Controls.Add(Me._fmDataFrame_2)
        Me._tbReferralData_TabPage2.Controls.Add(Me._fmDataFrame_22)
        Me._tbReferralData_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage2.Name = "_tbReferralData_TabPage2"
        Me._tbReferralData_TabPage2.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage2.TabIndex = 2
        Me._tbReferralData_TabPage2.Text = "Tab 2"
        '
        '_fmDataFrame_28
        '
        Me._fmDataFrame_28.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_28.Controls.Add(Me._DataComboArray_47)
        Me._fmDataFrame_28.Controls.Add(Me._DataTextArray_149)
        Me._fmDataFrame_28.Controls.Add(Me._DataLabelArray_199)
        Me._fmDataFrame_28.Controls.Add(Me._DataLabelArray_195)
        Me._fmDataFrame_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_28.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_28, CType(28, Short))
        Me._fmDataFrame_28.Location = New System.Drawing.Point(485, 11)
        Me._fmDataFrame_28.Name = "_fmDataFrame_28"
        Me._fmDataFrame_28.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_28.Size = New System.Drawing.Size(441, 281)
        Me._fmDataFrame_28.TabIndex = 208
        Me._fmDataFrame_28.TabStop = False
        Me._fmDataFrame_28.Tag = "t2Next Of Kin"
        Me._fmDataFrame_28.Text = "Next Of Kin - Tab 2"
        '
        '_DataComboArray_47
        '
        Me._DataComboArray_47.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_47.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_47.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_47.Enabled = False
        Me._DataComboArray_47.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_47.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_47, CType(47, Short))
        Me._DataComboArray_47.Location = New System.Drawing.Point(96, 16)
        Me._DataComboArray_47.Name = "_DataComboArray_47"
        Me._DataComboArray_47.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_47.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_47.TabIndex = 390
        Me._DataComboArray_47.Tag = "SecondaryNOKPostMortemAuthorization"
        '
        '_DataTextArray_149
        '
        Me._DataTextArray_149.AcceptsReturn = True
        Me._DataTextArray_149.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_149.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_149.Enabled = False
        Me._DataTextArray_149.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_149.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_149, CType(149, Short))
        Me._DataTextArray_149.Location = New System.Drawing.Point(96, 40)
        Me._DataTextArray_149.MaxLength = 25
        Me._DataTextArray_149.Multiline = True
        Me._DataTextArray_149.Name = "_DataTextArray_149"
        Me._DataTextArray_149.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_149.Size = New System.Drawing.Size(329, 19)
        Me._DataTextArray_149.TabIndex = 391
        Me._DataTextArray_149.Tag = "SecondaryNOKPostMortemAuthorizationReminder"
        '
        '_DataLabelArray_199
        '
        Me._DataLabelArray_199.AutoSize = True
        Me._DataLabelArray_199.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_199.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_199.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_199.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_199, CType(199, Short))
        Me._DataLabelArray_199.Location = New System.Drawing.Point(4, 17)
        Me._DataLabelArray_199.Name = "_DataLabelArray_199"
        Me._DataLabelArray_199.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_199.Size = New System.Drawing.Size(94, 14)
        Me._DataLabelArray_199.TabIndex = 221
        Me._DataLabelArray_199.Tag = "lblSecondaryNOKPostMortemAuthorization"
        Me._DataLabelArray_199.Text = "Exam Authorized?"
        '
        '_DataLabelArray_195
        '
        Me._DataLabelArray_195.AutoSize = True
        Me._DataLabelArray_195.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_195.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_195.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_195.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_195, CType(195, Short))
        Me._DataLabelArray_195.Location = New System.Drawing.Point(44, 41)
        Me._DataLabelArray_195.Name = "_DataLabelArray_195"
        Me._DataLabelArray_195.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_195.Size = New System.Drawing.Size(55, 14)
        Me._DataLabelArray_195.TabIndex = 220
        Me._DataLabelArray_195.Tag = "lblSecondaryNOKPostMortemAuthorizationReminder"
        Me._DataLabelArray_195.Text = "Reminder:"
        '
        '_fmDataFrame_21
        '
        Me._fmDataFrame_21.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_29)
        Me._fmDataFrame_21.Controls.Add(Me._DataComboArray_61)
        Me._fmDataFrame_21.Controls.Add(Me.cmdPhysicianDetail)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_60)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_61)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_69)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_13)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_18)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_19)
        Me._fmDataFrame_21.Controls.Add(Me._DataComboArray_11)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_54)
        Me._fmDataFrame_21.Controls.Add(Me._DataTextArray_55)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_52)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_83)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_84)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_92)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_93)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_24)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_25)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_31)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_32)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_76)
        Me._fmDataFrame_21.Controls.Add(Me._DataLabelArray_77)
        Me._fmDataFrame_21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_21, CType(21, Short))
        Me._fmDataFrame_21.Location = New System.Drawing.Point(479, 28)
        Me._fmDataFrame_21.Name = "_fmDataFrame_21"
        Me._fmDataFrame_21.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_21.Size = New System.Drawing.Size(444, 273)
        Me._fmDataFrame_21.TabIndex = 95
        Me._fmDataFrame_21.TabStop = False
        Me._fmDataFrame_21.Tag = "t2Patient Info"
        Me._fmDataFrame_21.Text = "Patient Info - Tab 2"
        Me._fmDataFrame_21.Visible = False
        '
        '_DataTextArray_29
        '
        Me._DataTextArray_29.AcceptsReturn = True
        Me._DataTextArray_29.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_29.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_29.Enabled = False
        Me._DataTextArray_29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_29.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_29, CType(29, Short))
        Me._DataTextArray_29.Location = New System.Drawing.Point(117, 70)
        Me._DataTextArray_29.MaxLength = 249
        Me._DataTextArray_29.Name = "_DataTextArray_29"
        Me._DataTextArray_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_29.Size = New System.Drawing.Size(321, 20)
        Me._DataTextArray_29.TabIndex = 531
        Me._DataTextArray_29.Tag = "SecondaryTriageSpecificCOD"
        '
        '_DataComboArray_61
        '
        Me._DataComboArray_61.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_61.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_61.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_61.Enabled = False
        Me._DataComboArray_61.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_61.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_61, CType(61, Short))
        Me._DataComboArray_61.Location = New System.Drawing.Point(117, 187)
        Me._DataComboArray_61.Name = "_DataComboArray_61"
        Me._DataComboArray_61.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_61.Size = New System.Drawing.Size(281, 22)
        Me._DataComboArray_61.Sorted = True
        Me._DataComboArray_61.TabIndex = 536
        Me._DataComboArray_61.Tag = "SecondaryMDAttendingId"
        '
        'cmdPhysicianDetail
        '
        Me.cmdPhysicianDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdPhysicianDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdPhysicianDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdPhysicianDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdPhysicianDetail.Location = New System.Drawing.Point(404, 189)
        Me.cmdPhysicianDetail.Name = "cmdPhysicianDetail"
        Me.cmdPhysicianDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdPhysicianDetail.Size = New System.Drawing.Size(24, 19)
        Me.cmdPhysicianDetail.TabIndex = 510
        Me.cmdPhysicianDetail.Text = "..."
        Me.cmdPhysicianDetail.UseVisualStyleBackColor = False
        '
        '_DataTextArray_60
        '
        Me._DataTextArray_60.AcceptsReturn = True
        Me._DataTextArray_60.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_60.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_60.Enabled = False
        Me._DataTextArray_60.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_60.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_60, CType(60, Short))
        Me._DataTextArray_60.Location = New System.Drawing.Point(117, 141)
        Me._DataTextArray_60.MaxLength = 25
        Me._DataTextArray_60.Name = "_DataTextArray_60"
        Me._DataTextArray_60.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_60.Size = New System.Drawing.Size(321, 20)
        Me._DataTextArray_60.TabIndex = 534
        Me._DataTextArray_60.Tag = "SecondaryPCPName"
        '
        '_DataTextArray_61
        '
        Me._DataTextArray_61.AcceptsReturn = True
        Me._DataTextArray_61.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_61.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_61.Enabled = False
        Me._DataTextArray_61.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_61.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_61, CType(61, Short))
        Me._DataTextArray_61.Location = New System.Drawing.Point(117, 164)
        Me._DataTextArray_61.MaxLength = 0
        Me._DataTextArray_61.Name = "_DataTextArray_61"
        Me._DataTextArray_61.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_61.Size = New System.Drawing.Size(113, 20)
        Me._DataTextArray_61.TabIndex = 535
        Me._DataTextArray_61.Tag = "SecondaryPCPPhone"
        '
        '_DataTextArray_69
        '
        Me._DataTextArray_69.AcceptsReturn = True
        Me._DataTextArray_69.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_69.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_69.Enabled = False
        Me._DataTextArray_69.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_69.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_69, CType(69, Short))
        Me._DataTextArray_69.Location = New System.Drawing.Point(117, 212)
        Me._DataTextArray_69.MaxLength = 0
        Me._DataTextArray_69.Name = "_DataTextArray_69"
        Me._DataTextArray_69.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_69.Size = New System.Drawing.Size(113, 20)
        Me._DataTextArray_69.TabIndex = 537
        Me._DataTextArray_69.Tag = "SecondaryMDAttendingPhone"
        '
        '_DataTextArray_13
        '
        Me._DataTextArray_13.AcceptsReturn = True
        Me._DataTextArray_13.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_13.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_13.Enabled = False
        Me._DataTextArray_13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_13.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_13, CType(13, Short))
        Me._DataTextArray_13.Location = New System.Drawing.Point(117, 118)
        Me._DataTextArray_13.MaxLength = 25
        Me._DataTextArray_13.Name = "_DataTextArray_13"
        Me._DataTextArray_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_13.Size = New System.Drawing.Size(201, 20)
        Me._DataTextArray_13.TabIndex = 533
        Me._DataTextArray_13.Tag = "SecondaryCODSignatory"
        '
        '_DataTextArray_18
        '
        Me._DataTextArray_18.AcceptsReturn = True
        Me._DataTextArray_18.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_18.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_18.Enabled = False
        Me._DataTextArray_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_18.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_18, CType(18, Short))
        Me._DataTextArray_18.Location = New System.Drawing.Point(117, 47)
        Me._DataTextArray_18.MaxLength = 0
        Me._DataTextArray_18.Name = "_DataTextArray_18"
        Me._DataTextArray_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_18.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_18.TabIndex = 529
        Me._DataTextArray_18.Tag = "SecondaryBrainDeathDate"
        '
        '_DataTextArray_19
        '
        Me._DataTextArray_19.AcceptsReturn = True
        Me._DataTextArray_19.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_19.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_19.Enabled = False
        Me._DataTextArray_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_19.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_19, CType(19, Short))
        Me._DataTextArray_19.Location = New System.Drawing.Point(237, 47)
        Me._DataTextArray_19.MaxLength = 0
        Me._DataTextArray_19.Name = "_DataTextArray_19"
        Me._DataTextArray_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_19.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_19.TabIndex = 530
        Me._DataTextArray_19.Tag = "SecondaryBrainDeathTime"
        '
        '_DataComboArray_11
        '
        Me._DataComboArray_11.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_11.Enabled = False
        Me._DataComboArray_11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_11.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_11, CType(11, Short))
        Me._DataComboArray_11.Location = New System.Drawing.Point(117, 93)
        Me._DataComboArray_11.Name = "_DataComboArray_11"
        Me._DataComboArray_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_11.Size = New System.Drawing.Size(201, 22)
        Me._DataComboArray_11.TabIndex = 532
        Me._DataComboArray_11.Tag = "SecondaryCOD"
        Me._DataComboArray_11.Text = "DataComboArray"
        '
        '_DataTextArray_54
        '
        Me._DataTextArray_54.AcceptsReturn = True
        Me._DataTextArray_54.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_54.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_54.Enabled = False
        Me._DataTextArray_54.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_54.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_54, CType(54, Short))
        Me._DataTextArray_54.Location = New System.Drawing.Point(117, 24)
        Me._DataTextArray_54.MaxLength = 0
        Me._DataTextArray_54.Name = "_DataTextArray_54"
        Me._DataTextArray_54.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_54.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_54.TabIndex = 527
        Me._DataTextArray_54.Tag = "SecondaryPatientDOD"
        '
        '_DataTextArray_55
        '
        Me._DataTextArray_55.AcceptsReturn = True
        Me._DataTextArray_55.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_55.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_55.Enabled = False
        Me._DataTextArray_55.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_55.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_55, CType(55, Short))
        Me._DataTextArray_55.Location = New System.Drawing.Point(237, 24)
        Me._DataTextArray_55.MaxLength = 0
        Me._DataTextArray_55.Name = "_DataTextArray_55"
        Me._DataTextArray_55.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_55.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_55.TabIndex = 528
        Me._DataTextArray_55.Tag = "SecondaryPatientTOD"
        '
        '_DataLabelArray_52
        '
        Me._DataLabelArray_52.AutoSize = True
        Me._DataLabelArray_52.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_52.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_52.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_52.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_52, CType(52, Short))
        Me._DataLabelArray_52.Location = New System.Drawing.Point(3, 73)
        Me._DataLabelArray_52.Name = "_DataLabelArray_52"
        Me._DataLabelArray_52.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_52.Size = New System.Drawing.Size(116, 14)
        Me._DataLabelArray_52.TabIndex = 615
        Me._DataLabelArray_52.Tag = "lblSecondaryCOD"
        Me._DataLabelArray_52.Text = "Triage Specific C.O.D.:"
        '
        '_DataLabelArray_83
        '
        Me._DataLabelArray_83.AutoSize = True
        Me._DataLabelArray_83.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_83.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_83.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_83.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_83, CType(83, Short))
        Me._DataLabelArray_83.Location = New System.Drawing.Point(60, 144)
        Me._DataLabelArray_83.Name = "_DataLabelArray_83"
        Me._DataLabelArray_83.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_83.Size = New System.Drawing.Size(59, 14)
        Me._DataLabelArray_83.TabIndex = 506
        Me._DataLabelArray_83.Tag = "lblSecondaryPCPName"
        Me._DataLabelArray_83.Text = "PCP Name:"
        '
        '_DataLabelArray_84
        '
        Me._DataLabelArray_84.AutoSize = True
        Me._DataLabelArray_84.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_84.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_84.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_84.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_84, CType(84, Short))
        Me._DataLabelArray_84.Location = New System.Drawing.Point(57, 167)
        Me._DataLabelArray_84.Name = "_DataLabelArray_84"
        Me._DataLabelArray_84.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_84.Size = New System.Drawing.Size(62, 14)
        Me._DataLabelArray_84.TabIndex = 505
        Me._DataLabelArray_84.Tag = "lblSecondaryPCPPhone"
        Me._DataLabelArray_84.Text = "PCP Phone:"
        '
        '_DataLabelArray_92
        '
        Me._DataLabelArray_92.AutoSize = True
        Me._DataLabelArray_92.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_92.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_92.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_92.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_92, CType(92, Short))
        Me._DataLabelArray_92.Location = New System.Drawing.Point(45, 191)
        Me._DataLabelArray_92.Name = "_DataLabelArray_92"
        Me._DataLabelArray_92.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_92.Size = New System.Drawing.Size(74, 14)
        Me._DataLabelArray_92.TabIndex = 504
        Me._DataLabelArray_92.Tag = "lblSecondaryMDAttending"
        Me._DataLabelArray_92.Text = "Attending MD:"
        '
        '_DataLabelArray_93
        '
        Me._DataLabelArray_93.AutoSize = True
        Me._DataLabelArray_93.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_93.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_93.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_93.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_93, CType(93, Short))
        Me._DataLabelArray_93.Location = New System.Drawing.Point(30, 215)
        Me._DataLabelArray_93.Name = "_DataLabelArray_93"
        Me._DataLabelArray_93.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_93.Size = New System.Drawing.Size(89, 14)
        Me._DataLabelArray_93.TabIndex = 503
        Me._DataLabelArray_93.Tag = "lblSecondaryMDAttendingPhone"
        Me._DataLabelArray_93.Text = "Attending Phone:"
        '
        '_DataLabelArray_24
        '
        Me._DataLabelArray_24.AutoSize = True
        Me._DataLabelArray_24.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_24.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_24.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_24, CType(24, Short))
        Me._DataLabelArray_24.Location = New System.Drawing.Point(34, 97)
        Me._DataLabelArray_24.Name = "_DataLabelArray_24"
        Me._DataLabelArray_24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_24.Size = New System.Drawing.Size(85, 14)
        Me._DataLabelArray_24.TabIndex = 502
        Me._DataLabelArray_24.Tag = "lblSecondaryCOD"
        Me._DataLabelArray_24.Text = "Cause of Death:"
        '
        '_DataLabelArray_25
        '
        Me._DataLabelArray_25.AutoSize = True
        Me._DataLabelArray_25.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_25.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_25.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_25, CType(25, Short))
        Me._DataLabelArray_25.Location = New System.Drawing.Point(46, 121)
        Me._DataLabelArray_25.Name = "_DataLabelArray_25"
        Me._DataLabelArray_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_25.Size = New System.Drawing.Size(73, 14)
        Me._DataLabelArray_25.TabIndex = 501
        Me._DataLabelArray_25.Tag = "lblSecondaryCODSignatory"
        Me._DataLabelArray_25.Text = "DC Signatory:"
        '
        '_DataLabelArray_31
        '
        Me._DataLabelArray_31.AutoSize = True
        Me._DataLabelArray_31.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_31.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_31.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_31.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_31, CType(31, Short))
        Me._DataLabelArray_31.Location = New System.Drawing.Point(28, 50)
        Me._DataLabelArray_31.Name = "_DataLabelArray_31"
        Me._DataLabelArray_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_31.Size = New System.Drawing.Size(91, 14)
        Me._DataLabelArray_31.TabIndex = 500
        Me._DataLabelArray_31.Tag = "lblSecondaryBrainDeathDate"
        Me._DataLabelArray_31.Text = "Brain Death Date:"
        '
        '_DataLabelArray_32
        '
        Me._DataLabelArray_32.AutoSize = True
        Me._DataLabelArray_32.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_32.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_32.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_32.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_32, CType(32, Short))
        Me._DataLabelArray_32.Location = New System.Drawing.Point(205, 50)
        Me._DataLabelArray_32.Name = "_DataLabelArray_32"
        Me._DataLabelArray_32.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_32.Size = New System.Drawing.Size(32, 14)
        Me._DataLabelArray_32.TabIndex = 499
        Me._DataLabelArray_32.Tag = "lblSecondaryBrainDeathTime"
        Me._DataLabelArray_32.Text = "Time:"
        '
        '_DataLabelArray_76
        '
        Me._DataLabelArray_76.AutoSize = True
        Me._DataLabelArray_76.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_76.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_76.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_76.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_76, CType(76, Short))
        Me._DataLabelArray_76.Location = New System.Drawing.Point(35, 27)
        Me._DataLabelArray_76.Name = "_DataLabelArray_76"
        Me._DataLabelArray_76.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_76.Size = New System.Drawing.Size(84, 14)
        Me._DataLabelArray_76.TabIndex = 498
        Me._DataLabelArray_76.Tag = "lblSecondaryPatientDOD"
        Me._DataLabelArray_76.Text = "Declared CTOD:"
        '
        '_DataLabelArray_77
        '
        Me._DataLabelArray_77.AutoSize = True
        Me._DataLabelArray_77.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_77.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_77.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_77.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_77, CType(77, Short))
        Me._DataLabelArray_77.Location = New System.Drawing.Point(205, 27)
        Me._DataLabelArray_77.Name = "_DataLabelArray_77"
        Me._DataLabelArray_77.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_77.Size = New System.Drawing.Size(32, 14)
        Me._DataLabelArray_77.TabIndex = 497
        Me._DataLabelArray_77.Tag = "lblSecondaryPatientTOD"
        Me._DataLabelArray_77.Text = "Time:"
        '
        '_fmDataFrame_18
        '
        Me._fmDataFrame_18.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_78)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_77)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_76)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_67)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_66)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_65)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_27)
        Me._fmDataFrame_18.Controls.Add(Me._DataTextArray_88)
        Me._fmDataFrame_18.Controls.Add(Me._DataTextArray_85)
        Me._fmDataFrame_18.Controls.Add(Me._DataTextArray_79)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_29)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_28)
        Me._fmDataFrame_18.Controls.Add(Me._DataComboArray_30)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_120)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_119)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_118)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_117)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_116)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_115)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_114)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_113)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_112)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_111)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_110)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_109)
        Me._fmDataFrame_18.Controls.Add(Me._DataLabelArray_108)
        Me._fmDataFrame_18.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_18.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_18, CType(18, Short))
        Me._fmDataFrame_18.Location = New System.Drawing.Point(460, 69)
        Me._fmDataFrame_18.Name = "_fmDataFrame_18"
        Me._fmDataFrame_18.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_18.Size = New System.Drawing.Size(417, 345)
        Me._fmDataFrame_18.TabIndex = 118
        Me._fmDataFrame_18.TabStop = False
        Me._fmDataFrame_18.Tag = "t2Fluids"
        Me._fmDataFrame_18.Text = "Fluids - Tab 2"
        '
        '_DataComboArray_78
        '
        Me._DataComboArray_78.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_78.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_78.Enabled = False
        Me._DataComboArray_78.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_78.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_78, CType(78, Short))
        Me._DataComboArray_78.Location = New System.Drawing.Point(120, 280)
        Me._DataComboArray_78.Name = "_DataComboArray_78"
        Me._DataComboArray_78.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_78.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_78.TabIndex = 317
        Me._DataComboArray_78.Tag = "SecondaryColloidsInfused3CC"
        Me._DataComboArray_78.Text = "DataComboArray"
        '
        '_DataComboArray_77
        '
        Me._DataComboArray_77.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_77.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_77.Enabled = False
        Me._DataComboArray_77.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_77.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_77, CType(77, Short))
        Me._DataComboArray_77.Location = New System.Drawing.Point(120, 180)
        Me._DataComboArray_77.Name = "_DataComboArray_77"
        Me._DataComboArray_77.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_77.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_77.TabIndex = 313
        Me._DataComboArray_77.Tag = "SecondaryColloidsInfused2CC"
        Me._DataComboArray_77.Text = "DataComboArray"
        '
        '_DataComboArray_76
        '
        Me._DataComboArray_76.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_76.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_76.Enabled = False
        Me._DataComboArray_76.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_76.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_76, CType(76, Short))
        Me._DataComboArray_76.Location = New System.Drawing.Point(120, 86)
        Me._DataComboArray_76.Name = "_DataComboArray_76"
        Me._DataComboArray_76.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_76.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_76.TabIndex = 309
        Me._DataComboArray_76.Tag = "SecondaryColloidsInfused1CC"
        Me._DataComboArray_76.Text = "DataComboArray"
        '
        '_DataComboArray_67
        '
        Me._DataComboArray_67.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_67.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_67.Enabled = False
        Me._DataComboArray_67.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_67.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_67, CType(67, Short))
        Me._DataComboArray_67.Location = New System.Drawing.Point(120, 232)
        Me._DataComboArray_67.Name = "_DataComboArray_67"
        Me._DataComboArray_67.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_67.Size = New System.Drawing.Size(265, 22)
        Me._DataComboArray_67.TabIndex = 315
        Me._DataComboArray_67.Tag = "SecondaryColloidsInfused3Type"
        Me._DataComboArray_67.Text = "DataComboArray"
        '
        '_DataComboArray_66
        '
        Me._DataComboArray_66.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_66.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_66.Enabled = False
        Me._DataComboArray_66.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_66.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_66, CType(66, Short))
        Me._DataComboArray_66.Location = New System.Drawing.Point(120, 134)
        Me._DataComboArray_66.Name = "_DataComboArray_66"
        Me._DataComboArray_66.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_66.Size = New System.Drawing.Size(265, 22)
        Me._DataComboArray_66.TabIndex = 311
        Me._DataComboArray_66.Tag = "SecondaryColloidsInfused2Type"
        Me._DataComboArray_66.Text = "DataComboArray"
        '
        '_DataComboArray_65
        '
        Me._DataComboArray_65.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_65.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_65.Enabled = False
        Me._DataComboArray_65.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_65.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_65, CType(65, Short))
        Me._DataComboArray_65.Location = New System.Drawing.Point(120, 40)
        Me._DataComboArray_65.Name = "_DataComboArray_65"
        Me._DataComboArray_65.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_65.Size = New System.Drawing.Size(265, 22)
        Me._DataComboArray_65.TabIndex = 307
        Me._DataComboArray_65.Tag = "SecondaryColloidsInfused1Type"
        Me._DataComboArray_65.Text = "DataComboArray"
        '
        '_DataComboArray_27
        '
        Me._DataComboArray_27.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_27.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_27.Enabled = False
        Me._DataComboArray_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_27.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_27, CType(27, Short))
        Me._DataComboArray_27.Location = New System.Drawing.Point(120, 16)
        Me._DataComboArray_27.Name = "_DataComboArray_27"
        Me._DataComboArray_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_27.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_27.TabIndex = 306
        Me._DataComboArray_27.Tag = "SecondaryColloidsInfused"
        '
        '_DataTextArray_88
        '
        Me._DataTextArray_88.AcceptsReturn = True
        Me._DataTextArray_88.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_88.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_88.Enabled = False
        Me._DataTextArray_88.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_88.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_88, CType(88, Short))
        Me._DataTextArray_88.Location = New System.Drawing.Point(120, 64)
        Me._DataTextArray_88.MaxLength = 25
        Me._DataTextArray_88.Name = "_DataTextArray_88"
        Me._DataTextArray_88.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_88.Size = New System.Drawing.Size(73, 20)
        Me._DataTextArray_88.TabIndex = 308
        Me._DataTextArray_88.Tag = "SecondaryColloidsInfused1Units"
        '
        '_DataTextArray_85
        '
        Me._DataTextArray_85.AcceptsReturn = True
        Me._DataTextArray_85.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_85.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_85.Enabled = False
        Me._DataTextArray_85.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_85.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_85, CType(85, Short))
        Me._DataTextArray_85.Location = New System.Drawing.Point(120, 158)
        Me._DataTextArray_85.MaxLength = 25
        Me._DataTextArray_85.Name = "_DataTextArray_85"
        Me._DataTextArray_85.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_85.Size = New System.Drawing.Size(73, 20)
        Me._DataTextArray_85.TabIndex = 312
        Me._DataTextArray_85.Tag = "SecondaryColloidsInfused2Units"
        '
        '_DataTextArray_79
        '
        Me._DataTextArray_79.AcceptsReturn = True
        Me._DataTextArray_79.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_79.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_79.Enabled = False
        Me._DataTextArray_79.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_79.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_79, CType(79, Short))
        Me._DataTextArray_79.Location = New System.Drawing.Point(120, 256)
        Me._DataTextArray_79.MaxLength = 25
        Me._DataTextArray_79.Name = "_DataTextArray_79"
        Me._DataTextArray_79.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_79.Size = New System.Drawing.Size(73, 20)
        Me._DataTextArray_79.TabIndex = 316
        Me._DataTextArray_79.Tag = "SecondaryColloidsInfused3Units"
        '
        '_DataComboArray_29
        '
        Me._DataComboArray_29.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_29.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_29.Enabled = False
        Me._DataComboArray_29.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_29.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_29, CType(29, Short))
        Me._DataComboArray_29.Location = New System.Drawing.Point(120, 110)
        Me._DataComboArray_29.Name = "_DataComboArray_29"
        Me._DataComboArray_29.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_29.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_29.TabIndex = 310
        Me._DataComboArray_29.Tag = "SecondaryColloidsInfused1UnitGiven"
        Me._DataComboArray_29.Text = "DataComboArray"
        '
        '_DataComboArray_28
        '
        Me._DataComboArray_28.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_28.Enabled = False
        Me._DataComboArray_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_28.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_28, CType(28, Short))
        Me._DataComboArray_28.Location = New System.Drawing.Point(120, 204)
        Me._DataComboArray_28.Name = "_DataComboArray_28"
        Me._DataComboArray_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_28.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_28.TabIndex = 314
        Me._DataComboArray_28.Tag = "SecondaryColloidsInfused2UnitGiven"
        Me._DataComboArray_28.Text = "DataComboArray"
        '
        '_DataComboArray_30
        '
        Me._DataComboArray_30.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_30.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_30.Enabled = False
        Me._DataComboArray_30.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_30.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_30, CType(30, Short))
        Me._DataComboArray_30.Location = New System.Drawing.Point(120, 304)
        Me._DataComboArray_30.Name = "_DataComboArray_30"
        Me._DataComboArray_30.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_30.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_30.TabIndex = 318
        Me._DataComboArray_30.Tag = "SecondaryColloidsInfused3UnitGiven"
        Me._DataComboArray_30.Text = "DataComboArray"
        '
        '_DataLabelArray_120
        '
        Me._DataLabelArray_120.AutoSize = True
        Me._DataLabelArray_120.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_120.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_120.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_120.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_120, CType(120, Short))
        Me._DataLabelArray_120.Location = New System.Drawing.Point(28, 18)
        Me._DataLabelArray_120.Name = "_DataLabelArray_120"
        Me._DataLabelArray_120.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_120.Size = New System.Drawing.Size(89, 14)
        Me._DataLabelArray_120.TabIndex = 131
        Me._DataLabelArray_120.Tag = "lblSecondaryColloidsInfused"
        Me._DataLabelArray_120.Text = "Colloids Infused?"
        '
        '_DataLabelArray_119
        '
        Me._DataLabelArray_119.AutoSize = True
        Me._DataLabelArray_119.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_119.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_119.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_119.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_119, CType(119, Short))
        Me._DataLabelArray_119.Location = New System.Drawing.Point(40, 42)
        Me._DataLabelArray_119.Name = "_DataLabelArray_119"
        Me._DataLabelArray_119.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_119.Size = New System.Drawing.Size(76, 14)
        Me._DataLabelArray_119.TabIndex = 130
        Me._DataLabelArray_119.Tag = "lblSecondaryColloidsInfused1Type"
        Me._DataLabelArray_119.Text = "Colloid 1 Type:"
        '
        '_DataLabelArray_118
        '
        Me._DataLabelArray_118.AutoSize = True
        Me._DataLabelArray_118.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_118.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_118.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_118.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_118, CType(118, Short))
        Me._DataLabelArray_118.Location = New System.Drawing.Point(40, 66)
        Me._DataLabelArray_118.Name = "_DataLabelArray_118"
        Me._DataLabelArray_118.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_118.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_118.TabIndex = 129
        Me._DataLabelArray_118.Tag = "lblSecondaryColloidsInfused1Units"
        Me._DataLabelArray_118.Text = "Colloid 1 Units:"
        '
        '_DataLabelArray_117
        '
        Me._DataLabelArray_117.AutoSize = True
        Me._DataLabelArray_117.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_117.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_117.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_117.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_117, CType(117, Short))
        Me._DataLabelArray_117.Location = New System.Drawing.Point(72, 90)
        Me._DataLabelArray_117.Name = "_DataLabelArray_117"
        Me._DataLabelArray_117.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_117.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_117.TabIndex = 128
        Me._DataLabelArray_117.Tag = "lblSecondaryColloidsInfused1CC"
        Me._DataLabelArray_117.Text = "CC/Unit:"
        '
        '_DataLabelArray_116
        '
        Me._DataLabelArray_116.AutoSize = True
        Me._DataLabelArray_116.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_116.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_116.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_116.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_116, CType(116, Short))
        Me._DataLabelArray_116.Location = New System.Drawing.Point(1, 114)
        Me._DataLabelArray_116.Name = "_DataLabelArray_116"
        Me._DataLabelArray_116.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_116.Size = New System.Drawing.Size(116, 14)
        Me._DataLabelArray_116.TabIndex = 127
        Me._DataLabelArray_116.Tag = "lblSecondaryColloidsInfused1UnitGiven"
        Me._DataLabelArray_116.Text = "Colloid 1 where Given:"
        '
        '_DataLabelArray_115
        '
        Me._DataLabelArray_115.AutoSize = True
        Me._DataLabelArray_115.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_115.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_115.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_115.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_115, CType(115, Short))
        Me._DataLabelArray_115.Location = New System.Drawing.Point(40, 138)
        Me._DataLabelArray_115.Name = "_DataLabelArray_115"
        Me._DataLabelArray_115.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_115.Size = New System.Drawing.Size(76, 14)
        Me._DataLabelArray_115.TabIndex = 126
        Me._DataLabelArray_115.Tag = "lblSecondaryColloidsInfused2Type"
        Me._DataLabelArray_115.Text = "Colloid 2 Type:"
        '
        '_DataLabelArray_114
        '
        Me._DataLabelArray_114.AutoSize = True
        Me._DataLabelArray_114.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_114.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_114.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_114.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_114, CType(114, Short))
        Me._DataLabelArray_114.Location = New System.Drawing.Point(40, 162)
        Me._DataLabelArray_114.Name = "_DataLabelArray_114"
        Me._DataLabelArray_114.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_114.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_114.TabIndex = 125
        Me._DataLabelArray_114.Tag = "lblSecondaryColloidsInfused2Units"
        Me._DataLabelArray_114.Text = "Colloid 2 Units:"
        '
        '_DataLabelArray_113
        '
        Me._DataLabelArray_113.AutoSize = True
        Me._DataLabelArray_113.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_113.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_113.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_113.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_113, CType(113, Short))
        Me._DataLabelArray_113.Location = New System.Drawing.Point(72, 184)
        Me._DataLabelArray_113.Name = "_DataLabelArray_113"
        Me._DataLabelArray_113.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_113.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_113.TabIndex = 124
        Me._DataLabelArray_113.Tag = "lblSecondaryColloidsInfused2CC"
        Me._DataLabelArray_113.Text = "CC/Unit:"
        '
        '_DataLabelArray_112
        '
        Me._DataLabelArray_112.AutoSize = True
        Me._DataLabelArray_112.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_112.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_112.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_112.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_112, CType(112, Short))
        Me._DataLabelArray_112.Location = New System.Drawing.Point(1, 208)
        Me._DataLabelArray_112.Name = "_DataLabelArray_112"
        Me._DataLabelArray_112.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_112.Size = New System.Drawing.Size(116, 14)
        Me._DataLabelArray_112.TabIndex = 123
        Me._DataLabelArray_112.Tag = "lblSecondaryColloidsInfused2UnitGiven"
        Me._DataLabelArray_112.Text = "Colloid 2 where Given:"
        '
        '_DataLabelArray_111
        '
        Me._DataLabelArray_111.AutoSize = True
        Me._DataLabelArray_111.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_111.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_111.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_111.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_111, CType(111, Short))
        Me._DataLabelArray_111.Location = New System.Drawing.Point(40, 232)
        Me._DataLabelArray_111.Name = "_DataLabelArray_111"
        Me._DataLabelArray_111.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_111.Size = New System.Drawing.Size(76, 14)
        Me._DataLabelArray_111.TabIndex = 122
        Me._DataLabelArray_111.Tag = "lblSecondaryColloidsInfused3Type"
        Me._DataLabelArray_111.Text = "Colloid 3 Type:"
        '
        '_DataLabelArray_110
        '
        Me._DataLabelArray_110.AutoSize = True
        Me._DataLabelArray_110.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_110.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_110.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_110.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_110, CType(110, Short))
        Me._DataLabelArray_110.Location = New System.Drawing.Point(40, 256)
        Me._DataLabelArray_110.Name = "_DataLabelArray_110"
        Me._DataLabelArray_110.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_110.Size = New System.Drawing.Size(77, 14)
        Me._DataLabelArray_110.TabIndex = 121
        Me._DataLabelArray_110.Tag = "lblSecondaryColloidsInfused3Units"
        Me._DataLabelArray_110.Text = "Colloid 3 Units:"
        '
        '_DataLabelArray_109
        '
        Me._DataLabelArray_109.AutoSize = True
        Me._DataLabelArray_109.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_109.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_109.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_109.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_109, CType(109, Short))
        Me._DataLabelArray_109.Location = New System.Drawing.Point(72, 280)
        Me._DataLabelArray_109.Name = "_DataLabelArray_109"
        Me._DataLabelArray_109.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_109.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_109.TabIndex = 120
        Me._DataLabelArray_109.Tag = "lblSecondaryColloidsInfused3CC"
        Me._DataLabelArray_109.Text = "CC/Unit:"
        '
        '_DataLabelArray_108
        '
        Me._DataLabelArray_108.AutoSize = True
        Me._DataLabelArray_108.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_108.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_108.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_108.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_108, CType(108, Short))
        Me._DataLabelArray_108.Location = New System.Drawing.Point(8, 304)
        Me._DataLabelArray_108.Name = "_DataLabelArray_108"
        Me._DataLabelArray_108.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_108.Size = New System.Drawing.Size(116, 14)
        Me._DataLabelArray_108.TabIndex = 119
        Me._DataLabelArray_108.Tag = "lblSecondaryColloidsInfused3UnitGiven"
        Me._DataLabelArray_108.Text = "Colloid 3 where Given:"
        '
        '_fmDataFrame_2
        '
        Me._fmDataFrame_2.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_2.Controls.Add(Me._DataTextArray_64)
        Me._fmDataFrame_2.Controls.Add(Me._DataComboArray_41)
        Me._fmDataFrame_2.Controls.Add(Me._DataComboArray_40)
        Me._fmDataFrame_2.Controls.Add(Me._DataTextArray_138)
        Me._fmDataFrame_2.Controls.Add(Me._DataTextArray_137)
        Me._fmDataFrame_2.Controls.Add(Me._DataTextArray_136)
        Me._fmDataFrame_2.Controls.Add(Me._DataTextArray_128)
        Me._fmDataFrame_2.Controls.Add(Me._DataComboArray_38)
        Me._fmDataFrame_2.Controls.Add(Me._DataTextArray_134)
        Me._fmDataFrame_2.Controls.Add(Me._DataTextArray_133)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_178)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_177)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_176)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_175)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_170)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_168)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_167)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_166)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_172)
        Me._fmDataFrame_2.Controls.Add(Me._DataLabelArray_171)
        Me._fmDataFrame_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_2, CType(2, Short))
        Me._fmDataFrame_2.Location = New System.Drawing.Point(464, 18)
        Me._fmDataFrame_2.Name = "_fmDataFrame_2"
        Me._fmDataFrame_2.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_2.Size = New System.Drawing.Size(441, 305)
        Me._fmDataFrame_2.TabIndex = 180
        Me._fmDataFrame_2.TabStop = False
        Me._fmDataFrame_2.Tag = "t2Labs"
        Me._fmDataFrame_2.Text = "Labs - Tab 2"
        Me._fmDataFrame_2.Visible = False
        '
        '_DataTextArray_64
        '
        Me._DataTextArray_64.AcceptsReturn = True
        Me._DataTextArray_64.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_64.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_64.Enabled = False
        Me._DataTextArray_64.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_64.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_64, CType(64, Short))
        Me._DataTextArray_64.Location = New System.Drawing.Point(136, 229)
        Me._DataTextArray_64.MaxLength = 255
        Me._DataTextArray_64.Multiline = True
        Me._DataTextArray_64.Name = "_DataTextArray_64"
        Me._DataTextArray_64.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_64.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_64.Size = New System.Drawing.Size(265, 59)
        Me._DataTextArray_64.TabIndex = 373
        Me._DataTextArray_64.Tag = "SecondarySputumCharacteristics"
        '
        '_DataComboArray_41
        '
        Me._DataComboArray_41.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_41.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_41.Enabled = False
        Me._DataComboArray_41.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_41.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_41, CType(41, Short))
        Me._DataComboArray_41.Location = New System.Drawing.Point(136, 158)
        Me._DataComboArray_41.Name = "_DataComboArray_41"
        Me._DataComboArray_41.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_41.Size = New System.Drawing.Size(257, 22)
        Me._DataComboArray_41.TabIndex = 370
        Me._DataComboArray_41.Tag = "SecondaryCulture3Type"
        Me._DataComboArray_41.Text = "DataComboArray"
        '
        '_DataComboArray_40
        '
        Me._DataComboArray_40.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_40.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_40.Enabled = False
        Me._DataComboArray_40.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_40.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_40, CType(40, Short))
        Me._DataComboArray_40.Location = New System.Drawing.Point(136, 87)
        Me._DataComboArray_40.Name = "_DataComboArray_40"
        Me._DataComboArray_40.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_40.Size = New System.Drawing.Size(257, 22)
        Me._DataComboArray_40.TabIndex = 367
        Me._DataComboArray_40.Tag = "SecondaryCulture2Type"
        Me._DataComboArray_40.Text = "DataComboArray"
        '
        '_DataTextArray_138
        '
        Me._DataTextArray_138.AcceptsReturn = True
        Me._DataTextArray_138.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_138.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_138.Enabled = False
        Me._DataTextArray_138.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_138.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_138, CType(138, Short))
        Me._DataTextArray_138.Location = New System.Drawing.Point(136, 183)
        Me._DataTextArray_138.MaxLength = 0
        Me._DataTextArray_138.Name = "_DataTextArray_138"
        Me._DataTextArray_138.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_138.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_138.TabIndex = 371
        Me._DataTextArray_138.Tag = "SecondaryCulture3DrawnDate"
        '
        '_DataTextArray_137
        '
        Me._DataTextArray_137.AcceptsReturn = True
        Me._DataTextArray_137.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_137.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_137.Enabled = False
        Me._DataTextArray_137.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_137.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_137, CType(137, Short))
        Me._DataTextArray_137.Location = New System.Drawing.Point(136, 206)
        Me._DataTextArray_137.MaxLength = 25
        Me._DataTextArray_137.Name = "_DataTextArray_137"
        Me._DataTextArray_137.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_137.Size = New System.Drawing.Size(161, 20)
        Me._DataTextArray_137.TabIndex = 372
        Me._DataTextArray_137.Tag = "SecondaryCulture3Growth"
        '
        '_DataTextArray_136
        '
        Me._DataTextArray_136.AcceptsReturn = True
        Me._DataTextArray_136.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_136.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_136.Enabled = False
        Me._DataTextArray_136.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_136.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_136, CType(136, Short))
        Me._DataTextArray_136.Location = New System.Drawing.Point(136, 135)
        Me._DataTextArray_136.MaxLength = 25
        Me._DataTextArray_136.Name = "_DataTextArray_136"
        Me._DataTextArray_136.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_136.Size = New System.Drawing.Size(161, 20)
        Me._DataTextArray_136.TabIndex = 369
        Me._DataTextArray_136.Tag = "SecondaryCulture2Growth"
        '
        '_DataTextArray_128
        '
        Me._DataTextArray_128.AcceptsReturn = True
        Me._DataTextArray_128.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_128.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_128.Enabled = False
        Me._DataTextArray_128.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_128.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_128, CType(128, Short))
        Me._DataTextArray_128.Location = New System.Drawing.Point(136, 112)
        Me._DataTextArray_128.MaxLength = 0
        Me._DataTextArray_128.Name = "_DataTextArray_128"
        Me._DataTextArray_128.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_128.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_128.TabIndex = 368
        Me._DataTextArray_128.Tag = "SecondaryCulture2DrawnDate"
        '
        '_DataComboArray_38
        '
        Me._DataComboArray_38.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_38.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_38.Enabled = False
        Me._DataComboArray_38.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_38.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_38, CType(38, Short))
        Me._DataComboArray_38.Location = New System.Drawing.Point(136, 16)
        Me._DataComboArray_38.Name = "_DataComboArray_38"
        Me._DataComboArray_38.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_38.Size = New System.Drawing.Size(257, 22)
        Me._DataComboArray_38.TabIndex = 364
        Me._DataComboArray_38.Tag = "SecondaryCulture1Type"
        Me._DataComboArray_38.Text = "DataComboArray"
        '
        '_DataTextArray_134
        '
        Me._DataTextArray_134.AcceptsReturn = True
        Me._DataTextArray_134.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_134.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_134.Enabled = False
        Me._DataTextArray_134.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_134.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_134, CType(134, Short))
        Me._DataTextArray_134.Location = New System.Drawing.Point(136, 41)
        Me._DataTextArray_134.MaxLength = 0
        Me._DataTextArray_134.Name = "_DataTextArray_134"
        Me._DataTextArray_134.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_134.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_134.TabIndex = 365
        Me._DataTextArray_134.Tag = "SecondaryCulture1DrawnDate"
        '
        '_DataTextArray_133
        '
        Me._DataTextArray_133.AcceptsReturn = True
        Me._DataTextArray_133.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_133.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_133.Enabled = False
        Me._DataTextArray_133.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_133.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_133, CType(133, Short))
        Me._DataTextArray_133.Location = New System.Drawing.Point(136, 64)
        Me._DataTextArray_133.MaxLength = 25
        Me._DataTextArray_133.Name = "_DataTextArray_133"
        Me._DataTextArray_133.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_133.Size = New System.Drawing.Size(161, 20)
        Me._DataTextArray_133.TabIndex = 366
        Me._DataTextArray_133.Tag = "SecondaryCulture1Growth"
        '
        '_DataLabelArray_178
        '
        Me._DataLabelArray_178.AutoSize = True
        Me._DataLabelArray_178.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_178.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_178.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_178.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_178, CType(178, Short))
        Me._DataLabelArray_178.Location = New System.Drawing.Point(22, 184)
        Me._DataLabelArray_178.Name = "_DataLabelArray_178"
        Me._DataLabelArray_178.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_178.Size = New System.Drawing.Size(114, 14)
        Me._DataLabelArray_178.TabIndex = 190
        Me._DataLabelArray_178.Tag = "lblSecondaryCulture3DrawnDate"
        Me._DataLabelArray_178.Text = "Culture 3 Date Drawn:"
        '
        '_DataLabelArray_177
        '
        Me._DataLabelArray_177.AutoSize = True
        Me._DataLabelArray_177.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_177.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_177.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_177.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_177, CType(177, Short))
        Me._DataLabelArray_177.Location = New System.Drawing.Point(6, 208)
        Me._DataLabelArray_177.Name = "_DataLabelArray_177"
        Me._DataLabelArray_177.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_177.Size = New System.Drawing.Size(130, 14)
        Me._DataLabelArray_177.TabIndex = 189
        Me._DataLabelArray_177.Tag = "lblSecondaryCulture3Growth"
        Me._DataLabelArray_177.Text = "Culture 3 Growth to Date:"
        '
        '_DataLabelArray_176
        '
        Me._DataLabelArray_176.AutoSize = True
        Me._DataLabelArray_176.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_176.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_176.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_176.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_176, CType(176, Short))
        Me._DataLabelArray_176.Location = New System.Drawing.Point(6, 136)
        Me._DataLabelArray_176.Name = "_DataLabelArray_176"
        Me._DataLabelArray_176.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_176.Size = New System.Drawing.Size(130, 14)
        Me._DataLabelArray_176.TabIndex = 188
        Me._DataLabelArray_176.Tag = "lblSecondaryCulture2Growth"
        Me._DataLabelArray_176.Text = "Culture 2 Growth to Date:"
        '
        '_DataLabelArray_175
        '
        Me._DataLabelArray_175.AutoSize = True
        Me._DataLabelArray_175.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_175.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_175.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_175.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_175, CType(175, Short))
        Me._DataLabelArray_175.Location = New System.Drawing.Point(56, 160)
        Me._DataLabelArray_175.Name = "_DataLabelArray_175"
        Me._DataLabelArray_175.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_175.Size = New System.Drawing.Size(79, 14)
        Me._DataLabelArray_175.TabIndex = 187
        Me._DataLabelArray_175.Tag = "lblSecondaryCulture3Type"
        Me._DataLabelArray_175.Text = "Culture 3 Type:"
        '
        '_DataLabelArray_170
        '
        Me._DataLabelArray_170.AutoSize = True
        Me._DataLabelArray_170.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_170.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_170.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_170.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_170, CType(170, Short))
        Me._DataLabelArray_170.Location = New System.Drawing.Point(56, 88)
        Me._DataLabelArray_170.Name = "_DataLabelArray_170"
        Me._DataLabelArray_170.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_170.Size = New System.Drawing.Size(79, 14)
        Me._DataLabelArray_170.TabIndex = 186
        Me._DataLabelArray_170.Tag = "lblSecondaryCulture2Type"
        Me._DataLabelArray_170.Text = "Culture 2 Type:"
        '
        '_DataLabelArray_168
        '
        Me._DataLabelArray_168.AutoSize = True
        Me._DataLabelArray_168.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_168.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_168.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_168.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_168, CType(168, Short))
        Me._DataLabelArray_168.Location = New System.Drawing.Point(22, 112)
        Me._DataLabelArray_168.Name = "_DataLabelArray_168"
        Me._DataLabelArray_168.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_168.Size = New System.Drawing.Size(114, 14)
        Me._DataLabelArray_168.TabIndex = 185
        Me._DataLabelArray_168.Tag = "lblSecondaryCulture2DrawnDate"
        Me._DataLabelArray_168.Text = "Culture 2 Date Drawn:"
        '
        '_DataLabelArray_167
        '
        Me._DataLabelArray_167.AutoSize = True
        Me._DataLabelArray_167.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_167.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_167.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_167.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_167, CType(167, Short))
        Me._DataLabelArray_167.Location = New System.Drawing.Point(14, 232)
        Me._DataLabelArray_167.Name = "_DataLabelArray_167"
        Me._DataLabelArray_167.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_167.Size = New System.Drawing.Size(122, 14)
        Me._DataLabelArray_167.TabIndex = 184
        Me._DataLabelArray_167.Tag = "lblSecondarySputumCharacteristics"
        Me._DataLabelArray_167.Text = "Sputum Characteristics:"
        '
        '_DataLabelArray_166
        '
        Me._DataLabelArray_166.AutoSize = True
        Me._DataLabelArray_166.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_166.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_166.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_166.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_166, CType(166, Short))
        Me._DataLabelArray_166.Location = New System.Drawing.Point(56, 16)
        Me._DataLabelArray_166.Name = "_DataLabelArray_166"
        Me._DataLabelArray_166.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_166.Size = New System.Drawing.Size(79, 14)
        Me._DataLabelArray_166.TabIndex = 183
        Me._DataLabelArray_166.Tag = "lblSecondaryCulture1Type"
        Me._DataLabelArray_166.Text = "Culture 1 Type:"
        '
        '_DataLabelArray_172
        '
        Me._DataLabelArray_172.AutoSize = True
        Me._DataLabelArray_172.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_172.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_172.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_172.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_172, CType(172, Short))
        Me._DataLabelArray_172.Location = New System.Drawing.Point(22, 40)
        Me._DataLabelArray_172.Name = "_DataLabelArray_172"
        Me._DataLabelArray_172.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_172.Size = New System.Drawing.Size(114, 14)
        Me._DataLabelArray_172.TabIndex = 182
        Me._DataLabelArray_172.Tag = "lblSecondaryCulture1DrawnDate"
        Me._DataLabelArray_172.Text = "Culture 1 Date Drawn:"
        '
        '_DataLabelArray_171
        '
        Me._DataLabelArray_171.AutoSize = True
        Me._DataLabelArray_171.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_171.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_171.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_171.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_171, CType(171, Short))
        Me._DataLabelArray_171.Location = New System.Drawing.Point(6, 64)
        Me._DataLabelArray_171.Name = "_DataLabelArray_171"
        Me._DataLabelArray_171.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_171.Size = New System.Drawing.Size(130, 14)
        Me._DataLabelArray_171.TabIndex = 181
        Me._DataLabelArray_171.Tag = "lblSecondaryCulture1Growth"
        Me._DataLabelArray_171.Text = "Culture 1 Growth to Date:"
        '
        '_fmDataFrame_22
        '
        Me._fmDataFrame_22.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_22.Controls.Add(Me._DataComboArray_59)
        Me._fmDataFrame_22.Controls.Add(Me._DataLabelArray_43)
        Me._fmDataFrame_22.Controls.Add(Me._DataItemListArray_0)
        Me._fmDataFrame_22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_22, CType(22, Short))
        Me._fmDataFrame_22.Location = New System.Drawing.Point(3, 16)
        Me._fmDataFrame_22.Name = "_fmDataFrame_22"
        Me._fmDataFrame_22.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_22.Size = New System.Drawing.Size(449, 337)
        Me._fmDataFrame_22.TabIndex = 554
        Me._fmDataFrame_22.TabStop = False
        Me._fmDataFrame_22.Tag = "t2Medications"
        Me._fmDataFrame_22.Text = "Medications - Tab 2"
        '
        '_DataComboArray_59
        '
        Me._DataComboArray_59.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_59.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_59.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_59.Enabled = False
        Me._DataComboArray_59.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_59.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_59, CType(59, Short))
        Me._DataComboArray_59.Location = New System.Drawing.Point(88, 24)
        Me._DataComboArray_59.Name = "_DataComboArray_59"
        Me._DataComboArray_59.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_59.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_59.TabIndex = 555
        Me._DataComboArray_59.Tag = "SecondarySteroid"
        '
        '_DataLabelArray_43
        '
        Me._DataLabelArray_43.AutoSize = True
        Me._DataLabelArray_43.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_43.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_43.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_43.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_43, CType(43, Short))
        Me._DataLabelArray_43.Location = New System.Drawing.Point(32, 27)
        Me._DataLabelArray_43.Name = "_DataLabelArray_43"
        Me._DataLabelArray_43.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_43.Size = New System.Drawing.Size(53, 14)
        Me._DataLabelArray_43.TabIndex = 557
        Me._DataLabelArray_43.Tag = "lblSecondaryMedication"
        Me._DataLabelArray_43.Text = "Steroids?"
        '
        '_DataItemListArray_0
        '
        Me._DataItemListArray_0.Enabled = False
        Me._DataItemListArray_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataItemListArray_0.Location = New System.Drawing.Point(0, 42)
        Me._DataItemListArray_0.Name = "_DataItemListArray_0"
        Me._DataItemListArray_0.Size = New System.Drawing.Size(446, 265)
        Me._DataItemListArray_0.TabIndex = 558
        Me._DataItemListArray_0.Tag = "SecondarySteroidList"
        '
        '_tbReferralData_TabPage3
        '
        Me._tbReferralData_TabPage3.AutoScroll = True
        Me._tbReferralData_TabPage3.Controls.Add(Me._fmDataFrame_14)
        Me._tbReferralData_TabPage3.Controls.Add(Me._fmDataFrame_19)
        Me._tbReferralData_TabPage3.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage3.Name = "_tbReferralData_TabPage3"
        Me._tbReferralData_TabPage3.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage3.TabIndex = 3
        Me._tbReferralData_TabPage3.Text = "Tab 3"
        '
        '_fmDataFrame_14
        '
        Me._fmDataFrame_14.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_14.Controls.Add(Me._DataTextArray_140)
        Me._fmDataFrame_14.Controls.Add(Me._DataTextArray_139)
        Me._fmDataFrame_14.Controls.Add(Me._DataTextArray_132)
        Me._fmDataFrame_14.Controls.Add(Me._DataTextArray_130)
        Me._fmDataFrame_14.Controls.Add(Me._DataTextArray_142)
        Me._fmDataFrame_14.Controls.Add(Me._DataTextArray_141)
        Me._fmDataFrame_14.Controls.Add(Me._DataComboArray_42)
        Me._fmDataFrame_14.Controls.Add(Me._DataLabelArray_182)
        Me._fmDataFrame_14.Controls.Add(Me._DataLabelArray_181)
        Me._fmDataFrame_14.Controls.Add(Me._DataLabelArray_180)
        Me._fmDataFrame_14.Controls.Add(Me._DataLabelArray_179)
        Me._fmDataFrame_14.Controls.Add(Me._DataLabelArray_190)
        Me._fmDataFrame_14.Controls.Add(Me._DataLabelArray_189)
        Me._fmDataFrame_14.Controls.Add(Me._DataLabelArray_188)
        Me._fmDataFrame_14.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_14, CType(14, Short))
        Me._fmDataFrame_14.Location = New System.Drawing.Point(8, 18)
        Me._fmDataFrame_14.Name = "_fmDataFrame_14"
        Me._fmDataFrame_14.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_14.Size = New System.Drawing.Size(441, 361)
        Me._fmDataFrame_14.TabIndex = 191
        Me._fmDataFrame_14.TabStop = False
        Me._fmDataFrame_14.Tag = "t3Labs"
        Me._fmDataFrame_14.Text = "Labs - Tab 3"
        Me._fmDataFrame_14.Visible = False
        '
        '_DataTextArray_140
        '
        Me._DataTextArray_140.AcceptsReturn = True
        Me._DataTextArray_140.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_140.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_140.Enabled = False
        Me._DataTextArray_140.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_140.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_140, CType(140, Short))
        Me._DataTextArray_140.Location = New System.Drawing.Point(88, 218)
        Me._DataTextArray_140.MaxLength = 255
        Me._DataTextArray_140.Multiline = True
        Me._DataTextArray_140.Name = "_DataTextArray_140"
        Me._DataTextArray_140.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_140.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_140.Size = New System.Drawing.Size(270, 51)
        Me._DataTextArray_140.TabIndex = 380
        Me._DataTextArray_140.Tag = "SecondaryCXR3Finding"
        '
        '_DataTextArray_139
        '
        Me._DataTextArray_139.AcceptsReturn = True
        Me._DataTextArray_139.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_139.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_139.Enabled = False
        Me._DataTextArray_139.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_139.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_139, CType(139, Short))
        Me._DataTextArray_139.Location = New System.Drawing.Point(88, 195)
        Me._DataTextArray_139.MaxLength = 0
        Me._DataTextArray_139.Name = "_DataTextArray_139"
        Me._DataTextArray_139.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_139.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_139.TabIndex = 379
        Me._DataTextArray_139.Tag = "SecondaryCXR3Date"
        '
        '_DataTextArray_132
        '
        Me._DataTextArray_132.AcceptsReturn = True
        Me._DataTextArray_132.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_132.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_132.Enabled = False
        Me._DataTextArray_132.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_132.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_132, CType(132, Short))
        Me._DataTextArray_132.Location = New System.Drawing.Point(88, 141)
        Me._DataTextArray_132.MaxLength = 255
        Me._DataTextArray_132.Multiline = True
        Me._DataTextArray_132.Name = "_DataTextArray_132"
        Me._DataTextArray_132.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_132.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_132.Size = New System.Drawing.Size(337, 51)
        Me._DataTextArray_132.TabIndex = 378
        Me._DataTextArray_132.Tag = "SecondaryCXR2Finding"
        '
        '_DataTextArray_130
        '
        Me._DataTextArray_130.AcceptsReturn = True
        Me._DataTextArray_130.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_130.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_130.Enabled = False
        Me._DataTextArray_130.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_130.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_130, CType(130, Short))
        Me._DataTextArray_130.Location = New System.Drawing.Point(88, 118)
        Me._DataTextArray_130.MaxLength = 0
        Me._DataTextArray_130.Name = "_DataTextArray_130"
        Me._DataTextArray_130.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_130.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_130.TabIndex = 377
        Me._DataTextArray_130.Tag = "SecondaryCXR2Date"
        '
        '_DataTextArray_142
        '
        Me._DataTextArray_142.AcceptsReturn = True
        Me._DataTextArray_142.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_142.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_142.Enabled = False
        Me._DataTextArray_142.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_142.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_142, CType(142, Short))
        Me._DataTextArray_142.Location = New System.Drawing.Point(88, 64)
        Me._DataTextArray_142.MaxLength = 255
        Me._DataTextArray_142.Multiline = True
        Me._DataTextArray_142.Name = "_DataTextArray_142"
        Me._DataTextArray_142.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_142.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me._DataTextArray_142.Size = New System.Drawing.Size(337, 51)
        Me._DataTextArray_142.TabIndex = 376
        Me._DataTextArray_142.Tag = "SecondaryCXR1Finding"
        '
        '_DataTextArray_141
        '
        Me._DataTextArray_141.AcceptsReturn = True
        Me._DataTextArray_141.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_141.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_141.Enabled = False
        Me._DataTextArray_141.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_141.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_141, CType(141, Short))
        Me._DataTextArray_141.Location = New System.Drawing.Point(88, 41)
        Me._DataTextArray_141.MaxLength = 0
        Me._DataTextArray_141.Name = "_DataTextArray_141"
        Me._DataTextArray_141.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_141.Size = New System.Drawing.Size(89, 20)
        Me._DataTextArray_141.TabIndex = 375
        Me._DataTextArray_141.Tag = "SecondaryCXR1Date"
        '
        '_DataComboArray_42
        '
        Me._DataComboArray_42.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_42.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_42.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_42.Enabled = False
        Me._DataComboArray_42.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_42.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_42, CType(42, Short))
        Me._DataComboArray_42.Location = New System.Drawing.Point(88, 16)
        Me._DataComboArray_42.Name = "_DataComboArray_42"
        Me._DataComboArray_42.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_42.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_42.TabIndex = 374
        Me._DataComboArray_42.Tag = "SecondaryCXRAvailable"
        '
        '_DataLabelArray_182
        '
        Me._DataLabelArray_182.AutoSize = True
        Me._DataLabelArray_182.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_182.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_182.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_182.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_182, CType(182, Short))
        Me._DataLabelArray_182.Location = New System.Drawing.Point(15, 224)
        Me._DataLabelArray_182.Name = "_DataLabelArray_182"
        Me._DataLabelArray_182.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_182.Size = New System.Drawing.Size(74, 14)
        Me._DataLabelArray_182.TabIndex = 198
        Me._DataLabelArray_182.Tag = "lblSecondaryCXR3Finding"
        Me._DataLabelArray_182.Text = "CXR Findings:"
        '
        '_DataLabelArray_181
        '
        Me._DataLabelArray_181.AutoSize = True
        Me._DataLabelArray_181.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_181.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_181.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_181.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_181, CType(181, Short))
        Me._DataLabelArray_181.Location = New System.Drawing.Point(24, 200)
        Me._DataLabelArray_181.Name = "_DataLabelArray_181"
        Me._DataLabelArray_181.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_181.Size = New System.Drawing.Size(65, 14)
        Me._DataLabelArray_181.TabIndex = 197
        Me._DataLabelArray_181.Tag = "lblSecondaryCXR3Date"
        Me._DataLabelArray_181.Text = "CXR 3 Date:"
        '
        '_DataLabelArray_180
        '
        Me._DataLabelArray_180.AutoSize = True
        Me._DataLabelArray_180.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_180.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_180.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_180.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_180, CType(180, Short))
        Me._DataLabelArray_180.Location = New System.Drawing.Point(6, 144)
        Me._DataLabelArray_180.Name = "_DataLabelArray_180"
        Me._DataLabelArray_180.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_180.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_180.TabIndex = 196
        Me._DataLabelArray_180.Tag = "lblSecondaryCXR2Finding"
        Me._DataLabelArray_180.Text = "CXR 2 Findings:"
        '
        '_DataLabelArray_179
        '
        Me._DataLabelArray_179.AutoSize = True
        Me._DataLabelArray_179.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_179.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_179.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_179.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_179, CType(179, Short))
        Me._DataLabelArray_179.Location = New System.Drawing.Point(24, 120)
        Me._DataLabelArray_179.Name = "_DataLabelArray_179"
        Me._DataLabelArray_179.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_179.Size = New System.Drawing.Size(65, 14)
        Me._DataLabelArray_179.TabIndex = 195
        Me._DataLabelArray_179.Tag = "lblSecondaryCXR2Date"
        Me._DataLabelArray_179.Text = "CXR 2 Date:"
        '
        '_DataLabelArray_190
        '
        Me._DataLabelArray_190.AutoSize = True
        Me._DataLabelArray_190.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_190.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_190.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_190.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_190, CType(190, Short))
        Me._DataLabelArray_190.Location = New System.Drawing.Point(6, 64)
        Me._DataLabelArray_190.Name = "_DataLabelArray_190"
        Me._DataLabelArray_190.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_190.Size = New System.Drawing.Size(83, 14)
        Me._DataLabelArray_190.TabIndex = 194
        Me._DataLabelArray_190.Tag = "lblSecondaryCXR1Finding"
        Me._DataLabelArray_190.Text = "CXR 1 Findings:"
        '
        '_DataLabelArray_189
        '
        Me._DataLabelArray_189.AutoSize = True
        Me._DataLabelArray_189.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_189.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_189.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_189.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_189, CType(189, Short))
        Me._DataLabelArray_189.Location = New System.Drawing.Point(24, 40)
        Me._DataLabelArray_189.Name = "_DataLabelArray_189"
        Me._DataLabelArray_189.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_189.Size = New System.Drawing.Size(65, 14)
        Me._DataLabelArray_189.TabIndex = 193
        Me._DataLabelArray_189.Tag = "lblSecondaryCXR1Date"
        Me._DataLabelArray_189.Text = "CXR 1 Date:"
        '
        '_DataLabelArray_188
        '
        Me._DataLabelArray_188.AutoSize = True
        Me._DataLabelArray_188.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_188.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_188.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_188.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_188, CType(188, Short))
        Me._DataLabelArray_188.Location = New System.Drawing.Point(8, 16)
        Me._DataLabelArray_188.Name = "_DataLabelArray_188"
        Me._DataLabelArray_188.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_188.Size = New System.Drawing.Size(80, 14)
        Me._DataLabelArray_188.TabIndex = 192
        Me._DataLabelArray_188.Tag = "lblSecondaryCXRAvailable"
        Me._DataLabelArray_188.Text = "CXR Available?"
        '
        '_fmDataFrame_19
        '
        Me._fmDataFrame_19.BackColor = System.Drawing.SystemColors.Control
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_81)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_80)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_79)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_70)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_69)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_68)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_34)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_33)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_32)
        Me._fmDataFrame_19.Controls.Add(Me._DataTextArray_97)
        Me._fmDataFrame_19.Controls.Add(Me._DataTextArray_94)
        Me._fmDataFrame_19.Controls.Add(Me._DataTextArray_91)
        Me._fmDataFrame_19.Controls.Add(Me._DataComboArray_31)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_133)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_132)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_131)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_130)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_129)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_128)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_127)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_126)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_125)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_124)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_123)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_122)
        Me._fmDataFrame_19.Controls.Add(Me._DataLabelArray_121)
        Me._fmDataFrame_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._fmDataFrame_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmDataFrame.SetIndex(Me._fmDataFrame_19, CType(19, Short))
        Me._fmDataFrame_19.Location = New System.Drawing.Point(470, 18)
        Me._fmDataFrame_19.Name = "_fmDataFrame_19"
        Me._fmDataFrame_19.Padding = New System.Windows.Forms.Padding(0)
        Me._fmDataFrame_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._fmDataFrame_19.Size = New System.Drawing.Size(417, 345)
        Me._fmDataFrame_19.TabIndex = 132
        Me._fmDataFrame_19.TabStop = False
        Me._fmDataFrame_19.Tag = "t3Fluids"
        Me._fmDataFrame_19.Text = "Fluids - Tab 3"
        '
        '_DataComboArray_81
        '
        Me._DataComboArray_81.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_81.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_81.Enabled = False
        Me._DataComboArray_81.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_81.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_81, CType(81, Short))
        Me._DataComboArray_81.Location = New System.Drawing.Point(136, 273)
        Me._DataComboArray_81.Name = "_DataComboArray_81"
        Me._DataComboArray_81.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_81.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_81.TabIndex = 330
        Me._DataComboArray_81.Tag = "SecondaryCrystalloids3CC"
        Me._DataComboArray_81.Text = "DataComboArray"
        '
        '_DataComboArray_80
        '
        Me._DataComboArray_80.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_80.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_80.Enabled = False
        Me._DataComboArray_80.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_80.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_80, CType(80, Short))
        Me._DataComboArray_80.Location = New System.Drawing.Point(136, 175)
        Me._DataComboArray_80.Name = "_DataComboArray_80"
        Me._DataComboArray_80.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_80.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_80.TabIndex = 326
        Me._DataComboArray_80.Tag = "SecondaryCrystalloids2CC"
        Me._DataComboArray_80.Text = "DataComboArray"
        '
        '_DataComboArray_79
        '
        Me._DataComboArray_79.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_79.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_79.Enabled = False
        Me._DataComboArray_79.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_79.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_79, CType(79, Short))
        Me._DataComboArray_79.Location = New System.Drawing.Point(136, 85)
        Me._DataComboArray_79.Name = "_DataComboArray_79"
        Me._DataComboArray_79.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_79.Size = New System.Drawing.Size(81, 22)
        Me._DataComboArray_79.TabIndex = 322
        Me._DataComboArray_79.Tag = "SecondaryCrystalloids1CC"
        Me._DataComboArray_79.Text = "DataComboArray"
        '
        '_DataComboArray_70
        '
        Me._DataComboArray_70.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_70.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_70.Enabled = False
        Me._DataComboArray_70.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_70.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_70, CType(70, Short))
        Me._DataComboArray_70.Location = New System.Drawing.Point(136, 232)
        Me._DataComboArray_70.Name = "_DataComboArray_70"
        Me._DataComboArray_70.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_70.Size = New System.Drawing.Size(249, 22)
        Me._DataComboArray_70.TabIndex = 328
        Me._DataComboArray_70.Tag = "SecondaryCrystalloids3Type"
        Me._DataComboArray_70.Text = "DataComboArray"
        '
        '_DataComboArray_69
        '
        Me._DataComboArray_69.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_69.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_69.Enabled = False
        Me._DataComboArray_69.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_69.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_69, CType(69, Short))
        Me._DataComboArray_69.Location = New System.Drawing.Point(136, 131)
        Me._DataComboArray_69.Name = "_DataComboArray_69"
        Me._DataComboArray_69.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_69.Size = New System.Drawing.Size(249, 22)
        Me._DataComboArray_69.TabIndex = 324
        Me._DataComboArray_69.Tag = "SecondaryCrystalloids2Type"
        Me._DataComboArray_69.Text = "DataComboArray"
        '
        '_DataComboArray_68
        '
        Me._DataComboArray_68.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_68.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_68.Enabled = False
        Me._DataComboArray_68.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_68.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_68, CType(68, Short))
        Me._DataComboArray_68.Location = New System.Drawing.Point(136, 41)
        Me._DataComboArray_68.Name = "_DataComboArray_68"
        Me._DataComboArray_68.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_68.Size = New System.Drawing.Size(249, 22)
        Me._DataComboArray_68.TabIndex = 320
        Me._DataComboArray_68.Tag = "SecondaryCrystalloids1Type"
        Me._DataComboArray_68.Text = "DataComboArray"
        '
        '_DataComboArray_34
        '
        Me._DataComboArray_34.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_34.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_34.Enabled = False
        Me._DataComboArray_34.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_34.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_34, CType(34, Short))
        Me._DataComboArray_34.Location = New System.Drawing.Point(136, 296)
        Me._DataComboArray_34.Name = "_DataComboArray_34"
        Me._DataComboArray_34.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_34.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_34.TabIndex = 331
        Me._DataComboArray_34.Tag = "SecondaryCrystalloids3UnitGiven"
        Me._DataComboArray_34.Text = "DataComboArray"
        '
        '_DataComboArray_33
        '
        Me._DataComboArray_33.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_33.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_33.Enabled = False
        Me._DataComboArray_33.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_33.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_33, CType(33, Short))
        Me._DataComboArray_33.Location = New System.Drawing.Point(136, 198)
        Me._DataComboArray_33.Name = "_DataComboArray_33"
        Me._DataComboArray_33.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_33.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_33.TabIndex = 327
        Me._DataComboArray_33.Tag = "SecondaryCrystalloids2UnitGiven"
        Me._DataComboArray_33.Text = "DataComboArray"
        '
        '_DataComboArray_32
        '
        Me._DataComboArray_32.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_32.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_32.Enabled = False
        Me._DataComboArray_32.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_32.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_32, CType(32, Short))
        Me._DataComboArray_32.Location = New System.Drawing.Point(136, 108)
        Me._DataComboArray_32.Name = "_DataComboArray_32"
        Me._DataComboArray_32.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_32.Size = New System.Drawing.Size(137, 22)
        Me._DataComboArray_32.TabIndex = 323
        Me._DataComboArray_32.Tag = "SecondaryCrystalloids1UnitGiven"
        Me._DataComboArray_32.Text = "DataComboArray"
        '
        '_DataTextArray_97
        '
        Me._DataTextArray_97.AcceptsReturn = True
        Me._DataTextArray_97.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_97.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_97.Enabled = False
        Me._DataTextArray_97.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_97.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_97, CType(97, Short))
        Me._DataTextArray_97.Location = New System.Drawing.Point(136, 256)
        Me._DataTextArray_97.MaxLength = 25
        Me._DataTextArray_97.Name = "_DataTextArray_97"
        Me._DataTextArray_97.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_97.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_97.TabIndex = 329
        Me._DataTextArray_97.Tag = "SecondaryCrystalloids3Units"
        '
        '_DataTextArray_94
        '
        Me._DataTextArray_94.AcceptsReturn = True
        Me._DataTextArray_94.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_94.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_94.Enabled = False
        Me._DataTextArray_94.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_94.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_94, CType(94, Short))
        Me._DataTextArray_94.Location = New System.Drawing.Point(136, 154)
        Me._DataTextArray_94.MaxLength = 25
        Me._DataTextArray_94.Name = "_DataTextArray_94"
        Me._DataTextArray_94.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_94.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_94.TabIndex = 325
        Me._DataTextArray_94.Tag = "SecondaryCrystalloids2Units"
        '
        '_DataTextArray_91
        '
        Me._DataTextArray_91.AcceptsReturn = True
        Me._DataTextArray_91.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataTextArray_91.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._DataTextArray_91.Enabled = False
        Me._DataTextArray_91.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataTextArray_91.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataTextArray.SetIndex(Me._DataTextArray_91, CType(91, Short))
        Me._DataTextArray_91.Location = New System.Drawing.Point(136, 64)
        Me._DataTextArray_91.MaxLength = 25
        Me._DataTextArray_91.Name = "_DataTextArray_91"
        Me._DataTextArray_91.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataTextArray_91.Size = New System.Drawing.Size(81, 20)
        Me._DataTextArray_91.TabIndex = 321
        Me._DataTextArray_91.Tag = "SecondaryCrystalloids1Units"
        '
        '_DataComboArray_31
        '
        Me._DataComboArray_31.BackColor = System.Drawing.SystemColors.InactiveCaptionText
        Me._DataComboArray_31.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataComboArray_31.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._DataComboArray_31.Enabled = False
        Me._DataComboArray_31.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataComboArray_31.ForeColor = System.Drawing.SystemColors.WindowText
        Me.DataComboArray.SetIndex(Me._DataComboArray_31, CType(31, Short))
        Me._DataComboArray_31.Location = New System.Drawing.Point(136, 18)
        Me._DataComboArray_31.Name = "_DataComboArray_31"
        Me._DataComboArray_31.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataComboArray_31.Size = New System.Drawing.Size(73, 22)
        Me._DataComboArray_31.TabIndex = 319
        Me._DataComboArray_31.Tag = "SecondaryCrystalloids"
        '
        '_DataLabelArray_133
        '
        Me._DataLabelArray_133.AutoSize = True
        Me._DataLabelArray_133.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_133.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_133.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_133.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_133, CType(133, Short))
        Me._DataLabelArray_133.Location = New System.Drawing.Point(5, 304)
        Me._DataLabelArray_133.Name = "_DataLabelArray_133"
        Me._DataLabelArray_133.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_133.Size = New System.Drawing.Size(135, 14)
        Me._DataLabelArray_133.TabIndex = 145
        Me._DataLabelArray_133.Tag = "lbSecondaryCrystalloids3UnitGiven"
        Me._DataLabelArray_133.Text = "Crystalloid 3 where Given:"
        '
        '_DataLabelArray_132
        '
        Me._DataLabelArray_132.AutoSize = True
        Me._DataLabelArray_132.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_132.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_132.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_132.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_132, CType(132, Short))
        Me._DataLabelArray_132.Location = New System.Drawing.Point(95, 280)
        Me._DataLabelArray_132.Name = "_DataLabelArray_132"
        Me._DataLabelArray_132.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_132.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_132.TabIndex = 144
        Me._DataLabelArray_132.Tag = "lblSecondaryCrystalloids3CC"
        Me._DataLabelArray_132.Text = "CC/Unit:"
        '
        '_DataLabelArray_131
        '
        Me._DataLabelArray_131.AutoSize = True
        Me._DataLabelArray_131.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_131.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_131.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_131.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_131, CType(131, Short))
        Me._DataLabelArray_131.Location = New System.Drawing.Point(44, 256)
        Me._DataLabelArray_131.Name = "_DataLabelArray_131"
        Me._DataLabelArray_131.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_131.Size = New System.Drawing.Size(96, 14)
        Me._DataLabelArray_131.TabIndex = 143
        Me._DataLabelArray_131.Tag = "lblSecondaryCrystalloids3Units"
        Me._DataLabelArray_131.Text = "Crystalloid 3 Units:"
        '
        '_DataLabelArray_130
        '
        Me._DataLabelArray_130.AutoSize = True
        Me._DataLabelArray_130.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_130.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_130.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_130.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_130, CType(130, Short))
        Me._DataLabelArray_130.Location = New System.Drawing.Point(44, 232)
        Me._DataLabelArray_130.Name = "_DataLabelArray_130"
        Me._DataLabelArray_130.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_130.Size = New System.Drawing.Size(95, 14)
        Me._DataLabelArray_130.TabIndex = 142
        Me._DataLabelArray_130.Tag = "lblSecondaryCrystalloids3Type"
        Me._DataLabelArray_130.Text = "Crystalloid 3 Type:"
        '
        '_DataLabelArray_129
        '
        Me._DataLabelArray_129.AutoSize = True
        Me._DataLabelArray_129.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_129.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_129.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_129.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_129, CType(129, Short))
        Me._DataLabelArray_129.Location = New System.Drawing.Point(5, 211)
        Me._DataLabelArray_129.Name = "_DataLabelArray_129"
        Me._DataLabelArray_129.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_129.Size = New System.Drawing.Size(135, 14)
        Me._DataLabelArray_129.TabIndex = 141
        Me._DataLabelArray_129.Tag = "lblSecondaryCrystalloids2UnitGiven"
        Me._DataLabelArray_129.Text = "Crystalloid 2 where Given:"
        '
        '_DataLabelArray_128
        '
        Me._DataLabelArray_128.AutoSize = True
        Me._DataLabelArray_128.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_128.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_128.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_128.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_128, CType(128, Short))
        Me._DataLabelArray_128.Location = New System.Drawing.Point(95, 187)
        Me._DataLabelArray_128.Name = "_DataLabelArray_128"
        Me._DataLabelArray_128.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_128.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_128.TabIndex = 140
        Me._DataLabelArray_128.Tag = "lblSecondaryCrystalloids2CC"
        Me._DataLabelArray_128.Text = "CC/Unit:"
        '
        '_DataLabelArray_127
        '
        Me._DataLabelArray_127.AutoSize = True
        Me._DataLabelArray_127.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_127.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_127.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_127.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_127, CType(127, Short))
        Me._DataLabelArray_127.Location = New System.Drawing.Point(44, 163)
        Me._DataLabelArray_127.Name = "_DataLabelArray_127"
        Me._DataLabelArray_127.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_127.Size = New System.Drawing.Size(96, 14)
        Me._DataLabelArray_127.TabIndex = 139
        Me._DataLabelArray_127.Tag = "lblSecondaryCrystalloids2Units"
        Me._DataLabelArray_127.Text = "Crystalloid 2 Units:"
        '
        '_DataLabelArray_126
        '
        Me._DataLabelArray_126.AutoSize = True
        Me._DataLabelArray_126.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_126.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_126.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_126.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_126, CType(126, Short))
        Me._DataLabelArray_126.Location = New System.Drawing.Point(44, 139)
        Me._DataLabelArray_126.Name = "_DataLabelArray_126"
        Me._DataLabelArray_126.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_126.Size = New System.Drawing.Size(95, 14)
        Me._DataLabelArray_126.TabIndex = 138
        Me._DataLabelArray_126.Tag = "lblSecondaryCrystalloids2Type"
        Me._DataLabelArray_126.Text = "Crystalloid 2 Type:"
        '
        '_DataLabelArray_125
        '
        Me._DataLabelArray_125.AutoSize = True
        Me._DataLabelArray_125.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_125.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_125.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_125.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_125, CType(125, Short))
        Me._DataLabelArray_125.Location = New System.Drawing.Point(5, 115)
        Me._DataLabelArray_125.Name = "_DataLabelArray_125"
        Me._DataLabelArray_125.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_125.Size = New System.Drawing.Size(135, 14)
        Me._DataLabelArray_125.TabIndex = 137
        Me._DataLabelArray_125.Tag = "lblSecondaryCrystalloids1UnitGiven"
        Me._DataLabelArray_125.Text = "Crystalloid 1 where Given:"
        '
        '_DataLabelArray_124
        '
        Me._DataLabelArray_124.AutoSize = True
        Me._DataLabelArray_124.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_124.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_124.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_124.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_124, CType(124, Short))
        Me._DataLabelArray_124.Location = New System.Drawing.Point(95, 91)
        Me._DataLabelArray_124.Name = "_DataLabelArray_124"
        Me._DataLabelArray_124.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_124.Size = New System.Drawing.Size(45, 14)
        Me._DataLabelArray_124.TabIndex = 136
        Me._DataLabelArray_124.Tag = "lblSecondaryCrystalloids1CC"
        Me._DataLabelArray_124.Text = "CC/Unit:"
        '
        '_DataLabelArray_123
        '
        Me._DataLabelArray_123.AutoSize = True
        Me._DataLabelArray_123.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_123.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_123.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_123.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_123, CType(123, Short))
        Me._DataLabelArray_123.Location = New System.Drawing.Point(44, 67)
        Me._DataLabelArray_123.Name = "_DataLabelArray_123"
        Me._DataLabelArray_123.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_123.Size = New System.Drawing.Size(96, 14)
        Me._DataLabelArray_123.TabIndex = 135
        Me._DataLabelArray_123.Tag = "lblSecondaryCrystalloids1Units"
        Me._DataLabelArray_123.Text = "Crystalloid 1 Units:"
        '
        '_DataLabelArray_122
        '
        Me._DataLabelArray_122.AutoSize = True
        Me._DataLabelArray_122.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_122.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_122.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_122.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_122, CType(122, Short))
        Me._DataLabelArray_122.Location = New System.Drawing.Point(44, 43)
        Me._DataLabelArray_122.Name = "_DataLabelArray_122"
        Me._DataLabelArray_122.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_122.Size = New System.Drawing.Size(95, 14)
        Me._DataLabelArray_122.TabIndex = 134
        Me._DataLabelArray_122.Tag = "lblSecondaryCrystalloids1Type"
        Me._DataLabelArray_122.Text = "Crystalloid 1 Type:"
        '
        '_DataLabelArray_121
        '
        Me._DataLabelArray_121.AutoSize = True
        Me._DataLabelArray_121.BackColor = System.Drawing.SystemColors.Control
        Me._DataLabelArray_121.Cursor = System.Windows.Forms.Cursors.Default
        Me._DataLabelArray_121.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._DataLabelArray_121.ForeColor = System.Drawing.SystemColors.ControlText
        Me.DataLabelArray.SetIndex(Me._DataLabelArray_121, CType(121, Short))
        Me._DataLabelArray_121.Location = New System.Drawing.Point(71, 19)
        Me._DataLabelArray_121.Name = "_DataLabelArray_121"
        Me._DataLabelArray_121.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._DataLabelArray_121.Size = New System.Drawing.Size(69, 14)
        Me._DataLabelArray_121.TabIndex = 133
        Me._DataLabelArray_121.Tag = "lblSecondaryCrystalloids"
        Me._DataLabelArray_121.Text = "Crystalloids?"
        '
        '_tbReferralData_TabPage4
        '
        Me._tbReferralData_TabPage4.AutoScroll = True
        Me._tbReferralData_TabPage4.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage4.Name = "_tbReferralData_TabPage4"
        Me._tbReferralData_TabPage4.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage4.TabIndex = 4
        Me._tbReferralData_TabPage4.Text = "Tab 4"
        '
        '_tbReferralData_TabPage5
        '
        Me._tbReferralData_TabPage5.AutoScroll = True
        Me._tbReferralData_TabPage5.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage5.Name = "_tbReferralData_TabPage5"
        Me._tbReferralData_TabPage5.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage5.TabIndex = 5
        Me._tbReferralData_TabPage5.Text = "Tab 5"
        '
        '_tbReferralData_TabPage6
        '
        Me._tbReferralData_TabPage6.AutoScroll = True
        Me._tbReferralData_TabPage6.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage6.Name = "_tbReferralData_TabPage6"
        Me._tbReferralData_TabPage6.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage6.TabIndex = 6
        Me._tbReferralData_TabPage6.Text = "Tab 6"
        '
        '_tbReferralData_TabPage7
        '
        Me._tbReferralData_TabPage7.AutoScroll = True
        Me._tbReferralData_TabPage7.Location = New System.Drawing.Point(4, 22)
        Me._tbReferralData_TabPage7.Name = "_tbReferralData_TabPage7"
        Me._tbReferralData_TabPage7.Size = New System.Drawing.Size(601, 575)
        Me._tbReferralData_TabPage7.TabIndex = 7
        Me._tbReferralData_TabPage7.Text = "Tab 7"
        '
        '_TabDonor_TabPage1
        '
        Me._TabDonor_TabPage1.Controls.Add(Me.lblScheduleAlert)
        Me._TabDonor_TabPage1.Controls.Add(Me.rtbScheduleAlert)
        Me._TabDonor_TabPage1.Controls.Add(Me.CmdDelete)
        Me._TabDonor_TabPage1.Controls.Add(Me._Frame_1)
        Me._TabDonor_TabPage1.Controls.Add(Me.CmdReferral)
        Me._TabDonor_TabPage1.Controls.Add(Me.CmdNewEvent)
        Me._TabDonor_TabPage1.Controls.Add(Me.LstViewLogEvent)
        Me._TabDonor_TabPage1.Controls.Add(Me.LstViewPending)
        Me._TabDonor_TabPage1.Controls.Add(Me._Lable_19)
        Me._TabDonor_TabPage1.Location = New System.Drawing.Point(4, 4)
        Me._TabDonor_TabPage1.Name = "_TabDonor_TabPage1"
        Me._TabDonor_TabPage1.Size = New System.Drawing.Size(1201, 393)
        Me._TabDonor_TabPage1.TabIndex = 1
        Me._TabDonor_TabPage1.Text = "Event Log"
        '
        'lblScheduleAlert
        '
        Me.lblScheduleAlert.AutoSize = True
        Me.lblScheduleAlert.BackColor = System.Drawing.SystemColors.Control
        Me.lblScheduleAlert.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblScheduleAlert.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblScheduleAlert.ForeColor = System.Drawing.Color.Black
        Me.lblScheduleAlert.Location = New System.Drawing.Point(993, 10)
        Me.lblScheduleAlert.Name = "lblScheduleAlert"
        Me.lblScheduleAlert.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblScheduleAlert.Size = New System.Drawing.Size(137, 14)
        Me.lblScheduleAlert.TabIndex = 210
        Me.lblScheduleAlert.Text = "Organization Special Notes"
        '
        'rtbScheduleAlert
        '
        Me.rtbScheduleAlert.Location = New System.Drawing.Point(990, 26)
        Me.rtbScheduleAlert.Name = "rtbScheduleAlert"
        Me.rtbScheduleAlert.Required = False
        Me.rtbScheduleAlert.Size = New System.Drawing.Size(200, 364)
        Me.rtbScheduleAlert.SpellCheckEnabled = False
        Me.rtbScheduleAlert.TabIndex = 209
        Me.rtbScheduleAlert.Text = ""
        '
        'CmdDelete
        '
        Me.CmdDelete.BackColor = System.Drawing.SystemColors.Control
        Me.CmdDelete.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdDelete.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdDelete.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdDelete.Location = New System.Drawing.Point(893, 86)
        Me.CmdDelete.Name = "CmdDelete"
        Me.CmdDelete.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdDelete.Size = New System.Drawing.Size(83, 21)
        Me.CmdDelete.TabIndex = 42
        Me.CmdDelete.TabStop = False
        Me.CmdDelete.Text = "Delete Event"
        Me.CmdDelete.UseVisualStyleBackColor = False
        '
        '_Frame_1
        '
        Me._Frame_1.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_1.Controls.Add(Me.chkViewLogEventDeleted)
        Me._Frame_1.Controls.Add(Me.CmdColorKey)
        Me._Frame_1.Controls.Add(Me.CboCallByEmployee)
        Me._Frame_1.Controls.Add(Me.TxtTotalTimeCounter)
        Me._Frame_1.Controls.Add(Me.TxtCallDate)
        Me._Frame_1.Controls.Add(Me._LblReferral_28)
        Me._Frame_1.Controls.Add(Me._LblReferral_27)
        Me._Frame_1.Controls.Add(Me._LblReferral_20)
        Me._Frame_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_1, CType(1, Short))
        Me._Frame_1.Location = New System.Drawing.Point(11, 344)
        Me._Frame_1.Name = "_Frame_1"
        Me._Frame_1.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_1.Size = New System.Drawing.Size(969, 47)
        Me._Frame_1.TabIndex = 43
        Me._Frame_1.TabStop = False
        '
        'chkViewLogEventDeleted
        '
        Me.chkViewLogEventDeleted.BackColor = System.Drawing.SystemColors.Control
        Me.chkViewLogEventDeleted.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkViewLogEventDeleted.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkViewLogEventDeleted.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkViewLogEventDeleted.Location = New System.Drawing.Point(658, 16)
        Me.chkViewLogEventDeleted.Name = "chkViewLogEventDeleted"
        Me.chkViewLogEventDeleted.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkViewLogEventDeleted.Size = New System.Drawing.Size(129, 21)
        Me.chkViewLogEventDeleted.TabIndex = 645
        Me.chkViewLogEventDeleted.Text = "Display All Events"
        Me.chkViewLogEventDeleted.UseVisualStyleBackColor = False
        '
        'CmdColorKey
        '
        Me.CmdColorKey.BackColor = System.Drawing.SystemColors.Control
        Me.CmdColorKey.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdColorKey.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdColorKey.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdColorKey.Location = New System.Drawing.Point(15, 9)
        Me.CmdColorKey.Name = "CmdColorKey"
        Me.CmdColorKey.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdColorKey.Size = New System.Drawing.Size(50, 36)
        Me.CmdColorKey.TabIndex = 617
        Me.CmdColorKey.Text = "Color Key"
        Me.CmdColorKey.UseVisualStyleBackColor = False
        '
        'CboCallByEmployee
        '
        Me.CboCallByEmployee.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.CboCallByEmployee.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.CboCallByEmployee.BackColor = System.Drawing.Color.White
        Me.CboCallByEmployee.Cursor = System.Windows.Forms.Cursors.Default
        Me.CboCallByEmployee.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CboCallByEmployee.Enabled = False
        Me.CboCallByEmployee.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CboCallByEmployee.ForeColor = System.Drawing.Color.Black
        Me.CboCallByEmployee.Location = New System.Drawing.Point(422, 16)
        Me.CboCallByEmployee.Name = "CboCallByEmployee"
        Me.CboCallByEmployee.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CboCallByEmployee.Size = New System.Drawing.Size(143, 22)
        Me.CboCallByEmployee.TabIndex = 46
        Me.CboCallByEmployee.TabStop = False
        '
        'TxtTotalTimeCounter
        '
        Me.TxtTotalTimeCounter.AcceptsReturn = True
        Me.TxtTotalTimeCounter.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.TxtTotalTimeCounter.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtTotalTimeCounter.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtTotalTimeCounter.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtTotalTimeCounter.Location = New System.Drawing.Point(902, 16)
        Me.TxtTotalTimeCounter.MaxLength = 0
        Me.TxtTotalTimeCounter.Name = "TxtTotalTimeCounter"
        Me.TxtTotalTimeCounter.ReadOnly = True
        Me.TxtTotalTimeCounter.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtTotalTimeCounter.Size = New System.Drawing.Size(51, 20)
        Me.TxtTotalTimeCounter.TabIndex = 45
        Me.TxtTotalTimeCounter.TabStop = False
        Me.TxtTotalTimeCounter.Text = "00:00:00"
        '
        'TxtCallDate
        '
        Me.TxtCallDate.AcceptsReturn = True
        Me.TxtCallDate.BackColor = System.Drawing.Color.White
        Me.TxtCallDate.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtCallDate.Enabled = False
        Me.TxtCallDate.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TxtCallDate.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TxtCallDate.Location = New System.Drawing.Point(220, 16)
        Me.TxtCallDate.MaxLength = 0
        Me.TxtCallDate.Name = "TxtCallDate"
        Me.TxtCallDate.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtCallDate.Size = New System.Drawing.Size(87, 20)
        Me.TxtCallDate.TabIndex = 44
        Me.TxtCallDate.TabStop = False
        Me.TxtCallDate.Text = "00/00/00  00:00"
        '
        '_LblReferral_28
        '
        Me._LblReferral_28.AutoSize = True
        Me._LblReferral_28.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_28.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_28.ForeColor = System.Drawing.Color.Black
        Me.LblReferral.SetIndex(Me._LblReferral_28, CType(28, Short))
        Me._LblReferral_28.Location = New System.Drawing.Point(822, 19)
        Me._LblReferral_28.Name = "_LblReferral_28"
        Me._LblReferral_28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_28.Size = New System.Drawing.Size(74, 14)
        Me._LblReferral_28.TabIndex = 49
        Me._LblReferral_28.Text = "Total Call Time"
        '
        '_LblReferral_27
        '
        Me._LblReferral_27.AutoSize = True
        Me._LblReferral_27.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_27.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_27.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_27.ForeColor = System.Drawing.Color.Black
        Me.LblReferral.SetIndex(Me._LblReferral_27, CType(27, Short))
        Me._LblReferral_27.Location = New System.Drawing.Point(166, 19)
        Me._LblReferral_27.Name = "_LblReferral_27"
        Me._LblReferral_27.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_27.Size = New System.Drawing.Size(49, 14)
        Me._LblReferral_27.TabIndex = 48
        Me._LblReferral_27.Text = "Call Date"
        '
        '_LblReferral_20
        '
        Me._LblReferral_20.AutoSize = True
        Me._LblReferral_20.BackColor = System.Drawing.SystemColors.Control
        Me._LblReferral_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._LblReferral_20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._LblReferral_20.ForeColor = System.Drawing.Color.Black
        Me.LblReferral.SetIndex(Me._LblReferral_20, CType(20, Short))
        Me._LblReferral_20.Location = New System.Drawing.Point(400, 19)
        Me._LblReferral_20.Name = "_LblReferral_20"
        Me._LblReferral_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._LblReferral_20.Size = New System.Drawing.Size(20, 14)
        Me._LblReferral_20.TabIndex = 47
        Me._LblReferral_20.Text = "By"
        '
        'CmdReferral
        '
        Me.CmdReferral.BackColor = System.Drawing.SystemColors.Control
        Me.CmdReferral.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdReferral.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdReferral.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdReferral.Location = New System.Drawing.Point(893, 24)
        Me.CmdReferral.Name = "CmdReferral"
        Me.CmdReferral.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdReferral.Size = New System.Drawing.Size(83, 21)
        Me.CmdReferral.TabIndex = 37
        Me.CmdReferral.Text = "On Call..."
        Me.CmdReferral.UseVisualStyleBackColor = False
        '
        'CmdNewEvent
        '
        Me.CmdNewEvent.BackColor = System.Drawing.SystemColors.Control
        Me.CmdNewEvent.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdNewEvent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdNewEvent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdNewEvent.Location = New System.Drawing.Point(893, 48)
        Me.CmdNewEvent.Name = "CmdNewEvent"
        Me.CmdNewEvent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdNewEvent.Size = New System.Drawing.Size(83, 21)
        Me.CmdNewEvent.TabIndex = 36
        Me.CmdNewEvent.Text = "New Event..."
        Me.CmdNewEvent.UseVisualStyleBackColor = False
        '
        'LstViewLogEvent
        '
        Me.LstViewLogEvent.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewLogEvent.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewLogEvent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewLogEvent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewLogEvent.FullRowSelect = True
        Me.LstViewLogEvent.HideSelection = False
        Me.LstViewLogEvent.LabelWrap = False
        Me.LstViewLogEvent.Location = New System.Drawing.Point(12, 112)
        Me.LstViewLogEvent.Name = "LstViewLogEvent"
        Me.LstViewLogEvent.Size = New System.Drawing.Size(966, 235)
        Me.LstViewLogEvent.TabIndex = 38
        Me.LstViewLogEvent.UseCompatibleStateImageBehavior = False
        Me.LstViewLogEvent.View = System.Windows.Forms.View.Details
        '
        'LstViewPending
        '
        Me.LstViewPending.BackColor = System.Drawing.SystemColors.Window
        Me.LstViewPending.BorderStyle = System.Windows.Forms.BorderStyle.None
        Me.LstViewPending.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LstViewPending.ForeColor = System.Drawing.SystemColors.WindowText
        Me.LstViewPending.FullRowSelect = True
        Me.LstViewPending.HideSelection = False
        Me.LstViewPending.LabelWrap = False
        Me.LstViewPending.Location = New System.Drawing.Point(12, 24)
        Me.LstViewPending.Name = "LstViewPending"
        Me.LstViewPending.Size = New System.Drawing.Size(550, 83)
        Me.LstViewPending.TabIndex = 39
        Me.LstViewPending.UseCompatibleStateImageBehavior = False
        Me.LstViewPending.View = System.Windows.Forms.View.Details
        '
        '_Lable_19
        '
        Me._Lable_19.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_19, CType(19, Short))
        Me._Lable_19.Location = New System.Drawing.Point(12, 8)
        Me._Lable_19.Name = "_Lable_19"
        Me._Lable_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_19.Size = New System.Drawing.Size(177, 15)
        Me._Lable_19.TabIndex = 40
        Me._Lable_19.Text = "Pending Events"
        '
        '_TabDonor_TabPage2
        '
        Me._TabDonor_TabPage2.Controls.Add(Me.fmSecondaryStatus)
        Me._TabDonor_TabPage2.Controls.Add(Me._Frame_0)
        Me._TabDonor_TabPage2.Location = New System.Drawing.Point(4, 4)
        Me._TabDonor_TabPage2.Name = "_TabDonor_TabPage2"
        Me._TabDonor_TabPage2.Size = New System.Drawing.Size(1201, 393)
        Me._TabDonor_TabPage2.TabIndex = 2
        Me._TabDonor_TabPage2.Text = "Case Mgmt."
        '
        'fmSecondaryStatus
        '
        Me.fmSecondaryStatus.BackColor = System.Drawing.SystemColors.Control
        Me.fmSecondaryStatus.Controls.Add(Me.chkCaseOpen)
        Me.fmSecondaryStatus.Controls.Add(Me.chkSystemEvents)
        Me.fmSecondaryStatus.Controls.Add(Me.chkSecondaryComplete)
        Me.fmSecondaryStatus.Controls.Add(Me.chkApproached)
        Me.fmSecondaryStatus.Controls.Add(Me.chkFinal)
        Me.fmSecondaryStatus.Controls.Add(Me.cmdDonorTrac)
        Me.fmSecondaryStatus.Controls.Add(Me.lblCaseOpenPersonDateTime)
        Me.fmSecondaryStatus.Controls.Add(Me.lblSystemEventsPersonDateTime)
        Me.fmSecondaryStatus.Controls.Add(Me.lblSecondaryCompletePersonDateTime)
        Me.fmSecondaryStatus.Controls.Add(Me.lblApproachedPersonDateTime)
        Me.fmSecondaryStatus.Controls.Add(Me.lblFinalPersonDateTime)
        Me.fmSecondaryStatus.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmSecondaryStatus.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmSecondaryStatus.Location = New System.Drawing.Point(8, 16)
        Me.fmSecondaryStatus.Name = "fmSecondaryStatus"
        Me.fmSecondaryStatus.Padding = New System.Windows.Forms.Padding(0)
        Me.fmSecondaryStatus.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmSecondaryStatus.Size = New System.Drawing.Size(521, 147)
        Me.fmSecondaryStatus.TabIndex = 12
        Me.fmSecondaryStatus.TabStop = False
        Me.fmSecondaryStatus.Text = "Secondary Status"
        '
        'cmdDonorTrac
        '
        Me.cmdDonorTrac.BackColor = System.Drawing.SystemColors.Control
        Me.cmdDonorTrac.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdDonorTrac.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdDonorTrac.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdDonorTrac.Location = New System.Drawing.Point(408, 56)
        Me.cmdDonorTrac.Name = "cmdDonorTrac"
        Me.cmdDonorTrac.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdDonorTrac.Size = New System.Drawing.Size(97, 35)
        Me.cmdDonorTrac.TabIndex = 631
        Me.cmdDonorTrac.Text = "DonorTrac Case"
        Me.cmdDonorTrac.UseVisualStyleBackColor = False
        '
        'lblCaseOpenPersonDateTime
        '
        Me.lblCaseOpenPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblCaseOpenPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCaseOpenPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCaseOpenPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblCaseOpenPersonDateTime.Location = New System.Drawing.Point(160, 24)
        Me.lblCaseOpenPersonDateTime.Name = "lblCaseOpenPersonDateTime"
        Me.lblCaseOpenPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCaseOpenPersonDateTime.Size = New System.Drawing.Size(193, 17)
        Me.lblCaseOpenPersonDateTime.TabIndex = 17
        Me.lblCaseOpenPersonDateTime.Visible = False
        '
        'lblSystemEventsPersonDateTime
        '
        Me.lblSystemEventsPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblSystemEventsPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSystemEventsPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSystemEventsPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSystemEventsPersonDateTime.Location = New System.Drawing.Point(160, 48)
        Me.lblSystemEventsPersonDateTime.Name = "lblSystemEventsPersonDateTime"
        Me.lblSystemEventsPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSystemEventsPersonDateTime.Size = New System.Drawing.Size(193, 17)
        Me.lblSystemEventsPersonDateTime.TabIndex = 16
        Me.lblSystemEventsPersonDateTime.Visible = False
        '
        'lblSecondaryCompletePersonDateTime
        '
        Me.lblSecondaryCompletePersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryCompletePersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryCompletePersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryCompletePersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryCompletePersonDateTime.Location = New System.Drawing.Point(160, 72)
        Me.lblSecondaryCompletePersonDateTime.Name = "lblSecondaryCompletePersonDateTime"
        Me.lblSecondaryCompletePersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryCompletePersonDateTime.Size = New System.Drawing.Size(201, 17)
        Me.lblSecondaryCompletePersonDateTime.TabIndex = 15
        Me.lblSecondaryCompletePersonDateTime.Visible = False
        '
        'lblApproachedPersonDateTime
        '
        Me.lblApproachedPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblApproachedPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblApproachedPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblApproachedPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblApproachedPersonDateTime.Location = New System.Drawing.Point(160, 96)
        Me.lblApproachedPersonDateTime.Name = "lblApproachedPersonDateTime"
        Me.lblApproachedPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblApproachedPersonDateTime.Size = New System.Drawing.Size(209, 17)
        Me.lblApproachedPersonDateTime.TabIndex = 14
        Me.lblApproachedPersonDateTime.Visible = False
        '
        'lblFinalPersonDateTime
        '
        Me.lblFinalPersonDateTime.BackColor = System.Drawing.SystemColors.Control
        Me.lblFinalPersonDateTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFinalPersonDateTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFinalPersonDateTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblFinalPersonDateTime.Location = New System.Drawing.Point(160, 120)
        Me.lblFinalPersonDateTime.Name = "lblFinalPersonDateTime"
        Me.lblFinalPersonDateTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFinalPersonDateTime.Size = New System.Drawing.Size(217, 17)
        Me.lblFinalPersonDateTime.TabIndex = 13
        Me.lblFinalPersonDateTime.Visible = False
        '
        '_Frame_0
        '
        Me._Frame_0.BackColor = System.Drawing.SystemColors.Control
        Me._Frame_0.Controls.Add(Me.chkSecondaryOTE)
        Me._Frame_0.Controls.Add(Me.cboSecondaryCryolifeFormCompleted)
        Me._Frame_0.Controls.Add(Me.cboSecondaryMedSoc)
        Me._Frame_0.Controls.Add(Me.cboSecondaryFamilyApproach)
        Me._Frame_0.Controls.Add(Me.chkSecondaryCryolifeFormCompleted)
        Me._Frame_0.Controls.Add(Me.chkSecondaryFamilyUnavailable)
        Me._Frame_0.Controls.Add(Me.chkSecondaryMedSoc)
        Me._Frame_0.Controls.Add(Me.chkSecondaryFamilyApproach)
        Me._Frame_0.Controls.Add(Me.chkSecondaryBillable)
        Me._Frame_0.Controls.Add(Me.lblSecondaryOTE)
        Me._Frame_0.Controls.Add(Me.lblSecondaryCryolifeFormCompleted)
        Me._Frame_0.Controls.Add(Me.lblSecondaryFamilyUnavailable)
        Me._Frame_0.Controls.Add(Me.lblSecondaryMedSoc)
        Me._Frame_0.Controls.Add(Me.lblSecondaryFamilyApproach)
        Me._Frame_0.Controls.Add(Me.lblSecondaryBillable)
        Me._Frame_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame.SetIndex(Me._Frame_0, CType(0, Short))
        Me._Frame_0.Location = New System.Drawing.Point(8, 176)
        Me._Frame_0.Name = "_Frame_0"
        Me._Frame_0.Padding = New System.Windows.Forms.Padding(0)
        Me._Frame_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame_0.Size = New System.Drawing.Size(521, 187)
        Me._Frame_0.TabIndex = 18
        Me._Frame_0.TabStop = False
        Me._Frame_0.Text = "Secondary Billing"
        '
        'cboSecondaryCryolifeFormCompleted
        '
        Me.cboSecondaryCryolifeFormCompleted.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboSecondaryCryolifeFormCompleted.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboSecondaryCryolifeFormCompleted.BackColor = System.Drawing.SystemColors.Window
        Me.cboSecondaryCryolifeFormCompleted.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboSecondaryCryolifeFormCompleted.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboSecondaryCryolifeFormCompleted.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboSecondaryCryolifeFormCompleted.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboSecondaryCryolifeFormCompleted.Location = New System.Drawing.Point(152, 144)
        Me.cboSecondaryCryolifeFormCompleted.Name = "cboSecondaryCryolifeFormCompleted"
        Me.cboSecondaryCryolifeFormCompleted.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboSecondaryCryolifeFormCompleted.Size = New System.Drawing.Size(41, 22)
        Me.cboSecondaryCryolifeFormCompleted.TabIndex = 31
        '
        'cboSecondaryMedSoc
        '
        Me.cboSecondaryMedSoc.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboSecondaryMedSoc.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboSecondaryMedSoc.BackColor = System.Drawing.SystemColors.Window
        Me.cboSecondaryMedSoc.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboSecondaryMedSoc.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboSecondaryMedSoc.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboSecondaryMedSoc.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboSecondaryMedSoc.Location = New System.Drawing.Point(152, 120)
        Me.cboSecondaryMedSoc.Name = "cboSecondaryMedSoc"
        Me.cboSecondaryMedSoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboSecondaryMedSoc.Size = New System.Drawing.Size(41, 22)
        Me.cboSecondaryMedSoc.TabIndex = 29
        '
        'cboSecondaryFamilyApproach
        '
        Me.cboSecondaryFamilyApproach.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboSecondaryFamilyApproach.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboSecondaryFamilyApproach.BackColor = System.Drawing.SystemColors.Window
        Me.cboSecondaryFamilyApproach.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboSecondaryFamilyApproach.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboSecondaryFamilyApproach.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboSecondaryFamilyApproach.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboSecondaryFamilyApproach.Location = New System.Drawing.Point(152, 96)
        Me.cboSecondaryFamilyApproach.Name = "cboSecondaryFamilyApproach"
        Me.cboSecondaryFamilyApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboSecondaryFamilyApproach.Size = New System.Drawing.Size(41, 22)
        Me.cboSecondaryFamilyApproach.TabIndex = 27
        '
        'lblSecondaryOTE
        '
        Me.lblSecondaryOTE.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryOTE.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryOTE.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryOTE.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryOTE.Location = New System.Drawing.Point(208, 48)
        Me.lblSecondaryOTE.Name = "lblSecondaryOTE"
        Me.lblSecondaryOTE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryOTE.Size = New System.Drawing.Size(193, 17)
        Me.lblSecondaryOTE.TabIndex = 630
        '
        'lblSecondaryCryolifeFormCompleted
        '
        Me.lblSecondaryCryolifeFormCompleted.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryCryolifeFormCompleted.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryCryolifeFormCompleted.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryCryolifeFormCompleted.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryCryolifeFormCompleted.Location = New System.Drawing.Point(208, 144)
        Me.lblSecondaryCryolifeFormCompleted.Name = "lblSecondaryCryolifeFormCompleted"
        Me.lblSecondaryCryolifeFormCompleted.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryCryolifeFormCompleted.Size = New System.Drawing.Size(201, 17)
        Me.lblSecondaryCryolifeFormCompleted.TabIndex = 449
        '
        'lblSecondaryFamilyUnavailable
        '
        Me.lblSecondaryFamilyUnavailable.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryFamilyUnavailable.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryFamilyUnavailable.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryFamilyUnavailable.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryFamilyUnavailable.Location = New System.Drawing.Point(208, 72)
        Me.lblSecondaryFamilyUnavailable.Name = "lblSecondaryFamilyUnavailable"
        Me.lblSecondaryFamilyUnavailable.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryFamilyUnavailable.Size = New System.Drawing.Size(193, 17)
        Me.lblSecondaryFamilyUnavailable.TabIndex = 448
        '
        'lblSecondaryMedSoc
        '
        Me.lblSecondaryMedSoc.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryMedSoc.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryMedSoc.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryMedSoc.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryMedSoc.Location = New System.Drawing.Point(208, 120)
        Me.lblSecondaryMedSoc.Name = "lblSecondaryMedSoc"
        Me.lblSecondaryMedSoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryMedSoc.Size = New System.Drawing.Size(201, 17)
        Me.lblSecondaryMedSoc.TabIndex = 34
        '
        'lblSecondaryFamilyApproach
        '
        Me.lblSecondaryFamilyApproach.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryFamilyApproach.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryFamilyApproach.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryFamilyApproach.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryFamilyApproach.Location = New System.Drawing.Point(208, 96)
        Me.lblSecondaryFamilyApproach.Name = "lblSecondaryFamilyApproach"
        Me.lblSecondaryFamilyApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryFamilyApproach.Size = New System.Drawing.Size(193, 17)
        Me.lblSecondaryFamilyApproach.TabIndex = 33
        '
        'lblSecondaryBillable
        '
        Me.lblSecondaryBillable.BackColor = System.Drawing.SystemColors.Control
        Me.lblSecondaryBillable.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecondaryBillable.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSecondaryBillable.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSecondaryBillable.Location = New System.Drawing.Point(208, 24)
        Me.lblSecondaryBillable.Name = "lblSecondaryBillable"
        Me.lblSecondaryBillable.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecondaryBillable.Size = New System.Drawing.Size(193, 17)
        Me.lblSecondaryBillable.TabIndex = 32
        '
        '_TabDonor_TabPage3
        '
        Me._TabDonor_TabPage3.Controls.Add(Me.SSTab1)
        Me._TabDonor_TabPage3.Location = New System.Drawing.Point(4, 4)
        Me._TabDonor_TabPage3.Name = "_TabDonor_TabPage3"
        Me._TabDonor_TabPage3.Size = New System.Drawing.Size(1201, 393)
        Me._TabDonor_TabPage3.TabIndex = 3
        Me._TabDonor_TabPage3.Text = "Approach"
        '
        'SSTab1
        '
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage0)
        Me.SSTab1.Controls.Add(Me._SSTab1_TabPage1)
        Me.SSTab1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.SSTab1.ItemSize = New System.Drawing.Size(42, 18)
        Me.SSTab1.Location = New System.Drawing.Point(8, 8)
        Me.SSTab1.Name = "SSTab1"
        Me.SSTab1.SelectedIndex = 0
        Me.SSTab1.Size = New System.Drawing.Size(620, 385)
        Me.SSTab1.TabIndex = 450
        '
        '_SSTab1_TabPage0
        '
        Me._SSTab1_TabPage0.Controls.Add(Me.fmeApproach)
        Me._SSTab1_TabPage0.Controls.Add(Me.Frame1)
        Me._SSTab1_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage0.Name = "_SSTab1_TabPage0"
        Me._SSTab1_TabPage0.Size = New System.Drawing.Size(612, 359)
        Me._SSTab1_TabPage0.TabIndex = 0
        Me._SSTab1_TabPage0.Text = "Approach"
        '
        'fmeApproach
        '
        Me.fmeApproach.BackColor = System.Drawing.SystemColors.Control
        Me.fmeApproach.Controls.Add(Me.cmdInformedApproachPersonDetail)
        Me.fmeApproach.Controls.Add(Me.cboApproachReason)
        Me.fmeApproach.Controls.Add(Me.cboApproachOutcome)
        Me.fmeApproach.Controls.Add(Me.cboApproachType)
        Me.fmeApproach.Controls.Add(Me.cboApproachedBy)
        Me.fmeApproach.Controls.Add(Me.cboApproached)
        Me.fmeApproach.Controls.Add(Me.Label11)
        Me.fmeApproach.Controls.Add(Me.Label10)
        Me.fmeApproach.Controls.Add(Me.Label9)
        Me.fmeApproach.Controls.Add(Me.Label8)
        Me.fmeApproach.Controls.Add(Me.Label7)
        Me.fmeApproach.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmeApproach.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmeApproach.Location = New System.Drawing.Point(8, 152)
        Me.fmeApproach.Name = "fmeApproach"
        Me.fmeApproach.Padding = New System.Windows.Forms.Padding(0)
        Me.fmeApproach.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmeApproach.Size = New System.Drawing.Size(601, 185)
        Me.fmeApproach.TabIndex = 451
        Me.fmeApproach.TabStop = False
        Me.fmeApproach.Text = "Informed Approach"
        '
        'cmdInformedApproachPersonDetail
        '
        Me.cmdInformedApproachPersonDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdInformedApproachPersonDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdInformedApproachPersonDetail.Enabled = False
        Me.cmdInformedApproachPersonDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdInformedApproachPersonDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdInformedApproachPersonDetail.Location = New System.Drawing.Point(361, 56)
        Me.cmdInformedApproachPersonDetail.Name = "cmdInformedApproachPersonDetail"
        Me.cmdInformedApproachPersonDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdInformedApproachPersonDetail.Size = New System.Drawing.Size(25, 21)
        Me.cmdInformedApproachPersonDetail.TabIndex = 470
        Me.cmdInformedApproachPersonDetail.Text = "..."
        Me.cmdInformedApproachPersonDetail.UseVisualStyleBackColor = False
        '
        'cboApproachReason
        '
        Me.cboApproachReason.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboApproachReason.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboApproachReason.BackColor = System.Drawing.SystemColors.Window
        Me.cboApproachReason.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboApproachReason.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboApproachReason.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboApproachReason.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboApproachReason.Location = New System.Drawing.Point(100, 149)
        Me.cboApproachReason.Name = "cboApproachReason"
        Me.cboApproachReason.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboApproachReason.Size = New System.Drawing.Size(113, 22)
        Me.cboApproachReason.TabIndex = 473
        '
        'cboApproachOutcome
        '
        Me.cboApproachOutcome.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboApproachOutcome.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboApproachOutcome.BackColor = System.Drawing.SystemColors.Control
        Me.cboApproachOutcome.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboApproachOutcome.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboApproachOutcome.Enabled = False
        Me.cboApproachOutcome.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboApproachOutcome.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboApproachOutcome.Location = New System.Drawing.Point(100, 104)
        Me.cboApproachOutcome.Name = "cboApproachOutcome"
        Me.cboApproachOutcome.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboApproachOutcome.Size = New System.Drawing.Size(113, 22)
        Me.cboApproachOutcome.TabIndex = 472
        '
        'cboApproachType
        '
        Me.cboApproachType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboApproachType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboApproachType.BackColor = System.Drawing.SystemColors.Control
        Me.cboApproachType.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboApproachType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboApproachType.Enabled = False
        Me.cboApproachType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboApproachType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboApproachType.Location = New System.Drawing.Point(100, 80)
        Me.cboApproachType.Name = "cboApproachType"
        Me.cboApproachType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboApproachType.Size = New System.Drawing.Size(113, 22)
        Me.cboApproachType.TabIndex = 471
        '
        'cboApproachedBy
        '
        Me.cboApproachedBy.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboApproachedBy.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboApproachedBy.BackColor = System.Drawing.SystemColors.Control
        Me.cboApproachedBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboApproachedBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboApproachedBy.Enabled = False
        Me.cboApproachedBy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboApproachedBy.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboApproachedBy.Location = New System.Drawing.Point(100, 56)
        Me.cboApproachedBy.Name = "cboApproachedBy"
        Me.cboApproachedBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboApproachedBy.Size = New System.Drawing.Size(257, 22)
        Me.cboApproachedBy.TabIndex = 469
        '
        'cboApproached
        '
        Me.cboApproached.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboApproached.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboApproached.BackColor = System.Drawing.SystemColors.Window
        Me.cboApproached.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboApproached.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboApproached.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboApproached.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboApproached.Location = New System.Drawing.Point(100, 32)
        Me.cboApproached.Name = "cboApproached"
        Me.cboApproached.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboApproached.Size = New System.Drawing.Size(81, 22)
        Me.cboApproached.TabIndex = 468
        '
        'Label11
        '
        Me.Label11.BackColor = System.Drawing.SystemColors.Control
        Me.Label11.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label11.Location = New System.Drawing.Point(3, 138)
        Me.Label11.Name = "Label11"
        Me.Label11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label11.Size = New System.Drawing.Size(89, 42)
        Me.Label11.TabIndex = 456
        Me.Label11.Text = "Reason Informed Approach Not Completed:"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.BackColor = System.Drawing.SystemColors.Control
        Me.Label10.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label10.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label10.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label10.Location = New System.Drawing.Point(42, 108)
        Me.Label10.Name = "Label10"
        Me.Label10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label10.Size = New System.Drawing.Size(53, 14)
        Me.Label10.TabIndex = 455
        Me.Label10.Text = "Outcome:"
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.BackColor = System.Drawing.SystemColors.Control
        Me.Label9.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label9.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label9.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label9.Location = New System.Drawing.Point(61, 84)
        Me.Label9.Name = "Label9"
        Me.Label9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label9.Size = New System.Drawing.Size(33, 14)
        Me.Label9.TabIndex = 454
        Me.Label9.Text = "Type:"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.BackColor = System.Drawing.SystemColors.Control
        Me.Label8.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label8.Location = New System.Drawing.Point(72, 60)
        Me.Label8.Name = "Label8"
        Me.Label8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label8.Size = New System.Drawing.Size(23, 14)
        Me.Label8.TabIndex = 453
        Me.Label8.Text = "By:"
        '
        'Label7
        '
        Me.Label7.BackColor = System.Drawing.SystemColors.Control
        Me.Label7.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label7.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label7.Location = New System.Drawing.Point(17, 26)
        Me.Label7.Name = "Label7"
        Me.Label7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label7.Size = New System.Drawing.Size(77, 30)
        Me.Label7.TabIndex = 452
        Me.Label7.Text = "Informed Apprch Done?"
        '
        'Frame1
        '
        Me.Frame1.BackColor = System.Drawing.SystemColors.Control
        Me.Frame1.Controls.Add(Me.cboHospitalApproachOutcome)
        Me.Frame1.Controls.Add(Me.cmdHospitalApproachPersonDetail)
        Me.Frame1.Controls.Add(Me.cboHospitalApproachedBy)
        Me.Frame1.Controls.Add(Me.cboHospitalApproachType)
        Me.Frame1.Controls.Add(Me.Label21)
        Me.Frame1.Controls.Add(Me.Label19)
        Me.Frame1.Controls.Add(Me.Label1)
        Me.Frame1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame1.Location = New System.Drawing.Point(8, 21)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(601, 105)
        Me.Frame1.TabIndex = 460
        Me.Frame1.TabStop = False
        Me.Frame1.Text = "Hospital Approach"
        '
        'cboHospitalApproachOutcome
        '
        Me.cboHospitalApproachOutcome.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboHospitalApproachOutcome.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboHospitalApproachOutcome.BackColor = System.Drawing.SystemColors.Control
        Me.cboHospitalApproachOutcome.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboHospitalApproachOutcome.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboHospitalApproachOutcome.Enabled = False
        Me.cboHospitalApproachOutcome.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboHospitalApproachOutcome.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboHospitalApproachOutcome.Location = New System.Drawing.Point(100, 72)
        Me.cboHospitalApproachOutcome.Name = "cboHospitalApproachOutcome"
        Me.cboHospitalApproachOutcome.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboHospitalApproachOutcome.Size = New System.Drawing.Size(113, 22)
        Me.cboHospitalApproachOutcome.TabIndex = 467
        '
        'cmdHospitalApproachPersonDetail
        '
        Me.cmdHospitalApproachPersonDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdHospitalApproachPersonDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdHospitalApproachPersonDetail.Enabled = False
        Me.cmdHospitalApproachPersonDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdHospitalApproachPersonDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdHospitalApproachPersonDetail.Location = New System.Drawing.Point(365, 48)
        Me.cmdHospitalApproachPersonDetail.Name = "cmdHospitalApproachPersonDetail"
        Me.cmdHospitalApproachPersonDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdHospitalApproachPersonDetail.Size = New System.Drawing.Size(25, 21)
        Me.cmdHospitalApproachPersonDetail.TabIndex = 466
        Me.cmdHospitalApproachPersonDetail.Text = "..."
        Me.cmdHospitalApproachPersonDetail.UseVisualStyleBackColor = False
        '
        'cboHospitalApproachedBy
        '
        Me.cboHospitalApproachedBy.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboHospitalApproachedBy.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboHospitalApproachedBy.BackColor = System.Drawing.SystemColors.Control
        Me.cboHospitalApproachedBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboHospitalApproachedBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboHospitalApproachedBy.Enabled = False
        Me.cboHospitalApproachedBy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboHospitalApproachedBy.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboHospitalApproachedBy.Location = New System.Drawing.Point(100, 48)
        Me.cboHospitalApproachedBy.Name = "cboHospitalApproachedBy"
        Me.cboHospitalApproachedBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboHospitalApproachedBy.Size = New System.Drawing.Size(257, 22)
        Me.cboHospitalApproachedBy.TabIndex = 465
        '
        'cboHospitalApproachType
        '
        Me.cboHospitalApproachType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboHospitalApproachType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboHospitalApproachType.BackColor = System.Drawing.SystemColors.Window
        Me.cboHospitalApproachType.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboHospitalApproachType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboHospitalApproachType.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboHospitalApproachType.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboHospitalApproachType.Location = New System.Drawing.Point(100, 24)
        Me.cboHospitalApproachType.Name = "cboHospitalApproachType"
        Me.cboHospitalApproachType.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboHospitalApproachType.Size = New System.Drawing.Size(113, 22)
        Me.cboHospitalApproachType.TabIndex = 464
        '
        'Label21
        '
        Me.Label21.AutoSize = True
        Me.Label21.BackColor = System.Drawing.SystemColors.Control
        Me.Label21.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label21.Location = New System.Drawing.Point(43, 76)
        Me.Label21.Name = "Label21"
        Me.Label21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label21.Size = New System.Drawing.Size(53, 14)
        Me.Label21.TabIndex = 463
        Me.Label21.Text = "Outcome:"
        '
        'Label19
        '
        Me.Label19.AutoSize = True
        Me.Label19.BackColor = System.Drawing.SystemColors.Control
        Me.Label19.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label19.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label19.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label19.Location = New System.Drawing.Point(10, 52)
        Me.Label19.Name = "Label19"
        Me.Label19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label19.Size = New System.Drawing.Size(86, 14)
        Me.Label19.TabIndex = 462
        Me.Label19.Text = "Approached By:"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.SystemColors.Control
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label1.Location = New System.Drawing.Point(11, 28)
        Me.Label1.Name = "Label1"
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(84, 14)
        Me.Label1.TabIndex = 461
        Me.Label1.Text = "Approach Type:"
        '
        '_SSTab1_TabPage1
        '
        Me._SSTab1_TabPage1.Controls.Add(Me.fmeConsent)
        Me._SSTab1_TabPage1.Controls.Add(Me.Frame2)
        Me._SSTab1_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._SSTab1_TabPage1.Name = "_SSTab1_TabPage1"
        Me._SSTab1_TabPage1.Size = New System.Drawing.Size(612, 359)
        Me._SSTab1_TabPage1.TabIndex = 1
        Me._SSTab1_TabPage1.Text = "Consent"
        '
        'fmeConsent
        '
        Me.fmeConsent.BackColor = System.Drawing.SystemColors.Control
        Me.fmeConsent.Controls.Add(Me.cmdConsentMedSocPersonDetail)
        Me.fmeConsent.Controls.Add(Me.cboConsentMedSocObtainedBy)
        Me.fmeConsent.Controls.Add(Me.cboConsentMedSocPaperwork)
        Me.fmeConsent.Controls.Add(Me.cmdConsentPaperworkPersonDetail)
        Me.fmeConsent.Controls.Add(Me.cboConsent)
        Me.fmeConsent.Controls.Add(Me.cboConsentBy)
        Me.fmeConsent.Controls.Add(Me.Label23)
        Me.fmeConsent.Controls.Add(Me.Label22)
        Me.fmeConsent.Controls.Add(Me.Label12)
        Me.fmeConsent.Controls.Add(Me.Label13)
        Me.fmeConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmeConsent.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmeConsent.Location = New System.Drawing.Point(8, 23)
        Me.fmeConsent.Name = "fmeConsent"
        Me.fmeConsent.Padding = New System.Windows.Forms.Padding(0)
        Me.fmeConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmeConsent.Size = New System.Drawing.Size(601, 137)
        Me.fmeConsent.TabIndex = 457
        Me.fmeConsent.TabStop = False
        Me.fmeConsent.Text = "Written Consent and Med/Soc"
        '
        'cmdConsentMedSocPersonDetail
        '
        Me.cmdConsentMedSocPersonDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdConsentMedSocPersonDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdConsentMedSocPersonDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdConsentMedSocPersonDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdConsentMedSocPersonDetail.Location = New System.Drawing.Point(376, 96)
        Me.cmdConsentMedSocPersonDetail.Name = "cmdConsentMedSocPersonDetail"
        Me.cmdConsentMedSocPersonDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdConsentMedSocPersonDetail.Size = New System.Drawing.Size(25, 21)
        Me.cmdConsentMedSocPersonDetail.TabIndex = 485
        Me.cmdConsentMedSocPersonDetail.Text = "..."
        Me.cmdConsentMedSocPersonDetail.UseVisualStyleBackColor = False
        '
        'cboConsentMedSocObtainedBy
        '
        Me.cboConsentMedSocObtainedBy.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboConsentMedSocObtainedBy.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboConsentMedSocObtainedBy.BackColor = System.Drawing.SystemColors.Window
        Me.cboConsentMedSocObtainedBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboConsentMedSocObtainedBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboConsentMedSocObtainedBy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboConsentMedSocObtainedBy.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboConsentMedSocObtainedBy.Location = New System.Drawing.Point(112, 96)
        Me.cboConsentMedSocObtainedBy.Name = "cboConsentMedSocObtainedBy"
        Me.cboConsentMedSocObtainedBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboConsentMedSocObtainedBy.Size = New System.Drawing.Size(257, 22)
        Me.cboConsentMedSocObtainedBy.TabIndex = 484
        '
        'cboConsentMedSocPaperwork
        '
        Me.cboConsentMedSocPaperwork.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboConsentMedSocPaperwork.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboConsentMedSocPaperwork.BackColor = System.Drawing.SystemColors.Window
        Me.cboConsentMedSocPaperwork.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboConsentMedSocPaperwork.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboConsentMedSocPaperwork.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboConsentMedSocPaperwork.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboConsentMedSocPaperwork.Location = New System.Drawing.Point(112, 72)
        Me.cboConsentMedSocPaperwork.Name = "cboConsentMedSocPaperwork"
        Me.cboConsentMedSocPaperwork.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboConsentMedSocPaperwork.Size = New System.Drawing.Size(81, 22)
        Me.cboConsentMedSocPaperwork.TabIndex = 483
        '
        'cmdConsentPaperworkPersonDetail
        '
        Me.cmdConsentPaperworkPersonDetail.BackColor = System.Drawing.SystemColors.Control
        Me.cmdConsentPaperworkPersonDetail.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdConsentPaperworkPersonDetail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdConsentPaperworkPersonDetail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdConsentPaperworkPersonDetail.Location = New System.Drawing.Point(376, 48)
        Me.cmdConsentPaperworkPersonDetail.Name = "cmdConsentPaperworkPersonDetail"
        Me.cmdConsentPaperworkPersonDetail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdConsentPaperworkPersonDetail.Size = New System.Drawing.Size(25, 21)
        Me.cmdConsentPaperworkPersonDetail.TabIndex = 482
        Me.cmdConsentPaperworkPersonDetail.Text = "..."
        Me.cmdConsentPaperworkPersonDetail.UseVisualStyleBackColor = False
        '
        'cboConsent
        '
        Me.cboConsent.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboConsent.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboConsent.BackColor = System.Drawing.SystemColors.Window
        Me.cboConsent.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboConsent.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboConsent.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboConsent.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboConsent.Location = New System.Drawing.Point(112, 24)
        Me.cboConsent.Name = "cboConsent"
        Me.cboConsent.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboConsent.Size = New System.Drawing.Size(81, 22)
        Me.cboConsent.TabIndex = 480
        '
        'cboConsentBy
        '
        Me.cboConsentBy.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboConsentBy.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboConsentBy.BackColor = System.Drawing.SystemColors.Window
        Me.cboConsentBy.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboConsentBy.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboConsentBy.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboConsentBy.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboConsentBy.Location = New System.Drawing.Point(112, 48)
        Me.cboConsentBy.Name = "cboConsentBy"
        Me.cboConsentBy.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboConsentBy.Size = New System.Drawing.Size(257, 22)
        Me.cboConsentBy.TabIndex = 481
        '
        'Label23
        '
        Me.Label23.AutoSize = True
        Me.Label23.BackColor = System.Drawing.SystemColors.Control
        Me.Label23.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label23.Location = New System.Drawing.Point(45, 100)
        Me.Label23.Name = "Label23"
        Me.Label23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label23.Size = New System.Drawing.Size(69, 14)
        Me.Label23.TabIndex = 477
        Me.Label23.Text = "Obtained By:"
        '
        'Label22
        '
        Me.Label22.AutoSize = True
        Me.Label22.BackColor = System.Drawing.SystemColors.Control
        Me.Label22.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label22.Location = New System.Drawing.Point(13, 76)
        Me.Label22.Name = "Label22"
        Me.Label22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label22.Size = New System.Drawing.Size(101, 14)
        Me.Label22.TabIndex = 476
        Me.Label22.Text = "Med/Soc Paperwk?"
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.BackColor = System.Drawing.SystemColors.Control
        Me.Label12.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label12.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label12.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label12.Location = New System.Drawing.Point(5, 28)
        Me.Label12.Name = "Label12"
        Me.Label12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label12.Size = New System.Drawing.Size(109, 14)
        Me.Label12.TabIndex = 459
        Me.Label12.Text = "Consent Paperwork?"
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.BackColor = System.Drawing.SystemColors.Control
        Me.Label13.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label13.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label13.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label13.Location = New System.Drawing.Point(45, 52)
        Me.Label13.Name = "Label13"
        Me.Label13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label13.Size = New System.Drawing.Size(69, 14)
        Me.Label13.TabIndex = 458
        Me.Label13.Text = "Obtained By:"
        '
        'Frame2
        '
        Me.Frame2.BackColor = System.Drawing.SystemColors.Control
        Me.Frame2.Controls.Add(Me.cboConsentLongSleeves)
        Me.Frame2.Controls.Add(Me.cboConsentFuneralPlan)
        Me.Frame2.Controls.Add(Me.cboConsentResearch)
        Me.Frame2.Controls.Add(Me.Label25)
        Me.Frame2.Controls.Add(Me.Label24)
        Me.Frame2.Controls.Add(Me.Label15)
        Me.Frame2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Frame2.Location = New System.Drawing.Point(8, 184)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(601, 105)
        Me.Frame2.TabIndex = 474
        Me.Frame2.TabStop = False
        Me.Frame2.Text = "Additional Info"
        '
        'cboConsentLongSleeves
        '
        Me.cboConsentLongSleeves.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboConsentLongSleeves.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboConsentLongSleeves.BackColor = System.Drawing.SystemColors.Window
        Me.cboConsentLongSleeves.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboConsentLongSleeves.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboConsentLongSleeves.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboConsentLongSleeves.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboConsentLongSleeves.Location = New System.Drawing.Point(112, 72)
        Me.cboConsentLongSleeves.Name = "cboConsentLongSleeves"
        Me.cboConsentLongSleeves.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboConsentLongSleeves.Size = New System.Drawing.Size(113, 22)
        Me.cboConsentLongSleeves.TabIndex = 488
        '
        'cboConsentFuneralPlan
        '
        Me.cboConsentFuneralPlan.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboConsentFuneralPlan.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboConsentFuneralPlan.BackColor = System.Drawing.SystemColors.Window
        Me.cboConsentFuneralPlan.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboConsentFuneralPlan.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboConsentFuneralPlan.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboConsentFuneralPlan.Location = New System.Drawing.Point(112, 48)
        Me.cboConsentFuneralPlan.Name = "cboConsentFuneralPlan"
        Me.cboConsentFuneralPlan.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboConsentFuneralPlan.Size = New System.Drawing.Size(233, 22)
        Me.cboConsentFuneralPlan.TabIndex = 487
        '
        'cboConsentResearch
        '
        Me.cboConsentResearch.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Append
        Me.cboConsentResearch.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboConsentResearch.BackColor = System.Drawing.SystemColors.Window
        Me.cboConsentResearch.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboConsentResearch.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboConsentResearch.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboConsentResearch.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboConsentResearch.Location = New System.Drawing.Point(112, 24)
        Me.cboConsentResearch.Name = "cboConsentResearch"
        Me.cboConsentResearch.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboConsentResearch.Size = New System.Drawing.Size(81, 22)
        Me.cboConsentResearch.TabIndex = 486
        '
        'Label25
        '
        Me.Label25.AutoSize = True
        Me.Label25.BackColor = System.Drawing.SystemColors.Control
        Me.Label25.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label25.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label25.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label25.Location = New System.Drawing.Point(35, 76)
        Me.Label25.Name = "Label25"
        Me.Label25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label25.Size = New System.Drawing.Size(79, 14)
        Me.Label25.TabIndex = 479
        Me.Label25.Text = "Long Sleeves?"
        '
        'Label24
        '
        Me.Label24.AutoSize = True
        Me.Label24.BackColor = System.Drawing.SystemColors.Control
        Me.Label24.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label24.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label24.Location = New System.Drawing.Point(39, 52)
        Me.Label24.Name = "Label24"
        Me.Label24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label24.Size = New System.Drawing.Size(75, 14)
        Me.Label24.TabIndex = 478
        Me.Label24.Text = "Funeral Plans:"
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.BackColor = System.Drawing.SystemColors.Control
        Me.Label15.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label15.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label15.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label15.Location = New System.Drawing.Point(12, 28)
        Me.Label15.Name = "Label15"
        Me.Label15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label15.Size = New System.Drawing.Size(102, 14)
        Me.Label15.TabIndex = 475
        Me.Label15.Text = "Cnst for Research?"
        '
        'Check25
        '
        Me.Check25.BackColor = System.Drawing.SystemColors.Control
        Me.Check25.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check25.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check25.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check25.Location = New System.Drawing.Point(-4992, 176)
        Me.Check25.Name = "Check25"
        Me.Check25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check25.Size = New System.Drawing.Size(121, 17)
        Me.Check25.TabIndex = 57
        Me.Check25.Text = "Final"
        Me.Check25.UseVisualStyleBackColor = False
        '
        'Check24
        '
        Me.Check24.BackColor = System.Drawing.SystemColors.Control
        Me.Check24.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check24.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check24.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check24.Location = New System.Drawing.Point(-4992, 152)
        Me.Check24.Name = "Check24"
        Me.Check24.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check24.Size = New System.Drawing.Size(121, 17)
        Me.Check24.TabIndex = 56
        Me.Check24.Text = "Approached"
        Me.Check24.UseVisualStyleBackColor = False
        '
        'Check23
        '
        Me.Check23.BackColor = System.Drawing.SystemColors.Control
        Me.Check23.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check23.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check23.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check23.Location = New System.Drawing.Point(-4992, 128)
        Me.Check23.Name = "Check23"
        Me.Check23.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check23.Size = New System.Drawing.Size(121, 17)
        Me.Check23.TabIndex = 55
        Me.Check23.Text = "Secondary Complete"
        Me.Check23.UseVisualStyleBackColor = False
        '
        'Check22
        '
        Me.Check22.BackColor = System.Drawing.SystemColors.Control
        Me.Check22.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check22.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check22.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check22.Location = New System.Drawing.Point(-4992, 104)
        Me.Check22.Name = "Check22"
        Me.Check22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check22.Size = New System.Drawing.Size(97, 17)
        Me.Check22.TabIndex = 54
        Me.Check22.Text = "System Events"
        Me.Check22.UseVisualStyleBackColor = False
        '
        'Check21
        '
        Me.Check21.BackColor = System.Drawing.SystemColors.Control
        Me.Check21.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check21.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check21.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Check21.Location = New System.Drawing.Point(-4992, 80)
        Me.Check21.Name = "Check21"
        Me.Check21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check21.Size = New System.Drawing.Size(129, 17)
        Me.Check21.TabIndex = 53
        Me.Check21.Text = "Case Open"
        Me.Check21.UseVisualStyleBackColor = False
        '
        'Picture4
        '
        Me.Picture4.BackColor = System.Drawing.SystemColors.Control
        Me.Picture4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Picture4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Picture4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Picture4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Picture4.Location = New System.Drawing.Point(-4992, 48)
        Me.Picture4.Name = "Picture4"
        Me.Picture4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture4.Size = New System.Drawing.Size(473, 273)
        Me.Picture4.TabIndex = 52
        Me.Picture4.TabStop = False
        '
        'Label20
        '
        Me.Label20.AutoSize = True
        Me.Label20.BackColor = System.Drawing.SystemColors.Control
        Me.Label20.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label20.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label20.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Label20.Location = New System.Drawing.Point(-4992, 56)
        Me.Label20.Name = "Label20"
        Me.Label20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label20.Size = New System.Drawing.Size(105, 17)
        Me.Label20.TabIndex = 58
        Me.Label20.Text = "Secondary Status"
        '
        'CmdCancel
        '
        Me.CmdCancel.BackColor = System.Drawing.SystemColors.Control
        Me.CmdCancel.CausesValidation = False
        Me.CmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.CmdCancel.Location = New System.Drawing.Point(1252, 220)
        Me.CmdCancel.Name = "CmdCancel"
        Me.CmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmdCancel.Size = New System.Drawing.Size(83, 21)
        Me.CmdCancel.TabIndex = 6
        Me.CmdCancel.Text = "Cancel"
        Me.CmdCancel.UseVisualStyleBackColor = False
        '
        'btnSaveAndClose
        '
        Me.btnSaveAndClose.BackColor = System.Drawing.SystemColors.Control
        Me.btnSaveAndClose.Cursor = System.Windows.Forms.Cursors.Default
        Me.btnSaveAndClose.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnSaveAndClose.ForeColor = System.Drawing.SystemColors.ControlText
        Me.btnSaveAndClose.Location = New System.Drawing.Point(1252, 55)
        Me.btnSaveAndClose.Name = "btnSaveAndClose"
        Me.btnSaveAndClose.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.btnSaveAndClose.Size = New System.Drawing.Size(83, 21)
        Me.btnSaveAndClose.TabIndex = 5
        Me.btnSaveAndClose.Text = "Save && Close"
        Me.btnSaveAndClose.UseVisualStyleBackColor = False
        '
        'ChkTemp
        '
        Me.ChkTemp.BackColor = System.Drawing.SystemColors.Control
        Me.ChkTemp.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkTemp.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkTemp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkTemp.Location = New System.Drawing.Point(1252, 79)
        Me.ChkTemp.Name = "ChkTemp"
        Me.ChkTemp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkTemp.Size = New System.Drawing.Size(77, 17)
        Me.ChkTemp.TabIndex = 4
        Me.ChkTemp.Text = "Incomplete"
        Me.ChkTemp.UseVisualStyleBackColor = False
        '
        'ChkExclusive
        '
        Me.ChkExclusive.BackColor = System.Drawing.SystemColors.Control
        Me.ChkExclusive.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkExclusive.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkExclusive.ForeColor = System.Drawing.SystemColors.ControlText
        Me.ChkExclusive.Location = New System.Drawing.Point(1252, 95)
        Me.ChkExclusive.Name = "ChkExclusive"
        Me.ChkExclusive.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkExclusive.Size = New System.Drawing.Size(77, 15)
        Me.ChkExclusive.TabIndex = 3
        Me.ChkExclusive.Text = "Exclusive"
        Me.ChkExclusive.UseVisualStyleBackColor = False
        '
        'Picture1
        '
        Me.Picture1.BackColor = System.Drawing.SystemColors.Control
        Me.Picture1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Picture1.Controls.Add(Me.txtHospitalName)
        Me.Picture1.Controls.Add(Me._Lable_8)
        Me.Picture1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Picture1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Picture1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Picture1.Location = New System.Drawing.Point(4, 7)
        Me.Picture1.Name = "Picture1"
        Me.Picture1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Picture1.Size = New System.Drawing.Size(1044, 40)
        Me.Picture1.TabIndex = 1
        Me.Picture1.TabStop = True
        '
        'txtHospitalName
        '
        Me.txtHospitalName.AcceptsReturn = True
        Me.txtHospitalName.BackColor = System.Drawing.SystemColors.Window
        Me.txtHospitalName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtHospitalName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtHospitalName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtHospitalName.Location = New System.Drawing.Point(56, 8)
        Me.txtHospitalName.MaxLength = 0
        Me.txtHospitalName.Name = "txtHospitalName"
        Me.txtHospitalName.ReadOnly = True
        Me.txtHospitalName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtHospitalName.Size = New System.Drawing.Size(700, 20)
        Me.txtHospitalName.TabIndex = 428
        '
        '_Lable_8
        '
        Me._Lable_8.AutoSize = True
        Me._Lable_8.BackColor = System.Drawing.SystemColors.Control
        Me._Lable_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lable_8.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lable_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Lable.SetIndex(Me._Lable_8, CType(8, Short))
        Me._Lable_8.Location = New System.Drawing.Point(6, 10)
        Me._Lable_8.Name = "_Lable_8"
        Me._Lable_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lable_8.Size = New System.Drawing.Size(51, 14)
        Me._Lable_8.TabIndex = 2
        Me._Lable_8.Text = "Location:"
        '
        'TimerTotalTime
        '
        Me.TimerTotalTime.Enabled = True
        Me.TimerTotalTime.Interval = 1000
        '
        'VP_Timer
        '
        Me.VP_Timer.Interval = 30000
        '
        'DataComboArray
        '
        '
        'DataRTFArray
        '
        '
        'DataTextArray
        '
        '
        'ctlSecondaryDisposition1
        '
        Me.ctlSecondaryDisposition1.AutoSize = True
        Me.ctlSecondaryDisposition1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.ctlSecondaryDisposition1.ButtonsVisible = False
        'Me.ctlSecondaryDisposition1.CallId = 0
        Me.ctlSecondaryDisposition1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.ctlSecondaryDisposition1.Location = New System.Drawing.Point(0, 0)
        Me.ctlSecondaryDisposition1.Name = "ctlSecondaryDisposition1"
        Me.ctlSecondaryDisposition1.ReportErrors = False
        Me.ctlSecondaryDisposition1.Size = New System.Drawing.Size(1347, 165)
        Me.ctlSecondaryDisposition1.TabIndex = 0
        Me.ctlSecondaryDisposition1.Visible = False
        '
        'SplitContainer1
        '
        Me.SplitContainer1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer1.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer1.Name = "SplitContainer1"
        Me.SplitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal
        '
        'SplitContainer1.Panel1
        '
        Me.SplitContainer1.Panel1.AutoScroll = True
        Me.SplitContainer1.Panel1.Controls.Add(Me.btnSave)
        Me.SplitContainer1.Panel1.Controls.Add(Me.Cmdactivate)
        Me.SplitContainer1.Panel1.Controls.Add(Me.Picture1)
        Me.SplitContainer1.Panel1.Controls.Add(Me.ChkExclusive)
        Me.SplitContainer1.Panel1.Controls.Add(Me.cmdVerify)
        Me.SplitContainer1.Panel1.Controls.Add(Me.ChkTemp)
        Me.SplitContainer1.Panel1.Controls.Add(Me.TabDonor)
        Me.SplitContainer1.Panel1.Controls.Add(Me.btnSaveAndClose)
        Me.SplitContainer1.Panel1.Controls.Add(Me.CmdCancel)
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.ctlSecondaryDisposition1)
        Me.SplitContainer1.Panel2.Padding = New System.Windows.Forms.Padding(0, 0, 0, 5)
        Me.SplitContainer1.Size = New System.Drawing.Size(1347, 633)
        Me.SplitContainer1.SplitterDistance = 459
        Me.SplitContainer1.TabIndex = 635
        '
        'btnSave
        '
        Me.btnSave.Location = New System.Drawing.Point(1252, 10)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(83, 23)
        Me.btnSave.TabIndex = 633
        Me.btnSave.Text = "Save"
        Me.btnSave.UseVisualStyleBackColor = False
        '
        'FrmReferralView
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(1347, 633)
        Me.ControlBox = False
        Me.Controls.Add(Me.SplitContainer1)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.KeyPreview = True
        Me.Location = New System.Drawing.Point(3, 22)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmReferralView"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Call #"
        Me.TabDonor.ResumeLayout(False)
        Me._TabDonor_TabPage0.ResumeLayout(False)
        Me.SubForm1.ResumeLayout(False)
        Me.Picture2.ResumeLayout(False)
        Me.tbReferralData.ResumeLayout(False)
        Me._tbReferralData_TabPage0.ResumeLayout(False)
        Me._fmDataFrame_8.ResumeLayout(False)
        Me._fmDataFrame_8.PerformLayout
        Me._fmDataFrame_4.ResumeLayout(False)
        Me._fmDataFrame_4.PerformLayout
        Me._fmDataFrame_5.ResumeLayout(False)
        Me._fmDataFrame_5.PerformLayout
        Me._fmDataFrame_7.ResumeLayout(False)
        Me._fmDataFrame_7.PerformLayout
        Me._fmDataFrame_11.ResumeLayout(False)
        Me._fmDataFrame_11.PerformLayout
        Me._fmDataFrame_16.ResumeLayout(False)
        Me._fmDataFrame_16.PerformLayout
        Me._fmDataFrame_30.ResumeLayout(False)
        Me._fmDataFrame_30.PerformLayout
        Me._fmDataFrame_15.ResumeLayout(False)
        Me._fmDataFrame_15.PerformLayout
        Me._fmDataFrame_13.ResumeLayout(False)
        Me._fmDataFrame_6.ResumeLayout(False)
        Me._fmDataFrame_6.PerformLayout
        Me._fmDataFrame_23.ResumeLayout(False)
        Me._fmDataFrame_23.PerformLayout
        Me.fmCreateMedication.ResumeLayout(False)
        Me.fmCreateMedication.PerformLayout
        Me._DataFrameArray_0.ResumeLayout(False)
        Me._DataFrameArray_0.PerformLayout
        Me._fmDataFrame_1.ResumeLayout(False)
        Me._fmDataFrame_1.PerformLayout
        Me._fmDataFrame_0.ResumeLayout(False)
        Me._fmDataFrame_0.PerformLayout
        Me._fmDataFrame_9.ResumeLayout(False)
        Me._fmDataFrame_9.PerformLayout
        Me._fmDataFrame_10.ResumeLayout(False)
        Me._fmDataFrame_10.PerformLayout
        Me.fmOrgSpecialNotes.ResumeLayout(False)
        Me.fmOrgSpecialNotes.PerformLayout
        Me._fmEyeCareInstructions_1.ResumeLayout(False)
        Me._fmEyeCareInstructions_1.PerformLayout
        Me._tbReferralData_TabPage1.ResumeLayout(False)
        Me._fmDataFrame_20.ResumeLayout(False)
        Me._fmDataFrame_20.PerformLayout
        Me._fmDataFrame_24.ResumeLayout(False)
        Me._fmDataFrame_24.PerformLayout
        Me._fmDataFrame_12.ResumeLayout(False)
        Me._fmDataFrame_12.PerformLayout
        Me._fmDataFrame_26.ResumeLayout(False)
        Me._fmDataFrame_26.PerformLayout
        Me._fmDataFrame_17.ResumeLayout(False)
        Me._fmDataFrame_17.PerformLayout
        Me._fmDataFrame_3.ResumeLayout(False)
        Me._fmDataFrame_3.PerformLayout
        Me._fmDataFrame_27.ResumeLayout(False)
        Me._fmDataFrame_27.PerformLayout
        Me._fmDataFrame_29.ResumeLayout(False)
        Me._fmDataFrame_29.PerformLayout
        Me._tbReferralData_TabPage2.ResumeLayout(False)
        Me._fmDataFrame_28.ResumeLayout(False)
        Me._fmDataFrame_28.PerformLayout
        Me._fmDataFrame_21.ResumeLayout(False)
        Me._fmDataFrame_21.PerformLayout
        Me._fmDataFrame_18.ResumeLayout(False)
        Me._fmDataFrame_18.PerformLayout
        Me._fmDataFrame_2.ResumeLayout(False)
        Me._fmDataFrame_2.PerformLayout
        Me._fmDataFrame_22.ResumeLayout(False)
        Me._fmDataFrame_22.PerformLayout
        Me._tbReferralData_TabPage3.ResumeLayout(False)
        Me._fmDataFrame_14.ResumeLayout(False)
        Me._fmDataFrame_14.PerformLayout
        Me._fmDataFrame_19.ResumeLayout(False)
        Me._fmDataFrame_19.PerformLayout
        Me._TabDonor_TabPage1.ResumeLayout(False)
        Me._TabDonor_TabPage1.PerformLayout
        Me._Frame_1.ResumeLayout(False)
        Me._Frame_1.PerformLayout
        Me._TabDonor_TabPage2.ResumeLayout(False)
        Me.fmSecondaryStatus.ResumeLayout(False)
        Me.fmSecondaryStatus.PerformLayout
        Me._Frame_0.ResumeLayout(False)
        Me._Frame_0.PerformLayout
        Me._TabDonor_TabPage3.ResumeLayout(False)
        Me.SSTab1.ResumeLayout(False)
        Me._SSTab1_TabPage0.ResumeLayout(False)
        Me.fmeApproach.ResumeLayout(False)
        Me.fmeApproach.PerformLayout
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout
        Me._SSTab1_TabPage1.ResumeLayout(False)
        Me.fmeConsent.ResumeLayout(False)
        Me.fmeConsent.PerformLayout
        Me.Frame2.ResumeLayout(False)
        Me.Frame2.PerformLayout
        CType(Me.Picture4, System.ComponentModel.ISupportInitialize).EndInit
        Me.Picture1.ResumeLayout(False)
        Me.Picture1.PerformLayout
        CType(Me.DataCheckboxArray, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.DataComboArray, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.DataFrameArray, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.DataLabelArray, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.DataRTFArray, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.DataTextArray, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Frame, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.Lable, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.LblReferral, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.fmDataFrame, System.ComponentModel.ISupportInitialize).EndInit
        CType(Me.fmEyeCareInstructions, System.ComponentModel.ISupportInitialize).EndInit
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        Me.SplitContainer1.Panel2.PerformLayout
        CType(Me.SplitContainer1, System.ComponentModel.ISupportInitialize).EndInit
        Me.SplitContainer1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents ctlSecondaryDisposition1 As CtlSecondaryDisposition
    Friend WithEvents SplitContainer1 As System.Windows.Forms.SplitContainer
    Public WithEvents lblScheduleAlert As Label
    Friend WithEvents rtbScheduleAlert As Statline.Stattrac.Windows.Forms.RichTextBox
    Friend WithEvents btnSave As Button
#End Region
End Class