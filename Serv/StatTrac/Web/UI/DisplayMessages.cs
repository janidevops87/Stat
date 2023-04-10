using System;
using System.Web;
using System.Collections;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for DisplayMessages.
	/// </summary>
	public class DisplayMessages : CollectionBase
	{
		public DisplayMessages()
		{
		}

		private void AddInternal( MessageType type, string message )
		{
			this.AddInternal( new DisplayMessage( type, message ) );
		}

		private void AddInternal( DisplayMessage messageInstance)
		{
			this.InnerList.Add( messageInstance );
		}

		public static void Add( MessageType type, string message )
		{
			DisplayMessages.Add( new DisplayMessage( type, message ) );
		}

		public static void Add( DisplayMessage messageInstance )
		{
			DisplayMessages.Messages.AddInternal( messageInstance );
		}

		private static readonly string MessageCollectionKey = "MessageCollectionKey";
		
		public static new void Clear()
		{
			
			((CollectionBase)DisplayMessages.Messages).Clear();
		}

		public static new int Count
		{
			get
			{
				return ((CollectionBase)DisplayMessages.Messages).Count;
			}
		}

		public static DisplayMessages Messages
		{
			get
			{
				HttpContext context = HttpContext.Current;

				DisplayMessages messageCollection = 
					context.Items[ MessageCollectionKey ] as DisplayMessages;

				if( messageCollection == null )
				{
					messageCollection = new DisplayMessages();
					context.Items[ MessageCollectionKey ] = messageCollection;
				}
				return messageCollection;
			}

		}
	}

	/// <summary>
	/// 
	/// </summary>
	public class DisplayMessage
	{
		private MessageType type = null;
		private string text = String.Empty;

		public DisplayMessage()
		{
		}

		public DisplayMessage( 
			MessageType type, 
			string text )
		{
			this.type = type;
			this.text = text;
		}

		public MessageType Type
		{
			get { return this.type; }
			set { this.type = value; }
		}

		public string Text
		{
			get { return this.text; }
			set { this.text = value; }
		}
	}

	/// <summary>
	/// Defines all the possible message types that will be rendered
	/// to the client.
	/// </summary>
	public class MessageType
	{

//		public static readonly MessageType ErrorMessage = 
//			new MessageType( "IconWarningError.gif" );

		public static readonly MessageType ErrorMessage = 
			new MessageType( "IconWarning.gif" );

		public static readonly MessageType WarningMessage = 
			new MessageType( "IconWarning.gif" );

		public static readonly MessageType InformationalMessage = 
			new MessageType( "IconWarningInfo.gif" );
        
		internal readonly string ImageFileName;

		private MessageType( string imageFileName )
		{
			this.ImageFileName = imageFileName;
		}

	}
}