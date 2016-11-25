﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataAccess.Db.Transaction.TransactionDbFull
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="MNSHOP")]
	public partial class TransactionDbFullDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InserttbTypeTransaction(tbTypeTransaction instance);
    partial void UpdatetbTypeTransaction(tbTypeTransaction instance);
    partial void DeletetbTypeTransaction(tbTypeTransaction instance);
    partial void InserttbTransaction(tbTransaction instance);
    partial void UpdatetbTransaction(tbTransaction instance);
    partial void DeletetbTransaction(tbTransaction instance);
    partial void InserttbUser(tbUser instance);
    partial void UpdatetbUser(tbUser instance);
    partial void DeletetbUser(tbUser instance);
    #endregion
		
		public TransactionDbFullDataContext() : 
				base(global::DataAccess.Properties.Settings.Default.MNSHOPConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public TransactionDbFullDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public TransactionDbFullDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public TransactionDbFullDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public TransactionDbFullDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<tbTypeTransaction> tbTypeTransactions
		{
			get
			{
				return this.GetTable<tbTypeTransaction>();
			}
		}
		
		public System.Data.Linq.Table<tbTransaction> tbTransactions
		{
			get
			{
				return this.GetTable<tbTransaction>();
			}
		}
		
		public System.Data.Linq.Table<tbUser> tbUsers
		{
			get
			{
				return this.GetTable<tbUser>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.tbTypeTransaction")]
	public partial class tbTypeTransaction : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _Id;
		
		private string _Name;
		
		private EntitySet<tbTransaction> _tbTransactions;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(int value);
    partial void OnIdChanged();
    partial void OnNameChanging(string value);
    partial void OnNameChanged();
    #endregion
		
		public tbTypeTransaction()
		{
			this._tbTransactions = new EntitySet<tbTransaction>(new Action<tbTransaction>(this.attach_tbTransactions), new Action<tbTransaction>(this.detach_tbTransactions));
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Name", DbType="NVarChar(50) NOT NULL", CanBeNull=false)]
		public string Name
		{
			get
			{
				return this._Name;
			}
			set
			{
				if ((this._Name != value))
				{
					this.OnNameChanging(value);
					this.SendPropertyChanging();
					this._Name = value;
					this.SendPropertyChanged("Name");
					this.OnNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="tbTypeTransaction_tbTransaction", Storage="_tbTransactions", ThisKey="Id", OtherKey="Type")]
		public EntitySet<tbTransaction> tbTransactions
		{
			get
			{
				return this._tbTransactions;
			}
			set
			{
				this._tbTransactions.Assign(value);
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
		
		private void attach_tbTransactions(tbTransaction entity)
		{
			this.SendPropertyChanging();
			entity.tbTypeTransaction = this;
		}
		
		private void detach_tbTransactions(tbTransaction entity)
		{
			this.SendPropertyChanging();
			entity.tbTypeTransaction = null;
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.tbTransaction")]
	public partial class tbTransaction : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _Id;
		
		private System.DateTime _CreatedDate;
		
		private string _Description;
		
		private int _Type;
		
		private decimal _Value;
		
		private System.Nullable<int> _InvokeId;
		
		private string _Source;
		
		private string _Destination;
		
		private EntityRef<tbTypeTransaction> _tbTypeTransaction;
		
		private EntityRef<tbUser> _tbUser;
		
		private EntityRef<tbUser> _tbUser1;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIdChanging(int value);
    partial void OnIdChanged();
    partial void OnCreatedDateChanging(System.DateTime value);
    partial void OnCreatedDateChanged();
    partial void OnDescriptionChanging(string value);
    partial void OnDescriptionChanged();
    partial void OnTypeChanging(int value);
    partial void OnTypeChanged();
    partial void OnValueChanging(decimal value);
    partial void OnValueChanged();
    partial void OnInvokeIdChanging(System.Nullable<int> value);
    partial void OnInvokeIdChanged();
    partial void OnSourceChanging(string value);
    partial void OnSourceChanged();
    partial void OnDestinationChanging(string value);
    partial void OnDestinationChanged();
    #endregion
		
		public tbTransaction()
		{
			this._tbTypeTransaction = default(EntityRef<tbTypeTransaction>);
			this._tbUser = default(EntityRef<tbUser>);
			this._tbUser1 = default(EntityRef<tbUser>);
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Id", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int Id
		{
			get
			{
				return this._Id;
			}
			set
			{
				if ((this._Id != value))
				{
					this.OnIdChanging(value);
					this.SendPropertyChanging();
					this._Id = value;
					this.SendPropertyChanged("Id");
					this.OnIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_CreatedDate", DbType="DateTime NOT NULL")]
		public System.DateTime CreatedDate
		{
			get
			{
				return this._CreatedDate;
			}
			set
			{
				if ((this._CreatedDate != value))
				{
					this.OnCreatedDateChanging(value);
					this.SendPropertyChanging();
					this._CreatedDate = value;
					this.SendPropertyChanged("CreatedDate");
					this.OnCreatedDateChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Description", DbType="NVarChar(50) NOT NULL", CanBeNull=false)]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this.OnDescriptionChanging(value);
					this.SendPropertyChanging();
					this._Description = value;
					this.SendPropertyChanged("Description");
					this.OnDescriptionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Type", DbType="Int NOT NULL")]
		public int Type
		{
			get
			{
				return this._Type;
			}
			set
			{
				if ((this._Type != value))
				{
					if (this._tbTypeTransaction.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnTypeChanging(value);
					this.SendPropertyChanging();
					this._Type = value;
					this.SendPropertyChanged("Type");
					this.OnTypeChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Value", DbType="Decimal(18,0) NOT NULL")]
		public decimal Value
		{
			get
			{
				return this._Value;
			}
			set
			{
				if ((this._Value != value))
				{
					this.OnValueChanging(value);
					this.SendPropertyChanging();
					this._Value = value;
					this.SendPropertyChanged("Value");
					this.OnValueChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_InvokeId", DbType="Int")]
		public System.Nullable<int> InvokeId
		{
			get
			{
				return this._InvokeId;
			}
			set
			{
				if ((this._InvokeId != value))
				{
					this.OnInvokeIdChanging(value);
					this.SendPropertyChanging();
					this._InvokeId = value;
					this.SendPropertyChanged("InvokeId");
					this.OnInvokeIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Source", DbType="NVarChar(50)")]
		public string Source
		{
			get
			{
				return this._Source;
			}
			set
			{
				if ((this._Source != value))
				{
					if (this._tbUser.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnSourceChanging(value);
					this.SendPropertyChanging();
					this._Source = value;
					this.SendPropertyChanged("Source");
					this.OnSourceChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Destination", DbType="NVarChar(50)")]
		public string Destination
		{
			get
			{
				return this._Destination;
			}
			set
			{
				if ((this._Destination != value))
				{
					if (this._tbUser1.HasLoadedOrAssignedValue)
					{
						throw new System.Data.Linq.ForeignKeyReferenceAlreadyHasValueException();
					}
					this.OnDestinationChanging(value);
					this.SendPropertyChanging();
					this._Destination = value;
					this.SendPropertyChanged("Destination");
					this.OnDestinationChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="tbTypeTransaction_tbTransaction", Storage="_tbTypeTransaction", ThisKey="Type", OtherKey="Id", IsForeignKey=true, DeleteOnNull=true, DeleteRule="CASCADE")]
		public tbTypeTransaction tbTypeTransaction
		{
			get
			{
				return this._tbTypeTransaction.Entity;
			}
			set
			{
				tbTypeTransaction previousValue = this._tbTypeTransaction.Entity;
				if (((previousValue != value) 
							|| (this._tbTypeTransaction.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._tbTypeTransaction.Entity = null;
						previousValue.tbTransactions.Remove(this);
					}
					this._tbTypeTransaction.Entity = value;
					if ((value != null))
					{
						value.tbTransactions.Add(this);
						this._Type = value.Id;
					}
					else
					{
						this._Type = default(int);
					}
					this.SendPropertyChanged("tbTypeTransaction");
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="tbUser_tbTransaction", Storage="_tbUser", ThisKey="Source", OtherKey="UserName", IsForeignKey=true)]
		public tbUser tbUser
		{
			get
			{
				return this._tbUser.Entity;
			}
			set
			{
				tbUser previousValue = this._tbUser.Entity;
				if (((previousValue != value) 
							|| (this._tbUser.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._tbUser.Entity = null;
						previousValue.tbTransactions.Remove(this);
					}
					this._tbUser.Entity = value;
					if ((value != null))
					{
						value.tbTransactions.Add(this);
						this._Source = value.UserName;
					}
					else
					{
						this._Source = default(string);
					}
					this.SendPropertyChanged("tbUser");
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="tbUser_tbTransaction1", Storage="_tbUser1", ThisKey="Destination", OtherKey="UserName", IsForeignKey=true, DeleteRule="CASCADE")]
		public tbUser tbUser1
		{
			get
			{
				return this._tbUser1.Entity;
			}
			set
			{
				tbUser previousValue = this._tbUser1.Entity;
				if (((previousValue != value) 
							|| (this._tbUser1.HasLoadedOrAssignedValue == false)))
				{
					this.SendPropertyChanging();
					if ((previousValue != null))
					{
						this._tbUser1.Entity = null;
						previousValue.tbTransactions1.Remove(this);
					}
					this._tbUser1.Entity = value;
					if ((value != null))
					{
						value.tbTransactions1.Add(this);
						this._Destination = value.UserName;
					}
					else
					{
						this._Destination = default(string);
					}
					this.SendPropertyChanged("tbUser1");
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.tbUser")]
	public partial class tbUser : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private string _UserName;
		
		private string _Password;
		
		private string _FullName;
		
		private int _TypeUser;
		
		private bool _Active;
		
		private decimal _Money;
		
		private System.DateTime _LastLogin;
		
		private string _Email;
		
		private string _Phone;
		
		private EntitySet<tbTransaction> _tbTransactions;
		
		private EntitySet<tbTransaction> _tbTransactions1;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnUserNameChanging(string value);
    partial void OnUserNameChanged();
    partial void OnPasswordChanging(string value);
    partial void OnPasswordChanged();
    partial void OnFullNameChanging(string value);
    partial void OnFullNameChanged();
    partial void OnTypeUserChanging(int value);
    partial void OnTypeUserChanged();
    partial void OnActiveChanging(bool value);
    partial void OnActiveChanged();
    partial void OnMoneyChanging(decimal value);
    partial void OnMoneyChanged();
    partial void OnLastLoginChanging(System.DateTime value);
    partial void OnLastLoginChanged();
    partial void OnEmailChanging(string value);
    partial void OnEmailChanged();
    partial void OnPhoneChanging(string value);
    partial void OnPhoneChanged();
    #endregion
		
		public tbUser()
		{
			this._tbTransactions = new EntitySet<tbTransaction>(new Action<tbTransaction>(this.attach_tbTransactions), new Action<tbTransaction>(this.detach_tbTransactions));
			this._tbTransactions1 = new EntitySet<tbTransaction>(new Action<tbTransaction>(this.attach_tbTransactions1), new Action<tbTransaction>(this.detach_tbTransactions1));
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UserName", DbType="NVarChar(50) NOT NULL", CanBeNull=false, IsPrimaryKey=true)]
		public string UserName
		{
			get
			{
				return this._UserName;
			}
			set
			{
				if ((this._UserName != value))
				{
					this.OnUserNameChanging(value);
					this.SendPropertyChanging();
					this._UserName = value;
					this.SendPropertyChanged("UserName");
					this.OnUserNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Password", DbType="NVarChar(50) NOT NULL", CanBeNull=false)]
		public string Password
		{
			get
			{
				return this._Password;
			}
			set
			{
				if ((this._Password != value))
				{
					this.OnPasswordChanging(value);
					this.SendPropertyChanging();
					this._Password = value;
					this.SendPropertyChanged("Password");
					this.OnPasswordChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_FullName", DbType="NVarChar(50) NOT NULL", CanBeNull=false)]
		public string FullName
		{
			get
			{
				return this._FullName;
			}
			set
			{
				if ((this._FullName != value))
				{
					this.OnFullNameChanging(value);
					this.SendPropertyChanging();
					this._FullName = value;
					this.SendPropertyChanged("FullName");
					this.OnFullNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_TypeUser", DbType="Int NOT NULL")]
		public int TypeUser
		{
			get
			{
				return this._TypeUser;
			}
			set
			{
				if ((this._TypeUser != value))
				{
					this.OnTypeUserChanging(value);
					this.SendPropertyChanging();
					this._TypeUser = value;
					this.SendPropertyChanged("TypeUser");
					this.OnTypeUserChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Active", DbType="Bit NOT NULL")]
		public bool Active
		{
			get
			{
				return this._Active;
			}
			set
			{
				if ((this._Active != value))
				{
					this.OnActiveChanging(value);
					this.SendPropertyChanging();
					this._Active = value;
					this.SendPropertyChanged("Active");
					this.OnActiveChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Money", DbType="Decimal(18,0) NOT NULL")]
		public decimal Money
		{
			get
			{
				return this._Money;
			}
			set
			{
				if ((this._Money != value))
				{
					this.OnMoneyChanging(value);
					this.SendPropertyChanging();
					this._Money = value;
					this.SendPropertyChanged("Money");
					this.OnMoneyChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LastLogin", DbType="DateTime NOT NULL")]
		public System.DateTime LastLogin
		{
			get
			{
				return this._LastLogin;
			}
			set
			{
				if ((this._LastLogin != value))
				{
					this.OnLastLoginChanging(value);
					this.SendPropertyChanging();
					this._LastLogin = value;
					this.SendPropertyChanged("LastLogin");
					this.OnLastLoginChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Email", DbType="NVarChar(50) NOT NULL", CanBeNull=false)]
		public string Email
		{
			get
			{
				return this._Email;
			}
			set
			{
				if ((this._Email != value))
				{
					this.OnEmailChanging(value);
					this.SendPropertyChanging();
					this._Email = value;
					this.SendPropertyChanged("Email");
					this.OnEmailChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Phone", DbType="NVarChar(14) NOT NULL", CanBeNull=false)]
		public string Phone
		{
			get
			{
				return this._Phone;
			}
			set
			{
				if ((this._Phone != value))
				{
					this.OnPhoneChanging(value);
					this.SendPropertyChanging();
					this._Phone = value;
					this.SendPropertyChanged("Phone");
					this.OnPhoneChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="tbUser_tbTransaction", Storage="_tbTransactions", ThisKey="UserName", OtherKey="Source")]
		public EntitySet<tbTransaction> tbTransactions
		{
			get
			{
				return this._tbTransactions;
			}
			set
			{
				this._tbTransactions.Assign(value);
			}
		}
		
		[global::System.Data.Linq.Mapping.AssociationAttribute(Name="tbUser_tbTransaction1", Storage="_tbTransactions1", ThisKey="UserName", OtherKey="Destination")]
		public EntitySet<tbTransaction> tbTransactions1
		{
			get
			{
				return this._tbTransactions1;
			}
			set
			{
				this._tbTransactions1.Assign(value);
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
		
		private void attach_tbTransactions(tbTransaction entity)
		{
			this.SendPropertyChanging();
			entity.tbUser = this;
		}
		
		private void detach_tbTransactions(tbTransaction entity)
		{
			this.SendPropertyChanging();
			entity.tbUser = null;
		}
		
		private void attach_tbTransactions1(tbTransaction entity)
		{
			this.SendPropertyChanging();
			entity.tbUser1 = this;
		}
		
		private void detach_tbTransactions1(tbTransaction entity)
		{
			this.SendPropertyChanging();
			entity.tbUser1 = null;
		}
	}
}
#pragma warning restore 1591