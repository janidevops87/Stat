using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Text.RegularExpressions;

namespace Statline.Collections
{

	public class UniqueStringCollection : CollectionBase  
	{

		public UniqueStringCollection()
		{
		}

		public UniqueStringCollection( 
			string value, 
			char[] separators
			)
		{
			string[] values = value.Split( separators );
			this.AddRange( values );
		}

		public UniqueStringCollection( string[] value )
		{
			this.AddRange( value );
		}

		public UniqueStringCollection( UniqueStringCollection value )
		{
			this.InnerList.AddRange( value.InnerList );
		}

		public void CopyTo( string[] value, int index )
		{
			this.List.CopyTo( value, index );
		}

		public void AddRange( string[] value )
		{
			this.InnerList.AddRange( value );
		}

		public string this[ int index ]  
		{
			get  
			{
				return( (string) List[index] );
			}
			set  
			{
				List[index] = value;
			}
		}

		public int Add( string value )  
		{
			int index = this.IndexOf( value );
			if( index >= 0 )
			{
				return index;
			}
			else
			{
				return( List.Add( value ) );
			}
		}

		public int IndexOf( string value )  
		{
			return( List.IndexOf( value ) );
		}

		public void Insert( int index, string value )  
		{
			if( this.IndexOf( value ) < 0 )
			{
				List.Insert( index, value );
			}
		}

		public void Remove( string value )  
		{
			List.Remove( value );
		}

		public bool Contains( string value )  
		{
			// If value is not of type string, this will return false.
			return( List.Contains( value ) );
		}

		protected override void OnInsert( int index, Object value )  
		{
			if ( value.GetType() != Type.GetType("System.String") )
				throw new ArgumentException( "value must be of type string.", "value" );
		}

		protected override void OnRemove( int index, Object value )  
		{
			if ( value.GetType() != Type.GetType("System.String") )
				throw new ArgumentException( "value must be of type string.", "value" );
		}

		protected override void OnSet( int index, Object oldValue, Object newValue )  
		{
			if ( newValue.GetType() != Type.GetType("System.String") )
				throw new ArgumentException( "newValue must be of type string.", "newValue" );
		}

		protected override void OnValidate( Object value )  
		{
			if ( value.GetType() != Type.GetType("System.String") )
				throw new ArgumentException( "value must be of type string." );
		}

		public override string ToString()
		{
			return this.ToString( "," );
		}

		public string ToString( string separator )
		{
			if( this.List.Count == 0 )
			{
				return null;
			}
			string[] strings = new string[this.List.Count];
			this.List.CopyTo( strings, 0 );
			return string.Join( separator, strings );
		}

	}
}