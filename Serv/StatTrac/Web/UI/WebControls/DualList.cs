using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Resources;
using System.ComponentModel;

namespace Statline.StatTrac.Web.UI.WebControls
{

	/// <summary>
	/// Provides the UI for the common requirement of two listboxes with items that move between them.
	/// </summary>
	/// <remarks>
	/// <p>
	/// For browsers that support scripting, the movement will be completely clientside. There is also 100% serverside support, for any browsers with script disabled or nonexistant.
	/// </p>
	/// <p>When DataBinding is used, the control will automaticly remove items from the left side if they exist on the right side. This ensures that double items can't be chosen.</p>
	/// </remarks>
	/// <example>
	/// The following is a simple example that uses this control.
	/// <code><![CDATA[
	/// <%@ Register TagPrefix="mbdlb" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
	/// <script runat="server" language="c#" >
	/// 	protected void DualList1_ItemsMoved( Object sender, EventArgs e ) {
	/// 		DualResult.Text = "The Chosen Items Are:";
	/// 		foreach( ListItem item in DualList1.RightBox.Items ) {
	/// 			DualResult.Text += "<br>" + item.Value + "/" + item.Text;
	///			}
	///		}
	/// </script>
	/// <form runat="server">
	/// <mbdlb:DualList runat="server" Id="DualList1" OnItemsMoved="DualList1_ItemsMoved" >
	/// 	<LeftBox>
	/// 		<asp:ListItem Value="1" Text="One" />
	/// 		<asp:ListItem Value="2" Text="Two" />
	/// 		<asp:ListItem Value="3" Text="Three" />
	/// 	</LeftBox>
	/// 	<RightBox>
	/// 		<asp:ListItem Value="4" Text="Four" />
	/// 		<asp:ListItem Value="5" Text="Five" />
	/// 		<asp:ListItem Value="6" Text="Six" />
	/// 	</RightBox>
	/// </mbdlb:DualList>
	/// <br><br><asp:Label runat="server" id="DualResult" />
	/// <hr><asp:Button runat="server" text="Go"/>
	/// </form>
	/// ]]></code>
	/// </example>
	[
	DefaultProperty("ItemsName"),
	DefaultEvent("ItemsMoved"),
	PersistChildren(false),
	ParseChildren(true),
	]
	public class DualList : System.Web.UI.WebControls.WebControl, INamingContainer {

		#region Composite Control Pattern
		/// <summary>
		/// Overrides <see cref="Control.Controls"/> to implement the Composite Control Pattern
		/// </summary>
		public override ControlCollection Controls
		{
			get 
			{
				this.EnsureChildControls();
				return base.Controls;
			}
		}

		/// <summary>
		/// Overrides <see cref="Control.CreateChildControls"/> to implement the Composite Control Pattern
		/// </summary>
		protected override void CreateChildControls()
		{
			this.Controls.Clear();
			this.InitializeComponent();			
		}

		#endregion

		#region Events
		/// <summary>
		/// The event that fires when items have been moved.
		/// </summary>
		public event EventHandler ItemsMoved;
		
		/// <summary>
		/// Raises the <see cref="ItemsMoved"/> event.
		/// </summary>
		protected virtual void OnItemsMoved(EventArgs e)
		{
			if ( this.ItemsMoved != null )
			{
				this.ItemsMoved(this,e);
			}
		}
		#endregion

		#region Properties
		/// <summary>
		/// Overrides <see cref="WebControl.TagKey"/>
		/// </summary>
		protected override HtmlTextWriterTag TagKey
		{
			get
			{
				return HtmlTextWriterTag.Table;
			}
		}


