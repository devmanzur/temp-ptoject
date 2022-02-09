IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    IF SCHEMA_ID(N'checklist-manager') IS NULL EXEC(N'CREATE SCHEMA [checklist-manager];');
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE TABLE [checklist-manager].[AccessPermissions] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(450) NOT NULL,
        [Group] nvarchar(max) NOT NULL,
        [DisplayName] nvarchar(450) NOT NULL,
        [IsSoftDeleted] bit NOT NULL,
        CONSTRAINT [PK_AccessPermissions] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE TABLE [checklist-manager].[ApplicationRoles] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(450) NOT NULL,
        [DisplayName] nvarchar(450) NOT NULL,
        [CreatedTime] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedTime] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        [Default] bit NOT NULL,
        [IsSoftDeleted] bit NOT NULL,
        CONSTRAINT [PK_ApplicationRoles] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE TABLE [checklist-manager].[ProductBrands] (
        [Id] int NOT NULL IDENTITY,
        [Brand] nvarchar(max) NOT NULL,
        [CreatedTime] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedTime] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        [IsSoftDeleted] bit NOT NULL,
        CONSTRAINT [PK_ProductBrands] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE TABLE [checklist-manager].[ProductTypes] (
        [Id] int NOT NULL IDENTITY,
        [Type] nvarchar(max) NOT NULL,
        [CreatedTime] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedTime] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        [IsSoftDeleted] bit NOT NULL,
        CONSTRAINT [PK_ProductTypes] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE TABLE [checklist-manager].[ApplicationRoleAccessPermissions] (
        [RoleId] int NOT NULL,
        [PermissionId] int NOT NULL,
        [CreatedTime] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedTime] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ApplicationRoleAccessPermissions] PRIMARY KEY ([PermissionId], [RoleId]),
        CONSTRAINT [FK_ApplicationRoleAccessPermissions_AccessPermissions_PermissionId] FOREIGN KEY ([PermissionId]) REFERENCES [checklist-manager].[AccessPermissions] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ApplicationRoleAccessPermissions_ApplicationRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [checklist-manager].[ApplicationRoles] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE TABLE [checklist-manager].[ApplicationUsers] (
        [Id] int NOT NULL IDENTITY,
        [RoleId] int NOT NULL,
        [Username] nvarchar(450) NOT NULL,
        [EmailAddress] nvarchar(450) NOT NULL,
        [FirstName] nvarchar(max) NOT NULL,
        [LastName] nvarchar(max) NOT NULL,
        [Status] nvarchar(max) NOT NULL,
        [CreatedTime] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedTime] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        [IsSoftDeleted] bit NOT NULL,
        CONSTRAINT [PK_ApplicationUsers] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ApplicationUsers_ApplicationRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [checklist-manager].[ApplicationRoles] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE TABLE [checklist-manager].[Products] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [Price] decimal(18,2) NOT NULL,
        [ImageUri] nvarchar(max) NOT NULL,
        [ProductTypeId] int NOT NULL,
        [ProductBrandId] int NOT NULL,
        [CreatedTime] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedTime] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        [IsSoftDeleted] bit NOT NULL,
        CONSTRAINT [PK_Products] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Products_ProductBrands_ProductBrandId] FOREIGN KEY ([ProductBrandId]) REFERENCES [checklist-manager].[ProductBrands] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Products_ProductTypes_ProductTypeId] FOREIGN KEY ([ProductTypeId]) REFERENCES [checklist-manager].[ProductTypes] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE UNIQUE INDEX [IX_AccessPermissions_DisplayName] ON [checklist-manager].[AccessPermissions] ([DisplayName]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_AccessPermissions_IsSoftDeleted] ON [checklist-manager].[AccessPermissions] ([IsSoftDeleted]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE UNIQUE INDEX [IX_AccessPermissions_Name] ON [checklist-manager].[AccessPermissions] ([Name]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_ApplicationRoleAccessPermissions_RoleId] ON [checklist-manager].[ApplicationRoleAccessPermissions] ([RoleId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE UNIQUE INDEX [IX_ApplicationRoles_DisplayName] ON [checklist-manager].[ApplicationRoles] ([DisplayName]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_ApplicationRoles_IsSoftDeleted] ON [checklist-manager].[ApplicationRoles] ([IsSoftDeleted]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE UNIQUE INDEX [IX_ApplicationRoles_Name] ON [checklist-manager].[ApplicationRoles] ([Name]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE UNIQUE INDEX [IX_ApplicationUsers_EmailAddress] ON [checklist-manager].[ApplicationUsers] ([EmailAddress]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_ApplicationUsers_IsSoftDeleted] ON [checklist-manager].[ApplicationUsers] ([IsSoftDeleted]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_ApplicationUsers_RoleId] ON [checklist-manager].[ApplicationUsers] ([RoleId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE UNIQUE INDEX [IX_ApplicationUsers_Username] ON [checklist-manager].[ApplicationUsers] ([Username]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_ProductBrands_IsSoftDeleted] ON [checklist-manager].[ProductBrands] ([IsSoftDeleted]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_Products_IsSoftDeleted] ON [checklist-manager].[Products] ([IsSoftDeleted]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_Products_ProductBrandId] ON [checklist-manager].[Products] ([ProductBrandId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_Products_ProductTypeId] ON [checklist-manager].[Products] ([ProductTypeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    CREATE INDEX [IX_ProductTypes_IsSoftDeleted] ON [checklist-manager].[ProductTypes] ([IsSoftDeleted]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220128052802_InitialMigration')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220128052802_InitialMigration', N'6.0.1');
END;
GO

COMMIT;
GO

