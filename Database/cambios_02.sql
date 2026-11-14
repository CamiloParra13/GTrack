USE gTrack;
GO

IF COL_LENGTH('dbo.Notificacion', 'Enlace') IS NULL
    ALTER TABLE dbo.Notificacion ADD Enlace nvarchar(200) NULL;
GO