		#region LeftBox
		/// <summary>
		/// Gets or sets the DataSource of the list on the left side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataSource of the list on the left side of the control."),
		Category("Data"),
		Bindable(true),
		DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden),
		]
		public virtual Object LeftDataSource
		{
			get
			{
				this.EnsureChildControls();
				return this.leftBox.DataSource;
			}
			set 
			{
				this.EnsureChildControls();
				this.leftBox.DataSource = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataMember of the list on the left side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataMember of the list on the left side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String LeftDataMember
		{
			get 
			{
				this.EnsureChildControls();
				return this.leftBox.DataMember;
			}
			set 
			{
				this.EnsureChildControls();
				this.leftBox.DataMember = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataTextField of the list on the left side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataTextField of the list on the left side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String LeftDataTextField 
		{
			get 
			{
				this.EnsureChildControls();
				return this.leftBox.DataTextField;
			}
			set 
			{
				this.EnsureChildControls();
				this.leftBox.DataTextField = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataValueField of the list on the left side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataValueField of the list on the left side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String LeftDataValueField 
		{
			get 
			{
				this.EnsureChildControls();
				return this.leftBox.DataValueField;
			}
			set 
			{
				this.EnsureChildControls();
				this.leftBox.DataValueField = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataTextFormatString of the list on the left side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataTextFormatString of the list on the left side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String LeftDataTextFormatString
		{
			get 
			{
				this.EnsureChildControls();
				return this.leftBox.DataTextFormatString;
			}
			set 
			{
				this.EnsureChildControls();
				this.leftBox.DataTextFormatString = value;
			}
		}

		/// <summary>
		/// Gets the items in the list the left side of the control.
		/// </summary>
		[
		Description("Gets the items in the list the left side of the control."),
		DefaultValue(null),
		MergableProperty(false),
		PersistenceMode(PersistenceMode.InnerProperty),
		DesignerSerializationVisibility(DesignerSerializationVisibility.Content), 
		NotifyParentProperty(true),
		]
		public virtual ListItemCollection LeftItems {
			get {
				this.EnsureChildControls();
				return this.leftBox.Items;
			}
		}

		/// <summary>
		/// Gets the <see cref="WebControl.ControlStyle"/> of the list on left side of the control.
		/// </summary>
		[
		Description("Gets the ControlStyle of the list on left side of the control."),
		Category("Appearance"),
		]
		public virtual Style LeftListStyle {
			get {
				this.EnsureChildControls();
				return this.leftBox.ControlStyle;
			}
		}

		#endregion

		#region RightBox
		/// <summary>
		/// Gets or sets the DataSource of the list on the right side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataSource of the list on the right side of the control."),
		Category("Data"),
		Bindable(true),
		DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden),
		]
		public virtual Object RightDataSource {
			get {
				this.EnsureChildControls();
				return this.rightBox.DataSource;
			}
			set {
				this.EnsureChildControls();
				this.rightBox.DataSource = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataMember of the list on the right side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataMember of the list on the right side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String RightDataMember {
			get {
				this.EnsureChildControls();
				return this.rightBox.DataMember;
			}
			set {
				this.EnsureChildControls();
				this.rightBox.DataMember = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataTextField of the list on the right side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataTextField of the list on the right side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String RightDataTextField {
			get {
				this.EnsureChildControls();
				return this.rightBox.DataTextField;
			}
			set {
				this.EnsureChildControls();
				this.rightBox.DataTextField = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataValueField of the list on the right side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataValueField of the list on the right side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String RightDataValueField {
			get {
				this.EnsureChildControls();
				return this.rightBox.DataValueField;
			}
			set {
				this.EnsureChildControls();
				this.rightBox.DataValueField = value;
			}
		}

		/// <summary>
		/// Gets or sets the DataTextFormatString of the list on the right side of the control.
		/// </summary>
		[
		Description("Gets or sets the DataTextFormatString of the list on the right side of the control."),
		Category("Data"),
		DefaultValue(""),
		]
		public virtual String RightDataTextFormatString {
			get {
				this.EnsureChildControls();
				return this.rightBox.DataTextFormatString;
			}
			set {
				this.EnsureChildControls();
				this.rightBox.DataTextFormatString = value;
			}
		}

		/// <summary>
		/// Gets the items in the list the right side of the control.
		/// </summary>
		[
		Description("Gets the items in the list the right side of the control."),
		DefaultValue(null),
		MergableProperty(false),
		PersistenceMode(PersistenceMode.InnerProperty),
		DesignerSerializationVisibility(DesignerSerializationVisibility.Content), 
		NotifyParentProperty(true),
		]
		public virtual ListItemCollection RightItems {
			get {
				this.EnsureChildControls();
				return this.rightBox.Items;
			}
		}

		/// <summary>
		/// Gets the <see cref="WebControl.ControlStyle"/> of the list on right side of the control.
		/// </summary>
		[
		Description("Gets the ControlStyle of the list on right side of the control."),
		Category("Appearance"),
		]
		public virtual Style RightListStyle {
			get {
				this.EnsureChildControls();
				return this.rightBox.ControlStyle;
			}
		}

		#endregion

		/// <summary>
		/// Gets or sets the number of rows visible in the lists of the control.
		/// </summary>
		[
		Description("Gets or sets the number of rows visible in the lists of the control."),
		Category("Appearance"),
		DefaultValue(8),
		]
		public virtual Int32 ListRows {
			get {
				this.EnsureChildControls();
				return this.leftBox.Rows;
			}
			set {
				this.EnsureChildControls();
				this.leftBox.Rows = value;
				this.rightBox.Rows = value;
			}
		}

		/// <summary>
		/// Gets or sets the text displayed above the lists, the plural name of the items being chosen.
		/// </summary>
		[
		Description("Gets or sets the text displayed above the lists, the plural name of the items being chosen."),
		Category("Appearance"),
		DefaultValue("Items"),
		]
		public virtual String ItemsName {
			get {
				Object savedState = this.ViewState["ItemLabel"];
				if ( savedState != null ) {
					return (String)savedState;
				}
				return "Items";
			}
			set {
				this.ViewState["ItemLabel"] = value;
				this.EnsureChildControls();
				this.leftBoxLabel.Text = "Available " + value;
				this.rightBoxLabel.Text = "Chosen " + value;
			}
		}

		/// <summary>
		/// Gets or sets the visibility of the buttons for moving all items between the lists.
		/// </summary>
		[
		Description("Gets or sets the visibility of the buttons for moving all items between the lists."),
		Category("Behavior"),
		DefaultValue(false),
		]
		public virtual Boolean EnableMoveAll {
			get {
				Object savedState = this.ViewState["EnableMoveAll"];
				if ( savedState != null ) {
					return (Boolean)savedState;
				}
				return false;
			}
			set {
				this.ViewState["EnableMoveAll"] = value;
			}
		}

		/// <summary>
		/// Gets or sets the visibility of the buttons for moving items up and down within the list on the right side of the control.
		/// </summary>
		[
		Description("Gets or sets the visibility of the buttons for moving items up and down within the RightBox."),
		Category("Behavior"),
		DefaultValue(false),
		]
		public virtual Boolean EnableMoveUpDown {
			get {
				Object savedState = this.ViewState["EnableMoveUpDown"];
				if ( savedState != null ) {
					return (Boolean)savedState;
				}
				return false;
			}
			set {
				this.ViewState["EnableMoveUpDown"] = value;
			}
		}

		/// <summary>
		/// Overrides <see cref="WebControl.Enabled"/>
		/// </summary>
		public override bool Enabled {
			get {
				return base.Enabled;
			}
			set {
				base.Enabled = value;
				this.EnsureChildControls();
				this.leftBox.Enabled = value;
				this.rightBox.Enabled = value;
				this.moveRight.Enabled = value;
				this.moveAllRight.Enabled = value;
				this.moveLeft.Enabled = value;
				this.moveAllLeft.Enabled = value;
				this.moveUp.Enabled = value;
				this.moveDown.Enabled = value;
			}
		}

		/// <summary>
		/// Gets the <see cref="WebControl.ControlStyle"/> of the buttons contained in the control.
		/// </summary>
		[
		Description("Gets the WebControl.ControlStyle of the buttons contained in the control."),
		Category("Appearance"),
		]
		public virtual Style ButtonStyle {
			get {
				this.EnsureChildControls();
				return this.moveRight.ControlStyle;
			}
		}
		#endregion
		
		/// <summary>
		/// Initializes the contained controls.
		/// </summary>
		private void InitializeComponent() {
			// Instantiate
			this.leftBox = new DynamicListBox();
			this.rightBox = new DynamicListBox();
			this.moveRight = new Button();
			this.moveLeft = new Button();
			this.moveAllRight = new Button();
			this.moveAllLeft = new Button();
			this.moveUp = new Button();
			this.moveDown = new Button();
			this.leftBoxLabel = new Label();
			this.rightBoxLabel = new Label();
			this.allLeftContainer = new PlaceHolder();
			this.allRightContainer = new PlaceHolder();

			// Customize
			this.leftBox.ID = "LeftBox";
			this.leftBox.SelectionMode = ListSelectionMode.Multiple;
			this.leftBox.Rows = 8;
			this.leftBox.ItemsChanged += new EventHandler(leftBox_ItemsChanged);

			this.rightBox.ID = "RightBox";
			this.rightBox.SelectionMode = ListSelectionMode.Multiple;
			this.rightBox.Rows = 8;
			this.rightBox.ItemsChanged += new EventHandler(rightBox_ItemsChanged);

			this.moveRight.ID = "MoveRight";
			this.moveRight.Text = "Add ->";
			this.moveRight.CssClass = "button";
			this.moveRight.CausesValidation = false;
			this.moveRight.Click += new EventHandler(moveRight_Click);

			this.moveAllRight.ID = "MoveAllRight";
			this.moveAllRight.Text = "Add All ->>";
			this.moveAllRight.CssClass = "button";
			this.moveAllRight.CausesValidation = false;
			this.moveAllRight.Click += new EventHandler(moveAllRight_Click);

			this.moveLeft.ID = "MoveLeft";
			this.moveLeft.Text = "<- Remove";
			this.moveLeft.CssClass = "button";
			this.moveLeft.CausesValidation = false;
			this.moveLeft.Click += new EventHandler(moveLeft_Click);

			this.moveAllLeft.ID = "MoveAllLeft";
			this.moveAllLeft.Text = "<<- Remove All";
			this.moveAllLeft.CssClass = "button";
			this.moveAllLeft.CausesValidation = false;
			this.moveAllLeft.Click += new EventHandler(moveAllLeft_Click);

			this.moveUp.ID = "MoveUp";
			this.moveUp.Text = "Move Up";
			this.moveUp.CssClass = "button";
			this.moveUp.CausesValidation = false;
			this.moveUp.Width = Unit.Parse("100%",System.Globalization.CultureInfo.InvariantCulture);
			this.moveUp.Click += new EventHandler(moveUp_Click);

			this.moveDown.ID = "MoveDown";
			this.moveDown.Text = "Move Down";
			this.moveDown.CssClass = "button";
			this.moveDown.CausesValidation = false;
			this.moveDown.Click += new EventHandler(moveDown_Click);

			this.leftBoxLabel.Text = "Available " + this.ItemsName;
			this.rightBoxLabel.Text = "Chosen " + this.ItemsName;

			// Layout
			TableRow topRow = new TableRow();
			this.Controls.Add(topRow);
			topRow.Cells.AddRange(new TableCell[] { new TableCell(), new TableCell(), new TableCell() } );
			topRow.Cells[0].Controls.Add(this.leftBoxLabel);
			topRow.Cells[0].CssClass = "DualListTextLabel";
			topRow.Cells[1].Controls.Add(new LiteralControl("&nbsp;"));
			topRow.Cells[2].ColumnSpan = 2;
			topRow.Cells[2].CssClass = "DualListTextLabel";
			topRow.Cells[2].Controls.Add(this.rightBoxLabel);

			TableRow mainRow = new TableRow();
			this.Controls.Add( mainRow );
			mainRow.Cells.AddRange( new TableCell[] { new TableCell(), new TableCell(), new TableCell(), new TableCell() } );
			
			TableCell currentCell;

			currentCell = mainRow.Cells[0];
			currentCell.Controls.Add(leftBox);
			currentCell.HorizontalAlign = HorizontalAlign.Center;
			
			currentCell = mainRow.Cells[1];
			currentCell.Controls.Add(moveRight);
			this.allRightContainer.Controls.Add(new LiteralControl("<br>"));
			this.allRightContainer.Controls.Add(moveAllRight);
			currentCell.Controls.Add(this.allRightContainer);
			currentCell.Controls.Add(new LiteralControl("<br>"));
			currentCell.Controls.Add(new LiteralControl("<br>"));
			currentCell.Controls.Add(moveLeft);
			this.allLeftContainer.Controls.Add(new LiteralControl("<br>"));
			this.allLeftContainer.Controls.Add(this.moveAllLeft);
			currentCell.Controls.Add(this.allLeftContainer);
			currentCell.HorizontalAlign = HorizontalAlign.Center;
			currentCell.VerticalAlign = VerticalAlign.Middle;
			
			currentCell = mainRow.Cells[2];
			currentCell.Controls.Add(rightBox);
			currentCell.HorizontalAlign = HorizontalAlign.Center;

			currentCell = mainRow.Cells[3];
			currentCell.Controls.Add(this.moveUp);
			currentCell.Controls.Add(new LiteralControl("<br>"));
			currentCell.Controls.Add(this.moveDown);
			currentCell.HorizontalAlign = HorizontalAlign.Left;
			currentCell.VerticalAlign = VerticalAlign.Middle;

			
			//this.Controls.Add(containerTable);
		}

		/// <summary>
		/// Overrides <see cref="Control.DataBind"/>.
		/// </summary>
		public override void DataBind() {
			base.DataBind ();
			this.FixAvailableItems();
		}

		/// <summary>
		/// FixAvailableItems is called after <see cref="DataBind"/> to make sure that none of the items on the right, "chosen", list exist in the left, "available" list.
		/// </summary>
		protected virtual void FixAvailableItems() {
			foreach( ListItem item in this.rightBox.Items ) {
				ListItem leftItem = this.leftBox.Items.FindByValue(item.Value);
				if ( leftItem != null && leftItem.Text == item.Text ) {
					this.leftBox.Items.Remove(leftItem);
				}
			}
		}

		
		/// <summary>
		/// Overrides <see cref="Control.OnPreRender"/>.
		/// </summary>
		protected override void OnPreRender(EventArgs e) {
			base.OnPreRender (e);
			this.RegisterScript();
		}

		
		/// <summary>
		/// Overrides <see cref="Control.Render"/>.
		/// </summary>
		protected override void Render(HtmlTextWriter writer) {
			this.EnsureChildControls();
			this.allRightContainer.Visible = this.EnableMoveAll;
			this.allLeftContainer.Visible = this.EnableMoveAll;
			this.moveUp.Parent.Visible = this.EnableMoveUpDown;

			this.moveAllRight.ControlStyle.CopyFrom(this.moveRight.ControlStyle);
			this.moveLeft.ControlStyle.CopyFrom(this.moveRight.ControlStyle);
			this.moveAllLeft.ControlStyle.CopyFrom(this.moveRight.ControlStyle);
			this.moveUp.ControlStyle.CopyFrom(this.moveRight.ControlStyle);
			this.moveDown.ControlStyle.CopyFrom(this.moveRight.ControlStyle);

			base.Render (writer);
		}


		/// <summary>
		/// Overrides <see cref="WebControl.CreateControlStyle"/>.
		/// </summary>
		protected override Style CreateControlStyle() {
			return new TableStyle(this.ViewState);
		}

		#region ClientScript
		/// <summary>
		/// Registers the script for this control.
		/// </summary>
		protected virtual void RegisterScript() {
			if ( this.Page != null ) {
				this.RegisterScriptLibrary();
				this.RegisterScriptArray();
				this.RegisterScriptStartup();
			}
		}

		/// <summary>
		/// Registers the script library for this control.
		/// </summary>
		protected virtual void RegisterScriptLibrary() {
			this.Page.RegisterClientScriptBlock("MetaBuilders_DualList",this.LibraryScript);
		}
		/// <summary>
		/// Gets the script library for this control.
		/// </summary>
		protected virtual String LibraryScript {
			get {
				ResourceManager manager = new ResourceManager( typeof(DualList) );
				return manager.GetResourceSet(System.Globalization.CultureInfo.CurrentCulture, true, true).GetString("Library");
			}
		}

		/// <summary>
		/// Registers the script array for this control.
		/// </summary>
		protected virtual void RegisterScriptArray() {
			this.Page.RegisterArrayDeclaration("MetaBuilders_DualLists","'" + this.UniqueID  + "'");
		}

		/// <summary>
		/// Registers the script which initializes this control.
		/// </summary>
		protected virtual void RegisterScriptStartup() {
			this.Page.RegisterStartupScript("MetaBuilders_DualList",@"
<script language='javascript'>
<!--
	MetaBuilders_DualList_Init();
//-->
</script>");
		}

		#endregion

		#region Child Control Event Handlers
		// These handlers will only fire if the client browser doesn't support clientscript

		private void moveRight_Click(object sender, EventArgs e) {
			this.MoveSelectedItems(this.leftBox,this.rightBox);
			this.EnsureChangeEvent();
		}

		private void moveAllRight_Click(object sender, EventArgs e) {
			this.MoveAllItems(this.leftBox,this.rightBox);
			this.EnsureChangeEvent();
		}

		private void moveLeft_Click(object sender, EventArgs e) {
			this.MoveSelectedItems(this.rightBox,this.leftBox);
			this.EnsureChangeEvent();
		}

		private void moveAllLeft_Click(object sender, EventArgs e) {
			this.MoveAllItems(this.rightBox,this.leftBox);
			this.EnsureChangeEvent();
		}

		private void moveUp_Click(object sender, EventArgs e) {
			Int32 originalIndex = this.rightBox.SelectedIndex;
			if ( originalIndex > 0 ) {
				ListItem movedItem = this.rightBox.SelectedItem;
				this.rightBox.Items.Remove(movedItem);
				this.rightBox.Items.Insert(originalIndex - 1, movedItem);
				this.EnsureChangeEvent();
			}
		}

		private void moveDown_Click(object sender, EventArgs e) {
			Int32 originalIndex = this.rightBox.SelectedIndex;
			if ( originalIndex < this.rightBox.Items.Count - 1 ) {
				ListItem movedItem = this.rightBox.SelectedItem;
				this.rightBox.Items.Remove(movedItem);
				this.rightBox.Items.Insert(originalIndex + 1, movedItem);
				this.EnsureChangeEvent();
			}
		}

		
		private void MoveSelectedItems(ListBox source, ListBox target) {
			while( source.SelectedIndex != -1 ) {
				target.Items.Add(source.SelectedItem);
				source.Items.Remove(source.SelectedItem);
			}
		}
		private void MoveAllItems(ListBox source, ListBox target) {
			while( source.Items.Count != 0 ) {
				target.Items.Add(source.Items[0]);
				source.Items.RemoveAt(0);
			}
		}

		private void leftBox_ItemsChanged(object sender, EventArgs e) {
			this.EnsureChangeEvent();
		}

		private void rightBox_ItemsChanged(object sender, EventArgs e) {
			this.EnsureChangeEvent();
		}
		private void EnsureChangeEvent() {
			if ( !this.hasNotifiedOfChange ) {
				hasNotifiedOfChange = true;
				this.OnItemsMoved(EventArgs.Empty);
			}
		}
		private Boolean hasNotifiedOfChange = false;
		#endregion

		#region Child Control References
		private DynamicListBox leftBox;
		private DynamicListBox rightBox;

		private Button moveRight;
		private Button moveLeft;
		private Button moveAllRight;
		private Button moveAllLeft;

		private Button moveUp;
		private Button moveDown;

		private Label leftBoxLabel;
		private Label rightBoxLabel;

		private PlaceHolder allRightContainer;
		private PlaceHolder allLeftContainer;
		#endregion
	}
}
