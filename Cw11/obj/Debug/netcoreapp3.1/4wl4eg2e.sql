IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Doctors] (
    [IdDoctor] int NOT NULL IDENTITY,
    [FirstName] nvarchar(100) NULL,
    [LastName] nvarchar(100) NULL,
    [Email] nvarchar(100) NULL,
    CONSTRAINT [PK_Doctors] PRIMARY KEY ([IdDoctor])
);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200603192819_DBCreateAndDoctorsTableAdded', N'3.1.4');

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200603192905_PatientTableAdded', N'3.1.4');

GO

CREATE TABLE [Medicaments] (
    [IdMedicament] int NOT NULL IDENTITY,
    [Name] nvarchar(100) NULL,
    [Description] nvarchar(100) NULL,
    [Type] nvarchar(100) NULL,
    CONSTRAINT [PK_Medicaments] PRIMARY KEY ([IdMedicament])
);

GO

CREATE TABLE [Patients] (
    [IdPatient] int NOT NULL IDENTITY,
    [FirstName] nvarchar(100) NULL,
    [LastName] nvarchar(100) NULL,
    [BirthDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Patients] PRIMARY KEY ([IdPatient])
);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200603193029_MedicamentsTableAdded', N'3.1.4');

GO

ALTER TABLE [Medicaments] ADD [Prescription_MedicamentIdMedicament] int NULL;

GO

ALTER TABLE [Medicaments] ADD [Prescription_MedicamentIdPrescription] int NULL;

GO

CREATE TABLE [Prescription_Medicament] (
    [IdMedicament] int NOT NULL,
    [IdPrescription] int NOT NULL,
    [Dose] int NULL,
    [Details] nvarchar(100) NULL,
    CONSTRAINT [PK_Prescription_Medicament] PRIMARY KEY ([IdMedicament], [IdPrescription])
);

GO

CREATE TABLE [Prescription] (
    [IdPrescription] int NOT NULL IDENTITY,
    [Date] datetime2 NOT NULL,
    [DueDate] datetime2 NOT NULL,
    [IdPatient] int NOT NULL,
    [IdDoctor] int NOT NULL,
    [Prescription_MedicamentIdMedicament] int NULL,
    [Prescription_MedicamentIdPrescription] int NULL,
    CONSTRAINT [PK_Prescription] PRIMARY KEY ([IdPrescription]),
    CONSTRAINT [FK_Prescription_Doctors_IdDoctor] FOREIGN KEY ([IdDoctor]) REFERENCES [Doctors] ([IdDoctor]) ON DELETE CASCADE,
    CONSTRAINT [FK_Prescription_Patients_IdPatient] FOREIGN KEY ([IdPatient]) REFERENCES [Patients] ([IdPatient]) ON DELETE CASCADE,
    CONSTRAINT [FK_Prescription_Prescription_Medicament_Prescription_MedicamentIdMedicament_Prescription_MedicamentIdPrescription] FOREIGN KEY ([Prescription_MedicamentIdMedicament], [Prescription_MedicamentIdPrescription]) REFERENCES [Prescription_Medicament] ([IdMedicament], [IdPrescription]) ON DELETE NO ACTION
);

GO

CREATE INDEX [IX_Medicaments_Prescription_MedicamentIdMedicament_Prescription_MedicamentIdPrescription] ON [Medicaments] ([Prescription_MedicamentIdMedicament], [Prescription_MedicamentIdPrescription]);

GO

CREATE INDEX [IX_Prescription_IdDoctor] ON [Prescription] ([IdDoctor]);

GO

CREATE INDEX [IX_Prescription_IdPatient] ON [Prescription] ([IdPatient]);

GO

CREATE INDEX [IX_Prescription_Prescription_MedicamentIdMedicament_Prescription_MedicamentIdPrescription] ON [Prescription] ([Prescription_MedicamentIdMedicament], [Prescription_MedicamentIdPrescription]);

GO

ALTER TABLE [Medicaments] ADD CONSTRAINT [FK_Medicaments_Prescription_Medicament_Prescription_MedicamentIdMedicament_Prescription_MedicamentIdPrescription] FOREIGN KEY ([Prescription_MedicamentIdMedicament], [Prescription_MedicamentIdPrescription]) REFERENCES [Prescription_Medicament] ([IdMedicament], [IdPrescription]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200603193452_AddRestOfTheTables', N'3.1.4');

GO

